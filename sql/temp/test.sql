


--===============================================================================================================
  
CREATE OR REPLACE FUNCTION bus.shortest_ways(	_city_id  	bigint,
						_p1 		geography,
						_p2 		geography,
						_day_id 	day_enum,
						_time_start  	time,
					        _max_distance 	double precision,
					        _transports 	bus.transport_type_enum[],
					        _discount_id    bigint,
					        _alg_strategy   bus.alg_strategy,
					        _lang_id        lang_enum)
RETURNS SETOF bus.path_elem AS
$BODY$
DECLARE
 r record;
 _path_elem              bus.path_elem%ROWTYPE;
 _relation_id   	integer;
 relations_A 		integer[];
 relations_B 		integer[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 count_i 		integer;
 count_j 		integer;
 _curr_path             integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'
BEGIN
 -- get _relation_input_id
 _relation_input_id := bus.get_relation_input_id(_city_id);
 RAISE NOTICE '_relation_input_id: %',_relation_input_id;
   FOR _relation_id IN select * FROM bus.find_nearest_stations(_p1,
				 _city_id,
				 _transports,
				 _max_distance)
  LOOP
       relations_A := array_append(relations_A,_relation_id);
   END LOOP;

   FOR _relation_id IN select * FROM bus.find_nearest_stations(_p2,
				 _city_id,
				 _transports,
				 _max_distance)
  LOOP
       relations_B := array_append(relations_B,_relation_id);
   END LOOP;

  
  CREATE TEMPORARY  TABLE use_routes  ON COMMIT DROP AS
  SELECT bus.route_types.id as id,transport_id,discount 
         FROM bus.route_types 
	 JOIN bus.discount_by_route_types ON bus.route_types.id = bus.discount_by_route_types.route_type_id
        WHERE bus.discount_by_route_types.discount_id = _discount_id AND transport_id = ANY(_transports);
  
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, relation_a_id as source,relation_b_id as target, cost_time as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.route_type_id 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id IS NULL);

  ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, relation_a_id as source,relation_b_id as target, use_routes.discount*cost_money as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.route_type_id 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id IS NULL);
  ELSE
        CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, 
	       relation_a_id as source,
	       relation_b_id as target, 
	       (30*bus.graph_relations.cost + cost_time) as cost
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.route_type_id 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id IS NULL);
  END IF;


  
  CREATE TEMPORARY TABLE paths
  (
     path_id     integer,
     index       integer,
     relation_id integer,
     graph_id    bigint
  )ON COMMIT DROP;
  _curr_path := 1;

 select count(*) INTO count_i from  graph where source<>1 OR (source = 1 and target =3);
           RAISE  NOTICE 'count: %',count_i; 
  count_i := array_upper(relations_A,1);
  count_j := array_upper(relations_B,1);
   i:=1;
  
  WHILE i<= count_i LOOP
        j := 1;
        WHILE j<= count_j LOOP
	   query:='select * from graph where source<>'||_relation_input_id||' OR (source = '
	          ||_relation_input_id||' and target = '||relations_A[i]||')';

	   
           --RAISE NOTICE '%',relations_A[i];
          -- RAISE NOTICE '%',relations_B[j];
          -- RAISE NOTICE '%',query;
           k:=0;
           WHILE k < 2 LOOP
           BEGIN

                INSERT INTO paths(path_id,index,relation_id,graph_id)
		   select _curr_path as path_id,
                          row_number() over (ORDER BY (select 0)) as index,
		          t1.vertex_id as  relation_id,
		          t1.edge_id   as graph_id
		   from shortest_path(query,_relation_input_id,relations_B[j],false,false) as t1;
		_curr_path := _curr_path + 1;
		
	   EXCEPTION  WHEN OTHERS THEN 
	        RAISE  NOTICE 'warning in shortest_path';
           END;
           k := k+1;
           END LOOP;
	   j := j + 1;
        END LOOP;
	i := i + 1;
  END LOOP;


 
 FOR _path_elem IN 
        SELECT 
		paths.path_id  as path_id,
		paths.index as index,
		bus.routes.id as route_id,
		bus.graph_relations.route_type_id as route_type,  
		bus.routes.number                as route_number,
		route_names.value                as route_name,
		station_names.value              as station_name,
		bus.graph_relations.move_time,
		bus.graph_relations.wait_time,
		bus.graph_relations.cost_money*use_routes.discount   as cost
        FROM paths
        JOIN bus.route_relations                  	     ON bus.route_relations.id = paths.relation_id
	JOIN bus.graph_relations                  	     ON bus.graph_relations.id = paths.graph_id
	JOIN bus.direct_routes                    	     ON bus.direct_routes.id = bus.route_relations.direct_route_id
	JOIN bus.routes                                      ON bus.routes.id = bus.direct_routes.route_id
        LEFT OUTER JOIN use_routes                           ON use_routes.id = bus.graph_relations.route_type_id 
	LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = bus.route_relations.station_b_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
        
        WHERE (route_names.lang_id = 'c_ru' or route_names.lang_id IS NULL) AND
              (station_names.lang_id = 'c_ru' or station_names.lang_id IS NULL)
  LOOP
         RETURN NEXT _path_elem;
   END LOOP;
	 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--===============================================================================================================
/*select 
paths.path_id  as path_id,
bus.routes.id as route_id,
bus.graph_relations.route_type_id as route_type,  
bus.routes.number                as route_number,
route_names.value                as route_name,
station_names.value              as station_name,
bus.graph_relations.move_time,
bus.graph_relations.wait_time,
bus.graph_relations.cost_money

*/
select  * from  bus.shortest_ways(bus.get_city_id(lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.0253650246659 36.3360857963562)'),
				 st_geographyfromtext('POINT(50.0355169337227 36.2198925018311)'),
				 day_enum('c_Monday'),
				 time  '10:00:00',
				 300,
				 ARRAY[bus.transport_type_enum('c_foot'),
				       bus.transport_type_enum('c_metro'),
				       bus.transport_type_enum('c_trolley')],
				 bus.get_discount_id(lang_enum('c_ru'),'Студенческий'),
				 bus.alg_strategy('c_cost'),
				 lang_enum('c_ru')) ORDER BY path_id; 
				--AS (id bigint, source  integer,target  integer,cost double precision);
				/*AS ( path_id  integer,relation_id  integer,graph_id bigint) )as paths
       
	JOIN bus.route_relations                  	     ON bus.route_relations.id = paths.relation_id
	JOIN bus.graph_relations                  	     ON bus.graph_relations.id = paths.graph_id
	JOIN bus.direct_routes                    	     ON bus.direct_routes.id = bus.route_relations.direct_route_id
	JOIN bus.routes                                      ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = bus.route_relations.station_b_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
        WHERE (route_names.lang_id = 'c_ru' or route_names.lang_id IS NULL) AND
              (station_names.lang_id = 'c_ru' or station_names.lang_id IS NULL);
*/
	/*LEFT JOIN bus.stations as stb                  ON stb.id = bus.route_relations.station_b_id
	JOIN bus.string_values as stations_name   ON stations_name.key_id = stb.name_key
	where lang_id = 'c_ru';
	*/





--select * from bus.discounts JOIN bus.discount_by_route_types ON bus.discount_by_route_types.discount_id = bus.discounts.id;

/*select row_number() over (order by t1.id) as id, 
t1.id as relation_A, t2.id as relation_B,t1.direct_route_id as direct_route_A,t2.direct_route_id as direct_route_B
   FROM bus.route_stations as t1
   JOIN bus.route_stations as t2 ON t1.station_b_id = t2.station_a_id;

   */
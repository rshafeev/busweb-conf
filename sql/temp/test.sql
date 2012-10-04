﻿
CREATE OR REPLACE FUNCTION bus.get_string_without_null(str text)
RETURNS  text AS
$BODY$
DECLARE
BEGIN
  IF str IS NOT NULL THEN
    return str;
  
  
  END IF;
  return '';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
--===============================================================================================================
  
CREATE OR REPLACE FUNCTION bus.shortest_ways2(	_city_id  	bigint,
						_p1 		geography,
						_p2 		geography,
						_day_id 	day_enum,
						_time_start  	time,
					        _max_distance 	double precision,
					        _routes 	bus.route_type_enum[],
					        _discount_id    bigint,
					        _alg_strategy   bus.alg_strategy,
					        _lang_id        lang_enum)
RETURNS SETOF bus.way_elem AS
$BODY$
DECLARE
 _foot_speed            double precision;
 _nearest_relation      bus.nearest_relation%ROWTYPE;
 relations_A 		bus.nearest_relation[];
 relations_B 		bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 count_i 		integer;
 count_j 		integer;
 _curr_path             integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path%ROWTYPE;
 _temp_filter_path	bus.filter_path%ROWTYPE;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
BEGIN

  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
         
 -- get _relation_input_id
 _relation_input_id := bus.get_relation_input_id(_city_id);

 -- get start end finish relations(stations)
 FOR _nearest_relation IN select * FROM bus.find_nearest_relations(_p1,
				 _city_id,
				 _max_distance)
 LOOP
       relations_A := array_append(relations_A,_nearest_relation);
 END LOOP;

 FOR _nearest_relation IN select * FROM bus.find_nearest_relations(_p2,
				 _city_id,
				 _max_distance)
  LOOP
       relations_B := array_append(relations_B,_nearest_relation);
   END LOOP;
  
  CREATE TEMPORARY  TABLE use_routes  ON COMMIT DROP AS
  SELECT bus.route_types.id as id,discount 
         FROM bus.route_types 
	 JOIN bus.discount_by_route_types ON bus.route_types.id = bus.discount_by_route_types.route_type_id
        WHERE bus.discount_by_route_types.discount_id = _discount_id AND bus.route_types.id = ANY(_routes);
  
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id as id,
	       relation_a_id          as source,
	       relation_b_id          as target, 
	       cost_time              as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.relation_type 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id IS NULL);

  ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, relation_a_id as source,relation_b_id as target, use_routes.discount*cost_money as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.relation_type 
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
  
 
  count_i := array_upper(relations_A,1);
  count_j := array_upper(relations_B,1);
   i:=1;
  _curr_path := 1;
  
  WHILE i<= count_i LOOP
        j := 1;
        WHILE j<= count_j LOOP
	   query:='select * from graph where source<>'||_relation_input_id||' OR (source = '
	          ||_relation_input_id||' and target = '||relations_A[i].id||')';

	   RAISE NOTICE '%',relations_A[i];
           RAISE NOTICE '%',relations_B[j];
           RAISE NOTICE '%',query;
           k:=0;
           WHILE k < 1 LOOP
           BEGIN

                INSERT INTO paths(path_id,index,relation_id,graph_id)
		   select _curr_path as path_id,
                          row_number() over (ORDER BY (select 0)) as index,
		          t1.vertex_id as  relation_id,
		          t1.edge_id   as graph_id
		   from shortest_path(query,_relation_input_id,relations_B[j].id,true,false) as t1;
		
		INSERT INTO paths(path_id,index) VALUES(_curr_path,10000);
		_curr_path := _curr_path + 1;
		
	   EXCEPTION  WHEN OTHERS THEN 
	       -- RAISE  NOTICE 'warning in shortest_path';
           END;
           k := k+1;
           END LOOP;
	   j := j + 1;
        END LOOP;
	i := i + 1;
  END LOOP;
 
 select count(*) INTO count_i from  graph ;
 RAISE  NOTICE 'count: %',count_i; 
 
 select count(*) INTO count_i from  paths ;
 RAISE  NOTICE 'count: %',count_i; 

 --=======================================================================

 
 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		paths.path_id                                        as path_id,
		paths.index                                          as index,
		bus.route_relations.direct_route_id                  as direct_route_id,
		bus.graph_relations.relation_type                    as route_type,
		bus.route_relations.position_index                   as relation_index,
		bus.route_relations.id                               as relation_id,
		bus.route_relations.station_b_id                     as station_id,
		bus.graph_relations.move_time                        as move_time,
		bus.graph_relations.wait_time                        as wait_time,
		bus.graph_relations.cost_money*use_routes.discount   as cost,
		bus.graph_relations.distance                         as distance
		
        FROM paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = paths.relation_id
	LEFT JOIN bus.graph_relations                  	     ON bus.graph_relations.id = paths.graph_id
	LEFT JOIN use_routes                                 ON use_routes.id = bus.graph_relations.route_type_id 
	ORDER BY paths.path_id,paths.index
  LOOP
     _paths:= array_append(_paths,_curr_filter_path);
    /*
       IF  _curr_filter_path.path_id = _prev_filter_path.path_id 
          AND _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id THEN
             _temp_filter_path           := _curr_filter_path;
             _temp_filter_path.wait_time := _prev_filter_path.wait_time;
             _temp_filter_path.cost      := _prev_filter_path.cost;
             
             IF _prev_filter_path.route_type = bus.route_type_enum('c_route_station_input') THEN
               select relations.distance into _temp_filter_path.distance FROM unnest(relations_A) as relations 
			where relations.id = _curr_filter_path.relation_id;
               _temp_filter_path.move_time := _temp_filter_path.distance/1000.0/_foot_speed * interval '1 hour';
               
             ELSE
	        _temp_filter_path.move_time := _prev_filter_path.move_time;
	        _temp_filter_path.distance  := _prev_filter_path.distance;
	     END IF;
             _paths:= array_append(_paths,_temp_filter_path);
             IF _prev_filter_path.relation_id <> _relation_input_id THEN
               _temp_filter_path           := _prev_filter_path;
               _temp_filter_path.move_time := _move_time;
               _temp_filter_path.cost      := null;
               _temp_filter_path.wait_time := null;
               _temp_filter_path.distance  := _distance;
               _paths :=  array_append(_paths,_temp_filter_path);
             END IF;
             _move_time := interval '00:00:00';
             _distance  := 0.0;
       ELSEIF _curr_filter_path.path_id = _prev_filter_path.path_id AND  _prev_filter_path.move_time IS NOT NULL THEN
             _move_time := _move_time + _prev_filter_path.move_time;
             _distance  := _distance + _prev_filter_path.distance;
       END IF;

       
       IF _prev_filter_path.path_id = _curr_filter_path.path_id AND
          _curr_filter_path.index = 10000  THEN
	    _prev_filter_path.move_time := _move_time;
	    _prev_filter_path.distance := _distance;
	    _paths:= array_append(_paths,_prev_filter_path);
	    select relations.distance into _curr_filter_path.distance FROM unnest(relations_B) as relations 
                  where relations.id = _prev_filter_path.relation_id;
            _curr_filter_path.move_time := _curr_filter_path.distance/1000.0/_foot_speed * interval '1 hour';
            _paths:= array_append(_paths,_curr_filter_path);	
       END IF;*/
       _prev_filter_path := _curr_filter_path;
   END LOOP;

 --=======================================================================
   
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			as path_id,
		paths.index 			as index,
		bus.direct_routes.id 		as direct_route_id,
		bus.routes.route_type_id 	as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		paths.wait_time                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
        
        WHERE (route_names.lang_id = _lang_id or route_names.lang_id IS NULL) AND
              (station_names.lang_id = _lang_id or station_names.lang_id IS NULL)
  LOOP
         RETURN NEXT _way_elem;
   END LOOP;
	 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--===============================================================================================================

select  * from  bus.shortest_ways2(bus.get_city_id(lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.026350246659 36.3360857963562)'),
				 st_geographyfromtext('POINT(50.0046341324976 36.2337112426758)'),
				 day_enum('c_Monday'),
				 time  '10:00:00',
				 300,
				 ARRAY[bus.route_type_enum('c_route_station_input'),
				       bus.route_type_enum('c_route_transition'),
				       bus.route_type_enum('c_route_trolley'),
				       bus.route_type_enum('c_route_metro'),
				       bus.route_type_enum('c_route_bus')],
				 bus.get_discount_id(lang_enum('c_ru'),'Студенческий'),
				 bus.alg_strategy('c_cost'),
				 lang_enum('c_ru')) ORDER BY path_id,index; 



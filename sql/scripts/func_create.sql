
CREATE OR REPLACE FUNCTION bus.insert_route_relation(
												 _direct_route_id	bigint,
												 _station_A_id 		bigint, 
												 _station_B_id 		bigint,
												 _index        		bigint,
												 _geom               geography
												) 
RETURNS bigint AS
$BODY$
DECLARE
  _speed                double precision; 
  _distance             double precision;
  _time                 interval;
  _id                   bigint;
BEGIN
  _speed := 1;
  SELECT bus.transport_types.ev_speed INTO _speed
  FROM bus.direct_routes 
    JOIN bus.routes ON bus.routes.id = bus.direct_routes.route_id 
    JOIN bus.route_types ON bus.route_types.id = bus.routes.route_type_id
    JOIN bus.transport_types ON bus.transport_types.id = bus.route_types.transport_id
  WHERE bus.direct_routes.id  = _direct_route_id;
  IF _geom IS NOT NULL THEN
    _distance := st_length(geography(_geom),false);
  ELSE
    _distance := 0;
  END IF;
  
  _time := _distance/1000.0/_speed * interval '1 hour';
	if _station_A_id <=0 THEN
	_station_A_id:= null;
	END IF;
	if _station_B_id <=0 THEN
	_station_A_id:= null;
	END IF;
   INSERT INTO bus.route_relations (direct_route_id,station_A_id,station_B_id,position_index,geom,ev_time,distance) 
          VALUES (_direct_route_id,_station_A_id,_station_B_id,_index,_geom,_time,_distance) RETURNING id INTO  _id;
  RETURN _id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
--===============================================================================================================
CREATE OR REPLACE FUNCTION bus.__clean_paths_table(_relation_input_id integer)
RETURNS  void AS
$BODY$
DECLARE
 _id_arr                integer[];
 _id                    integer;
BEGIN
  FOR _id IN SELECT t1.path_id FROM
	           (SELECT paths.path_id as path_id,count(*) as count FROM paths 
	                   JOIN bus.route_relations ON bus.route_relations.id = paths.relation_id
	                   WHERE bus.route_relations.id <> _relation_input_id
	                  GROUP BY paths.path_id,bus.route_relations.direct_route_id
	           ) as t1
	           WHERE t1.count = 1
	LOOP
           _id_arr:= array_append(_id_arr,_id);
	END LOOP;

  DELETE FROM paths where path_id = ANY(_id_arr);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
--===============================================================================================================

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
  
CREATE OR REPLACE FUNCTION bus.shortest_ways(	_city_id  	bigint,
						_p1 		geography,
						_p2 		geography,
						_day_id 	bus.day_enum,
						_time_start  	time,
					        _max_distance 	double precision,
					        _route_types 	text[],
					        _discounts      double precision[],
					        _alg_strategy   bus.alg_strategy,
					        _lang_id        bus.lang_enum)
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
 _id_arr                integer[];
 _id                    integer;
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
  select route_type as id,discount from 
	( select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)) as route_types
        JOIN
        ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)) as discounts
        ON discounts.id =  route_types.id;

  
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
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));

  ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, relation_a_id as source,relation_b_id as target, use_routes.discount*cost_money as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.relation_type 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));
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
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));
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

	 --  RAISE NOTICE '%',relations_A[i];
          -- RAISE NOTICE '%',relations_B[j];
         --  RAISE NOTICE '%',query;
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

 --delete bad ways from paths table
 EXECUTE bus.__clean_paths_table(_relation_input_id);

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
    -- _paths:= array_append(_paths,_curr_filter_path);
    
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
       END IF;
       _prev_filter_path := _curr_filter_path;
   END LOOP;

 -- return data
   
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
  
CREATE OR REPLACE FUNCTION bus.get_relation_input_id(_city_id bigint)
RETURNS integer AS
$BODY$
DECLARE
  _relation_input_id bigint;
BEGIN
 SELECT bus.route_relations.id INTO _relation_input_id FROM bus.routes 
	 JOIN bus.direct_routes   ON bus.direct_routes.route_id = bus.routes.id
	 JOIN bus.route_relations ON bus.route_relations.direct_route_id = bus.direct_routes.id
 WHERE route_type_id=bus.route_type_enum('c_route_station_input') and city_id = _city_id;

 return _relation_input_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
--=================================================================================================

CREATE OR REPLACE FUNCTION bus.drop_functions()
RETURNS void AS
$BODY$
DECLARE

BEGIN
   DROP FUNCTION bus.init_system_data();
   DROP FUNCTION bus.insert_user_role( character);
   DROP FUNCTION bus.insert_user(bigint,character, character);
   DROP FUNCTION bus.insert_user(character,character, character);
   DROP FUNCTION bus.authenticate(character,character, character);
   DROP FUNCTION bus.get_city_id (bus.lang_enum, text);
   DROP FUNCTION bus.get_discount_id (bus.lang_enum, text);

   DROP FUNCTION bus.find_nearest_relations(geometry,bigint,bus.transport_type_enum[],double precision);
   DROP FUNCTION bus.data_clear();
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--=================================================================================================

CREATE OR REPLACE FUNCTION bus.init_system_data()
RETURNS  void AS
$BODY$
DECLARE
  _discount bus.discounts%ROWTYPE;
BEGIN
--============== system data=======================
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_metro',44);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_bus',50);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_tram',48);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_trolley',45);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_foot',5);

INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_metro','c_metro',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_trolley','c_trolley',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_bus','c_bus',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_tram','c_tram',B'1');

INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_station_input','c_foot',B'0');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_transition','c_foot',B'0');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_metro_transition','c_foot',B'0');



INSERT INTO bus.languages(id,name) VALUES('c_en', 'English');
INSERT INTO bus.languages(id,name) VALUES('c_ru', 'Русский');
INSERT INTO bus.languages(id,name) VALUES('c_uk', 'Українська');

 -- insert direct_route
 

-- insert discounts
INSERT INTO bus.discounts (id) VALUES (default) RETURNING * INTO _discount;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_ru','Отсутствует');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_en','Dissapear');
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),1);


INSERT INTO bus.discounts (id) VALUES (default) RETURNING * INTO _discount;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_ru','Студенческий');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_en','Student');
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro'),0.5);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_bus'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_trolley'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_tram'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_station_input'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_transition'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),0.0);
--========================================================
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
--====================================================================================================================	
CREATE OR REPLACE FUNCTION bus.get_city_id (_lang bus.lang_enum, _name text)
RETURNS  bigint AS
$BODY$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT * INTO _id FROM bus.cities JOIN bus.string_values ON bus.string_values.key_id = bus.cities.name_key
    WHERE value = _name AND lang_id = _lang;
    
  RETURN  _id;
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
--====================================================================================================================	
CREATE OR REPLACE FUNCTION bus.get_discount_id (_lang bus.lang_enum, _name text)
RETURNS  bigint AS
$BODY$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT bus.discounts .id INTO _id FROM bus.discounts JOIN bus.string_values ON bus.string_values.key_id = bus.discounts.name_key
    WHERE value = _name AND lang_id = _lang;
  RETURN  _id;
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--====================================================================================================================	
-- function returns sql-array of route_relation_id indexes
CREATE OR REPLACE FUNCTION bus.find_nearest_relations(
   _location geography,
   _city_id  bigint,
   max_distance double precision
)
RETURNS SETOF bus.nearest_relation AS
$BODY$
DECLARE
  _relation bus.nearest_relation;
BEGIN
    FOR _relation IN SELECT 
                              bus.route_relations.id          as id ,
                              st_distance(location,_location) as distance 
                     FROM bus.route_relations
                     JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                     WHERE city_id = _city_id AND 
                         st_distance(location,_location) < max_distance 
    LOOP
         RETURN NEXT _relation;
   END LOOP;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  
--====================================================================================================================	
-- function returns sql-array of route_relation_id indexes
CREATE OR REPLACE FUNCTION bus.find_nearest_relations(
   _location geography,
   _city_id  bigint,
   _transports bus.transport_type_enum[],
   max_distance double precision
)
RETURNS SETOF bus.nearest_relation AS
$BODY$
DECLARE
  _relation bus.nearest_relation;
BEGIN
    FOR _relation IN SELECT 
                              bus.route_relations.id          as id ,
                              st_distance(location,_location) as distance 
                     FROM bus.route_relations
                     JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                     JOIN bus.station_transports ON bus.station_transports.station_id = bus.stations.id
                     WHERE city_id = _city_id AND 
                         st_distance(location,_location) < max_distance AND 
                         transport_type_id =  ANY(_transports)
    LOOP
         RETURN NEXT _relation;
   END LOOP;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  
--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.insert_user_role(role_name character)
RETURNS bigint AS
$BODY$
DECLARE
  role_id bigint;
BEGIN
  INSERT INTO bus.user_roles (name)  VALUES(role_name) RETURNING id INTO role_id;
  RETURN role_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.insert_user(role_id bigint,login character, password character)
RETURNS bigint AS
$BODY$
DECLARE
 user_id bigint;
BEGIN
  INSERT INTO bus.users (role_id,login,password)  VALUES(role_id,login,password) RETURNING id INTO user_id;
  RETURN user_id;
END;
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--=============================

CREATE OR REPLACE FUNCTION bus.insert_user(role_name character,login character, password character)
RETURNS bigint AS
$BODY$
DECLARE
 user_id bigint;
 role_id bigint;
BEGIN
  SELECT id INTO role_id  FROM bus.user_roles WHERE name = role_name;
  IF NOT FOUND THEN
     RAISE EXCEPTION 'user_role % not found', role_name;
   END IF;
 
  SELECT * INTO user_id FROM bus.insert_user(role_id,login,password);
  RETURN 1;
END;
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================

-- return 0 : ok
-- return 1 : invalid role
-- return 2 : invalid login
-- return 3 : invalid password

CREATE OR REPLACE FUNCTION bus.authenticate(role_name character,v_login character, v_password character)
RETURNS bigint AS
$BODY$
DECLARE
 user_id bigint;
 v_role_id bigint;
 v_user  record;
BEGIN
  SELECT id INTO v_role_id  FROM bus.user_roles WHERE name = role_name;
  IF NOT FOUND THEN
     RETURN 1;
   END IF;
  RAISE NOTICE '%', v_role_id;
  SELECT * INTO v_user  FROM bus.users WHERE bus.users.role_id = v_role_id AND bus.users.login = v_login;
  IF NOT FOUND THEN
     RETURN 2;
   END IF;
  IF v_user.password <> v_password THEN
     RETURN 3;
  END IF;
  RETURN 0;
END;
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.data_clear()
RETURNS void AS
$BODY$
DECLARE
BEGIN

delete from  bus.timetable;
delete from  bus.schedule_group_days;
delete from  bus.schedule_groups;
delete from  bus.schedule;
delete from  bus.graph_relations;
delete from  bus.route_relations;
delete from  bus.direct_routes;
delete from  bus.routes;

delete from bus.station_transports;
delete from bus.stations;
delete from bus.cities;

delete from bus.discount_by_route_types;
delete from bus.discounts;

delete from bus.transport_types;

delete from bus.user_roles;
delete from bus.users;

delete from bus.string_values;
delete from bus.string_keys;
delete from bus.languages;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
 --====================================================================================================================	
 
 CREATE OR REPLACE FUNCTION enum_del(enum_name character varying, enum_elem character varying, enum_schema character varying DEFAULT 'public'::character varying)
  RETURNS void AS
$BODY$
DECLARE
    type_oid INTEGER;
    rec RECORD;
    sql VARCHAR;
    ret INTEGER;
    schemaoid INTEGER;
BEGIN
    SELECT oid INTO schemaoid FROM pg_namespace WHERE nspname = enum_schema;
    IF NOT FOUND THEN
    RAISE EXCEPTION 'Could not find schema ''%''', enum_schema;
    END IF;
    SELECT pg_type.oid
    FROM pg_type
    WHERE typtype = 'e' AND typname = enum_name AND typnamespace = schemaoid
    INTO type_oid;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cannot find a enum: %', enum_name;
    END IF;
    -- Check column DEFAULT value references.
    SELECT *
    FROM
        pg_attrdef
        JOIN pg_attribute ON attnum = adnum AND atttypid = type_oid
        JOIN pg_class ON pg_class.oid = attrelid
        JOIN pg_namespace ON pg_namespace.oid = relnamespace
    WHERE
        adsrc = quote_literal(enum_elem) || '::' || quote_ident(enum_name)
    LIMIT 1
    INTO rec;
    IF FOUND THEN
        RAISE EXCEPTION
            'Cannot delete the ENUM element %.%: column %.%.% has DEFAULT value of ''%''',
            quote_ident(enum_name), quote_ident(enum_elem),
            quote_ident(rec.nspname), quote_ident(rec.relname),
            rec.attname, quote_ident(enum_elem);
    END IF;
    -- Check data references.
    FOR rec IN
        SELECT *
        FROM
            pg_attribute
            JOIN pg_class ON pg_class.oid = attrelid
            JOIN pg_namespace ON pg_namespace.oid = relnamespace
        WHERE
            atttypid = type_oid
            AND relkind = 'r'
    LOOP
        sql :=
            'SELECT 1 FROM ONLY '
            || quote_ident(rec.nspname) || '.'
            || quote_ident(rec.relname) || ' '
            || ' WHERE '
            || quote_ident(rec.attname) || ' = '
            || quote_literal(enum_elem)
            || ' LIMIT 1';
        EXECUTE sql INTO ret;
        IF ret IS NOT NULL THEN
            RAISE EXCEPTION
                'Cannot delete the ENUM element %.%: column %.%.% contains references',
                quote_ident(enum_name), quote_ident(enum_elem),
                quote_ident(rec.nspname), quote_ident(rec.relname),
                rec.attname;
        END IF;
    END LOOP;
    -- OK. We may delete.
    DELETE FROM pg_enum WHERE enumtypid = type_oid AND enumlabel = enum_elem;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

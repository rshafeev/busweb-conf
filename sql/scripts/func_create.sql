
/*
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'bus.test';
select bus.update_graph_relations(id) from bus.routes WHERE route_type_id <> bus.route_type_enum('c_route_station_input') LIMIT 10;
*/


CREATE OR REPLACE FUNCTION bus._recurs_get_path_droutes(curr_node    bigint,
													    _droutes bigint[]
                                                     )
 RETURNS bigint[] AS
$BODY$
DECLARE
 _curr_rid bigint;
 _parent_id bigint;
BEGIN
  SELECT curr_rid,parent_id INTO _curr_rid,_parent_id FROM  bus._droute_trees WHERE id = curr_node;
  _droutes := array_append(_droutes,_curr_rid);
  IF _parent_id IS NOT NULL THEN
	_droutes := bus._recurs_get_path_droutes(_parent_id,_droutes);
  END IF;
  return _droutes;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
                                                    
--==========================================================================================================================  


CREATE OR REPLACE FUNCTION bus._recurs_make_subpaths(curr_node    bus._droute_trees,
													 curr_droutes bigint[],
													 _city_id bigint
                                                     )
RETURNS void AS
$BODY$
DECLARE
 _r          record;
 new_node    bus._droute_trees;

 transition   bus.route_transition;
 _root_index  integer;
 
BEGIN
  curr_droutes :=  array_append(curr_droutes,curr_node.curr_rid);
  FOR _r IN 
     SELECT bus.direct_routes.id as droute_id  FROM bus.direct_routes
     JOIN   bus.routes ON bus.routes.id = bus.direct_routes.route_id
     WHERE  city_id = _city_id AND
            bus.direct_routes.id <> ANY(curr_droutes) AND
            bus.possible_route_transiton(curr_node.curr_rid,bus.direct_routes.id,curr_node.curr_index) = true
  LOOP
    transition:= bus.find_route_transiton(curr_node.curr_rid, _r.droute_id,curr_node.curr_index);
    new_node.id                 := -1;
    new_node.parent_id          := curr_node.id;
    new_node.root_rid           := curr_node.root_rid;
    new_node.root_index         := -1;
    new_node.curr_rid           := _r.droute_id;
    new_node.curr_index         := transition.index_b;
    new_node.level              := curr_node.level + 1;
    new_node.parent_relation_id := transition.route_relation_a_id;
     
    if curr_node.level = 0 then
		new_node.root_index := transition.index_a;
    else
        new_node.root_index := curr_node.root_index;
    end if;
    
	INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (new_node.parent_id,   -- parent_id
			        new_node.root_rid,  -- root_rid
			        new_node.root_index,  -- root_index
			        new_node.curr_rid,    -- curr_rid
			        new_node.curr_index,    -- curr_index
			        new_node.level,            -- level
			        new_node.parent_relation_id  -- parent_relation_id
			        ) RETURNING id INTO new_node.id;
	if new_node.level < bus._MAX_TREE_LEVEL() then
		--execute bus._recurs_make_subpaths(new_node,curr_droutes,_city_id);
    end if;
  END LOOP; 
  
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus._make_subpaths(droute_id bigint, _city_id bigint)
RETURNS void AS
$BODY$
DECLARE
 _curr_node  bus._droute_trees%ROWTYPE;
 droutes bigint[];
BEGIN
  FOR _curr_node IN 
     SELECT * FROM  bus._droute_trees 
     WHERE bus._droute_trees.curr_rid = droute_id AND level < bus._MAX_TREE_LEVEL()
  LOOP
     droutes := bus._recurs_get_path_droutes(_curr_node.id, droutes ) ;
     EXECUTE bus._recurs_make_subpaths(_curr_node, droutes,_city_id);
 
  END LOOP;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
CREATE OR REPLACE FUNCTION bus.update_droute_trees(droute_id bigint)
RETURNS void AS
$BODY$
DECLARE
 _r  		  record;
 _city_id     bigint;
 _route_id    bigint;
 transition   bus.route_transition;
 _root_index  integer;
BEGIN
  -- Найдем id города, которому принадлежит текущий маршрут
  SELECT bus.routes.city_id,bus.routes.id INTO _city_id,_route_id FROM bus.direct_routes
       join bus.routes ON bus.routes.id = bus.direct_routes.route_id
       where bus.direct_routes.id = droute_id LIMIT 1;
 
  -- Удалим все ноды, соотв. текущему маршруту
  DELETE FROM bus._droute_trees WHERE curr_rid = droute_id;
  
  -- Добавим корень дерева 
  INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (NULL,droute_id,0,droute_id,0,0,NULL);
 
  --Добавим ноды, соотв. текущему маршруту к тем родителям, с которых возможен переход на текущий маршрут   
 FOR _r IN 
     select bus._droute_trees.id               as node_id,
			bus._droute_trees.root_rid         as root_rid,
			bus._droute_trees.root_index       as root_index,
			bus._droute_trees.curr_rid         as curr_rid,
			bus._droute_trees.curr_rid         as curr_index,
			bus._droute_trees.level            as level
			
			from bus._droute_trees
		    join bus.direct_routes ON bus.direct_routes.id = bus._droute_trees.curr_rid
			join bus.routes        ON bus.routes.id = bus.direct_routes.route_id
			where city_id = _city_id and
				level < bus._MAX_TREE_LEVEL() and
				bus.routes.id <> _route_id and
				bus.possible_route_transiton(curr_rid,droute_id,curr_index) = true
LOOP
    transition:= find_route_transiton(_r.curr_rid,droute_id,_r.curr_index);
    if _r.level = 0 then
		_root_index := transition.index_a;
    else
       _root_index  := _r.root_index;
    end if;
	INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (_r.node_id,   -- parent_id
			        _r.root_rid,  -- root_rid
			        _root_index,  -- root_index
			        droute_id,    -- curr_rid
			        transition.index_b,    -- curr_index
			        _r.level+1,            -- level
			        transition.route_relation_a_id  -- parent_relation_id
			        );
 

END LOOP;
  -- Создадим поддеревья, корнями для которых являются ноды, соотв. текущему маршруту 
  EXECUTE bus._make_subpaths(droute_id,_city_id);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.possible_route_transiton( _from_droute_id  bigint, 
                                                    _to_droute_id    bigint,
                                                    _start_index     integer
                                                    )
RETURNS bool AS
$BODY$
DECLARE
 _r bus.route_transition;
BEGIN   
  _r :=  bus.find_route_transiton(_from_droute_id,_to_droute_id,_start_index);
  if _r IS NULL THEN
    return false;
  END IF;
  return true;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
                                              
--==========================================================================================================================  
/*
  Функция get_route_transiton ищет первый возможый переход с маршрута _from_droute_id на 
  маршрут _to_droute_id, начиная с дуги первого маршрута, индекс которой равен _start_index.
  
  @_from_droute_id Id маршрута, для которого ищем переход на маршрут _to_droute_id
  @_to_droute_id Id машршрута, на который возможен переход с маршрута _from_droute_id
  @_start_index Индекс дуги маршута droute1_id, с которой начинаем поиск перехода на droute2_id
  @return Возвращает первый найденный переход
*/
CREATE OR REPLACE FUNCTION bus.find_route_transiton( _from_droute_id  bigint, 
                                                    _to_droute_id    bigint,
                                                    _start_index     integer
                                                    )
RETURNS bus.route_transition AS
$BODY$
DECLARE
 _r bus.route_transition;
BEGIN
-- Найдем дуги(переходы) между пересек. маршрутами
 FOR _r IN 
   SELECT  
           table1.id as route_relation_a_id, 
           table2.id as route_relation_b_id, 
           table1.position_index as index_a,
           table2.position_index as index_b,
           st_distance(table1.location, table2.location) as distance
   FROM  
	(select  bus.route_relations.id as id,
	         position_index,
	         location,
	         station_b_id
	    from bus.route_relations
	    join bus.stations ON bus.stations.id = bus.route_relations.station_b_id
	    where direct_route_id = _from_droute_id and position_index >= _start_index
	    order by position_index
        ) as table1
        ,
    (select  bus.route_relations.id as id,
             position_index,
             location, 
             station_a_id
        from bus.route_relations
	    join bus.stations ON bus.stations.id = bus.route_relations.station_a_id
        where direct_route_id = _to_droute_id
	    order by position_index
        ) as table2
   WHERE  ST_DWithin(table1.location, table2.location,bus._MAX_TRANSITION_DISTANCE())
         AND    bus._is_has_transition(table1.id,table2.id, bus._MAX_TRANSITION_DISTANCE()/2.0)
   LIMIT 1            
 LOOP
 END LOOP;
 return _r;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.lib_shortest_paths(sql text, source_id integer, target_id integer, directed boolean, has_reverse_cost boolean)
  RETURNS SETOF bus.paths_result AS
'$libdir/libpgcityways', 'shortest_paths'
  LANGUAGE c IMMUTABLE STRICT
COST 1 ROWS 1000;

--==========================================================================================================================  
CREATE OR REPLACE FUNCTION bus._get_prev_relation(_direct_route_id bigint,_prev_index bigint)
RETURNS bus.route_relations AS
$BODY$
DECLARE
 _prev_relation    bus.route_relations;
BEGIN
 _prev_index := _prev_index + 1;
  SELECT * INTO _prev_relation FROM bus.route_relations WHERE direct_route_id = _direct_route_id AND position_index = _prev_index LIMIT 1;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _prev_relation;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION bus._get_next_relation(_direct_route_id bigint,_curr_index bigint)
RETURNS bus.route_relations AS
$BODY$
DECLARE
 _next_relation    bus.route_relations;
BEGIN
 _curr_index := _curr_index + 1;
  SELECT * INTO _next_relation FROM bus.route_relations WHERE direct_route_id = _direct_route_id AND position_index = _curr_index LIMIT 1;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _next_relation;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--==========================================================================================================================  
CREATE OR REPLACE FUNCTION bus._is_has_transition(_curr_relation_a_id integer, 
						 _curr_relation_b_id integer,
						 _max_distance double precision
						 )
RETURNS bool AS
$BODY$
DECLARE
  _curr_relation_a    bus.route_relations%ROWTYPE;
  curr_relation_b_sta bigint;
  curr_relation_b_stb bigint;
  
  next_relation_a_stb bigint;
BEGIN
 --  RETURN 1;
    SELECT id,direct_route_id,station_a_id,station_b_id,position_index INTO _curr_relation_a FROM bus.route_relations WHERE id = _curr_relation_a_id LIMIT 1;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
    SELECT station_a_id,station_b_id INTO curr_relation_b_sta,curr_relation_b_stb FROM bus.route_relations WHERE id = _curr_relation_b_id LIMIT 1;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
  
  
  IF  bus.is_nearest_stations(_curr_relation_a.station_a_id,curr_relation_b_stb, _max_distance)  THEN
    return false;
  END IF;
 
   SELECT station_b_id INTO next_relation_a_stb FROM bus.route_relations WHERE direct_route_id = _curr_relation_a.direct_route_id AND 
                                                                               position_index = _curr_relation_a.position_index LIMIT 1;
   IF NOT FOUND THEN
	return true;
  END IF;
   
 --_next_relation_a := bus._get_next_relation(_curr_relation_a.direct_route_id,_curr_relation_a.position_index);
  IF next_relation_a_stb IS NOT NULL AND next_relation_a_stb = curr_relation_b_stb THEN
	return false;
  END IF;
  
  return true;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION bus.is_nearest_stations(_station_a_id bigint, _station_b_id bigint,distance double precision)
RETURNS bool AS
$BODY$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;

 return ST_DWithin(p1, p2,distance);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
--===============================================================================================================

CREATE OR REPLACE FUNCTION bus.get_distance_between_stations(_station_a_id bigint, _station_b_id bigint)
RETURNS double precision AS
$BODY$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id LIMIT 1;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id LIMIT 1;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;

 return st_distance(p1,p2);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
--===============================================================================================================
CREATE OR REPLACE FUNCTION bus.delete_graph_relations(_route_id bigint)
RETURNS void AS
$BODY$
DECLARE
 _route_type_id     bus.route_type_enum;
 _stA_ID            bigint;
 _stB_ID            bigint;
BEGIN

SELECT route_type_id INTO _route_type_id FROM bus.routes WHERE id = _route_id  LIMIT 1;

IF _route_type_id = bus.route_type_enum('c_route_metro_transition') THEN
   select station_a_id,station_b_id  INTO _stA_ID,_stB_ID  FROM bus.route_relations 
                  JOIN bus.direct_routes ON bus.direct_routes.id = bus.route_relations.direct_route_id
				  JOIN bus.routes        ON bus.routes.id = bus.direct_routes.route_id
				  WHERE bus.routes.id = _route_id AND
				        bus.direct_routes.direct = BIT '1' AND
				        position_index = 1 LIMIT 1;
	DELETE FROM bus._graph_relations WHERE 
	  relation_a_id IN (select bus.route_relations.id from bus.route_relations 
				join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
				join bus.routes        on bus.routes.id        = bus.direct_routes.route_id
				where (station_b_id = _stA_ID or station_b_id = _stB_ID) and
				      bus.routes.route_type_id = bus.route_type_enum('c_route_metro')) AND
	  relation_b_id IN (select bus.route_relations.id from bus.route_relations 
				join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
				join bus.routes        on bus.routes.id        = bus.direct_routes.route_id
				where (station_b_id = _stA_ID or station_b_id = _stB_ID) and
				      bus.routes.route_type_id = bus.route_type_enum('c_route_metro'));
ELSE
	DELETE FROM bus._graph_relations WHERE 
		relation_a_id IN (select bus.route_relations.id from bus.route_relations 
				join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
				where route_id = _route_id) OR
		relation_b_id IN (select bus.route_relations.id from bus.route_relations 
				join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
				where route_id = _route_id);
END IF;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


--===============================================================================================================

CREATE OR REPLACE FUNCTION bus.update_graph_relations_by_city(_city_id bigint)
RETURNS void AS
$BODY$
DECLARE

BEGIN
  PERFORM bus.update_graph_relations(id) from bus.routes WHERE city_id = _city_id;
 
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
--===============================================================================================================
CREATE OR REPLACE FUNCTION bus.update_graph_relations(_route_id bigint)
RETURNS void AS
$BODY$
DECLARE

BEGIN
  EXECUTE bus.delete_graph_relations(_route_id);
  EXECUTE bus._insert_graph_relations(_route_id);
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
--===============================================================================================================
CREATE OR REPLACE FUNCTION bus._insert_graph_relations(_route_id bigint)
RETURNS void AS
$BODY$
DECLARE
  _city_id 				bigint;
  _direct_id 			bigint;
  _reverse_id 			bigint;
  _route_type_id     bus.route_type_enum;
BEGIN
   SELECT route_type_id INTO _route_type_id FROM bus.routes WHERE id = _route_id LIMIT 1;
  IF _route_type_id = bus.route_type_enum('c_route_metro_transition') THEN
    return;
  END IF;
  -- Получим id города
  SELECT city_id INTO _city_id FROM bus.routes WHERE id = _route_id LIMIT 1;
  IF NOT FOUND THEN
     RAISE EXCEPTION 'city_id for route %  was not found', _route_id;
  END IF;
  
  
 

  -- получим id прямого и обратного пути
  SELECT id INTO _direct_id FROM bus.direct_routes WHERE route_id = _route_id AND direct = BIT '1'  LIMIT 1;
  IF NOT FOUND THEN
     RAISE EXCEPTION 'direct_id for route %  was not found', _route_id;
  END IF;
  
  SELECT id INTO _reverse_id FROM bus.direct_routes WHERE route_id = _route_id AND direct = BIT '0' LIMIT 1;
  IF NOT FOUND THEN
     RAISE EXCEPTION 'reverse_id for route %  was not found', _route_id;
  END IF;
  
  EXECUTE bus._insert_graph_relations(_city_id, _route_id, _direct_id);
  EXECUTE bus._insert_graph_relations(_city_id, _route_id, _reverse_id);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--===============================================================================================================
CREATE OR REPLACE FUNCTION bus._insert_graph_relations(_city_id      			bigint,
													   _route_id    			bigint,
													   _direct_route_id			bigint
													   )
RETURNS void AS
$BODY$
DECLARE
  i                integer;
  count            integer;
  _pause           interval;
  _frequency       interval;
  _r               record;
  _max_distance    double precision; -- максимальное расстояние между соседними узлами, в метрах
  _temp_relations  bus._graph_relations[];
  _relations       bus._graph_relations[];
  _graph_relation  bus._graph_relations%ROWTYPE;
  _foot_speed      double precision;
BEGIN
 _pause     := interval '00:00:08';
 _frequency := interval '00:05:00';
 _max_distance := bus._MAX_TRANSITION_DISTANCE();
 
 
  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
  
 -- Добавим дуги между узлами маршрута

 INSERT INTO bus._graph_relations (city_id,relation_a_id,
 relation_b_id,relation_b_type,wait_time,move_time,cost_money,cost_time,distance,is_transition)
 SELECT  
	    bus.routes.city_id                           as city_id,
	    r1.id                       				 as relation_a_id,
        r2.id          			    				 as relation_b_id,
        bus.routes.route_type_id                     as relation_b_type,
        interval '00:00:00'                          as wait_time,
        (r2.ev_time + _pause)   					 as move_time,
		0                                            as cost_money,
		EXTRACT(EPOCH FROM r2.ev_time + _pause)      as cost_time,
		r2.distance                                  as distance,
		false                                        as is_transition                               
    
        from bus.route_relations  as r1
	JOIN bus.route_relations  as r2     ON r1.station_B_id = r2.station_A_id
	JOIN bus.direct_routes              ON r2.direct_route_id = direct_routes.id
	JOIN bus.routes                     ON direct_routes.route_id = routes.id
 WHERE r1.direct_route_id = _direct_route_id and r2.direct_route_id = _direct_route_id ;

-- Найдем дуги(переходы) между пересек. маршрутами
 FOR _r IN 
   SELECT  table1.id as relation_a_id, 
           table2.id as relation_b_id, 
           bus.get_distance_between_stations(table1.station_b_id, table2.station_b_id) as distance
   FROM  
	(select bus.route_relations.id as id,location,station_b_id  from bus.route_relations
	    join bus.stations ON bus.stations.id = bus.route_relations.station_b_id
	    where bus.stations.city_id = _city_id and direct_route_id = _direct_route_id
        ) as table1
        ,
    (select bus.route_relations.id as id,location,station_b_id from bus.route_relations
	    join bus.stations ON bus.stations.id = bus.route_relations.station_b_id
        join bus.direct_routes ON bus.direct_routes.id = bus.route_relations.direct_route_id
        join bus.routes ON bus.routes.id = bus.direct_routes.route_id
	    where bus.stations.city_id = _city_id and bus.routes.id <> _route_id
        ) as table2
        where  ST_DWithin(table1.location, table2.location,_max_distance)

 LOOP
      _graph_relation.relation_a_id := _r.relation_a_id;
      _graph_relation.relation_b_id := _r.relation_b_id;
      _graph_relation.distance      := _r.distance;
      _temp_relations:= array_append(_temp_relations,_graph_relation);    
 END LOOP;
 
 -- insert reverse relations
  i:=1;
  count := array_upper(_temp_relations,1);
  WHILE i<= count LOOP
     _graph_relation.relation_a_id := _temp_relations[i].relation_b_id;
	 _graph_relation.relation_b_id := _temp_relations[i].relation_a_id;
	 _graph_relation.distance      := _temp_relations[i].distance;
	 _temp_relations := array_append(_temp_relations,_graph_relation);
     i:= i + 1;
  END LOOP;
  
  i:=1;
  count := array_upper(_temp_relations,1);
  WHILE i<= count LOOP
      
        IF bus._is_has_transition(_temp_relations[i].relation_a_id,_temp_relations[i].relation_b_id, _max_distance/2.0) = true THEN
			_relations := array_append(_relations,_temp_relations[i]);
	    END IF;
	i:= i + 1;
  END LOOP;
  
  
    INSERT INTO bus._graph_relations (city_id,relation_a_id,
 relation_b_id,relation_b_type,wait_time,move_time,cost_money,cost_time,distance,is_transition)
  SELECT  
              _city_id            												as city_id,
	          relations.relation_a_id 											as relation_a_id,
              relations.relation_b_id 											as relation_b_id,
              bus.routes.route_type_id                                          as relation_b_type,
              bus.time_routes.freq	                    						as wait_time,
			  (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00'  as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00' + bus.time_routes.freq/2.0) as cost_time,
			  relations.distance                                                as distance,
		      true                                                              as is_transition        
      from unnest(_relations) as relations
              JOIN bus.route_relations as r1 ON  r1.id = relations.relation_a_id
              JOIN bus.route_relations as r2 ON  r2.id = relations.relation_b_id
              JOIN bus.direct_routes         ON bus.direct_routes.id = r2.direct_route_id
              JOIN bus.routes                ON bus.routes.id = bus.direct_routes.route_id
	          JOIN bus.time_routes           ON bus.routes.id = bus.time_routes.route_id;
	
END;
$BODY$
LANGUAGE plpgsql VOLATILE;  

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
	           (SELECT paths.path_id as path_id,count(*) as count FROM temp_paths 
	                   JOIN bus.route_relations ON bus.route_relations.id = temp_paths.relation_id
	                   WHERE bus.route_relations.id <> _relation_input_id
	                  GROUP BY temp_paths.path_id,bus.route_relations.direct_route_id
	           ) as t1
	           WHERE t1.count = 1
	LOOP
           _id_arr:= array_append(_id_arr,_id);
	END LOOP;

  DELETE FROM temp_paths where path_id = ANY(_id_arr);
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
  CREATE OR REPLACE FUNCTION bus.find_shortest_paths(	_city_id  	bigint,
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
 relations_A 		    bus.nearest_relation[];
 relations_B 		    bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 --count_i 		integer;
 --count_j 		integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path;
 _temp_filter_path	bus.filter_path;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
 _id_arr                integer[];
 _id                    integer;
 _start_id              integer;
 _finish_id             integer;
 _r                     record;
 transition_sql         text;
BEGIN

  -- Сохраним скорость движения пешехода (км/ч) в переменную  _foot_speed
  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
  
  
 -- get _relation_input_id
 /*_relation_input_id := bus._get_relation_input_id(_city_id);*/

  -- создадим временную таблицу  use_routes(id,discount) используемых типов маршрутов и 
  -- скидки по каждому в процентном эквиваленте(от 0 до 1)
  CREATE TEMPORARY  TABLE temp_use_routes  ON COMMIT DROP AS
    SELECT route_type as id,discount FROM 
	(select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)
	) as route_types
    JOIN
    ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)
    ) as discounts
    ON discounts.id =  route_types.id;

  
 -- Зададим id начальной и конечной дуги
 _start_id  := -10;
 _finish_id := -11;
 transition_sql := ' AND bus._graph_relations.is_transition = false';
 --SELECT max(id) INTO _start_id FROM bus._graph_relations;       
  if  'c_route_transition' = ANY(_route_types) then
	transition_sql := '';
  end if;
 -- Найдем ближайшие дуги от начальной точки назначения и сохраним их во временную таблицу  nearest_relations
 CREATE TEMPORARY  TABLE temp_nearest_relations  ON COMMIT DROP AS
    (SELECT    -row_number() over (ORDER BY (select 0))-1 		      			as id,
              _start_id           												as relation_a_id,
              nr_table.id         												as relation_b_id,
              bus.routes.route_type_id                                          as relation_b_type,
              bus.time_routes.freq	                    						as wait_time,
			  (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			  interval '00:01:00' + bus.time_routes.freq/2.0)                   as cost_time,
			  nr_table.distance                                                 as distance,
			  true                                                              as is_transition
		FROM bus.find_nearest_relations(_p1,
				 _city_id,
				 _max_distance) as nr_table
		JOIN bus.route_relations ON bus.route_relations.id = nr_table.id
		JOIN bus.direct_routes   ON bus.direct_routes.id = bus.route_relations.direct_route_id
		JOIN bus.routes          ON bus.routes.id = bus.direct_routes.route_id
		JOIN bus.time_routes     ON bus.time_routes.route_id = bus.routes.id
     );
     
  -- Найдем ближайшие дуги до конечной точки назначения и сохраним их в таблицу nearest_relations
  SELECT min(id) INTO i FROM temp_nearest_relations;  
  INSERT INTO temp_nearest_relations(id,relation_a_id,relation_b_id,relation_b_type,wait_time,
                                move_time,cost_money,cost_time,distance,is_transition)
  (SELECT    -row_number() over (ORDER BY (select 0)) +i     		           as id,
             nr_table.id                                                       as relation_a_id,
             _finish_id           										  	   as relation_b_id,
             bus.route_type_enum('c_route_station_output')           		   as relation_b_type,
             interval '00:00:00'                    						   as wait_time,
			 (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			 0.0		                                                       as cost_money,
			 EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			 interval '00:01:00') 											   as cost_time,
			 nr_table.distance                                                 as distance,
			 true                                                              as is_transition
		FROM bus.find_nearest_relations(_p2,
				 _city_id,
				 _max_distance) as nr_table
     );
    
  
   
  -- Составим query графа
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
  	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        cost_time                           as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        cost_time                      as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type' ||
  	         ')';
  	ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        temp_use_routes.discount*cost_money as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        temp_use_routes.discount*cost_money as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type ' ||
  	         ')';
  ELSE
     	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        (cost_money + cost_time/10.0) as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        (cost_money + cost_time/10.0)       as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type ' ||
  	         ')';
   END IF;	
   i:=1;
   
 /*  FOR _r IN EXECUTE ('select * from ( '|| query || ' ) as tt1') 
   LOOP
     RAISE  NOTICE 'output data: %',_r; 
     i := i + 1;
   END LOOP;*/
  
  -- Создадим временную таблицу paths, в которую сохраним найденные пути
  CREATE TEMPORARY TABLE temp_paths
  (
     path_id     integer, -- id пути
     index       integer, -- индекс дуги
     relation_id integer, -- id дуги из таблицы bus.route_relations
     graph_id    bigint   -- id дуги из таблицы bus._graph_relations
  )ON COMMIT DROP;
  
 /* RAISE NOTICE 'paths:';
  FOR _r IN select *
		   from bus.lib_shortest_paths(query,_start_id,_finish_id,true,false) as t1
  LOOP
    RAISE NOTICE '%',_r;
  END LOOP;
  RAISE NOTICE 'paths end.';*/
  -- Найдем кратчайший путь
  BEGIN
     INSERT INTO temp_paths(path_id,index,relation_id,graph_id)
		   select t1.path_id                                 as path_id,
                  row_number() over (ORDER BY (select 0))    as index,
		          t1.vertex_id                               as relation_id,
		          t1.edge_id                                 as graph_id
		   from bus.lib_shortest_paths(query,_start_id,_finish_id,true,false) as t1;
 -- EXCEPTION  WHEN OTHERS THEN 
      RAISE  NOTICE 'count(i222): %',i; 
  END;
 -- Сохраним в _paths только нужную  инфу о маршрутах
 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		temp_paths.path_id                                    as path_id,
		temp_paths.graph_id									  as graph_id,
		temp_paths.index                                      as index,
		temp_paths.relation_id                                as relation_id,
		bus.route_relations.direct_route_id                   as direct_route_id,
		bus.route_relations.position_index                    as relation_index,
		bus.route_relations.station_b_id                      as station_id,
		graph_relations.relation_b_type                       as route_type,
		graph_relations.move_time                             as move_time,
		(graph_relations.cost_money*temp_use_routes.discount) as cost,
		graph_relations.distance                              as distance,
		graph_relations.is_transition                         as is_transition
		
	    FROM temp_paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = temp_paths.relation_id
	    LEFT JOIN ( (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM bus._graph_relations) 
	                 UNION ALL 
	                (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM temp_nearest_relations)) as graph_relations 
	         ON graph_relations.id = temp_paths.graph_id
	    LEFT JOIN temp_use_routes                                 ON temp_use_routes.id = graph_relations.relation_b_type 
	ORDER BY temp_paths.path_id,temp_paths.index
  LOOP
     -- Если текущий путь не меняется, 
     IF _curr_filter_path.relation_id = _start_id THEN
			
     ELSEIF _curr_filter_path.relation_id = _finish_id THEN
			--RAISE  NOTICE 'finish path: %',_curr_filter_path; 
 			 _temp_filter_path:= null;
             _temp_filter_path.distance   := _prev_filter_path.distance;
             _temp_filter_path.move_time  := _prev_filter_path.move_time;
			 _temp_filter_path.route_type :=  bus.route_type_enum('c_route_station_output');
			 _temp_filter_path.index      := 10000;
			 _temp_filter_path.path_id    := _prev_filter_path.path_id;
			 _paths:= array_append(_paths,_temp_filter_path);

     ELSEIF _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id OR
            _prev_filter_path.direct_route_id IS NULL THEN 
			-- RAISE  NOTICE 'path: %',_curr_filter_path; 
			
			-- Добавим данные о начале  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
			_temp_filter_path.move_time := _prev_filter_path.move_time;
			_temp_filter_path.cost      := _prev_filter_path.cost;
			_temp_filter_path.distance  := _prev_filter_path.distance;
			_paths:= array_append(_paths,_temp_filter_path);
             -- Обнулим накапливающие переменные времени передвижения и длины текущего маршрута
			_move_time := _curr_filter_path.move_time;
			_distance  := _curr_filter_path.distance;
     ELSEIF _curr_filter_path.graph_id <= 0 OR 
            _curr_filter_path.is_transition = true THEN
            --RAISE  NOTICE 'path: %',_curr_filter_path; 
            -- Добавим данные о конце  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
            _temp_filter_path.move_time := _move_time;
            _temp_filter_path.cost      := null;
            _temp_filter_path.distance  := _distance;
            _paths :=  array_append(_paths,_temp_filter_path);
	 ELSE
			--RAISE  NOTICE 'path: %',_curr_filter_path; 
			_move_time := _move_time + _curr_filter_path.move_time;
			_distance  := _distance + _curr_filter_path.distance;
     
     END IF;
     _prev_filter_path := _curr_filter_path;
    -- RAISE  NOTICE 'path: %',_curr_filter_path; 
   END LOOP;
  
 -- return data
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			        as path_id,
		paths.index 			        as index,
		bus.direct_routes.id 		    as direct_route_id,
		bus.routes.route_type_id 	    as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		time_table.freq                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	    LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
          LEFT JOIN (select route_id,avg(freq) as freq from bus.time_routes group by route_id) as time_table 
                             ON  time_table.route_id = bus.routes.id
                             
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
  /*
  select  * from  bus.find_shortest_path(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.026350246659 36.3360857963562)'),
				 st_geographyfromtext('POINT(50.0046342324976 36.234312426768)'),
				 bus.day_enum('c_Monday'),
				 time  '10:00:00',
				 500,
				 ARRAY['c_route_station_input',
					   'c_route_station_output'
				       'c_route_transition',
				       'c_route_trolley',
				       'c_route_metro',
				       'c_route_bus'],
				 ARRAY[1,
				       1,
				       1,
				       0.5,
				       1],
				 bus.alg_strategy('c_cost'),
				 bus.lang_enum('c_ru')) ORDER BY path_id,index; 
  
  */
CREATE OR REPLACE FUNCTION bus.find_shortest_path(	_city_id  	bigint,
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
 relations_A 		    bus.nearest_relation[];
 relations_B 		    bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 count_i 		integer;
 count_j 		integer;
 _curr_path_id             integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path;
 _temp_filter_path	bus.filter_path;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
 _id_arr                integer[];
 _id                    integer;
 _start_id              integer;
 _finish_id             integer;
 _r                  record;
BEGIN

  -- Сохраним скорость движения пешехода (км/ч) в переменную  _foot_speed
  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
  
  -- создадим временную таблицу  use_routes(id,discount) используемых типов маршрутов и 
  -- скидки по каждому в процентном эквиваленте(от 0 до 1)
  CREATE TEMPORARY  TABLE use_routes  ON COMMIT DROP AS
    SELECT route_type as id,discount FROM 
	(select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)
	) as route_types
    JOIN
    ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)
    ) as discounts
    ON discounts.id =  route_types.id;

   
 -- Зададим id начальной и конечной дуги
 _start_id  := -10;
 _finish_id := -11;
     
 
 -- Найдем ближайшие дуги от начальной точки назначения и сохраним их во временную таблицу  nearest_relations
 CREATE TEMPORARY  TABLE nearest_relations  ON COMMIT DROP AS
    (SELECT    -row_number() over (ORDER BY (select 0))-1 		      			as id,
              _start_id           												as relation_a_id,
              nr_table.id         												as relation_b_id,
              bus.routes.route_type_id                                          as route_type_id,
              bus.route_type_enum('c_route_station_input')						as relation_type,
              bus.time_routes.freq	                    						as wait_time,
			  (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			  interval '00:01:00' + bus.time_routes.freq/2.0)                   as cost_time,
			  nr_table.distance                                                 as distance
		FROM bus.find_nearest_relations(_p1,
				 _city_id,
				 _max_distance) as nr_table
		JOIN bus.route_relations ON bus.route_relations.id = nr_table.id
		JOIN bus.direct_routes   ON bus.direct_routes.id = bus.route_relations.direct_route_id
		JOIN bus.routes          ON bus.routes.id = bus.direct_routes.route_id
		JOIN bus.time_routes     ON bus.time_routes.route_id = bus.routes.id
     );
     
  -- Найдем ближайшие дуги до конечной точки назначения и сохраним их в таблицу nearest_relations
  SELECT min(id) INTO i FROM nearest_relations;  
  INSERT INTO nearest_relations(id,relation_a_id,relation_b_id,route_type_id,relation_type,wait_time,
                                move_time,cost_money,cost_time,distance)
  (SELECT    -row_number() over (ORDER BY (select 0)) +i     		           as id,
             nr_table.id                                                       as relation_a_id,
             _finish_id           										  	   as relation_b_id,
             bus.route_type_enum('c_route_station_output')           		   as route_type_id,
             bus.route_type_enum('c_route_station_output')			  		   as relation_type,
             interval '00:00:00'                    						   as wait_time,
			 (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			 0.0		                                                       as cost_money,
			 EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			 interval '00:01:00') 											   as cost_time,
			 nr_table.distance                                                 as distance
		FROM bus.find_nearest_relations(_p2,
				 _city_id,
				 _max_distance) as nr_table
     );
   
  -- Составим query графа
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
    query := 'select 0;';
  ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  	query := '(SELECT bus._graph_relations.id         as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        use_routes.discount*cost_money as cost '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' LEFT JOIN use_routes ON use_routes.id = bus._graph_relations.route_type_id' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT nearest_relations.id           as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        use_routes.discount*cost_money as cost '   ||
  	         ' FROM nearest_relations '                          ||
  	         ' JOIN use_routes ON use_routes.id = nearest_relations.route_type_id' ||
  	         ')';
  ELSE
    query := 'select 0;';
   END IF;	
   i:=1;
   
  -- Создадим временную таблицу paths, в которую сохраним найденные пути
  CREATE TEMPORARY TABLE paths
  (
     path_id     integer, -- id пути
     index       integer, -- индекс дуги
     relation_id integer, -- id дуги из таблицы bus.route_relations
     graph_id    bigint   -- id дуги из таблицы bus._graph_relations
  )ON COMMIT DROP;
  
  _curr_path_id:= 1; -- текущий индекс маршрута
  
  -- Найдем кратчайший путь
  WHILE _curr_path_id < 2 LOOP
  BEGIN
     INSERT INTO paths(path_id,index,relation_id,graph_id)
		   select _curr_path_id                           as path_id,
                  row_number() over (ORDER BY (select 0)) as index,
		          t1.vertex_id                            as relation_id,
		          t1.edge_id                              as graph_id
		   from shortest_path(query,_start_id,_finish_id,true,false) as t1;
  EXCEPTION  WHEN OTHERS THEN 
    
  END;
  _curr_path_id:= _curr_path_id + 1;
 END LOOP;
 -- Сохраним в _paths только нужную  инфу о маршрутах
 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		paths.path_id                                         as path_id,
		paths.graph_id										  as graph_id,
		paths.index                                           as index,
		paths.relation_id                                     as relation_id,
		bus.route_relations.direct_route_id                   as direct_route_id,
		bus.route_relations.position_index                    as relation_index,
		bus.route_relations.station_b_id                      as station_id,
		graph_relations.relation_type                         as route_type,
		graph_relations.move_time                             as move_time,
		(graph_relations.cost_money*use_routes.discount)      as cost,
		graph_relations.distance                              as distance
	    FROM paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = paths.relation_id
	    LEFT JOIN ( (SELECT id,relation_type,move_time,cost_money,distance,route_type_id FROM bus._graph_relations) 
	                 UNION ALL 
	                (SELECT id,relation_type,move_time,cost_money,distance,route_type_id FROM nearest_relations)) as graph_relations 
	         ON graph_relations.id = paths.graph_id
	    LEFT JOIN use_routes                                 ON use_routes.id = graph_relations.route_type_id 
	ORDER BY paths.path_id,paths.index
  LOOP
     -- Если текущий путь не меняется, 
     IF _curr_filter_path.relation_id = _start_id THEN
			
     ELSEIF _curr_filter_path.relation_id = _finish_id THEN
			_temp_filter_path:= null;
	         _temp_filter_path.distance  := _prev_filter_path.distance;
             _temp_filter_path.move_time := _prev_filter_path.move_time;
			_temp_filter_path.route_type :=  bus.route_type_enum('c_route_station_output');
			_temp_filter_path.index      := 10000;
			_temp_filter_path.path_id    := _prev_filter_path.path_id;
			_paths:= array_append(_paths,_temp_filter_path);

     ELSEIF _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id OR
            _prev_filter_path.direct_route_id IS NULL THEN 
			
			-- Добавим данные о начале  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
			_temp_filter_path.move_time := _prev_filter_path.move_time;
			_temp_filter_path.cost      := _prev_filter_path.cost;
			_temp_filter_path.distance  := _prev_filter_path.distance;
			_paths:= array_append(_paths,_temp_filter_path);
             -- Обнулим накапливающие переменные времени передвижения и длины текущего маршрута
			_move_time := _curr_filter_path.move_time;
			_distance  := _curr_filter_path.distance;
     ELSEIF _curr_filter_path.graph_id <= 0 OR 
            _curr_filter_path.route_type = bus.route_type_enum('c_route_transition') THEN
            -- Добавим данные о конце  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
            _temp_filter_path.move_time := _move_time;
            _temp_filter_path.cost      := null;
            _temp_filter_path.distance  := _distance;
            _paths :=  array_append(_paths,_temp_filter_path);
	 ELSE
			_move_time := _move_time + _curr_filter_path.move_time;
			_distance  := _distance + _curr_filter_path.distance;
     
     END IF;
     _prev_filter_path := _curr_filter_path;
   END LOOP;
  
 -- return data
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			        as path_id,
		paths.index 			        as index,
		bus.direct_routes.id 		    as direct_route_id,
		bus.routes.route_type_id 	    as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		time_table.freq                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	    LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
        LEFT JOIN (select route_id,avg(freq) as freq from bus.time_routes group by route_id) as time_table 
                             ON  time_table.route_id = bus.routes.id
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
  
/*CREATE OR REPLACE FUNCTION bus._get_relation_input_id(_city_id bigint)
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
  */
--=================================================================================================


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

--INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_station_input','c_foot',B'0');
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
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_transition'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),0.0);

--INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_station_input'),1.0);
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
/* Функция возвращает дуги от/до точки, выбранной пользователем и ближайшими
   узлами графа
*/
CREATE OR REPLACE FUNCTION bus.find_nearest_relations(
   _location       geography,           -- местоположение точки назначения
   _city_id        bigint,              -- город
   max_distance    double precision     -- максимальное расстояние от/до точки назначения
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
                     WHERE city_id = _city_id AND  ST_DWithin(location, _location,max_distance)
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
 
 --====================================================================================================================	
 

CREATE OR REPLACE FUNCTION bus.drop_functions(_schema text, _del text = '')
RETURNS text AS
$BODY$
DECLARE
    _sql   text;
    _ct    text;

BEGIN
   SELECT INTO _sql, _ct
          string_agg('DROP '
                   || CASE p.proisagg WHEN true THEN 'AGGREGATE '
                                                ELSE 'FUNCTION ' END
                   || quote_ident(n.nspname) || '.' || quote_ident(p.proname)
                   || '('
                   || pg_catalog.pg_get_function_identity_arguments(p.oid)
                   || ');'
                  ,E'\n'
          )
          ,count(*)::text
   FROM   pg_catalog.pg_proc p
   LEFT   JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
   WHERE  n.nspname = _schema;
   -- AND p.proname ~~* 'f_%';                     -- Only selected funcs?
   -- AND pg_catalog.pg_function_is_visible(p.oid) -- Only visible funcs?

IF lower(_del) = 'del' THEN                        -- Actually delete!
   EXECUTE _sql;
   RETURN _ct || E' functions deleted:\n' || _sql;
ELSE                                               -- Else only show SQL.
   RETURN _ct || E' functions to delete:\n' || _sql;
END IF;

END;
$BODY$   LANGUAGE plpgsql ;

 --========================CONSTANTS======================================	

CREATE OR REPLACE FUNCTION bus._MAX_TRANSITION_DISTANCE()
RETURNS double precision AS
$BODY$
DECLARE
BEGIN
 return 350.0;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE NOT LEAKPROOF;

--================

CREATE OR REPLACE FUNCTION bus._MAX_TREE_LEVEL()
RETURNS integer AS
$BODY$
DECLARE
BEGIN
 return 5;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE NOT LEAKPROOF;






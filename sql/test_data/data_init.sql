CREATE OR REPLACE FUNCTION bus.get_distance_between_stations(_station_a_id bigint, _station_b_id bigint)
RETURNS double precision AS
$BODY$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;

 return st_distance(p1,p2);
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.get_next_relation(_curr_relation_id integer,_station_b_id bigint)
RETURNS bus.route_relations AS
$BODY$
DECLARE
 _next_relation    bus.route_relations;
BEGIN
  SELECT * INTO _next_relation FROM bus.route_relations WHERE station_a_id = _station_b_id;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _next_relation;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.is_has_transition(_curr_relation_a_id integer, 
						 _curr_relation_b_id integer,
						 _max_distance      double precision
						 )
RETURNS integer AS
$BODY$
DECLARE
  _curr_relation_a    bus.route_relations%ROWTYPE;
  _curr_relation_b    bus.route_relations%ROWTYPE;
  
  _next_relation_a    bus.route_relations;
  _next_relation_b    bus.route_relations;
BEGIN
 
    SELECT * INTO _curr_relation_a FROM bus.route_relations WHERE id = _curr_relation_a_id;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
    SELECT * INTO _curr_relation_b FROM bus.route_relations WHERE id = _curr_relation_b_id;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
  _next_relation_a:= bus.get_next_relation(_curr_relation_a.id,_curr_relation_a.station_b_id);
  _next_relation_b:= bus.get_next_relation(_curr_relation_b.id,_curr_relation_b.station_b_id);
  --return -1;
  IF _next_relation_a IS NOT NULL AND _next_relation_b IS NOT NULL THEN
	IF  ( bus.get_distance_between_stations(_curr_relation_a.station_b_id,_curr_relation_b.station_b_id) < _max_distance AND
	      bus.get_distance_between_stations(_next_relation_a.station_b_id,_next_relation_b.station_b_id) < _max_distance)
	    OR
	    ( bus.get_distance_between_stations(_curr_relation_a.station_b_id,_next_relation_b.station_b_id) < _max_distance AND
	      bus.get_distance_between_stations(_next_relation_a.station_b_id,_curr_relation_b.station_b_id) < _max_distance)
	THEN
	    return -1;
	END IF;
  END IF;
  return 1;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================
CREATE OR REPLACE FUNCTION bus.insert_transitions_for_metro_transition(_route_id     bigint
) RETURNS void AS
$BODY$
DECLARE
  r 		     bus.graph_relations%ROWTYPE;
  _foot_speed    double precision;
BEGIN
   
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.insert_transitions(_route_id            bigint,
								                  _route_type   	   bus.route_type_enum,
								                  _max_distance        double precision
) RETURNS void AS
$BODY$
DECLARE
  _graph_relation      bus.graph_relations%ROWTYPE;
  r                    bus.relation%ROWTYPE;
  relations            bus.relation[];
  i                    int;
  count                int;
  _row                 record;
  _city_id             bigint;
  _arr_types           bus.route_type_enum[];
  _foot_speed    double precision;
BEGIN

  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
         
_arr_types = array[bus.route_type_enum('c_route_metro'),bus.route_type_enum('c_route_metro_transition')];

-- get city_id
SELECT city_id INTO _city_id from bus.routes where id = _route_id;

-- add transitions between 'c_route_metro' and 'c_route_metro_transition'
IF _route_type = ANY(_arr_types) THEN
  EXECUTE bus.insert_transitions_for_metro_transition(_route_id);

END IF;

-- get all nearest route_relations to current route 
FOR r IN
SELECT 
        r1.id                       as source,
        table2.relation_id          as target,
        st_distance(table2.location,bus.stations.location) as  distance,
        _route_type                 as source_route_type,
	bus.routes.route_type_id    as target_route_type       
FROM    bus.route_relations  as r1
        JOIN bus.stations       ON bus.stations.id = r1.station_b_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        JOIN bus.routes         ON bus.routes.id = bus.direct_routes.route_id

        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_b_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  where bus.direct_routes.route_id = _route_id
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        st_distance(table2.location,bus.stations.location) < _max_distance AND
	        (bus.routes.route_type_id <> ALL(_arr_types) OR _route_type <> ALL(_arr_types))
	        
	LOOP
	  relations := array_append(relations,r);
	END LOOP;	     

-- insert reverse relations
  i:=1;
  count := array_upper(relations,1);
  WHILE i<= count LOOP
        r.source = relations[i].target;
        r.target = relations[i].source;
        relations := array_append(relations,r);
	i:= i + 1;
  END LOOP;
  RAISE NOTICE 'update_transitions(): %',count;

  -- insert into graph_relations
  INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
  SELECT  
              _city_id            												as city_id,
	          bus.routes.route_type_id                                          as route_type_id,
              bus.route_type_enum('c_route_transition')							as relation_type,
              relations.source 													as relation_a_id,
              relations.target 													as relation_b_id,
              bus.timetable.time_a 												as time_a,
              bus.timetable.time_b 												as time_b,
              bus.schedule_group_days.day_id      								as day_id,
              bus.timetable.frequency                    						as wait_time,
			  (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00'  as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00' + bus.timetable.frequency/2.0) as cost_time,
			  relations.distance                                                as distance
		
      from unnest(relations) as relations
              JOIN bus.route_relations as r1 ON  r1.id = relations.source
              JOIN bus.route_relations as r2 ON  r2.id = relations.target
              JOIN bus.direct_routes         ON bus.direct_routes.id = r2.direct_route_id
              JOIN bus.routes                ON bus.routes.id = bus.direct_routes.route_id
	      
	      JOIN bus.schedule              ON bus.schedule.direct_route_id = r2.direct_route_id
              JOIN bus.schedule_groups       ON bus.schedule_groups.schedule_id = bus.schedule.id
              JOIN bus.schedule_group_days   ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
              JOIN bus.timetable             ON bus.timetable.schedule_group_id = bus.schedule_groups.id    

              where r1.station_a_id IS NOT NULL  AND 
                    r2.station_a_id IS NOT NULL  AND
                    bus.is_has_transition(relations.source,relations.target, _max_distance/2.0) > 0;
  select count(*) into count from bus.graph_relations;
  RAISE NOTICE 'transitions count: %',count;
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================

CREATE OR REPLACE FUNCTION bus.insert_graph_relations(_direct_route_id	bigint,_route_station_input_id bigint)
RETURNS void AS
$BODY$
DECLARE
  _pause interval;
BEGIN

 -- insert route relations
 _pause := interval '00:00:08';
 INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
 SELECT  
	    bus.routes.city_id                           as city_id,
	    bus.routes.route_type_id    				 as route_type_id,
	    bus.routes.route_type_id                     as relation_type,
        r1.id                       				 as relation_a_id,
        r2.id          			    				 as relation_b_id,
        null                  						 as time_a,
        null   	                    				 as time_b,
        day_enum('c_all')							 as day_id,
        interval '00:00:00'                          as wait_time,
        (r2.ev_time + _pause)   					 as move_time,
		0                                            as cost_money,
		EXTRACT(EPOCH FROM r2.ev_time + _pause)      as cost_time,
		r2.distance                 as distance
    
        from bus.route_relations  as r1
	JOIN bus.route_relations  as r2     ON r1.station_B_id = r2.station_A_id
	JOIN bus.direct_routes              ON r2.direct_route_id = direct_routes.id
	JOIN bus.routes                     ON direct_routes.route_id = routes.id
WHERE r1.direct_route_id = _direct_route_id and r2.direct_route_id = _direct_route_id ;

-- insert relations between station and route_station (virtual relation) 
 INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
 SELECT  
	bus.routes.city_id                          as city_id,
	bus.routes.route_type_id                    as route_type_id,
	bus.route_type_enum('c_route_station_input') as relation_type,
    _route_station_input_id                     as relation_a_id,
    bus.route_relations.id                      as relation_b_id,
    bus.timetable.time_a                        as time_a,
    bus.timetable.time_b   	                    as time_b,
    bus.schedule_group_days.day_id              as day_id,
    bus.timetable.frequency                     as wait_time,
    interval '00:00:00'                         as move_time,
    bus.routes.cost                             as cost_money,
    EXTRACT(EPOCH FROM bus.timetable.frequency/2.0) as cost_time,
    0                                           as distance   
    from bus.route_relations 
	JOIN bus.direct_routes       ON bus.direct_routes.id = bus.route_relations.direct_route_id
	JOIN bus.routes              ON bus.routes.id = bus.direct_routes.route_id
    JOIN bus.schedule            ON bus.route_relations.direct_route_id = bus.schedule.direct_route_id
	JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
    JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
    JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id
WHERE bus.route_relations.direct_route_id = _direct_route_id;


        
END;
$BODY$
LANGUAGE plpgsql VOLATILE;  
--====================================================================================================================	

CREATE OR REPLACE FUNCTION bus.add_route_relation(_station_A_id 		bigint, 
												 _station_B_id 		bigint,
												 _direct_route_id	bigint,
												 _index        		bigint,
												 _transport_speed 	double precision,
												 _relation_input_id bigint
												) 
RETURNS void AS
$BODY$
DECLARE
  _speed                double precision; 
  _distance             double precision;
  _p1               	geometry;
  _p2                   geometry;
  _geom                 geometry;
  _time                 interval;
BEGIN
    IF _station_A_id  IS NOT NULL AND _station_B_id IS NOT NULL THEN
		SELECT location INTO _p1 FROM bus.stations WHERE id = _station_A_id;
		SELECT location INTO _p2 FROM bus.stations WHERE id = _station_B_id;
		_geom := st_makeline(ARRAY [_p1,_p2,_p2,_p2]);
		_distance := st_length(_geom,false);
		_time := _distance/1000.0/_transport_speed * interval '1 hour';
    ELSE
        _distance := 0.0;
        _time     := interval '00:00:00';
    END IF;
INSERT INTO bus.route_relations (direct_route_id,station_A_id,station_B_id,position_index,geom,ev_time,distance) 
          VALUES (_direct_route_id,_station_A_id,_station_B_id,_index,_geom,_time,_distance);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


--=================================================================================================


CREATE OR REPLACE FUNCTION bus.add_route(_city_id 				bigint,
										_direct_stations 		bigint[], 
										 _reverse_stations 		bigint[],
										 _route_type_id 	    bus.route_type_enum,
										 _number                text,
										 _names 				text[][],
										 _cost                  double precision
										 )
RETURNS void AS
$BODY$
DECLARE
  i  					bigint;
  _direct_route_id      bigint;
  _reverse_route_id     bigint;
  _schedule_id          bigint;
  _schedule_group_id    bigint;
  _route  		        bus.routes%ROWTYPE;
  _transport_type       bus.transport_types%ROWTYPE;
  _relation_input_id    bigint;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'
  max_distance          double precision;
BEGIN
 max_distance := 500;
 
 -- get _relation_input_id
 _relation_input_id := bus.get_relation_input_id(_city_id);
 -- get transport_type
 SELECT bus.transport_types.id,bus.transport_types.ev_speed INTO _transport_type FROM bus.route_types JOIN bus.transport_types 
          ON bus.route_types.transport_id = bus.transport_types.id 
		  WHERE bus.route_types.id = _route_type_id;
 IF NOT FOUND THEN
      RAISE EXCEPTION 'could not define transport type for route_type %',_route_type_id;
 END IF; 
 
 -- insert route
 INSERT INTO bus.routes (city_id,route_type_id,number,cost) VALUES (_city_id,_route_type_id,_number,_cost) RETURNING  * INTO  _route;
 
 -- insert names
 i := 0;
 WHILE i< array_upper(_names,1) LOOP
   --RAISE NOTICE ' % : %', _names[i+1][1],_names[i+1][2];
   INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_route.name_key,lang_enum(_names[i+1][1]),_names[i+1][2]);
   i:= i + 1;
 END LOOP;
 
 -- insert direct_route
 INSERT INTO bus.direct_routes (route_id,direct) VALUES (_route.id,B'0') RETURNING id INTO _direct_route_id;
 INSERT INTO bus.direct_routes (route_id,direct) VALUES (_route.id,B'1') RETURNING id INTO _reverse_route_id;
 
 -- insert direct stations
 i := 0;
 WHILE i< array_upper(_direct_stations,1) LOOP
   EXECUTE bus.add_route_relation(_direct_stations[i],_direct_stations[i+1],_direct_route_id,i,_transport_type.ev_speed,1);
   i:= i + 1;
 END LOOP;

 -- insert reverse stations
 i := 0;
 WHILE i< array_upper(_reverse_stations,1) LOOP
   EXECUTE bus.add_route_relation(_reverse_stations[i],_reverse_stations[i+1],_reverse_route_id,i,_transport_type.ev_speed,1);
   i:= i + 1;
 END LOOP; 
 
 
 
 -- insert schedule
 INSERT INTO bus.schedule (direct_route_id) VALUES(_direct_route_id) RETURNING id INTO _schedule_id;
 INSERT INTO bus.schedule_groups (schedule_id) VALUES (_schedule_id) RETURNING id INTO _schedule_group_id;
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_all'));
/*
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Sunday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Saturday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Monday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Tuesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Wednesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Thursday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Friday'));*/
 INSERT INTO bus.timetable(schedule_group_id,time_A,time_B,frequency) 
				VALUES (_schedule_group_id,time '06:00:00', time '22:00:00', interval '00:05:00');

 INSERT INTO bus.schedule (direct_route_id) VALUES(_reverse_route_id) RETURNING id INTO _schedule_id;
 INSERT INTO bus.schedule_groups (schedule_id) VALUES (_schedule_id) RETURNING id INTO _schedule_group_id;
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_all'));
 /*
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Sunday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Saturday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Monday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Tuesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Wednesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Thursday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Friday'));*/
 INSERT INTO bus.timetable(schedule_group_id,time_A,time_B,frequency) 
				VALUES (_schedule_group_id,time '06:00:00', time '22:00:00', interval '00:05:00');

 EXECUTE bus.insert_graph_relations(_direct_route_id,_relation_input_id);
 EXECUTE bus.insert_graph_relations(_reverse_route_id,_relation_input_id);
 -- insert transitions
 EXECUTE bus.insert_transitions(_route.id,_route_type_id,max_distance);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.stations_init(v_city_id bigint)
RETURNS void AS
$BODY$
DECLARE
    i               bigint;
	st_geroiv  		bus.stations%ROWTYPE;
	st_stud    		bus.stations%ROWTYPE;
	st_ac_pavlova   bus.stations%ROWTYPE;
	st_ac_barabash  bus.stations%ROWTYPE;
	st_kievsk       bus.stations%ROWTYPE;
	st_pyshk        bus.stations%ROWTYPE;
	st_univer       bus.stations%ROWTYPE;
	st_istor        bus.stations%ROWTYPE;
	
	st_august       bus.stations%ROWTYPE;
	st_botan_sad    bus.stations%ROWTYPE;
	st_nauchnaia    bus.stations%ROWTYPE;
	st_gosprom      bus.stations%ROWTYPE;
	st_arch_biket   bus.stations%ROWTYPE;
	st_vosstania    bus.stations%ROWTYPE;
	st_metrost 		bus.stations%ROWTYPE;
	
	st_xol_gora 		bus.stations%ROWTYPE;
	st_vokzal 		    bus.stations%ROWTYPE;
	st_cent_market 		bus.stations%ROWTYPE;
	st_sovetsk 		    bus.stations%ROWTYPE;
	st_prosp_gagarina   bus.stations%ROWTYPE;
	st_sport 		    bus.stations%ROWTYPE;
	st_zavod_malish     bus.stations%ROWTYPE;
	st_mosk_prosp 		bus.stations%ROWTYPE;
	st_marsh_guk 		bus.stations%ROWTYPE;
	st_sovet_armii 		bus.stations%ROWTYPE;
	st_maselskogo 		bus.stations%ROWTYPE;
	st_traktor 		    bus.stations%ROWTYPE;
	st_proletar 		bus.stations%ROWTYPE;
		
	

BEGIN


--== Geroiv praci ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0253650246659 36.3360857963562)')) 
			RETURNING  * INTO  st_geroiv;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_geroiv.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_geroiv.name_key,'c_ru','Героев труда');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_geroiv.name_key,'c_en','Geroiv praci');


--== Studentska ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0176997043346 36.3299918174744)')) 
			RETURNING  * INTO  st_stud;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_stud.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_stud.name_key,'c_ru','Студенческая');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_stud.name_key,'c_en','Studentska');

--== Academica Pavlova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0090127013683 36.3178038597107)')) 
			RETURNING  * INTO  st_ac_pavlova;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_ac_pavlova.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_pavlova.name_key,'c_ru','Академика Павлова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_pavlova.name_key,'c_en','Academica Pavlova');

--== Academica Barabashova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0023067780423 36.3040602207184)')) 
			RETURNING  * INTO  st_ac_barabash;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_ac_barabash.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_barabash.name_key,'c_ru','Академика Барабашова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_barabash.name_key,'c_en','Academica Barabashova');

--== Kievskaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.001075820572 36.2700176239014)')) 
			RETURNING  * INTO  st_kievsk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_kievsk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_kievsk.name_key,'c_ru','Киевская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_kievsk.name_key,'c_en','Kievskaia');

--== Pushkinskaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0038066416005 36.247615814209)')) 
			RETURNING  * INTO  st_pyshk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_pyshk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_pyshk.name_key,'c_ru','Пушкинская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_pyshk.name_key,'c_en','Pushkinskaia');

--== University ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0046341324976 36.2337112426758)')) 
			RETURNING  * INTO  st_univer;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_univer.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_univer.name_key,'c_ru','Университет');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_univer.name_key,'c_en','University');

--== Istor. musem ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9929514004981 36.2312064170837)')) 
			RETURNING  * INTO  st_istor;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_istor.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_istor.name_key,'c_ru','Исторический музей');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_istor.name_key,'c_en','Istor. musem');

--=============================================================

--== 23 auguast ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0355169337227 36.2198925018311)')) 
			RETURNING  * INTO  st_august;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_august.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_august.name_key,'c_ru','23 августа');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_august.name_key,'c_en','23 August');

--== Botan sad ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0267504421571 36.2228965759277)')) 
			RETURNING  * INTO  st_botan_sad;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_botan_sad.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_botan_sad.name_key,'c_ru','Ботанический сад');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_botan_sad.name_key,'c_en','Botan sad');

--== Nauchnaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.0129082580197 36.2261581420898)')) 
			RETURNING  * INTO  st_nauchnaia;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_nauchnaia.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_nauchnaia.name_key,'c_ru','Научная');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_nauchnaia.name_key,'c_en','Nauchnaia');

--== Gosprom ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(50.004854794331 36.2313938140869)')) 
			RETURNING  * INTO  st_gosprom;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_gosprom.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_gosprom.name_key,'c_ru','Госпром');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_gosprom.name_key,'c_en','Gosprom');

--== Arch Beketova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9990620854991 36.2404918670654)')) 
			RETURNING  * INTO  st_arch_biket;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_arch_biket.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_arch_biket.name_key,'c_ru','Архитектора Бекетова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_arch_biket.name_key,'c_en','Arch Beketova ');

--== Vosstania square ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9887300223925 36.264910697937)')) 
			RETURNING  * INTO  st_vosstania;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_vosstania.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vosstania.name_key,'c_ru','Площадь восстания');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vosstania.name_key,'c_en','Vosstania square');

--== Metrostroitelei Vashenka ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9789683911537 36.2627863883972)')) 
			RETURNING  * INTO  st_metrost;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_metrost.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_metrost.name_key,'c_ru','Метростроителей им. Ващенка');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_metrost.name_key,'c_en','Metrostroitelei Vashenka');

--=============================================================

--== Xol gora ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9823282715423 36.1816549301147)')) 
			RETURNING  * INTO  st_xol_gora;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_xol_gora.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_xol_gora.name_key,'c_ru','Холодная гора');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_xol_gora.name_key,'c_en','Xolodna gora');

--== Ugniy vokzal ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9897371168367 36.2051939964294)')) 
			RETURNING  * INTO  st_vokzal;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_vokzal.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vokzal.name_key,'c_ru','Южный вокзал');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vokzal.name_key,'c_en','Ugniy vokzal');

--== Central market ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9927996580315 36.2193775177002)')) 
			RETURNING  * INTO  st_cent_market;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_cent_market.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_cent_market.name_key,'c_ru','Центральный рынок');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_cent_market.name_key,'c_en','Central market');

--== Radianska==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9917512424607 36.232852935791)')) 
			RETURNING  * INTO  st_sovetsk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sovetsk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovetsk.name_key,'c_ru','Советская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovetsk.name_key,'c_en','Radianska');

--== Prospect Gagarina ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9804517348322 36.242938041687)')) 
			RETURNING  * INTO  st_prosp_gagarina;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_prosp_gagarina.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_prosp_gagarina.name_key,'c_ru','Проспект Гагарина');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_prosp_gagarina.name_key,'c_en','Prospect Gagarina');

--== Sportivna ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9794582445876 36.2607908248901)')) 
			RETURNING  * INTO  st_sport;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sport.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sport.name_key,'c_ru','Спортивная');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sport.name_key,'c_en','Sportivna');

--== Zavod im. Malisheva ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9759325684943 36.28093957901)')) 
			RETURNING  * INTO  st_zavod_malish;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_zavod_malish.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_zavod_malish.name_key,'c_ru','Завод им. Малышева');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_zavod_malish.name_key,'c_en','Zavod im. Malisheva');

--== Moskovskii prospect ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9721789229428 36.3014960289001)')) 
			RETURNING  * INTO  st_mosk_prosp;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_mosk_prosp.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_mosk_prosp.name_key,'c_ru','Московский проспект');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_mosk_prosp.name_key,'c_en','Moskovskii prospect');

--== Marshala Gykova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9662442535992 36.3212370872498)')) 
			RETURNING  * INTO  st_marsh_guk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_marsh_guk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_marsh_guk.name_key,'c_ru','Маршала Жукова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_marsh_guk.name_key,'c_en','Marshala Gykova');

--== Sovetskoi armii ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9618548878886 36.3429093360901)')) 
			RETURNING  * INTO  st_sovet_armii;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sovet_armii.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovet_armii.name_key,'c_ru','Советской армии');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovet_armii.name_key,'c_en','Sovetskoi armii');

--== Maselskogo ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.95849357784841 36.36005973815918)')) 
			RETURNING  * INTO  st_maselskogo;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_maselskogo.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_maselskogo.name_key,'c_ru','Масельского');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_maselskogo.name_key,'c_en','Maselskogo');

--== Traktornii zavod ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9526331558422 36.3787007331848)')) 
			RETURNING  * INTO  st_traktor;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_traktor.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_traktor.name_key,'c_ru','Тракторный завод');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_traktor.name_key,'c_en','Traktornii zavod');

--== Proletarska ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geographyfromtext('POINT(49.9466408444924 36.3989996910095)')) 
			RETURNING  * INTO  st_proletar;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_proletar.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_proletar.name_key,'c_ru','Пролетарская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_proletar.name_key,'c_en','Proletarska');


i := 0;
/*
EXECUTE bus.add_route(v_city_id,
    ARRAY [st_univer.id,st_gosprom.id],
	ARRAY [st_gosprom.id,st_univer.id],
	bus.route_type_enum('c_route_metro_transition'),
	'',
	null,
	0.00);
	*/
WHILE i< 1 LOOP  
 RAISE NOTICE 'Add Routes iteration: %',i;

EXECUTE bus.add_route(v_city_id,
    ARRAY [st_geroiv.id,st_stud.id,st_ac_pavlova.id,st_ac_barabash.id,st_kievsk.id,st_pyshk.id,st_univer.id,st_istor.id],
	ARRAY [st_istor.id,st_univer.id,st_pyshk.id,st_kievsk.id,st_ac_barabash.id,st_ac_pavlova.id,st_stud.id,st_geroiv.id],
	bus.route_type_enum('c_route_trolley'),
	'324e',
	null,
	2.00);
/*
ARRAY [ARRAY ['c_en','Saltovska line'], ARRAY ['c_ru','Салтовская линия']]
*/
EXECUTE bus.add_route(v_city_id,
    ARRAY [st_august.id,st_botan_sad.id,st_nauchnaia.id,st_gosprom.id,st_arch_biket.id,st_vosstania.id,st_metrost.id],
	ARRAY [st_metrost.id,st_vosstania.id,st_arch_biket.id,st_gosprom.id,st_nauchnaia.id,st_botan_sad.id,st_august.id],
	bus.route_type_enum('c_route_metro'),
	'',
	ARRAY [ARRAY ['c_en','Oleksiivska line'], ARRAY ['c_ru','Алексеевская линия']],
	2.00);
		
EXECUTE bus.add_route(v_city_id,
    ARRAY [st_xol_gora.id,st_vokzal.id,st_cent_market.id,st_sovetsk.id,st_prosp_gagarina.id,st_sport.id,st_zavod_malish.id,
		   st_mosk_prosp.id,st_marsh_guk.id,st_sovet_armii.id,st_maselskogo.id,st_traktor.id,st_proletar.id],
	ARRAY [st_proletar.id,st_traktor.id,st_maselskogo.id,st_sovet_armii.id,st_marsh_guk.id,st_mosk_prosp.id,st_zavod_malish.id,
		   st_sport.id,st_prosp_gagarina.id,st_sovetsk.id,st_cent_market.id,st_vokzal.id,st_xol_gora.id],
	bus.route_type_enum('c_route_metro'),
	'',
	ARRAY [ARRAY ['c_en','Xolondo-gersko-zavodskaia line'], ARRAY ['c_ru','Холодногорско-заводская линия']],
	2.00);

EXECUTE bus.add_route(v_city_id,
    ARRAY [st_botan_sad.id,st_nauchnaia.id,st_gosprom.id,st_arch_biket.id,st_sport.id,st_zavod_malish.id],
	ARRAY [st_zavod_malish.id,st_sport.id,st_arch_biket.id,st_gosprom.id,st_nauchnaia.id,st_botan_sad.id],
	bus.route_type_enum('c_route_bus'),
	'34e',
	null,
	3.50);
		
 i:= i + 1;
 END LOOP;
 


END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
  
--==========================================================================================================================  
  
CREATE OR REPLACE FUNCTION bus.init()
RETURNS void AS
$BODY$
DECLARE
  v_id  bigint;
  name_key bigint;
  kharkov bus.cities%ROWTYPE;
  kiev bus.cities%ROWTYPE;
BEGIN

EXECUTE bus.init_system_data();
 
SELECT * INTO v_id FROM bus.insert_user_role('admin');
SELECT * INTO v_id FROM bus.insert_user('admin','roma','14R199009');
SELECT * INTO v_id FROM bus.insert_user('admin','marianna','14R199009');

-- insert cities --

INSERT INTO bus.cities (key,lat,lon,scale,is_show) VALUES('kharkiv',50,36,10,B'1') RETURNING  * INTO kharkov;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kharkov.name_key,'c_ru','Харьков');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kharkov.name_key,'c_en','Kharkov');

INSERT INTO bus.cities (key,lat,lon,scale,is_show) VALUES('kyiv', 50,30,8,B'1') RETURNING  * INTO kiev;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kiev.name_key,'c_ru','Киев');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kiev.name_key,'c_en','Kyiv');


-- insert stations to Kharkov
EXECUTE bus.stations_init(kharkov.id);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--- init ---
--BEGIN;  
 SELECT bus.init();
 DROP FUNCTION bus.init();
 DROP FUNCTION bus.stations_init(bigint);
 DROP FUNCTION bus.add_route(bigint,bigint[], bigint[],bus.route_type_enum, text, text[][],double precision);
		
 DROP FUNCTION bus.add_route_relation( bigint, bigint, 	bigint,	bigint,	double precision,bigint);
--COMMIT;

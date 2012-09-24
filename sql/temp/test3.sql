--transition
CREATE OR REPLACE FUNCTION bus.update_transitions(_direct_route_id  bigint,_max_distance double precision)
RETURNS SETOF record AS
$BODY$
DECLARE
  r 		record;
  _foot_speed    double precision;
BEGIN
  _foot_speed := 8;


-- add relations between  current route and  other route stations
FOR r IN

select bus.routes.city_id,
       bus.route_type_enum('c_route_foot') as route_type_id,
       relations.relation_a as relation_a_id,
       relations.relation_b as relation_b_id,
       bus.timetable.time_a as time_a,
       bus.timetable.time_b as time_b,
       bus.schedule_group_days.day_id      as day_id,
       (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00'   + bus.timetable.frequency as move_time,
       bus.routes.cost
       
from 
(SELECT table2.station_id as station_a,
	r1.station_a_id as station_b,
        r1.id as relation_a,
        table2.relation_id 		as relation_b,
	r1.direct_route_id 		as direct_route_a,
	table2.direct_route_id 		as direct_route_b,
	bus.direct_routes.route_id 	as route_a,
	table2.route_id   		as route_b,
	st_distance(geography(table2.location),geography(bus.stations.location)) as distance       
FROM    bus.route_relations  as r1
        JOIN bus.stations       ON bus.stations.id = r1.station_a_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_b_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  where bus.direct_routes.route_id=_direct_route_id
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        st_distance(geography(table2.location),geography(bus.stations.location)) < _max_distance
) as relations
JOIN bus.routes ON bus.routes.id = relations.route_b
JOIN bus.schedule            ON bus.schedule.direct_route_id = relations.direct_route_b
JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id
LOOP
 RETURN NEXT r;

END LOOP;	


-- add relations between route stations and current route stations
FOR r IN

select bus.routes.city_id,
       bus.route_type_enum('c_route_foot') as route_type_id,
       relations.relation_a as relation_a_id,
       relations.relation_b as relation_b_id,
       bus.timetable.time_a as time_a,
       bus.timetable.time_b as time_b,
       bus.schedule_group_days.day_id      as day_id,
       (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00'   + bus.timetable.frequency as move_time,
       bus.routes.cost
       
from 
(SELECT r1.station_a_id as station_a,
        table2.station_id as station_b,
	r1.id as relation_a,
        table2.relation_id 		as relation_b,
	r1.direct_route_id 		as direct_route_a,
	table2.direct_route_id 		as direct_route_b,
	bus.direct_routes.route_id 	as route_a,
	table2.route_id   		as route_b,
	st_distance(geography(table2.location),geography(bus.stations.location)) as distance       
FROM    bus.route_relations  as r1
        JOIN bus.stations       ON bus.stations.id = r1.station_b_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_a_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  where bus.direct_routes.route_id = _direct_route_id
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        st_distance(geography(table2.location),geography(bus.stations.location)) < _max_distance
) as relations
JOIN bus.routes ON bus.routes.id = relations.route_b
JOIN bus.schedule            ON bus.schedule.direct_route_id = relations.direct_route_b
JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id
LOOP
 RETURN NEXT r;

END LOOP;	

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


SELECT* from   bus.update_transitions(1516,500) 
    as (city_id bigint, route_type_id bus.route_type_enum,relation_a_id bigint,relation_b_id bigint, 
        time_a time, time_b time, day_id day_enum , move_time interval, cost double precision);




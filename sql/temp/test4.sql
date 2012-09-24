--select * from bus.routes;

--select bus.update_transitions(6639,500);

select r1.station_b_id, r2.station_b_id,v1.value,v2.value,graph_relations.route_type_id,r1.direct_route_id from 
(


select bus.routes.city_id,
       bus.route_type_enum('c_route_foot') as route_type_id,
       relations.relation_a as relation_b_id,
       relations.relation_b as relation_a_id,
       bus.timetable.time_a as time_a,
       bus.timetable.time_b as time_b,
       bus.schedule_group_days.day_id      as day_id,
       (relations.distance/1000.0/5*60) * interval '00:01:00'   + bus.timetable.frequency as move_time,
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
        JOIN bus.stations       ON bus.stations.id = r1.station_b_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_b_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  where bus.direct_routes.route_id = 19 and bus.route_relations.station_a_id IS NOT NULL
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        r1.station_a_id IS NOT NULL AND
	        st_distance(geography(table2.location),geography(bus.stations.location)) < 500 
) as relations
JOIN bus.routes ON bus.routes.id = relations.route_b
JOIN bus.schedule            ON bus.schedule.direct_route_id = relations.direct_route_b
JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id

)
 as graph_relations
    JOIN bus.route_relations as r1 ON r1.id = graph_relations.relation_a_id
    JOIN bus.route_relations as r2 ON r2.id = graph_relations.relation_b_id
    LEFT JOIN bus.stations  as st1 ON st1.id = r1.station_b_id
    LEFT JOIN bus.stations  as st2 ON st2.id = r2.station_b_id
    LEFT JOIN bus.string_values as v1 ON v1.key_id = st1.name_key
    LEFT JOIN bus.string_values as v2 ON v2.key_id = st2.name_key
where (graph_relations.day_id IS NULL  or graph_relations.day_id = day_enum('c_Sunday')) AND
    v1.lang_id = 'c_ru' and   v2.lang_id = 'c_ru' and graph_relations.route_type_id='c_route_foot';
   

 

    /*SELECT 
    r1.station_a_id             as station_a,
    table2.station_id           as station_b,
	r1.id                       as relation_a,
    table2.relation_id 		    as relation_b,
	r1.direct_route_id 		    as direct_route_a,
	table2.direct_route_id 		as direct_route_b,
	bus.direct_routes.route_id 	as route_a,
	table2.route_id   		    as route_b,
	st_distance(geography(table2.location),geography(bus.stations.location)) as distance,
	table2.cost                     as cost       
FROM    bus.route_relations  as r1
        JOIN bus.stations       ON bus.stations.id = r1.station_b_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id,
		  bus.routes.cost            as cost
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_b_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  JOIN bus.routes ON bus.routes.id = bus.direct_routes.route_id
                  where bus.direct_routes.route_id =6
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        st_distance(geography(table2.location),geography(bus.stations.location)) < 500;
*/
	        
--select * from bus.cities;
/*
select * from bus.relations JOIN bus.schedule as schedule1   ON schedule1.direct_route_id = bus.relations.direct_route_a
			    JOIN bus.schedule as schedule2   ON schedule1.direct_route_id = bus.relations.direct_route_a
;*/

/*

select  bus.route_relations.id              as route_station_id,
	bus.route_relations.station_a_id as v1,
	bus.route_relations.station_b_id as v2,
	bus.routes.cost                as cost,
	bus.route_relations.ev_time     as time
	
	FROM bus.routes 
	JOIN bus.direct_routes       ON bus.direct_routes.route_id = bus.routes.id
        JOIN bus.schedule            ON bus.schedule.direct_route_id = bus.direct_routes.id
        JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
        JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
        JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id
        JOIN bus.route_relations     ON bus.route_relations.direct_route_id = bus.direct_routes.id
     
where 
       
       day_id  = day_enum('c_Monday')  AND 
       time_a < time '6:00:01'   AND time_b> time '6:00:00';
  */
/*
select * from bus.route_stations      AS route_stations1 
JOIN bus.route_stations      AS route_stations2 ON route_stations1.station_b_id = route_stations2.station_a_id
WHERE route_stations1.station_a_id <> route_stations2.station_b_id*/
--select * from bus.routes;
--select * from bus.relations;
/*
SELECT *          FROM bus.routes JOIN bus.direct_routes ON bus.direct_routes.route_id = bus.routes.id
                        
		        JOIN bus.schedule      ON bus.schedule.direct_route_id = bus.direct_routes.id
                        JOIN bus.schedule_groups ON bus.schedule_groups.schedule_id = bus.schedule.id
                        JOIN bus.schedule_group_days   ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
                        JOIN bus.timetable ON bus.timetable.schedule_group_id = bus.schedule_groups.id
                        ;*/
                 --JOIN bus.route_stations AS route_stations1 bus.direct_routes.route_id = bus.routes.id
		 -- JOIN bus.route_stations AS route_station2 ON route_stations1.station_b_id = route_station2.station_a_id;
           
/*select * from bus.schedule JOIN bus.schedule_groups ON bus.schedule_groups.schedule_id = bus.schedule.id
                           JOIN bus.schedule_group_days   ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
                           JOIN bus.timetable ON bus.timetable.schedule_group_id = bus.schedule_groups.id
                           JOIN bus.relations as relations1 ON relations1.direct_route_a = bus.schedule.direct_route_id
                           JOIN bus.relations as relations2 ON relations2.direct_route_b = bus.schedule.direct_route_id
                           where day_id=day_enum('c_Monday')  AND time_a < time '6:00:01' AND time_b> time '6:00:00';
*/
select * from bus.graph_relations;

 --select * from bus.stations JOIN bus.string_values ON bus.stations.name_key = bus.string_values.key_id where lang_id = 'c_ru';
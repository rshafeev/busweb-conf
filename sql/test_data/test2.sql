 BEGIN;
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.0253640226659 36.3350757963562)'),
				 st_geographyfromtext('POINT(50.0353179327227 36.2199825018311)'),
				 bus.day_enum('c_all'),
				 time  '10:00:00',
				 500,
				 ARRAY['c_route_trolley',
				       'c_route_metro',
				       'c_route_bus',
				       'c_route_transition',
				       'c_route_tram',
				       'c_route_station_output',
				       'c_route_station_input'],
				 ARRAY[1,
				       1,
				       1,
				       1,
				       1,
				       1,
				       1],
				 bus.alg_strategy('c_time'),
				 bus.lang_enum('c_ru')) ORDER BY path_id,index; 
/*
select * from temp_paths

 ORDER BY path_id,index;*/
 select  * from temp_nearest_relations;	
END;

/*
select  
       t1.path_id,
       t1.index,
       t1.direct_route_id,
       bus.routes.route_type_id as route_type,
       bus.routes.number as route_name,
       station_names.value as station_name,
       t1.relation_index,
       t1.ev_time + ( t1.last_index - t1.first_index)*bus._STATION_TIME_PAUSE() as move_time,
       bus.view_schedule_droutes.frequency as wait_time,
       bus.routes.cost as cost,
       t1.distance
from(
select temp_paths.path_id as path_id,
       temp_paths.index   as index, 
       bus.route_relations.station_b_id      as station_id,
       bus.route_relations.position_index  as relation_index,
       bus.route_relations.direct_route_id as direct_route_id,
       bus.direct_routes.route_id as route_id,
       sum(bus.route_relations.distance)       OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id)as distance,
       sum(bus.route_relations.ev_time)        OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id)as ev_time,
       min(bus.route_relations.position_index) OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id) as first_index,
       max(bus.route_relations.position_index) OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id) as last_index
       from temp_paths
         join bus._graph_nodes on bus._graph_nodes.id =  temp_paths.node_id
         join bus.route_relations on bus.route_relations.id = bus._graph_nodes.route_relation_id
         join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
 ) as t1
 left join bus.view_schedule_droutes on  bus.view_schedule_droutes.direct_route_id = t1.direct_route_id and 
           time_a <= time  '05:00:00' and time_b >= time  '05:00:00' and day_id = bus.day_enum('c_all')
 join bus.routes on bus.routes.id = t1.route_id
 join bus.stations on bus.stations.id = t1.station_id
 left join bus.string_values as station_names on station_names.key_id = bus.stations.name_key  
 where (t1.relation_index = t1.first_index or t1.relation_index = t1.last_index ) and
-- (time_a <= time  '01:00:00' and time_b >= time  '01:00:00' and day_id = bus.day_enum('c_all') ) and
 station_names.lang_id = 'c_ru'
 ORDER BY path_id,index;


select *from bus.station_transitions
         join bus.stations as sta on sta.id = station_transitions.station_a_id
         join bus.stations as stb on stb.id = station_transitions.station_b_id
         where sta.city_id = 1;

 
*/

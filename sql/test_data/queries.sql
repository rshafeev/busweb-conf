
--select bus.update_graph_relations(id) from bus.routes WHERE route_type_id <> bus.route_type_enum('c_route_station_input');
--AND city_id = 1 AND id = 4;

--select count(*) from bus.routes;
	
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(49.99296711397555 36.21909141540527)'),
				 st_geographyfromtext('POINT(50.005573856522304 36.23743772506714)'),
				 bus.day_enum('c_Monday'),
				 time  '10:00:00',
				 500,
				 ARRAY['c_route_station_input',
				       'c_route_station_output',
				       'c_route_transition',
				       'c_route_trolley',
				       'c_route_metro',
				       'c_route_bus'],
				 ARRAY[1,
				       1,
				       1,
				       1,
				       0.5,
				       1],
				 bus.alg_strategy('c_cost'),
				 bus.lang_enum('c_ru')) ORDER BY path_id,index; 

--SELECT * from nearest_relations;
/*
select s1.value,s2.value,bus._graph_relations.relation_a_id,bus._graph_relations.relation_b_id,* from bus._graph_relations 
	LEFT JOIN bus.route_relations as r1 ON r1.id = bus._graph_relations.relation_a_id
	LEFT JOIN bus.stations as st1 ON st1.id = r1.station_b_id
	LEFT JOIN bus.string_values as s1 ON s1.key_id = st1.name_key
	
	LEFT JOIN bus.route_relations as r2 ON r2.id = bus._graph_relations.relation_b_id
	LEFT JOIN bus.stations as st2 ON st2.id = r2.station_b_id
	LEFT JOIN bus.string_values as s2 ON s2.key_id = st2.name_key
	
	where bus._graph_relations.city_id  = 1 
	       AND s1.lang_id = 'c_ru' AND s2.lang_id = 'c_ru'
	       AND (r1.direct_route_id = 6 );
*/

/*
select bus.update_graph_relations(id) from bus.routes WHERE route_type_id <> bus.route_type_enum('c_route_station_input') 
   AND city_id = 1 AND id = 3;
select s1.value,s2.value,route1.id,route1.number,route2.number, bus._graph_relations.relation_a_id,bus._graph_relations.relation_b_id,* from bus._graph_relations 
	LEFT JOIN bus.route_relations as r1 ON r1.id = bus._graph_relations.relation_a_id
	LEFT JOIN bus.stations as st1 ON st1.id = r1.station_b_id
	LEFT JOIN bus.string_values as s1 ON s1.key_id = st1.name_key
	LEFT JOIN bus.direct_routes as dir1 ON  dir1.id = r1.direct_route_id
	LEFT JOIN bus.routes    as route1 ON route1.id = dir1.route_id

	LEFT JOIN bus.route_relations as r2 ON r2.id = bus._graph_relations.relation_b_id
	LEFT JOIN bus.stations as st2 ON st2.id = r2.station_b_id
	LEFT JOIN bus.string_values as s2 ON s2.key_id = st2.name_key
	LEFT JOIN bus.direct_routes as dir2 ON  dir2.id = r2.direct_route_id
	LEFT JOIN bus.routes    as route2 ON route2.id = dir2.route_id

	where bus._graph_relations.city_id  = 1 
	       AND s1.lang_id = 'c_ru' AND s2.lang_id = 'c_ru' and bus._graph_relations.relation_b_id = 11;
*/
	
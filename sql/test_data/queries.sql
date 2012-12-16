
--select bus.update_graph_relations(id) from bus.routes WHERE route_type_id <> bus.route_type_enum('c_route_station_input');
--AND city_id = 1 AND id = 4;

	
 select  * from  bus.shortest_ways(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.035753153247484 36.22037887573242)'),
				 st_geographyfromtext('POINT(50.025167052708014 36.334877014160156)'),
				 bus.day_enum('c_Monday'),
				 time  '10:00:00',
				 500,
				 ARRAY['c_route_station_input',
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
	
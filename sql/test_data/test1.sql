 BEGIN;
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(49.99317403468021 36.230506896972656)'),
				 st_geographyfromtext('POINT(50.0250567685471  36.335906982421875)'),
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
				 bus.lang_enum('c_ru')) WHERE path_id = 13  ORDER BY path_id,index; 

select * from temp_paths join bus._graph_relations ON bus._graph_relations.id = graph_id
WHERE path_id = 13 ;

END;

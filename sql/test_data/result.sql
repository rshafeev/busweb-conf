 BEGIN;
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

select * from temp_paths;

END;

 BEGIN;
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Киев'),
				 st_geographyfromtext('POINT(50.462148544138415 30.482511520385742)'),
				 st_geographyfromtext('POINT(50.42973665246389 30.54147720336914)'),
				 bus.day_enum('c_Monday'),
				 time  '10:00:00',
				 1100,
				 ARRAY['c_route_trolley',
				       'c_route_metro',
				       'c_route_bus',
				       'c_route_tram'],
				  true,
				 ARRAY[1,
				       1,
				       1],
				 bus.alg_strategy('c_time'),
				 bus.lang_enum('c_ru')) ORDER BY path_id,index; 
 --select  * from paths;
 --select * from droutes_zero where level = 4;
 
/*
select * from droutes_one  as t1
							join bus.route_transitions on t1.level = 2 and route_transitions.droute_a_id = t1.droute_b_id and
							                              route_transitions.from_index_a_id > t1.rindex_start_b
							join droutes_one  as t2    on t2.level = 3 and route_transitions.droute_b_id = t2.droute_a_id and
														  route_transitions.to_index_b_id < t2.rindex_finish_a;*/
-- select * from droutes_one where level = 3;
              
END;

/*
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.0253640226659 36.3350757963562)'),
				 st_geographyfromtext('POINT(50.0353179327227 36.2199825018311)'),
				 bus.day_enum('c_all'),
				 time  '10:00:00',
				 1800,
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

 select  * from temp_nearest_relations;	
END;

 
*/

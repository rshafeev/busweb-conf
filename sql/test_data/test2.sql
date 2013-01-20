 BEGIN;
 select  * from  bus.find_shortest_paths(bus.get_city_id(bus.lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.0253650246659 36.3360857963562)'),
				 st_geographyfromtext('POINT(50.0355169337227 36.2198925018311)'),
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

select * from temp_paths join bus._graph_relations ON bus._graph_relations.id = graph_id 
WHERE path_id <> -1 
 ORDER BY path_id,index;

END;
/*

{"cityID":1,"p1":{"lat":50.0253650246659,"lon":36.3360857963562},"p2":{"lat":50.0355169337227,"lon":36.2198925018311},
"usageRouteTypes":[{"route_type_id":"c_route_input","discount":1.0},
{"route_type_id":"c_route_output","discount":1.0},
{"route_type_id":"c_route_transition","discount":1.0},
{"route_type_id":"c_route_metro","discount":1.0},
{"route_type_id":"c_route_bus","discount":1.0},
{"route_type_id":"c_route_tram","discount":1.0},
{"route_type_id":"c_route_trolley","discount":1.0}],
"algStrategy":"c_time",
"langID":"c_ru",
"maxDistance":500.0,
"outTime":
{"dayID":"c_all","timeStart":36000000}}

*/

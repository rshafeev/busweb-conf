select * from  bus.shortest_ways(bus.get_city_id(lang_enum('c_ru'),'Харьков'),
				 st_geographyfromtext('POINT(50.0253650246659 36.3360857963562)'),
				 st_geographyfromtext('POINT(50.0355169337227 36.2198925018311)'),
				 day_enum('c_Monday'),
				 time  '10:00:00',
				 500,
				 ARRAY[bus.transport_type_enum('c_foot'),
				       bus.transport_type_enum('c_metro'),
				       bus.transport_type_enum('c_trolley')],
				 bus.get_discount_id(lang_enum('c_ru'),'Студенческий'),
				 bus.alg_strategy('c_cost'),
				 lang_enum('c_ru'))  
				--AS (id bigint, source  integer,target  integer,cost double precision);
				AS ( path_id  integer,relation_id  integer);
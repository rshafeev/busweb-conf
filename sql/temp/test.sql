
CREATE OR REPLACE FUNCTION bus.shortest_ways(	_city_id  	bigint,
						_p1 		geometry,
						_p2 		geometry,
						_day_id 	day_enum,
						_time_start  	time,
					        _max_distance 	double precision,
					        _transports 	bus.transport_type_enum[],
					        _discount_id    bigint)
RETURNS SETOF RECORD AS
$BODY$
DECLARE
 r record;
 station   bus.stations%ROWTYPE;
 statins_A bus.stations[];
 statins_B bus.stations[];
 
BEGIN
   FOR station IN select * FROM bus.find_nearest_stations(_p1,
				 _city_id,
				 _transports,
				 _max_distance)
  LOOP
     
          RAISE NOTICE 'found station';
   END LOOP;

   FOR station IN select * FROM bus.find_nearest_stations(_p2,
				 _city_id,
				 _transports,
				 _max_distance)
  LOOP
          RAISE NOTICE 'found station';
   END LOOP;
      
  CREATE TEMPORARY  TABLE use_routes  ON COMMIT DROP AS
  SELECT id,transport_id,discount FROM bus.route_types JOIN bus.discount_by_route_types 
        ON bus.route_types.id = bus.discount_by_route_types.route_type_id
        WHERE transport_id = ANY(_transports);

 FOR r IN select bus.routes.id from bus.routes JOIN use_routes ON use_routes.id = route_type_id  
			 JOIN bus.direct_routes ON bus.direct_routes.route_id = bus.routes.id
	 where city_id = _city_id
  LOOP
         RETURN NEXT r;
   END LOOP;
	 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--===============================================================================================================
/*
select * from  bus.shortest_ways(bus.get_city_id(lang_enum('c_ru'),'Харьков'),
				 st_geomfromtext('POINT(50.0253650246659 36.3360857963562)',4326),
				 st_geomfromtext('POINT(50.0355169337227 36.2198925018311)',4326),
				 day_enum('c_Monday'),
				 time '00:10:00',
				 500,
				 ARRAY[bus.transport_type_enum('c_metro'),bus.transport_type_enum('c_trolley')],
				 bus.get_discount_id(lang_enum('c_ru'),'Студенческий'))  
				AS (id bigiarray nt);


*/


CREATE TYPE bus.relation AS 
(
   source  integer,
   target  integer,
   distance double precision,
   source_route_type bus.route_type_enum,
   target_route_type bus.route_type_enum
);
--select * from bus.discounts JOIN bus.discount_by_route_types ON bus.discount_by_route_types.discount_id = bus.discounts.id;

/*select row_number() over (order by t1.id) as id, 
t1.id as relation_A, t2.id as relation_B,t1.direct_route_id as direct_route_A,t2.direct_route_id as direct_route_B
   FROM bus.route_stations as t1
   JOIN bus.route_stations as t2 ON t1.station_b_id = t2.station_a_id;

   */
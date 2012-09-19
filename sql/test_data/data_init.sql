
--==========================================================================================================================  


CREATE OR REPLACE FUNCTION bus.add_route_station(_station_A_id 		bigint, 
												 _station_B_id 		bigint,
												 _direct_route_id	bigint,
												 _index        		bigint,
												 _transport_speed 	double precision
												) 
RETURNS void AS
$BODY$
DECLARE
  _speed                double precision; 
  _distance             double precision;
  _p1               	geometry;
  _p2                   geometry;
  _geom                 geometry;
  _time                 interval;
BEGIN
	SELECT location INTO _p1 FROM bus.stations WHERE id = _station_A_id;
	SELECT location INTO _p2 FROM bus.stations WHERE id = _station_B_id;
    _geom := st_multi(st_makeline(_p1,_p2));
    _distance := st_length(geography(_geom),false);
    _time := _distance/1000.0/_transport_speed * interval '1 hour';

INSERT INTO bus.route_stations (direct_route_id,station_A_id,station_B_id,position_index,geom,ev_time,distance) 
          VALUES (_direct_route_id,_station_A_id,_station_B_id,_index,_geom,_time,_distance);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


--=================================================================================================


CREATE OR REPLACE FUNCTION bus.add_route(_city_id 				bigint,
										_direct_stations 		bigint[], 
										 _reverse_stations 		bigint[],
										 _route_type_id 			bus.route_type_enum,
										 _number                 text,
										 _names 				    text[][],
										 _cost                   double precision
										 )
RETURNS void AS
$BODY$
DECLARE
  i  					bigint;
  _route_id 			bigint;
  _direct_route_id      bigint;
  _reverse_route_id     bigint;
  _schedule_id          bigint;
  _schedule_group_id    bigint;
  _route  		        bus.routes%ROWTYPE;
  _transport_type       bus.transport_types%ROWTYPE;
BEGIN
 -- get transport_type
 SELECT bus.transport_types.id,bus.transport_types.ev_speed INTO _transport_type FROM bus.route_types JOIN bus.transport_types 
          ON bus.route_types.transport_id = bus.transport_types.id 
		  WHERE bus.route_types.id=_route_type_id;
 IF NOT FOUND THEN
      RAISE EXCEPTION 'could not define transport type';
 END IF; 
 
 -- insert route
 INSERT INTO bus.routes (city_id,route_type_id,number,cost) VALUES (_city_id,_route_type_id,_number,_cost) RETURNING  * INTO  _route;
 
 -- insert names
 i := 0;
 WHILE i< array_upper(_names,1) LOOP
   RAISE NOTICE ' % : %', _names[i+1][1],_names[i+1][2];
   INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_route.name_key,lang_enum(_names[i+1][1]),_names[i+1][2]);
   i:= i + 1;
 END LOOP;
 
 -- insert direct_route
 INSERT INTO bus.direct_routes (route_id,direct) VALUES (_route.id,B'0') RETURNING id INTO _direct_route_id;
 INSERT INTO bus.direct_routes (route_id,direct) VALUES (_route.id,B'1') RETURNING id INTO _reverse_route_id;
 
 -- insert direct stations
 i := 0;
 WHILE i< array_upper(_direct_stations,1)-1 LOOP
   EXECUTE bus.add_route_station(_direct_stations[i+1],_direct_stations[i+2],_direct_route_id,i,_transport_type.ev_speed);
   i:= i + 1;
 END LOOP;

 -- insert reverse stations
 i := 0;
 WHILE i< array_upper(_reverse_stations,1)-1 LOOP
   EXECUTE bus.add_route_station(_reverse_stations[i+1],_reverse_stations[i+2],_reverse_route_id,i,_transport_type.ev_speed);
   i:= i + 1;
 END LOOP; 
 
 -- insert schedule
 INSERT INTO bus.schedule (direct_route_id) VALUES(_direct_route_id) RETURNING id INTO _schedule_id;
 INSERT INTO bus.schedule_groups (schedule_id) VALUES (_schedule_id) RETURNING id INTO _schedule_group_id;
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Monday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Tuesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Wednesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Thursday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Friday'));
 INSERT INTO bus.timetable(schedule_group_id,time_A,time_B,frequency) 
				VALUES (_schedule_group_id,time '06:00:00', time '22:00:00', interval '00:05:00');

 INSERT INTO bus.schedule (direct_route_id) VALUES(_reverse_route_id) RETURNING id INTO _schedule_id;
 INSERT INTO bus.schedule_groups (schedule_id) VALUES (_schedule_id) RETURNING id INTO _schedule_group_id;
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Monday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Tuesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Wednesday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Thursday'));
 INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Friday'));
 INSERT INTO bus.timetable(schedule_group_id,time_A,time_B,frequency) 
				VALUES (_schedule_group_id,time '06:00:00', time '22:00:00', interval '00:05:00');

 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.stations_init(v_city_id bigint)
RETURNS void AS
$BODY$
DECLARE
    i               bigint;
	st_geroiv  		bus.stations%ROWTYPE;
	st_stud    		bus.stations%ROWTYPE;
	st_ac_pavlova   bus.stations%ROWTYPE;
	st_ac_barabash  bus.stations%ROWTYPE;
	st_kievsk       bus.stations%ROWTYPE;
	st_pyshk        bus.stations%ROWTYPE;
	st_univer       bus.stations%ROWTYPE;
	st_istor        bus.stations%ROWTYPE;
	
	st_august       bus.stations%ROWTYPE;
	st_botan_sad    bus.stations%ROWTYPE;
	st_nauchnaia    bus.stations%ROWTYPE;
	st_gosprom      bus.stations%ROWTYPE;
	st_arch_biket   bus.stations%ROWTYPE;
	st_vosstania    bus.stations%ROWTYPE;
	st_metrost 		bus.stations%ROWTYPE;
	
	st_xol_gora 		bus.stations%ROWTYPE;
	st_vokzal 		    bus.stations%ROWTYPE;
	st_cent_market 		bus.stations%ROWTYPE;
	st_sovetsk 		    bus.stations%ROWTYPE;
	st_prosp_gagarina   bus.stations%ROWTYPE;
	st_sport 		    bus.stations%ROWTYPE;
	st_zavod_malish     bus.stations%ROWTYPE;
	st_mosk_prosp 		bus.stations%ROWTYPE;
	st_marsh_guk 		bus.stations%ROWTYPE;
	st_sovet_armii 		bus.stations%ROWTYPE;
	st_maselskogo 		bus.stations%ROWTYPE;
	st_traktor 		    bus.stations%ROWTYPE;
	st_proletar 		bus.stations%ROWTYPE;
		
	

BEGIN


--== Geroiv praci ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0253650246659 36.3360857963562)',4326)) 
			RETURNING  * INTO  st_geroiv;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_geroiv.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_geroiv.name_key,'c_ru','Героев труда');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_geroiv.name_key,'c_en','Geroiv praci');

--== Studentska ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0176997043346 36.3299918174744)',4326)) 
			RETURNING  * INTO  st_stud;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_stud.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_stud.name_key,'c_ru','Студенческая');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_stud.name_key,'c_en','Studentska');

--== Academica Pavlova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0090127013683 36.3178038597107)',4326)) 
			RETURNING  * INTO  st_ac_pavlova;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_ac_pavlova.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_pavlova.name_key,'c_ru','Академика Павлова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_pavlova.name_key,'c_en','Academica Pavlova');

--== Academica Barabashova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0023067780423 36.3040602207184)',4326)) 
			RETURNING  * INTO  st_ac_barabash;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_ac_barabash.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_barabash.name_key,'c_ru','Академика Барабашова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_ac_barabash.name_key,'c_en','Academica Barabashova');

--== Kievskaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.001075820572 36.2700176239014)',4326)) 
			RETURNING  * INTO  st_kievsk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_kievsk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_kievsk.name_key,'c_ru','Киевская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_kievsk.name_key,'c_en','Kievskaia');

--== Pushkinskaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0038066416005 36.247615814209)',4326)) 
			RETURNING  * INTO  st_pyshk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_pyshk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_pyshk.name_key,'c_ru','Пушкинская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_pyshk.name_key,'c_en','Pushkinskaia');

--== University ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0046341324976 36.2337112426758)',4326)) 
			RETURNING  * INTO  st_univer;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_univer.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_univer.name_key,'c_ru','Университет');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_univer.name_key,'c_en','University');

--== Istor. musem ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9929514004981 36.2312064170837)',4326)) 
			RETURNING  * INTO  st_istor;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_istor.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_istor.name_key,'c_ru','Исторический музей');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_istor.name_key,'c_en','Istor. musem');

--=============================================================

--== 23 auguast ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0355169337227 36.2198925018311)',4326)) 
			RETURNING  * INTO  st_august;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_august.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_august.name_key,'c_ru','23 августа');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_august.name_key,'c_en','23 August');

--== Botan sad ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0267504421571 36.2228965759277)',4326)) 
			RETURNING  * INTO  st_botan_sad;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_botan_sad.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_botan_sad.name_key,'c_ru','Ботанический сад');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_botan_sad.name_key,'c_en','Botan sad');

--== Nauchnaia ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.0129082580197 36.2261581420898)',4326)) 
			RETURNING  * INTO  st_nauchnaia;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_nauchnaia.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_nauchnaia.name_key,'c_ru','Научная');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_nauchnaia.name_key,'c_en','Nauchnaia');

--== Gosprom ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(50.004854794331 36.2313938140869)',4326)) 
			RETURNING  * INTO  st_gosprom;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_gosprom.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_gosprom.name_key,'c_ru','Госпром');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_gosprom.name_key,'c_en','Gosprom');

--== Arch Beketova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9990620854991 36.2404918670654)',4326)) 
			RETURNING  * INTO  st_arch_biket;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_arch_biket.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_arch_biket.name_key,'c_ru','Архитектора Бекетова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_arch_biket.name_key,'c_en','Arch Beketova ');

--== Vosstania square ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9887300223925 36.264910697937)',4326)) 
			RETURNING  * INTO  st_vosstania;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_vosstania.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vosstania.name_key,'c_ru','Площадь восстания');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vosstania.name_key,'c_en','Vosstania square');

--== Metrostroitelei Vashenka ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9789683911537 36.2627863883972)',4326)) 
			RETURNING  * INTO  st_metrost;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_metrost.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_metrost.name_key,'c_ru','Метростроителей им. Ващенка');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_metrost.name_key,'c_en','Metrostroitelei Vashenka');

--=============================================================

--== Xol gora ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9823282715423 36.1816549301147)',4326)) 
			RETURNING  * INTO  st_xol_gora;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_xol_gora.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_xol_gora.name_key,'c_ru','Холодная гора');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_xol_gora.name_key,'c_en','Xolodna gora');

--== Ugniy vokzal ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9897371168367 36.2051939964294)',4326)) 
			RETURNING  * INTO  st_vokzal;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_vokzal.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vokzal.name_key,'c_ru','Южный вокзал');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_vokzal.name_key,'c_en','Ugniy vokzal');

--== Central market ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9927996580315 36.2193775177002)',4326)) 
			RETURNING  * INTO  st_cent_market;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_cent_market.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_cent_market.name_key,'c_ru','Центральный рынок');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_cent_market.name_key,'c_en','Central market');

--== Radianska==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9917512424607 36.232852935791)',4326)) 
			RETURNING  * INTO  st_sovetsk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sovetsk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovetsk.name_key,'c_ru','Советская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovetsk.name_key,'c_en','Radianska');

--== Prospect Gagarina ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9804517348322 36.242938041687)',4326)) 
			RETURNING  * INTO  st_prosp_gagarina;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_prosp_gagarina.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_prosp_gagarina.name_key,'c_ru','Проспект Гагарина');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_prosp_gagarina.name_key,'c_en','Prospect Gagarina');

--== Sportivna ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9794582445876 36.2607908248901)',4326)) 
			RETURNING  * INTO  st_sport;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sport.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sport.name_key,'c_ru','Спортивная');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sport.name_key,'c_en','Sportivna');

--== Zavod im. Malisheva ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9759325684943 36.28093957901)',4326)) 
			RETURNING  * INTO  st_zavod_malish;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_zavod_malish.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_zavod_malish.name_key,'c_ru','Завод им. Малышева');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_zavod_malish.name_key,'c_en','Zavod im. Malisheva');

--== Moskovskii prospect ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9721789229428 36.3014960289001)',4326)) 
			RETURNING  * INTO  st_mosk_prosp;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_mosk_prosp.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_mosk_prosp.name_key,'c_ru','Московский проспект');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_mosk_prosp.name_key,'c_en','Moskovskii prospect');

--== Marshala Gykova ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9662442535992 36.3212370872498)',4326)) 
			RETURNING  * INTO  st_marsh_guk;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_marsh_guk.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_marsh_guk.name_key,'c_ru','Маршала Жукова');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_marsh_guk.name_key,'c_en','Marshala Gykova');

--== Sovetskoi armii ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9618548878886 36.3429093360901)',4326)) 
			RETURNING  * INTO  st_sovet_armii;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_sovet_armii.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovet_armii.name_key,'c_ru','Советской армии');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_sovet_armii.name_key,'c_en','Sovetskoi armii');

--== Maselskogo ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.95849357784841 36.36005973815918)',4326)) 
			RETURNING  * INTO  st_maselskogo;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_maselskogo.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_maselskogo.name_key,'c_ru','Масельского');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_maselskogo.name_key,'c_en','Maselskogo');

--== Traktornii zavod ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9526331558422 36.3787007331848)',4326)) 
			RETURNING  * INTO  st_traktor;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_traktor.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_traktor.name_key,'c_ru','Тракторный завод');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_traktor.name_key,'c_en','Traktornii zavod');

--== Proletarska ==
INSERT INTO bus.stations (city_id,location) VALUES(v_city_id,st_geomfromtext('POINT(49.9466408444924 36.3989996910095)',4326)) 
			RETURNING  * INTO  st_proletar;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (st_proletar.id, bus.transport_type_enum('c_metro'));
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_proletar.name_key,'c_ru','Пролетарская');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(st_proletar.name_key,'c_en','Proletarska');


i := 0;
WHILE i< 500 LOOP
  

EXECUTE bus.add_route(v_city_id,
    ARRAY [st_geroiv.id,st_stud.id,st_ac_pavlova.id,st_ac_barabash.id,st_kievsk.id,st_pyshk.id,st_univer.id,st_istor.id],
	ARRAY [st_istor.id,st_univer.id,st_pyshk.id,st_kievsk.id,st_ac_barabash.id,st_ac_pavlova.id,st_stud.id,st_geroiv.id],
	bus.route_type_enum('c_route_metro'),
	'',
	ARRAY [ARRAY ['c_en','Saltovska line'], ARRAY ['c_ru','Салтовская линия']],
	2.00);

EXECUTE bus.add_route(v_city_id,
    ARRAY [st_august.id,st_botan_sad.id,st_nauchnaia.id,st_gosprom.id,st_arch_biket.id,st_vosstania.id,st_metrost.id],
	ARRAY [st_metrost.id,st_vosstania.id,st_arch_biket.id,st_gosprom.id,st_nauchnaia.id,st_botan_sad.id,st_august.id],
	bus.route_type_enum('c_route_metro'),
	'',
	ARRAY [ARRAY ['c_en','Oleksiivska line'], ARRAY ['c_ru','Алексеевская линия']],
	2.00);
	
EXECUTE bus.add_route(v_city_id,
    ARRAY [st_xol_gora.id,st_vokzal.id,st_cent_market.id,st_sovetsk.id,st_prosp_gagarina.id,st_sport.id,st_zavod_malish.id,
		   st_mosk_prosp.id,st_marsh_guk.id,st_sovet_armii.id,st_maselskogo.id,st_traktor.id,st_proletar.id],
	ARRAY [st_proletar.id,st_traktor.id,st_maselskogo.id,st_sovet_armii.id,st_marsh_guk.id,st_mosk_prosp.id,st_zavod_malish.id,
		   st_sport.id,st_prosp_gagarina.id,st_sovetsk.id,st_cent_market.id,st_vokzal.id,st_xol_gora.id],
	bus.route_type_enum('c_route_metro'),
	'',
	ARRAY [ARRAY ['c_en','Xolondo-gersko-zavodskaia line'], ARRAY ['c_ru','Холодногорско-заводская линия']],
	2.00);
	
 i:= i + 1;
 END LOOP;
 


END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
  
--==========================================================================================================================  
  
CREATE OR REPLACE FUNCTION bus.init()
RETURNS void AS
$BODY$
DECLARE
  v_id  bigint;
  name_key bigint;
  kharkov bus.cities%ROWTYPE;
  kiev bus.cities%ROWTYPE;
BEGIN

EXECUTE bus.init_system_data();

SELECT * INTO v_id FROM bus.insert_user_role('admin');
SELECT * INTO v_id FROM bus.insert_user('admin','roma','14R199009');
SELECT * INTO v_id FROM bus.insert_user('admin','marianna','14R199009');

-- insert cities --

INSERT INTO bus.cities (lat,lon,scale) VALUES(50,36,10) RETURNING  * INTO kharkov;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kharkov.name_key,'c_ru','Харьков');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kharkov.name_key,'c_en','Kharkov');

INSERT INTO bus.cities (lat,lon,scale) VALUES(50,30,8) RETURNING  * INTO kiev;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kiev.name_key,'c_ru','Киев');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(kiev.name_key,'c_en','Kiev');

-- insert stations to Kharkov
EXECUTE bus.stations_init(kharkov.id);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--- init ---
BEGIN;  
 SELECT bus.init();
 DROP FUNCTION bus.init();
 DROP FUNCTION bus.stations_init(bigint);
 DROP FUNCTION bus.add_route(bigint,bigint[], bigint[],bus.route_type_enum, text, text[][],double precision);
		
 DROP FUNCTION bus.add_route_station( bigint, bigint, 	bigint,	bigint,	double precision);
COMMIT;



CREATE OR REPLACE FUNCTION bus.data_init()
RETURNS void AS
$BODY$
DECLARE
  v_id  bigint;
  name_key bigint;
  kharkov bus.cities%ROWTYPE;
  kiev bus.cities%ROWTYPE;
  station_1 bus.stations%ROWTYPE;
  location text;
BEGIN
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_metro',44);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_bus',50);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_tram',48);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_trolley',45);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_foot',5);

INSERT INTO bus.languages(id,name) VALUES('c_en', 'English');
INSERT INTO bus.languages(id,name) VALUES('c_ru', 'Русский');
INSERT INTO bus.languages(id,name) VALUES('c_uk', 'Українська');

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

-- insert station to Kharkov
location := 'POINT('||50||' '||36|| ')';
-- ST_AsText
INSERT INTO bus.stations (city_id,location) VALUES(kharkov.id,st_geomfromtext(location,4326)) RETURNING  * INTO  station_1;
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (station_1.id, bus.transport_type_enum('c_bus'));
INSERT INTO bus.station_transports (station_id,transport_type_id) VALUES (station_1.id, bus.transport_type_enum('c_tram'));
--INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(name_key,'c_ru','Госпром');
--INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(name_key,'c_en','Gosprom');



END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--- init ---
 SELECT bus.data_init();
 DROP FUNCTION bus.data_init();

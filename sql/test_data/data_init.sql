

CREATE OR REPLACE FUNCTION bus.data_init()
RETURNS void AS
$BODY$
DECLARE
  id  bigint;
  city_name_key bigint;
BEGIN
INSERT INTO bus.languages(id,name) VALUES('c_en', 'English');
INSERT INTO bus.languages(id,name) VALUES('c_ru', 'Русский');

SELECT * INTO id FROM bus.insert_user_role('admin');
SELECT * INTO id FROM bus.insert_user('admin','roma','14R199009');
SELECT * INTO id FROM bus.insert_user('admin','marianna','14R199009');

-- insert cities --


INSERT INTO bus.cities (lat,lon) VALUES(50,36) RETURNING  name_key INTO city_name_key;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(city_name_key,'c_ru','Харьков');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(city_name_key,'c_en','Kharkov');

INSERT INTO bus.cities (lat,lon) VALUES(50,30) RETURNING  name_key INTO city_name_key;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(city_name_key,'c_ru','Киев');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(city_name_key,'c_en','Kiev');


--select * from bus.authenticate('admin','marianna','rar') as t1;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--- init ---
 SELECT bus.data_clear();
 SELECT bus.data_init();
--select bus.insert_user_role('admin');
/*
select bus.add_city('{"c_en","c_ru"}','{"Kharkov","Харьков"}');
select bus.add_city('{"c_en","c_ru"}','{"Kiev","Киев"}');
*/



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

--INSERT INTO bus.lang_keys () VALUES() RETURNING  id INTO city_name_key;

--select bus.add_city('{"c_en","c_ru"}','{"Kharkov","Харьков"}');
--select bus.add_city('{"c_en","c_ru"}','{"Kiev","Киев"}');



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

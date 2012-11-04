
-- Trigger functions

-- execute, when insert row, which need name_key (for insert triggers) 
CREATE OR REPLACE FUNCTION bus.create_name_key() RETURNS trigger AS
$BODY$
DECLARE
 key_id  bigint;
BEGIN
 INSERT INTO bus.string_keys (name) VALUES(null) RETURNING  id INTO key_id;
NEW.name_key = key_id;
return NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================

-- execute, when delete row, which it has name_key (for delete triggers) 
CREATE OR REPLACE FUNCTION bus.delete_name_key() RETURNS trigger AS
$BODY$
DECLARE
 key_id  bigint;
BEGIN
 DELETE from bus.string_keys where id = OLD.name_key;
 RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
--=================================================================================================
CREATE OR REPLACE FUNCTION bus.on_insert_city() RETURNS trigger AS
$BODY$
DECLARE
 _route_id 				bigint;
 _direct_route_id 		bigint;
 _schedule_id           bigint;
 _schedule_group_id     bigint;
BEGIN
	INSERT INTO bus.routes (city_id,route_type_id,number,cost) 
	   VALUES (NEW.id,bus.route_type_enum('c_route_station_input'),'',0.0)  
	   RETURNING  id INTO  _route_id;
	INSERT INTO bus.direct_routes (route_id,direct) VALUES (_route_id,B'0') 
	   RETURNING  id INTO  _direct_route_id;
	
	-- add fictive relation
	INSERT INTO bus.route_relations (direct_route_id,station_A_id,station_B_id,position_index,ev_time,distance) 
          VALUES (_direct_route_id,null,null,0,interval '00:00:00',0);
          
	/*
	INSERT INTO bus.schedule (direct_route_id) VALUES(_direct_route_id) RETURNING id INTO _schedule_id;
	INSERT INTO bus.schedule_groups (schedule_id) VALUES (_schedule_id) RETURNING id INTO _schedule_group_id;
 
    INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Sunday'));
    INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Monday'));
	INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Tuesday'));
	INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Wednesday'));
	INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Thursday'));
	INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Friday'));
    INSERT INTO bus.schedule_group_days (schedule_group_id,day_id) VALUES (_schedule_group_id,day_enum('c_Saturday'));
      
    INSERT INTO bus.timetable(schedule_group_id,time_A,time_B,frequency) 
				VALUES (_schedule_group_id,time '00:00:00', time '24:00:00', interval '00:00:00');
			*/	
	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================

CREATE OR REPLACE FUNCTION bus.on_delete_city() RETURNS trigger AS
$BODY$
DECLARE

BEGIN
    DELETE FROM bus.routes 
		   WHERE city_id = OLD.id AND 
		   route_type_id = bus.route_type_enum('c_route_station_input');
	RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
 
--=================================================================================================
CREATE OR REPLACE FUNCTION bus.on_insert_station() RETURNS trigger AS
$BODY$
DECLARE
 _input_route bus.routes%ROWTYPE;
 _direct_route_id bigint;
 
BEGIN
--c_route_station_input
 SELECT * INTO _input_route FROM bus.routes 
          WHERE route_type_id = bus.route_type_enum('c_route_station_input') AND
                city_id = NEW.city_id LIMIT 1;
 IF NOT FOUND THEN
     RAISE EXCEPTION 'c_route_station_input was not found';
 END IF;
 
 SELECT id INTO _direct_route_id FROM bus.direct_routes WHERE route_id = _input_route.id;
 
 IF NOT FOUND THEN
     RAISE EXCEPTION 'c_route_station_input was not found';
 END IF;
 
 INSERT INTO bus.route_stations (direct_route_id,station_B_id,position_index,ev_time,distance) 
          VALUES (_direct_route_id,NEW.id,0,'00:00:00',0.0);
 RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================
CREATE OR REPLACE FUNCTION bus.on_delete_station() RETURNS trigger AS
$BODY$
DECLARE
 
BEGIN
 DELETE FROM bus.route_stations WHERE station_A_id = NULL AND station_B_id = OLD.id;
 
 RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--=================================================================================================

-- City triggers
CREATE TRIGGER city_createname_key_trigger
BEFORE INSERT ON bus.cities
FOR EACH  ROW EXECUTE PROCEDURE bus.create_name_key();

CREATE TRIGGER city_deletename_key_trigger
AFTER DELETE ON bus.cities
FOR EACH  ROW EXECUTE PROCEDURE bus.delete_name_key();

CREATE TRIGGER city_insert_trigger
AFTER INSERT ON bus.cities
FOR EACH  ROW EXECUTE PROCEDURE bus.on_insert_city();

CREATE TRIGGER city_delete_trigger
BEFORE DELETE ON bus.cities
FOR EACH  ROW EXECUTE PROCEDURE bus.on_delete_city();

-- Station triggers
CREATE TRIGGER station_createname_key_trigger
BEFORE INSERT ON bus.stations
FOR EACH  ROW EXECUTE PROCEDURE bus.create_name_key();

CREATE TRIGGER station_deletename_key_trigger
AFTER DELETE ON bus.stations
FOR EACH  ROW EXECUTE PROCEDURE bus.delete_name_key();


-- Route triggers

CREATE TRIGGER route_createname_key_trigger
BEFORE INSERT ON bus.routes
FOR EACH  ROW EXECUTE PROCEDURE bus.create_name_key();

CREATE TRIGGER route_deletename_key_trigger
AFTER DELETE ON bus.routes
FOR EACH  ROW EXECUTE PROCEDURE bus.delete_name_key();


-- Discounts triggers

CREATE TRIGGER discount_createname_key_trigger
BEFORE INSERT ON bus.discounts
FOR EACH  ROW EXECUTE PROCEDURE bus.create_name_key();

CREATE TRIGGER discount_deletename_key_trigger
AFTER DELETE ON bus.discounts
FOR EACH  ROW EXECUTE PROCEDURE bus.delete_name_key();








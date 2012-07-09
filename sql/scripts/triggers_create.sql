
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

-- execute, when delete row, which it has name_key (for delete triggers) 
CREATE OR REPLACE FUNCTION bus.delete_name_key() RETURNS trigger AS
$BODY$
DECLARE
 key_id  bigint;
BEGIN
 DELETE from bus.string_keys where id = OLD.name_key;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;


-- Triggers
CREATE TRIGGER city_createname_key_trigger
BEFORE INSERT ON bus.cities
FOR EACH  ROW EXECUTE PROCEDURE bus.create_name_key();

 

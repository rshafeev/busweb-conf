
-- Dropped triggers and trigger functions

DROP TRIGGER city_createname_key_trigger ON bus.cities;
DROP TRIGGER city_deletename_key_trigger ON bus.cities;
DROP TRIGGER station_createname_key_trigger ON bus.stations;
DROP TRIGGER station_deletename_key_trigger ON bus.stations;

 
DROP FUNCTION bus.create_name_key();
DROP FUNCTION bus.delete_name_key();


-- Dropped triggers and trigger functions

DROP TRIGGER city_createname_key_trigger ON bus.cities;
DROP TRIGGER city_deletename_key_trigger ON bus.cities;
DROP TRIGGER city_insert_trigger         ON bus.cities;
DROP TRIGGER city_delete_trigger      	 ON bus.cities;

DROP TRIGGER station_createname_key_trigger ON bus.stations;
DROP TRIGGER station_deletename_key_trigger ON bus.stations;
DROP TRIGGER station_insert_trigger   	    ON bus.stations;
DROP TRIGGER station_delete_trigger         ON bus.stations;

DROP TRIGGER route_createname_key_trigger ON bus.routes;
DROP TRIGGER route_deletename_key_trigger ON bus.routes;

DROP TRIGGER discount_createname_key_trigger ON bus.discounts;
DROP TRIGGER discount_deletename_key_trigger ON bus.discounts;
 
DROP FUNCTION bus.create_name_key();
DROP FUNCTION bus.delete_name_key();



CREATE OR REPLACE FUNCTION bus.data_clear()
RETURNS void AS
$BODY$
DECLARE
BEGIN


delete from bus.route_way_days;
delete from bus.route_schedule;
delete from bus.route_way_daygroups;

delete from bus.route_way_nodes;
delete from bus.route_ways;
delete from bus.routes;


delete from bus.node_transports;
delete from bus.nodes;
delete from bus.cities;

delete from bus.transport_types;

delete from bus.user_roles;
delete from bus.users;

delete from bus.string_values;
delete from bus.string_keys;
delete from bus.languages;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			


SELECT  bus.data_clear();


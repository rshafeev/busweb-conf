
--------------------- delete database -------------------------------
/*
DROP TABLE  bus.graph_relations;
DROP TABLE  bus.timetable;
DROP TABLE  bus.schedule_group_days;
DROP TABLE  bus.schedule_groups;
DROP TABLE  bus.schedule;
DROP TABLE  bus.route_relations;
DROP TABLE  bus.direct_routes;
DROP TABLE  bus.routes;

DROP TABLE  bus.station_transports;
DROP TABLE  bus.stations;

DROP TABLE  bus.cities;

DROP TABLE  bus.discount_by_route_types;
DROP TABLE  bus.discounts;

DROP TABLE  bus.string_values;
DROP TABLE  bus.string_keys;

DROP TABLE  bus.users;
DROP TABLE  bus.user_roles;



DROP TABLE  bus.languages;
DROP TABLE  bus.route_types;
DROP TABLE  bus.transport_types;

DROP TYPE  bus.transport_type_enum;
DROP TYPE  bus.route_type_enum;
DROP TYPE  bus.way;
*/
DROP SCHEMA bus CASCADE;
DROP TYPE  day_enum;
DROP TYPE  lang_enum;



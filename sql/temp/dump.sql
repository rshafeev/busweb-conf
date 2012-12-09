--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = bus, pg_catalog;

ALTER TABLE ONLY bus.users DROP CONSTRAINT users_role_id_fk;
ALTER TABLE ONLY bus.timetable DROP CONSTRAINT timetable_schedule_group_id_fk;
ALTER TABLE ONLY bus.station_transports DROP CONSTRAINT station_trasnport_ttid_fk;
ALTER TABLE ONLY bus.station_transports DROP CONSTRAINT station_trasnport_nid_fk;
ALTER TABLE ONLY bus.schedule_groups DROP CONSTRAINT schedule_groups_schedule_id_fk;
ALTER TABLE ONLY bus.schedule_group_days DROP CONSTRAINT schedule_group_days_schedule_group_id_fk;
ALTER TABLE ONLY bus.schedule DROP CONSTRAINT schedule_directroute_id_fk;
ALTER TABLE ONLY bus.route_types DROP CONSTRAINT route_type_transporttype_fk;
ALTER TABLE ONLY bus.route_relations DROP CONSTRAINT route_relations_station_b_id_fk;
ALTER TABLE ONLY bus.route_relations DROP CONSTRAINT route_relations_station_a_id_fk;
ALTER TABLE ONLY bus.route_relations DROP CONSTRAINT route_relations_directroute_id_fk;
ALTER TABLE ONLY bus.routes DROP CONSTRAINT route_name_key_fk;
ALTER TABLE ONLY bus.routes DROP CONSTRAINT route_city_id_fk;
ALTER TABLE ONLY bus.stations DROP CONSTRAINT node_name_fk;
ALTER TABLE ONLY bus.stations DROP CONSTRAINT node_city_id_fk;
ALTER TABLE ONLY bus.string_values DROP CONSTRAINT lang_string_values_fk;
ALTER TABLE ONLY bus.string_values DROP CONSTRAINT key_string_values_fk;
ALTER TABLE ONLY bus.import_objects DROP CONSTRAINT import_objects_city_id_fk;
ALTER TABLE ONLY bus.graph_relations DROP CONSTRAINT graph_relations_relation_b_id_fk;
ALTER TABLE ONLY bus.graph_relations DROP CONSTRAINT graph_relations_relation_a_id_fk;
ALTER TABLE ONLY bus.graph_relations DROP CONSTRAINT graph_relations_city_id_fk;
ALTER TABLE ONLY bus.discount_by_route_types DROP CONSTRAINT discount_tr_trid_fk;
ALTER TABLE ONLY bus.discount_by_route_types DROP CONSTRAINT discount_tr_disid_fk;
ALTER TABLE ONLY bus.discounts DROP CONSTRAINT discount_name_fk;
ALTER TABLE ONLY bus.direct_routes DROP CONSTRAINT direct_route_routeid_fk;
ALTER TABLE ONLY bus.cities DROP CONSTRAINT city_name_fk;
DROP TRIGGER station_deletename_key_trigger ON bus.stations;
DROP TRIGGER station_createname_key_trigger ON bus.stations;
DROP TRIGGER route_deletename_key_trigger ON bus.routes;
DROP TRIGGER route_createname_key_trigger ON bus.routes;
DROP TRIGGER discount_deletename_key_trigger ON bus.discounts;
DROP TRIGGER discount_createname_key_trigger ON bus.discounts;
DROP TRIGGER city_insert_trigger ON bus.cities;
DROP TRIGGER city_deletename_key_trigger ON bus.cities;
DROP TRIGGER city_delete_trigger ON bus.cities;
DROP TRIGGER city_createname_key_trigger ON bus.cities;
ALTER TABLE ONLY bus.user_roles DROP CONSTRAINT user_role_id_pk;
ALTER TABLE ONLY bus.users DROP CONSTRAINT user_id_pk;
ALTER TABLE ONLY bus.transport_types DROP CONSTRAINT transport_type_pk;
ALTER TABLE ONLY bus.timetable DROP CONSTRAINT timetable_pk;
ALTER TABLE ONLY bus.string_values DROP CONSTRAINT string_values_pk;
ALTER TABLE ONLY bus.string_keys DROP CONSTRAINT string_keys_pk;
ALTER TABLE ONLY bus.station_transports DROP CONSTRAINT station_transport_pk;
ALTER TABLE ONLY bus.schedule DROP CONSTRAINT schedule_pk;
ALTER TABLE ONLY bus.schedule_groups DROP CONSTRAINT schedule_groups_pk;
ALTER TABLE ONLY bus.schedule_group_days DROP CONSTRAINT schedule_group_days_pk;
ALTER TABLE ONLY bus.routes DROP CONSTRAINT routes_pk;
ALTER TABLE ONLY bus.route_types DROP CONSTRAINT route_type_pk;
ALTER TABLE ONLY bus.route_relations DROP CONSTRAINT route_relations_pk;
ALTER TABLE ONLY bus.stations DROP CONSTRAINT node_pk;
ALTER TABLE ONLY bus.languages DROP CONSTRAINT languages_pk;
ALTER TABLE ONLY bus.import_objects DROP CONSTRAINT import_objectss_pk;
ALTER TABLE ONLY bus.graph_relations DROP CONSTRAINT graph_relations_pk;
ALTER TABLE ONLY bus.discounts DROP CONSTRAINT discounts_pk;
ALTER TABLE ONLY bus.discount_by_route_types DROP CONSTRAINT discount_by_route_type_id_pk;
ALTER TABLE ONLY bus.direct_routes DROP CONSTRAINT direct_routes_unique;
ALTER TABLE ONLY bus.direct_routes DROP CONSTRAINT direct_routes_pk;
ALTER TABLE ONLY bus.cities DROP CONSTRAINT city_pk;
ALTER TABLE bus.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.user_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.timetable ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.string_values ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.string_keys ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.stations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.schedule_groups ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.schedule_group_days ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.schedule ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.routes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.route_relations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.import_objects ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.graph_relations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.discounts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.direct_routes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE bus.cities ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE bus.users_id_seq;
DROP TABLE bus.users;
DROP SEQUENCE bus.user_roles_id_seq;
DROP TABLE bus.user_roles;
DROP TABLE bus.transport_types;
DROP SEQUENCE bus.timetable_id_seq;
DROP TABLE bus.timetable;
DROP SEQUENCE bus.string_values_id_seq;
DROP TABLE bus.string_values;
DROP SEQUENCE bus.string_keys_id_seq;
DROP TABLE bus.string_keys;
DROP SEQUENCE bus.stations_id_seq;
DROP TABLE bus.stations;
DROP TABLE bus.station_transports;
DROP SEQUENCE bus.schedule_id_seq;
DROP SEQUENCE bus.schedule_groups_id_seq;
DROP TABLE bus.schedule_groups;
DROP SEQUENCE bus.schedule_group_days_id_seq;
DROP TABLE bus.schedule_group_days;
DROP TABLE bus.schedule;
DROP SEQUENCE bus.routes_id_seq;
DROP TABLE bus.routes;
DROP TABLE bus.route_types;
DROP SEQUENCE bus.route_relations_id_seq;
DROP TABLE bus.languages;
DROP SEQUENCE bus.import_objects_id_seq;
DROP TABLE bus.import_objects;
DROP SEQUENCE bus.graph_relations_id_seq;
DROP TABLE bus.graph_relations;
DROP SEQUENCE bus.discounts_id_seq;
DROP TABLE bus.discounts;
DROP TABLE bus.discount_by_route_types;
DROP SEQUENCE bus.direct_routes_id_seq;
DROP TABLE bus.direct_routes;
DROP SEQUENCE bus.cities_id_seq;
DROP TABLE bus.cities;
DROP FUNCTION bus.shortest_ways(_city_id bigint, _p1 public.geography, _p2 public.geography, _day_id bus.day_enum, _time_start time without time zone, _max_distance double precision, _route_types text[], _discounts double precision[], _alg_strategy alg_strategy, _lang_id bus.lang_enum);
DROP FUNCTION bus.on_insert_station();
DROP FUNCTION bus.on_insert_city();
DROP FUNCTION bus.on_delete_station();
DROP FUNCTION bus.on_delete_city();
DROP FUNCTION bus.is_has_transition(_curr_relation_a_id integer, _curr_relation_b_id integer, _max_distance double precision);
DROP FUNCTION bus.insert_user_role(role_name character);
DROP FUNCTION bus.insert_user(role_name character, login character, password character);
DROP FUNCTION bus.insert_user(role_id bigint, login character, password character);
DROP FUNCTION bus.insert_transitions_for_metro_transition(_route_id bigint);
DROP FUNCTION bus.insert_transitions(_route_id bigint, _route_type route_type_enum, _max_distance double precision);
DROP FUNCTION bus.insert_route_relation(_direct_route_id bigint, _station_a_id bigint, _station_b_id bigint, _index bigint, _geom public.geography);
DROP FUNCTION bus.insert_graph_relations(_direct_route_id bigint, _route_station_input_id bigint);
DROP FUNCTION bus.init_system_data();
DROP FUNCTION bus.get_string_without_null(str text);
DROP FUNCTION bus.get_relation_input_id(_city_id bigint);
DROP FUNCTION bus.get_next_relation(_curr_relation_id integer, _station_b_id bigint);
DROP TABLE bus.route_relations;
DROP FUNCTION bus.get_distance_between_stations(_station_a_id bigint, _station_b_id bigint);
DROP FUNCTION bus.get_discount_id(_lang bus.lang_enum, _name text);
DROP FUNCTION bus.get_city_id(_lang bus.lang_enum, _name text);
DROP FUNCTION bus.find_nearest_relations(_location public.geography, _city_id bigint, _transports transport_type_enum[], max_distance double precision);
DROP FUNCTION bus.find_nearest_relations(_location public.geography, _city_id bigint, max_distance double precision);
DROP FUNCTION bus.drop_functions();
DROP FUNCTION bus.delete_name_key();
DROP FUNCTION bus.data_clear();
DROP FUNCTION bus.create_name_key();
DROP FUNCTION bus.authenticate(role_name character, v_login character, v_password character);
DROP FUNCTION bus.__clean_paths_table(_relation_input_id integer);
DROP TYPE bus.lang_enum;
DROP TYPE bus.day_enum;

DROP TYPE bus.way_elem;
DROP TYPE bus.transport_type_enum;
DROP TYPE bus.relation;
DROP TYPE bus.path_elem;
DROP TYPE bus.nearest_relation;
DROP TYPE bus.filter_path;
DROP TYPE bus.route_type_enum;
DROP TYPE bus.alg_strategy;

DROP SCHEMA bus;
--
-- Name: bus; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bus;


ALTER SCHEMA bus OWNER TO postgres;

SET search_path = bus, pg_catalog;

--
-- Name: alg_strategy; Type: TYPE; Schema: bus; Owner: postgres
--
CREATE TYPE bus.lang_enum AS ENUM
   (
     'c_en',
     'c_ru',
     'c_uk',
     'c_be',
     'c_kk'
   );
   
CREATE TYPE bus.day_enum AS ENUM
   ( 
      'c_Sunday',
      'c_Monday',
      'c_Tuesday',
      'c_Wednesday',
      'c_Thursday',
      'c_Friday',
      'c_Saturday',
      'c_all'
   );
   
CREATE TYPE alg_strategy AS ENUM (
    'c_time',
    'c_cost',
    'c_opt'
);


ALTER TYPE bus.alg_strategy OWNER TO postgres;

--
-- Name: route_type_enum; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE route_type_enum AS ENUM (
    'c_route_metro',
    'c_route_trolley',
    'c_route_bus',
    'c_route_tram',
    'c_route_electric_train',
    'c_route_transition',
    'c_route_metro_transition',
    'c_route_station_input'
);


ALTER TYPE bus.route_type_enum OWNER TO postgres;

--
-- Name: filter_path; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE filter_path AS (
	path_id integer,
	index integer,
	direct_route_id bigint,
	route_type route_type_enum,
	relation_index integer,
	relation_id integer,
	station_id bigint,
	move_time interval,
	wait_time interval,
	cost double precision,
	distance double precision
);


ALTER TYPE bus.filter_path OWNER TO postgres;

--
-- Name: nearest_relation; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE nearest_relation AS (
	id integer,
	distance double precision
);


ALTER TYPE bus.nearest_relation OWNER TO postgres;

--
-- Name: path_elem; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE path_elem AS (
	path_id integer,
	index integer,
	relation_id integer,
	graph_id bigint
);


ALTER TYPE bus.path_elem OWNER TO postgres;

--
-- Name: relation; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE relation AS (
	source integer,
	target integer,
	distance double precision,
	source_route_type route_type_enum,
	target_route_type route_type_enum
);


ALTER TYPE bus.relation OWNER TO postgres;

--
-- Name: transport_type_enum; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE transport_type_enum AS ENUM (
    'c_metro',
    'c_bus',
    'c_trolley',
    'c_tram',
    'c_foot',
    'c_electric_train',
    'c_taxi'
);


ALTER TYPE bus.transport_type_enum OWNER TO postgres;

--
-- Name: way_elem; Type: TYPE; Schema: bus; Owner: postgres
--

CREATE TYPE way_elem AS (
	path_id integer,
	index integer,
	direct_route_id bigint,
	route_type route_type_enum,
	relation_index integer,
	route_name text,
	station_name text,
	move_time interval,
	wait_time interval,
	cost double precision,
	distance double precision
);


ALTER TYPE bus.way_elem OWNER TO postgres;

--
-- Name: __clean_paths_table(integer); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION __clean_paths_table(_relation_input_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
 _id_arr                integer[];
 _id                    integer;
BEGIN
  FOR _id IN SELECT t1.path_id FROM
	           (SELECT paths.path_id as path_id,count(*) as count FROM paths 
	                   JOIN bus.route_relations ON bus.route_relations.id = paths.relation_id
	                   WHERE bus.route_relations.id <> _relation_input_id
	                  GROUP BY paths.path_id,bus.route_relations.direct_route_id
	           ) as t1
	           WHERE t1.count = 1
	LOOP
           _id_arr:= array_append(_id_arr,_id);
	END LOOP;

  DELETE FROM paths where path_id = ANY(_id_arr);
END;
$$;


ALTER FUNCTION bus.__clean_paths_table(_relation_input_id integer) OWNER TO postgres;

--
-- Name: authenticate(character, character, character); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION authenticate(role_name character, v_login character, v_password character) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
 user_id bigint;
 v_role_id bigint;
 v_user  record;
BEGIN
  SELECT id INTO v_role_id  FROM bus.user_roles WHERE name = role_name;
  IF NOT FOUND THEN
     RETURN 1;
   END IF;
  RAISE NOTICE '%', v_role_id;
  SELECT * INTO v_user  FROM bus.users WHERE bus.users.role_id = v_role_id AND bus.users.login = v_login;
  IF NOT FOUND THEN
     RETURN 2;
   END IF;
  IF v_user.password <> v_password THEN
     RETURN 3;
  END IF;
  RETURN 0;
END;
$$;


ALTER FUNCTION bus.authenticate(role_name character, v_login character, v_password character) OWNER TO postgres;

--
-- Name: create_name_key(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION create_name_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 key_id  bigint;
BEGIN
 INSERT INTO bus.string_keys (name) VALUES(null) RETURNING  id INTO key_id;
NEW.name_key = key_id;
return NEW;
END;
$$;


ALTER FUNCTION bus.create_name_key() OWNER TO postgres;

--
-- Name: data_clear(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION data_clear() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN

delete from  bus.timetable;
delete from  bus.schedule_group_days;
delete from  bus.schedule_groups;
delete from  bus.schedule;
delete from  bus.graph_relations;
delete from  bus.route_relations;
delete from  bus.direct_routes;
delete from  bus.routes;

delete from bus.station_transports;
delete from bus.stations;
delete from bus.cities;

delete from bus.discount_by_route_types;
delete from bus.discounts;

delete from bus.transport_types;

delete from bus.user_roles;
delete from bus.users;

delete from bus.string_values;
delete from bus.string_keys;
delete from bus.languages;
END;
$$;


ALTER FUNCTION bus.data_clear() OWNER TO postgres;

--
-- Name: delete_name_key(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION delete_name_key() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 key_id  bigint;
BEGIN
 DELETE from bus.string_keys where id = OLD.name_key;
 RETURN OLD;
END;
$$;


ALTER FUNCTION bus.delete_name_key() OWNER TO postgres;

--
-- Name: drop_functions(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION drop_functions() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE

BEGIN
   DROP FUNCTION bus.init_system_data();
   DROP FUNCTION bus.insert_user_role( character);
   DROP FUNCTION bus.insert_user(bigint,character, character);
   DROP FUNCTION bus.insert_user(character,character, character);
   DROP FUNCTION bus.authenticate(character,character, character);
   DROP FUNCTION bus.get_city_id (bus.lang_enum, text);
   DROP FUNCTION bus.get_discount_id (bus.lang_enum, text);

   DROP FUNCTION bus.find_nearest_relations(geometry,bigint,bus.transport_type_enum[],double precision);
   DROP FUNCTION bus.data_clear();
   
END;
$$;


ALTER FUNCTION bus.drop_functions() OWNER TO postgres;

--
-- Name: find_nearest_relations(public.geography, bigint, double precision); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION find_nearest_relations(_location public.geography, _city_id bigint, max_distance double precision) RETURNS SETOF nearest_relation
    LANGUAGE plpgsql
    AS $$
DECLARE
  _relation bus.nearest_relation;
BEGIN
    FOR _relation IN SELECT 
                              bus.route_relations.id          as id ,
                              st_distance(location,_location) as distance 
                     FROM bus.route_relations
                     JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                     WHERE city_id = _city_id AND 
                         st_distance(location,_location) < max_distance 
    LOOP
         RETURN NEXT _relation;
   END LOOP;
    
END;
$$;


ALTER FUNCTION bus.find_nearest_relations(_location public.geography, _city_id bigint, max_distance double precision) OWNER TO postgres;

--
-- Name: find_nearest_relations(public.geography, bigint, transport_type_enum[], double precision); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION find_nearest_relations(_location public.geography, _city_id bigint, _transports transport_type_enum[], max_distance double precision) RETURNS SETOF nearest_relation
    LANGUAGE plpgsql
    AS $$
DECLARE
  _relation bus.nearest_relation;
BEGIN
    FOR _relation IN SELECT 
                              bus.route_relations.id          as id ,
                              st_distance(location,_location) as distance 
                     FROM bus.route_relations
                     JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                     JOIN bus.station_transports ON bus.station_transports.station_id = bus.stations.id
                     WHERE city_id = _city_id AND 
                         st_distance(location,_location) < max_distance AND 
                         transport_type_id =  ANY(_transports)
    LOOP
         RETURN NEXT _relation;
   END LOOP;
    
END;
$$;


ALTER FUNCTION bus.find_nearest_relations(_location public.geography, _city_id bigint, _transports transport_type_enum[], max_distance double precision) OWNER TO postgres;

--
-- Name: get_city_id(public.lang_enum, text); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_city_id(_lang bus.lang_enum, _name text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT * INTO _id FROM bus.cities JOIN bus.string_values ON bus.string_values.key_id = bus.cities.name_key
    WHERE value = _name AND lang_id = _lang;
    
  RETURN  _id;
   
END;
$$;


ALTER FUNCTION bus.get_city_id(_lang bus.lang_enum, _name text) OWNER TO postgres;

--
-- Name: get_discount_id(public.lang_enum, text); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_discount_id(_lang bus.lang_enum, _name text) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT bus.discounts .id INTO _id FROM bus.discounts JOIN bus.string_values ON bus.string_values.key_id = bus.discounts.name_key
    WHERE value = _name AND lang_id = _lang;
  RETURN  _id;
   
END;
$$;


ALTER FUNCTION bus.get_discount_id(_lang bus.lang_enum, _name text) OWNER TO postgres;

--
-- Name: get_distance_between_stations(bigint, bigint); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_distance_between_stations(_station_a_id bigint, _station_b_id bigint) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id;
 IF NOT FOUND THEN
	return 1000000000000000000;
 END IF;

 return st_distance(p1,p2);
END;
$$;


ALTER FUNCTION bus.get_distance_between_stations(_station_a_id bigint, _station_b_id bigint) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: route_relations; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE route_relations (
    id integer NOT NULL,
    direct_route_id bigint NOT NULL,
    station_a_id bigint,
    station_b_id bigint,
    position_index bigint NOT NULL,
    distance double precision NOT NULL,
    ev_time interval NOT NULL,
    geom public.geography(LineString,4326)
);


ALTER TABLE bus.route_relations OWNER TO postgres;

--
-- Name: get_next_relation(integer, bigint); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_next_relation(_curr_relation_id integer, _station_b_id bigint) RETURNS route_relations
    LANGUAGE plpgsql
    AS $$
DECLARE
 _next_relation    bus.route_relations;
BEGIN
  SELECT * INTO _next_relation FROM bus.route_relations WHERE station_a_id = _station_b_id;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _next_relation;
END;
$$;


ALTER FUNCTION bus.get_next_relation(_curr_relation_id integer, _station_b_id bigint) OWNER TO postgres;

--
-- Name: get_relation_input_id(bigint); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_relation_input_id(_city_id bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  _relation_input_id bigint;
BEGIN
 SELECT bus.route_relations.id INTO _relation_input_id FROM bus.routes 
	 JOIN bus.direct_routes   ON bus.direct_routes.route_id = bus.routes.id
	 JOIN bus.route_relations ON bus.route_relations.direct_route_id = bus.direct_routes.id
 WHERE route_type_id=bus.route_type_enum('c_route_station_input') and city_id = _city_id;

 return _relation_input_id;
END;
$$;


ALTER FUNCTION bus.get_relation_input_id(_city_id bigint) OWNER TO postgres;

--
-- Name: get_string_without_null(text); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION get_string_without_null(str text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
  IF str IS NOT NULL THEN
    return str;
  
  
  END IF;
  return '';
END;
$$;


ALTER FUNCTION bus.get_string_without_null(str text) OWNER TO postgres;

--
-- Name: init_system_data(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION init_system_data() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  _discount bus.discounts%ROWTYPE;
BEGIN
--============== system data=======================
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_metro',44);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_bus',50);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_tram',48);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_trolley',45);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_foot',5);

INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_metro','c_metro',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_trolley','c_trolley',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_bus','c_bus',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_tram','c_tram',B'1');

INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_station_input','c_foot',B'0');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_transition','c_foot',B'0');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_metro_transition','c_foot',B'0');



INSERT INTO bus.languages(id,name) VALUES('c_en', 'English');
INSERT INTO bus.languages(id,name) VALUES('c_ru', 'Русский');
INSERT INTO bus.languages(id,name) VALUES('c_uk', 'Українська');

 -- insert direct_route
 

-- insert discounts
INSERT INTO bus.discounts (id) VALUES (default) RETURNING * INTO _discount;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_ru','Отсутствует');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_en','Dissapear');
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),1);


INSERT INTO bus.discounts (id) VALUES (default) RETURNING * INTO _discount;
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_ru','Студенческий');
INSERT INTO bus.string_values(key_id,lang_id,value) VALUES(_discount.name_key,'c_en','Student');
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro'),0.5);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_bus'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_trolley'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_tram'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_station_input'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_transition'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),0.0);
--========================================================
   
END;
$$;


ALTER FUNCTION bus.init_system_data() OWNER TO postgres;

--
-- Name: insert_graph_relations(bigint, bigint); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_graph_relations(_direct_route_id bigint, _route_station_input_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  _pause interval;
BEGIN

 -- insert route relations
 _pause := interval '00:00:08';
 INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
 SELECT  
	    bus.routes.city_id                           as city_id,
	    bus.routes.route_type_id    				 as route_type_id,
	    bus.routes.route_type_id                     as relation_type,
        r1.id                       				 as relation_a_id,
        r2.id          			    				 as relation_b_id,
        null                  						 as time_a,
        null   	                    				 as time_b,
        bus.day_enum('c_all')							 as day_id,
        interval '00:00:00'                          as wait_time,
        (r2.ev_time + _pause)   					 as move_time,
		0                                            as cost_money,
		EXTRACT(EPOCH FROM r2.ev_time + _pause)      as cost_time,
		r2.distance                 as distance
    
        from bus.route_relations  as r1
	JOIN bus.route_relations  as r2     ON r1.station_B_id = r2.station_A_id
	JOIN bus.direct_routes              ON r2.direct_route_id = direct_routes.id
	JOIN bus.routes                     ON direct_routes.route_id = routes.id
WHERE r1.direct_route_id = _direct_route_id and r2.direct_route_id = _direct_route_id ;

-- insert relations between station and route_station (virtual relation) 
 INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
 SELECT  
	bus.routes.city_id                          as city_id,
	bus.routes.route_type_id                    as route_type_id,
	bus.route_type_enum('c_route_station_input') as relation_type,
    _route_station_input_id                     as relation_a_id,
    bus.route_relations.id                      as relation_b_id,
    bus.timetable.time_a                        as time_a,
    bus.timetable.time_b   	                    as time_b,
    bus.schedule_group_days.day_id              as day_id,
    bus.timetable.frequency                     as wait_time,
    interval '00:00:00'                         as move_time,
    bus.routes.cost                             as cost_money,
    EXTRACT(EPOCH FROM bus.timetable.frequency/2.0) as cost_time,
    0                                           as distance   
    from bus.route_relations 
	JOIN bus.direct_routes       ON bus.direct_routes.id = bus.route_relations.direct_route_id
	JOIN bus.routes              ON bus.routes.id = bus.direct_routes.route_id
    JOIN bus.schedule            ON bus.route_relations.direct_route_id = bus.schedule.direct_route_id
	JOIN bus.schedule_groups     ON bus.schedule_groups.schedule_id = bus.schedule.id
    JOIN bus.schedule_group_days ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
    JOIN bus.timetable           ON bus.timetable.schedule_group_id = bus.schedule_groups.id
WHERE bus.route_relations.direct_route_id = _direct_route_id;


        
END;
$$;


ALTER FUNCTION bus.insert_graph_relations(_direct_route_id bigint, _route_station_input_id bigint) OWNER TO postgres;

--
-- Name: insert_route_relation(bigint, bigint, bigint, bigint, public.geography); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_route_relation(_direct_route_id bigint, _station_a_id bigint, _station_b_id bigint, _index bigint, _geom public.geography) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
  _speed                double precision; 
  _distance             double precision;
  _time                 interval;
  _id                   bigint;
BEGIN
  _speed := 1;
  SELECT bus.transport_types.ev_speed INTO _speed
  FROM bus.direct_routes 
    JOIN bus.routes ON bus.routes.id = bus.direct_routes.route_id 
    JOIN bus.route_types ON bus.route_types.id = bus.routes.route_type_id
    JOIN bus.transport_types ON bus.transport_types.id = bus.route_types.transport_id
  WHERE bus.direct_routes.id  = _direct_route_id;
  IF _geom IS NOT NULL THEN
    _distance := st_length(geography(_geom),false);
  ELSE
    _distance := 0;
  END IF;
  
  _time := _distance/1000.0/_speed * interval '1 hour';
	if _station_A_id <=0 THEN
	_station_A_id:= null;
	END IF;
	if _station_B_id <=0 THEN
	_station_A_id:= null;
	END IF;
   INSERT INTO bus.route_relations (direct_route_id,station_A_id,station_B_id,position_index,geom,ev_time,distance) 
          VALUES (_direct_route_id,_station_A_id,_station_B_id,_index,_geom,_time,_distance) RETURNING id INTO  _id;
  RETURN _id;
END;
$$;


ALTER FUNCTION bus.insert_route_relation(_direct_route_id bigint, _station_a_id bigint, _station_b_id bigint, _index bigint, _geom public.geography) OWNER TO postgres;

--
-- Name: insert_transitions(bigint, route_type_enum, double precision); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_transitions(_route_id bigint, _route_type route_type_enum, _max_distance double precision) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  _graph_relation      bus.graph_relations%ROWTYPE;
  r                    bus.relation%ROWTYPE;
  relations            bus.relation[];
  i                    int;
  count                int;
  _row                 record;
  _city_id             bigint;
  _arr_types           bus.route_type_enum[];
  _foot_speed    double precision;
BEGIN

  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
         
_arr_types = array[bus.route_type_enum('c_route_metro'),bus.route_type_enum('c_route_metro_transition')];

-- get city_id
SELECT city_id INTO _city_id from bus.routes where id = _route_id;

-- add transitions between 'c_route_metro' and 'c_route_metro_transition'
IF _route_type = ANY(_arr_types) THEN
  EXECUTE bus.insert_transitions_for_metro_transition(_route_id);

END IF;

-- get all nearest route_relations to current route 
FOR r IN
SELECT 
        r1.id                       as source,
        table2.relation_id          as target,
        st_distance(table2.location,bus.stations.location) as  distance,
        _route_type                 as source_route_type,
	bus.routes.route_type_id    as target_route_type       
FROM    bus.route_relations  as r1
        JOIN bus.stations       ON bus.stations.id = r1.station_b_id
        JOIN bus.direct_routes  ON bus.direct_routes.id = r1.direct_route_id
        JOIN bus.routes         ON bus.routes.id = bus.direct_routes.route_id

        ,(select bus.route_relations.id      as relation_id, 
		  bus.stations.location      as location,
		  bus.direct_routes.route_id as route_id,
		  bus.direct_routes.id       as direct_route_id,
		  bus.stations.id            as station_id
		  from bus.route_relations
                  JOIN bus.stations  ON bus.stations.id = bus.route_relations.station_b_id 
                  JOIN bus.direct_routes  ON bus.direct_routes.id = bus.route_relations.direct_route_id
                  where bus.direct_routes.route_id = _route_id
           )as table2
	WHERE   bus.direct_routes.route_id <> table2.route_id AND
	        st_distance(table2.location,bus.stations.location) < _max_distance AND
	        (bus.routes.route_type_id <> ALL(_arr_types) OR _route_type <> ALL(_arr_types))
	        
	LOOP
	  relations := array_append(relations,r);
	END LOOP;	     

-- insert reverse relations
  i:=1;
  count := array_upper(relations,1);
  WHILE i<= count LOOP
        r.source = relations[i].target;
        r.target = relations[i].source;
        relations := array_append(relations,r);
	i:= i + 1;
  END LOOP;
  RAISE NOTICE 'update_transitions(): %',count;

  -- insert into graph_relations
  INSERT INTO bus.graph_relations (city_id,route_type_id,relation_type,relation_a_id,
 relation_b_id,time_a,time_b,day_id,wait_time,move_time,cost_money,cost_time,distance)
  SELECT  
              _city_id            												as city_id,
	          bus.routes.route_type_id                                          as route_type_id,
              bus.route_type_enum('c_route_transition')							as relation_type,
              relations.source 													as relation_a_id,
              relations.target 													as relation_b_id,
              bus.timetable.time_a 												as time_a,
              bus.timetable.time_b 												as time_b,
              bus.schedule_group_days.day_id      								as day_id,
              bus.timetable.frequency                    						as wait_time,
			  (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00'  as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (relations.distance/1000.0/_foot_speed*60) * interval '00:01:00' + bus.timetable.frequency/2.0) as cost_time,
			  relations.distance                                                as distance
		
      from unnest(relations) as relations
              JOIN bus.route_relations as r1 ON  r1.id = relations.source
              JOIN bus.route_relations as r2 ON  r2.id = relations.target
              JOIN bus.direct_routes         ON bus.direct_routes.id = r2.direct_route_id
              JOIN bus.routes                ON bus.routes.id = bus.direct_routes.route_id
	      
	      JOIN bus.schedule              ON bus.schedule.direct_route_id = r2.direct_route_id
              JOIN bus.schedule_groups       ON bus.schedule_groups.schedule_id = bus.schedule.id
              JOIN bus.schedule_group_days   ON bus.schedule_group_days.schedule_group_id = bus.schedule_groups.id
              JOIN bus.timetable             ON bus.timetable.schedule_group_id = bus.schedule_groups.id    

              where r1.station_a_id IS NOT NULL  AND 
                    r2.station_a_id IS NOT NULL  AND
                    bus.is_has_transition(relations.source,relations.target, _max_distance/2.0) > 0;
  select count(*) into count from bus.graph_relations;
  RAISE NOTICE 'transitions count: %',count;
  
END;
$$;


ALTER FUNCTION bus.insert_transitions(_route_id bigint, _route_type route_type_enum, _max_distance double precision) OWNER TO postgres;

--
-- Name: insert_transitions_for_metro_transition(bigint); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_transitions_for_metro_transition(_route_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  r 		     bus.graph_relations%ROWTYPE;
  _foot_speed    double precision;
BEGIN
   
  
END;
$$;


ALTER FUNCTION bus.insert_transitions_for_metro_transition(_route_id bigint) OWNER TO postgres;

--
-- Name: insert_user(bigint, character, character); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_user(role_id bigint, login character, password character) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
 user_id bigint;
BEGIN
  INSERT INTO bus.users (role_id,login,password)  VALUES(role_id,login,password) RETURNING id INTO user_id;
  RETURN user_id;
END;
$$;


ALTER FUNCTION bus.insert_user(role_id bigint, login character, password character) OWNER TO postgres;

--
-- Name: insert_user(character, character, character); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_user(role_name character, login character, password character) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
 user_id bigint;
 role_id bigint;
BEGIN
  SELECT id INTO role_id  FROM bus.user_roles WHERE name = role_name;
  IF NOT FOUND THEN
     RAISE EXCEPTION 'user_role % not found', role_name;
   END IF;
 
  SELECT * INTO user_id FROM bus.insert_user(role_id,login,password);
  RETURN 1;
END;
$$;


ALTER FUNCTION bus.insert_user(role_name character, login character, password character) OWNER TO postgres;

--
-- Name: insert_user_role(character); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION insert_user_role(role_name character) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
  role_id bigint;
BEGIN
  INSERT INTO bus.user_roles (name)  VALUES(role_name) RETURNING id INTO role_id;
  RETURN role_id;
END;
$$;


ALTER FUNCTION bus.insert_user_role(role_name character) OWNER TO postgres;

--
-- Name: is_has_transition(integer, integer, double precision); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION is_has_transition(_curr_relation_a_id integer, _curr_relation_b_id integer, _max_distance double precision) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  _curr_relation_a    bus.route_relations%ROWTYPE;
  _curr_relation_b    bus.route_relations%ROWTYPE;
  
  _next_relation_a    bus.route_relations;
  _next_relation_b    bus.route_relations;
BEGIN
 
    SELECT * INTO _curr_relation_a FROM bus.route_relations WHERE id = _curr_relation_a_id;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
    SELECT * INTO _curr_relation_b FROM bus.route_relations WHERE id = _curr_relation_b_id;
  IF NOT FOUND THEN
	RAISE EXCEPTION 'function bus.get_next_relation(): Cannot find relation';
  END IF;
  _next_relation_a:= bus.get_next_relation(_curr_relation_a.id,_curr_relation_a.station_b_id);
  _next_relation_b:= bus.get_next_relation(_curr_relation_b.id,_curr_relation_b.station_b_id);
  --return -1;
  IF _next_relation_a IS NOT NULL AND _next_relation_b IS NOT NULL THEN
	IF  ( bus.get_distance_between_stations(_curr_relation_a.station_b_id,_curr_relation_b.station_b_id) < _max_distance AND
	      bus.get_distance_between_stations(_next_relation_a.station_b_id,_next_relation_b.station_b_id) < _max_distance)
	    OR
	    ( bus.get_distance_between_stations(_curr_relation_a.station_b_id,_next_relation_b.station_b_id) < _max_distance AND
	      bus.get_distance_between_stations(_next_relation_a.station_b_id,_curr_relation_b.station_b_id) < _max_distance)
	THEN
	    return -1;
	END IF;
  END IF;
  return 1;
END;
$$;


ALTER FUNCTION bus.is_has_transition(_curr_relation_a_id integer, _curr_relation_b_id integer, _max_distance double precision) OWNER TO postgres;

--
-- Name: on_delete_city(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION on_delete_city() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE

BEGIN
    DELETE FROM bus.routes 
		   WHERE city_id = OLD.id AND 
		   route_type_id = bus.route_type_enum('c_route_station_input');
	RETURN OLD;
END;
$$;


ALTER FUNCTION bus.on_delete_city() OWNER TO postgres;

--
-- Name: on_delete_station(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION on_delete_station() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 
BEGIN
 DELETE FROM bus.route_stations WHERE station_A_id = NULL AND station_B_id = OLD.id;
 
 RETURN OLD;
END;
$$;


ALTER FUNCTION bus.on_delete_station() OWNER TO postgres;

--
-- Name: on_insert_city(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION on_insert_city() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION bus.on_insert_city() OWNER TO postgres;

--
-- Name: on_insert_station(); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION on_insert_station() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION bus.on_insert_station() OWNER TO postgres;

--
-- Name: shortest_ways(bigint, public.geography, public.geography, public.day_enum, time without time zone, double precision, text[], double precision[], alg_strategy, public.lang_enum); Type: FUNCTION; Schema: bus; Owner: postgres
--

CREATE FUNCTION shortest_ways(_city_id bigint, _p1 public.geography, _p2 public.geography, _day_id bus.day_enum, _time_start time without time zone, _max_distance double precision, _route_types text[], _discounts double precision[], _alg_strategy alg_strategy, _lang_id bus.lang_enum) RETURNS SETOF way_elem
    LANGUAGE plpgsql
    AS $$
DECLARE
 _foot_speed            double precision;
 _nearest_relation      bus.nearest_relation%ROWTYPE;
 relations_A 		bus.nearest_relation[];
 relations_B 		bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 count_i 		integer;
 count_j 		integer;
 _curr_path             integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path%ROWTYPE;
 _temp_filter_path	bus.filter_path%ROWTYPE;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
 _id_arr                integer[];
 _id                    integer;
BEGIN

  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
         
 -- get _relation_input_id
 _relation_input_id := bus.get_relation_input_id(_city_id);

 -- get start end finish relations(stations)
 FOR _nearest_relation IN select * FROM bus.find_nearest_relations(_p1,
				 _city_id,
				 _max_distance)
 LOOP
       relations_A := array_append(relations_A,_nearest_relation);
 END LOOP;

 FOR _nearest_relation IN select * FROM bus.find_nearest_relations(_p2,
				 _city_id,
				 _max_distance)
  LOOP
       relations_B := array_append(relations_B,_nearest_relation);
   END LOOP;
  
  CREATE TEMPORARY  TABLE use_routes  ON COMMIT DROP AS
  select route_type as id,discount from 
	( select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)) as route_types
        JOIN
        ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)) as discounts
        ON discounts.id =  route_types.id;

  
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id as id,
	       relation_a_id          as source,
	       relation_b_id          as target, 
	       cost_time              as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.relation_type 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));

  ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  
	CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, relation_a_id as source,relation_b_id as target, use_routes.discount*cost_money as cost 
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.relation_type 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));
  ELSE
        CREATE TEMPORARY TABLE graph ON COMMIT DROP AS
	select bus.graph_relations.id, 
	       relation_a_id as source,
	       relation_b_id as target, 
	       (30*bus.graph_relations.cost + cost_time) as cost
	       from bus.graph_relations 
	       JOIN use_routes ON use_routes.id = bus.graph_relations.route_type_id 
	       where city_id = _city_id AND
	             (time_a IS NULL OR (_time_start >= time_a AND _time_start <= time_b)) AND 
	             (day_id=_day_id or day_id = bus.day_enum('c_all'));
  END IF;



  
  CREATE TEMPORARY TABLE paths
  (
     path_id     integer,
     index       integer,
     relation_id integer,
     graph_id    bigint
  )ON COMMIT DROP;

  
 
  count_i := array_upper(relations_A,1);
  count_j := array_upper(relations_B,1);
   i:=1;
  _curr_path := 1;
  
  WHILE i<= count_i LOOP
        j := 1;
        WHILE j<= count_j LOOP
	   query:='select * from graph where source<>'||_relation_input_id||' OR (source = '
	          ||_relation_input_id||' and target = '||relations_A[i].id||')';

	 --  RAISE NOTICE '%',relations_A[i];
          -- RAISE NOTICE '%',relations_B[j];
         --  RAISE NOTICE '%',query;
           k:=0;
           WHILE k < 1 LOOP
           BEGIN

                INSERT INTO paths(path_id,index,relation_id,graph_id)
		   select _curr_path as path_id,
                          row_number() over (ORDER BY (select 0)) as index,
		          t1.vertex_id as  relation_id,
		          t1.edge_id   as graph_id
		   from shortest_path(query,_relation_input_id,relations_B[j].id,true,false) as t1;
		
		INSERT INTO paths(path_id,index) VALUES(_curr_path,10000);
		_curr_path := _curr_path + 1;
		
	   EXCEPTION  WHEN OTHERS THEN 
	       -- RAISE  NOTICE 'warning in shortest_path';
           END;
           k := k+1;
           END LOOP;
	   j := j + 1;
        END LOOP;
	i := i + 1;
  END LOOP;
 
 select count(*) INTO count_i from  graph ;
 RAISE  NOTICE 'count: %',count_i; 
 
 select count(*) INTO count_i from  paths ;
 RAISE  NOTICE 'count: %',count_i; 

 --delete bad ways from paths table
 EXECUTE bus.__clean_paths_table(_relation_input_id);

 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		paths.path_id                                        as path_id,
		paths.index                                          as index,
		bus.route_relations.direct_route_id                  as direct_route_id,
		bus.graph_relations.relation_type                    as route_type,
		bus.route_relations.position_index                   as relation_index,
		bus.route_relations.id                               as relation_id,
		bus.route_relations.station_b_id                     as station_id,
		bus.graph_relations.move_time                        as move_time,
		bus.graph_relations.wait_time                        as wait_time,
		bus.graph_relations.cost_money*use_routes.discount   as cost,
		bus.graph_relations.distance                         as distance
		
        FROM paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = paths.relation_id
	LEFT JOIN bus.graph_relations                  	     ON bus.graph_relations.id = paths.graph_id
	LEFT JOIN use_routes                                 ON use_routes.id = bus.graph_relations.route_type_id 
	ORDER BY paths.path_id,paths.index
  LOOP
    -- _paths:= array_append(_paths,_curr_filter_path);
    
       IF  _curr_filter_path.path_id = _prev_filter_path.path_id 
          AND _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id THEN
             _temp_filter_path           := _curr_filter_path;
             _temp_filter_path.wait_time := _prev_filter_path.wait_time;
             _temp_filter_path.cost      := _prev_filter_path.cost;
             
             IF _prev_filter_path.route_type = bus.route_type_enum('c_route_station_input') THEN
               select relations.distance into _temp_filter_path.distance FROM unnest(relations_A) as relations 
			where relations.id = _curr_filter_path.relation_id;
               _temp_filter_path.move_time := _temp_filter_path.distance/1000.0/_foot_speed * interval '1 hour';
               
             ELSE
	        _temp_filter_path.move_time := _prev_filter_path.move_time;
	        _temp_filter_path.distance  := _prev_filter_path.distance;
	     END IF;
             _paths:= array_append(_paths,_temp_filter_path);
             IF _prev_filter_path.relation_id <> _relation_input_id THEN
               _temp_filter_path           := _prev_filter_path;
               _temp_filter_path.move_time := _move_time;
               _temp_filter_path.cost      := null;
               _temp_filter_path.wait_time := null;
               _temp_filter_path.distance  := _distance;
               _paths :=  array_append(_paths,_temp_filter_path);
             END IF;
             _move_time := interval '00:00:00';
             _distance  := 0.0;
       ELSEIF _curr_filter_path.path_id = _prev_filter_path.path_id AND  _prev_filter_path.move_time IS NOT NULL THEN
             _move_time := _move_time + _prev_filter_path.move_time;
             _distance  := _distance + _prev_filter_path.distance;
       END IF;

       
       IF _prev_filter_path.path_id = _curr_filter_path.path_id AND
          _curr_filter_path.index = 10000  THEN
	    _prev_filter_path.move_time := _move_time;
	    _prev_filter_path.distance := _distance;
	    _paths:= array_append(_paths,_prev_filter_path);
	    select relations.distance into _curr_filter_path.distance FROM unnest(relations_B) as relations 
                  where relations.id = _prev_filter_path.relation_id;
            _curr_filter_path.move_time := _curr_filter_path.distance/1000.0/_foot_speed * interval '1 hour';
            _paths:= array_append(_paths,_curr_filter_path);	
       END IF;
       _prev_filter_path := _curr_filter_path;
   END LOOP;

 -- return data
   
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			as path_id,
		paths.index 			as index,
		bus.direct_routes.id 		as direct_route_id,
		bus.routes.route_type_id 	as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		paths.wait_time                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
        
        WHERE (route_names.lang_id = _lang_id or route_names.lang_id IS NULL) AND
              (station_names.lang_id = _lang_id or station_names.lang_id IS NULL)
  LOOP
         RETURN NEXT _way_elem;
   END LOOP;
	 
END;
$$;


ALTER FUNCTION bus.shortest_ways(_city_id bigint, _p1 public.geography, _p2 public.geography, _day_id bus.day_enum, _time_start time without time zone, _max_distance double precision, _route_types text[], _discounts double precision[], _alg_strategy alg_strategy, _lang_id bus.lang_enum) OWNER TO postgres;

--
-- Name: cities; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE cities (
    id bigint NOT NULL,
    key text NOT NULL,
    name_key bigint NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    scale bigint NOT NULL,
    is_show bit(1) NOT NULL
);


ALTER TABLE bus.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE cities_id_seq OWNED BY cities.id;


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('cities_id_seq', 6, true);


--
-- Name: direct_routes; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE direct_routes (
    id bigint NOT NULL,
    route_id bigint NOT NULL,
    direct bit(1) NOT NULL
);


ALTER TABLE bus.direct_routes OWNER TO postgres;

--
-- Name: direct_routes_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE direct_routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.direct_routes_id_seq OWNER TO postgres;

--
-- Name: direct_routes_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE direct_routes_id_seq OWNED BY direct_routes.id;


--
-- Name: direct_routes_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('direct_routes_id_seq', 84, true);


--
-- Name: discount_by_route_types; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE discount_by_route_types (
    discount_id bigint NOT NULL,
    route_type_id route_type_enum NOT NULL,
    discount double precision NOT NULL,
    CONSTRAINT discount_route_types_discount_after_check CHECK (((discount >= (0)::double precision) AND (discount <= (1)::double precision)))
);


ALTER TABLE bus.discount_by_route_types OWNER TO postgres;

--
-- Name: discounts; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE discounts (
    id bigint NOT NULL,
    name_key bigint NOT NULL
);


ALTER TABLE bus.discounts OWNER TO postgres;

--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.discounts_id_seq OWNER TO postgres;

--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE discounts_id_seq OWNED BY discounts.id;


--
-- Name: discounts_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('discounts_id_seq', 2, true);


--
-- Name: graph_relations; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE graph_relations (
    id bigint NOT NULL,
    city_id bigint NOT NULL,
    route_type_id route_type_enum NOT NULL,
    relation_type route_type_enum NOT NULL,
    relation_a_id integer NOT NULL,
    relation_b_id integer NOT NULL,
    time_a time without time zone,
    time_b time without time zone,
    day_id bus.day_enum NOT NULL,
    move_time interval NOT NULL,
    wait_time interval NOT NULL,
    cost_money double precision NOT NULL,
    cost_time double precision NOT NULL,
    distance double precision NOT NULL
);


ALTER TABLE bus.graph_relations OWNER TO postgres;

--
-- Name: graph_relations_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE graph_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.graph_relations_id_seq OWNER TO postgres;

--
-- Name: graph_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE graph_relations_id_seq OWNED BY graph_relations.id;


--
-- Name: graph_relations_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('graph_relations_id_seq', 152, true);


--
-- Name: import_objects; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE import_objects (
    id bigint NOT NULL,
    city_id bigint NOT NULL,
    route_type route_type_enum NOT NULL,
    route_number text NOT NULL,
    obj text NOT NULL
);


ALTER TABLE bus.import_objects OWNER TO postgres;

--
-- Name: import_objects_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE import_objects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.import_objects_id_seq OWNER TO postgres;

--
-- Name: import_objects_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE import_objects_id_seq OWNED BY import_objects.id;


--
-- Name: import_objects_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('import_objects_id_seq', 18, true);


--
-- Name: languages; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE languages (
    id bus.lang_enum NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE bus.languages OWNER TO postgres;

--
-- Name: route_relations_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE route_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.route_relations_id_seq OWNER TO postgres;

--
-- Name: route_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE route_relations_id_seq OWNED BY route_relations.id;


--
-- Name: route_relations_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('route_relations_id_seq', 1159, true);


--
-- Name: route_types; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE route_types (
    id route_type_enum NOT NULL,
    transport_id transport_type_enum NOT NULL,
    visible bit(1) NOT NULL
);


ALTER TABLE bus.route_types OWNER TO postgres;

--
-- Name: routes; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE routes (
    id bigint NOT NULL,
    city_id bigint NOT NULL,
    cost double precision NOT NULL,
    route_type_id route_type_enum NOT NULL,
    number character varying(128) NOT NULL,
    name_key bigint
);


ALTER TABLE bus.routes OWNER TO postgres;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.routes_id_seq OWNER TO postgres;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE routes_id_seq OWNED BY routes.id;


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('routes_id_seq', 45, true);


--
-- Name: schedule; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE schedule (
    id bigint NOT NULL,
    direct_route_id bigint NOT NULL
);


ALTER TABLE bus.schedule OWNER TO postgres;

--
-- Name: schedule_group_days; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE schedule_group_days (
    id bigint NOT NULL,
    schedule_group_id bigint NOT NULL,
    day_id bus.day_enum NOT NULL
);


ALTER TABLE bus.schedule_group_days OWNER TO postgres;

--
-- Name: schedule_group_days_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE schedule_group_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.schedule_group_days_id_seq OWNER TO postgres;

--
-- Name: schedule_group_days_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE schedule_group_days_id_seq OWNED BY schedule_group_days.id;


--
-- Name: schedule_group_days_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('schedule_group_days_id_seq', 88, true);


--
-- Name: schedule_groups; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE schedule_groups (
    id bigint NOT NULL,
    schedule_id bigint NOT NULL
);


ALTER TABLE bus.schedule_groups OWNER TO postgres;

--
-- Name: schedule_groups_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE schedule_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.schedule_groups_id_seq OWNER TO postgres;

--
-- Name: schedule_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE schedule_groups_id_seq OWNED BY schedule_groups.id;


--
-- Name: schedule_groups_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('schedule_groups_id_seq', 88, true);


--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.schedule_id_seq OWNER TO postgres;

--
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE schedule_id_seq OWNED BY schedule.id;


--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('schedule_id_seq', 88, true);


--
-- Name: station_transports; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE station_transports (
    station_id bigint NOT NULL,
    transport_type_id transport_type_enum NOT NULL
);


ALTER TABLE bus.station_transports OWNER TO postgres;

--
-- Name: stations; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE stations (
    id bigint NOT NULL,
    city_id bigint NOT NULL,
    name_key bigint NOT NULL,
    location public.geography(Point,4326) NOT NULL
);


ALTER TABLE bus.stations OWNER TO postgres;

--
-- Name: stations_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.stations_id_seq OWNER TO postgres;

--
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE stations_id_seq OWNED BY stations.id;


--
-- Name: stations_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('stations_id_seq', 741, true);


--
-- Name: string_keys; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE string_keys (
    id bigint NOT NULL,
    name character varying(256)
);


ALTER TABLE bus.string_keys OWNER TO postgres;

--
-- Name: string_keys_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE string_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.string_keys_id_seq OWNER TO postgres;

--
-- Name: string_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE string_keys_id_seq OWNED BY string_keys.id;


--
-- Name: string_keys_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('string_keys_id_seq', 798, true);


--
-- Name: string_values; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE string_values (
    id bigint NOT NULL,
    key_id bigint NOT NULL,
    lang_id bus.lang_enum NOT NULL,
    value text NOT NULL
);


ALTER TABLE bus.string_values OWNER TO postgres;

--
-- Name: string_values_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE string_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.string_values_id_seq OWNER TO postgres;

--
-- Name: string_values_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE string_values_id_seq OWNED BY string_values.id;


--
-- Name: string_values_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('string_values_id_seq', 2227, true);


--
-- Name: timetable; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE timetable (
    id bigint NOT NULL,
    schedule_group_id bigint NOT NULL,
    time_a time without time zone NOT NULL,
    time_b time without time zone NOT NULL,
    frequency interval NOT NULL
);


ALTER TABLE bus.timetable OWNER TO postgres;

--
-- Name: timetable_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE timetable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.timetable_id_seq OWNER TO postgres;

--
-- Name: timetable_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE timetable_id_seq OWNED BY timetable.id;


--
-- Name: timetable_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('timetable_id_seq', 112, true);


--
-- Name: transport_types; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE transport_types (
    id transport_type_enum NOT NULL,
    ev_speed double precision NOT NULL
);


ALTER TABLE bus.transport_types OWNER TO postgres;

--
-- Name: user_roles; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE user_roles (
    id bigint NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE bus.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE user_roles_id_seq OWNED BY user_roles.id;


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('user_roles_id_seq', 1, true);


--
-- Name: users; Type: TABLE; Schema: bus; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    login character varying(256) NOT NULL,
    password character varying(256) NOT NULL
);


ALTER TABLE bus.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: bus; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bus.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: bus; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: bus; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 2, true);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY cities ALTER COLUMN id SET DEFAULT nextval('cities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY direct_routes ALTER COLUMN id SET DEFAULT nextval('direct_routes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY discounts ALTER COLUMN id SET DEFAULT nextval('discounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY graph_relations ALTER COLUMN id SET DEFAULT nextval('graph_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY import_objects ALTER COLUMN id SET DEFAULT nextval('import_objects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY route_relations ALTER COLUMN id SET DEFAULT nextval('route_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY routes ALTER COLUMN id SET DEFAULT nextval('routes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule ALTER COLUMN id SET DEFAULT nextval('schedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule_group_days ALTER COLUMN id SET DEFAULT nextval('schedule_group_days_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule_groups ALTER COLUMN id SET DEFAULT nextval('schedule_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY stations ALTER COLUMN id SET DEFAULT nextval('stations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY string_keys ALTER COLUMN id SET DEFAULT nextval('string_keys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY string_values ALTER COLUMN id SET DEFAULT nextval('string_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY timetable ALTER COLUMN id SET DEFAULT nextval('timetable_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY user_roles ALTER COLUMN id SET DEFAULT nextval('user_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY cities (id, key, name_key, lat, lon, scale, is_show) FROM stdin;
1	kharkiv	3	50	36	10	1
2	kyiv	5	50	30	8	1
\.


--
-- Data for Name: direct_routes; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY direct_routes (id, route_id, direct) FROM stdin;
1	1	0
2	2	0
3	3	0
4	3	1
5	4	0
6	4	1
7	5	0
8	5	1
9	6	0
10	6	1
41	24	1
42	24	0
45	26	1
46	26	0
47	27	1
48	27	0
49	28	1
50	28	0
51	29	1
52	29	0
53	30	1
54	30	0
55	31	1
56	31	0
57	32	1
58	32	0
59	33	1
60	33	0
61	34	1
62	34	0
63	35	1
64	35	0
65	36	1
66	36	0
67	37	1
68	37	0
69	38	1
70	38	0
71	39	1
72	39	0
73	40	1
74	40	0
75	41	1
76	41	0
77	42	1
78	42	0
79	43	1
80	43	0
81	44	1
82	44	0
83	45	1
84	45	0
\.


--
-- Data for Name: discount_by_route_types; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY discount_by_route_types (discount_id, route_type_id, discount) FROM stdin;
1	c_route_metro	1
1	c_route_metro_transition	1
2	c_route_metro	0.5
2	c_route_bus	1
2	c_route_trolley	1
2	c_route_tram	1
2	c_route_station_input	1
2	c_route_transition	1
2	c_route_metro_transition	0
\.


--
-- Data for Name: discounts; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY discounts (id, name_key) FROM stdin;
1	1
2	2
\.


--
-- Data for Name: graph_relations; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY graph_relations (id, city_id, route_type_id, relation_type, relation_a_id, relation_b_id, time_a, time_b, day_id, move_time, wait_time, cost_money, cost_time, distance) FROM stdin;
1	1	c_route_trolley	c_route_trolley	3	4	\N	\N	c_all	00:01:25.175832	00:00:00	0	85.1758319999999998	964.697903796407331
2	1	c_route_trolley	c_route_trolley	4	5	\N	\N	c_all	00:02:13.024162	00:00:00	0	133.02416199999999	1562.80202721257888
3	1	c_route_trolley	c_route_trolley	5	6	\N	\N	c_all	00:02:19.368552	00:00:00	0	139.368551999999994	1642.10690547141644
4	1	c_route_trolley	c_route_trolley	6	7	\N	\N	c_all	00:05:10.958145	00:00:00	0	310.958145000000002	3786.9768150445384
5	1	c_route_trolley	c_route_trolley	7	8	\N	\N	c_all	00:03:28.238087	00:00:00	0	208.238087000000007	2502.97608581568602
6	1	c_route_trolley	c_route_trolley	8	9	\N	\N	c_all	00:02:11.831998	00:00:00	0	131.831997999999999	1547.899970322336
7	1	c_route_trolley	c_route_trolley	9	10	\N	\N	c_all	00:01:34.73933	00:00:00	0	94.7393299999999954	1084.24161958873697
8	1	c_route_trolley	c_route_station_input	1	3	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
9	1	c_route_trolley	c_route_station_input	1	4	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
10	1	c_route_trolley	c_route_station_input	1	5	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
11	1	c_route_trolley	c_route_station_input	1	6	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
12	1	c_route_trolley	c_route_station_input	1	7	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
13	1	c_route_trolley	c_route_station_input	1	8	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
14	1	c_route_trolley	c_route_station_input	1	9	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
15	1	c_route_trolley	c_route_station_input	1	10	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
16	1	c_route_trolley	c_route_trolley	11	12	\N	\N	c_all	00:01:34.73933	00:00:00	0	94.7393299999999954	1084.24161958872423
17	1	c_route_trolley	c_route_trolley	12	13	\N	\N	c_all	00:02:11.831998	00:00:00	0	131.831997999999999	1547.89997032247766
18	1	c_route_trolley	c_route_trolley	13	14	\N	\N	c_all	00:03:28.238087	00:00:00	0	208.238087000000007	2502.9760858154641
19	1	c_route_trolley	c_route_trolley	14	15	\N	\N	c_all	00:05:10.958145	00:00:00	0	310.958145000000002	3786.97681504448519
20	1	c_route_trolley	c_route_trolley	15	16	\N	\N	c_all	00:02:19.368552	00:00:00	0	139.368551999999994	1642.10690547099739
21	1	c_route_trolley	c_route_trolley	16	17	\N	\N	c_all	00:02:13.024162	00:00:00	0	133.02416199999999	1562.80202721251658
22	1	c_route_trolley	c_route_trolley	17	18	\N	\N	c_all	00:01:25.175832	00:00:00	0	85.1758319999999998	964.697903796676542
23	1	c_route_trolley	c_route_station_input	1	11	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
24	1	c_route_trolley	c_route_station_input	1	12	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
25	1	c_route_trolley	c_route_station_input	1	13	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
26	1	c_route_trolley	c_route_station_input	1	14	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
27	1	c_route_trolley	c_route_station_input	1	15	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
28	1	c_route_trolley	c_route_station_input	1	16	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
29	1	c_route_trolley	c_route_station_input	1	17	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
30	1	c_route_trolley	c_route_station_input	1	18	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
31	1	c_route_metro	c_route_metro	19	20	\N	\N	c_all	00:01:17.905978	00:00:00	0	77.9059780000000046	854.40639771077042
32	1	c_route_metro	c_route_metro	20	21	\N	\N	c_all	00:01:53.835996	00:00:00	0	113.835995999999994	1293.55106316396541
33	1	c_route_metro	c_route_metro	21	22	\N	\N	c_all	00:01:23.908383	00:00:00	0	83.9083830000000006	927.769131150337103
34	1	c_route_metro	c_route_metro	22	23	\N	\N	c_all	00:01:41.049122	00:00:00	0	101.049121999999997	1137.26704917355619
35	1	c_route_metro	c_route_metro	23	24	\N	\N	c_all	00:04:02.7334	00:00:00	0	242.733399999999989	2868.96378180913143
36	1	c_route_metro	c_route_metro	24	25	\N	\N	c_all	00:01:22.169218	00:00:00	0	82.1692180000000008	906.512662272981061
37	1	c_route_metro	c_route_station_input	1	19	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
38	1	c_route_metro	c_route_station_input	1	20	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
39	1	c_route_metro	c_route_station_input	1	21	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
40	1	c_route_metro	c_route_station_input	1	22	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
41	1	c_route_metro	c_route_station_input	1	23	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
42	1	c_route_metro	c_route_station_input	1	24	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
43	1	c_route_metro	c_route_station_input	1	25	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
44	1	c_route_metro	c_route_metro	26	27	\N	\N	c_all	00:01:22.169218	00:00:00	0	82.1692180000000008	906.512662273003002
45	1	c_route_metro	c_route_metro	27	28	\N	\N	c_all	00:04:02.7334	00:00:00	0	242.733399999999989	2868.96378180915917
46	1	c_route_metro	c_route_metro	28	29	\N	\N	c_all	00:01:41.049122	00:00:00	0	101.049121999999997	1137.26704917324469
47	1	c_route_metro	c_route_metro	29	30	\N	\N	c_all	00:01:23.908383	00:00:00	0	83.9083830000000006	927.769131150104045
48	1	c_route_metro	c_route_metro	30	31	\N	\N	c_all	00:01:53.835996	00:00:00	0	113.835995999999994	1293.5510631640243
49	1	c_route_metro	c_route_metro	31	32	\N	\N	c_all	00:01:17.905978	00:00:00	0	77.9059780000000046	854.406397710846591
50	1	c_route_metro	c_route_station_input	1	26	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
51	1	c_route_metro	c_route_station_input	1	27	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
52	1	c_route_metro	c_route_station_input	1	28	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
53	1	c_route_metro	c_route_station_input	1	29	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
54	1	c_route_metro	c_route_station_input	1	30	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
55	1	c_route_metro	c_route_station_input	1	31	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
56	1	c_route_metro	c_route_station_input	1	32	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
57	1	c_route_trolley	c_route_transition	29	9	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
58	1	c_route_trolley	c_route_transition	22	9	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
59	1	c_route_trolley	c_route_transition	29	12	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
60	1	c_route_trolley	c_route_transition	22	12	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
61	1	c_route_metro	c_route_transition	12	22	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
62	1	c_route_metro	c_route_transition	9	22	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
63	1	c_route_metro	c_route_transition	12	29	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
64	1	c_route_metro	c_route_transition	9	29	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	2	335.697769999999991	257.913569180591651
65	1	c_route_metro	c_route_metro	33	34	\N	\N	c_all	00:03:48.953918	00:00:00	0	228.953917999999987	2700.54788689421957
66	1	c_route_metro	c_route_metro	34	35	\N	\N	c_all	00:02:18.982092	00:00:00	0	138.982091999999994	1600.89223124044634
67	1	c_route_metro	c_route_metro	35	36	\N	\N	c_all	00:02:10.837601	00:00:00	0	130.837601000000006	1501.34846177088752
68	1	c_route_metro	c_route_metro	36	37	\N	\N	c_all	00:02:11.666702	00:00:00	0	131.666701999999987	1511.48191785973813
69	1	c_route_metro	c_route_metro	37	38	\N	\N	c_all	00:02:50.58415	00:00:00	0	170.584149999999994	1987.13961139174739
70	1	c_route_metro	c_route_metro	38	39	\N	\N	c_all	00:03:13.124074	00:00:00	0	193.124074000000007	2262.62757091444109
71	1	c_route_metro	c_route_metro	39	40	\N	\N	c_all	00:03:17.032794	00:00:00	0	197.032793999999996	2310.4008153231066
72	1	c_route_metro	c_route_metro	40	41	\N	\N	c_all	00:03:12.794467	00:00:00	0	192.794466999999997	2258.5990462284467
73	1	c_route_metro	c_route_metro	41	42	\N	\N	c_all	00:03:27.77656	00:00:00	0	207.776559999999989	2441.71351381456952
74	1	c_route_metro	c_route_metro	42	43	\N	\N	c_all	00:02:45.962482	00:00:00	0	165.962481999999994	1930.65255454697035
75	1	c_route_metro	c_route_metro	43	44	\N	\N	c_all	00:03:02.941206	00:00:00	0	182.941205999999994	2138.17029511797773
76	1	c_route_metro	c_route_metro	44	45	\N	\N	c_all	00:03:17.818438	00:00:00	0	197.818437999999986	2320.00312697125355
77	1	c_route_metro	c_route_station_input	1	33	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
78	1	c_route_metro	c_route_station_input	1	34	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
79	1	c_route_metro	c_route_station_input	1	35	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
80	1	c_route_metro	c_route_station_input	1	36	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
81	1	c_route_metro	c_route_station_input	1	37	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
82	1	c_route_metro	c_route_station_input	1	38	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
83	1	c_route_metro	c_route_station_input	1	39	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
84	1	c_route_metro	c_route_station_input	1	40	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
85	1	c_route_metro	c_route_station_input	1	41	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
86	1	c_route_metro	c_route_station_input	1	42	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
87	1	c_route_metro	c_route_station_input	1	43	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
88	1	c_route_metro	c_route_station_input	1	44	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
89	1	c_route_metro	c_route_station_input	1	45	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
90	1	c_route_metro	c_route_metro	46	47	\N	\N	c_all	00:03:17.818438	00:00:00	0	197.818437999999986	2320.00312697108302
91	1	c_route_metro	c_route_metro	47	48	\N	\N	c_all	00:03:02.941206	00:00:00	0	182.941205999999994	2138.17029511778037
92	1	c_route_metro	c_route_metro	48	49	\N	\N	c_all	00:02:45.962482	00:00:00	0	165.962481999999994	1930.65255454715066
93	1	c_route_metro	c_route_metro	49	50	\N	\N	c_all	00:03:27.77656	00:00:00	0	207.776559999999989	2441.71351381437444
94	1	c_route_metro	c_route_metro	50	51	\N	\N	c_all	00:03:12.794467	00:00:00	0	192.794466999999997	2258.59904622827935
95	1	c_route_metro	c_route_metro	51	52	\N	\N	c_all	00:03:17.032794	00:00:00	0	197.032793999999996	2310.4008153231207
96	1	c_route_metro	c_route_metro	52	53	\N	\N	c_all	00:03:13.124074	00:00:00	0	193.124074000000007	2262.62757091442154
97	1	c_route_metro	c_route_metro	53	54	\N	\N	c_all	00:02:50.58415	00:00:00	0	170.584149999999994	1987.13961139161643
98	1	c_route_metro	c_route_metro	54	55	\N	\N	c_all	00:02:11.666702	00:00:00	0	131.666701999999987	1511.48191785965287
99	1	c_route_metro	c_route_metro	55	56	\N	\N	c_all	00:02:10.837601	00:00:00	0	130.837601000000006	1501.34846177101963
100	1	c_route_metro	c_route_metro	56	57	\N	\N	c_all	00:02:18.982092	00:00:00	0	138.982091999999994	1600.89223124072032
101	1	c_route_metro	c_route_metro	57	58	\N	\N	c_all	00:03:48.953918	00:00:00	0	228.953917999999987	2700.54788689444467
102	1	c_route_metro	c_route_station_input	1	46	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
103	1	c_route_metro	c_route_station_input	1	47	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
104	1	c_route_metro	c_route_station_input	1	48	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
105	1	c_route_metro	c_route_station_input	1	49	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
106	1	c_route_metro	c_route_station_input	1	50	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
107	1	c_route_metro	c_route_station_input	1	51	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
108	1	c_route_metro	c_route_station_input	1	52	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
109	1	c_route_metro	c_route_station_input	1	53	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
110	1	c_route_metro	c_route_station_input	1	54	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
111	1	c_route_metro	c_route_station_input	1	55	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
112	1	c_route_metro	c_route_station_input	1	56	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
113	1	c_route_metro	c_route_station_input	1	57	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
114	1	c_route_metro	c_route_station_input	1	58	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
115	1	c_route_trolley	c_route_transition	55	10	06:00:00	22:00:00	c_all	00:02:32.77121	00:05:00	2	302.771209999999996	212.182236713871362
116	1	c_route_trolley	c_route_transition	36	10	06:00:00	22:00:00	c_all	00:02:32.77121	00:05:00	2	302.771209999999996	212.182236713871362
117	1	c_route_metro	c_route_transition	10	36	06:00:00	22:00:00	c_all	00:02:32.77121	00:05:00	2	302.771209999999996	212.182236713871362
118	1	c_route_metro	c_route_transition	10	55	06:00:00	22:00:00	c_all	00:02:32.77121	00:05:00	2	302.771209999999996	212.182236713871362
119	1	c_route_bus	c_route_bus	59	60	\N	\N	c_all	00:01:41.135677	00:00:00	0	101.135677000000001	1293.55106316396541
120	1	c_route_bus	c_route_bus	60	61	\N	\N	c_all	00:01:14.799377	00:00:00	0	74.7993770000000069	927.769131150337103
121	1	c_route_bus	c_route_bus	61	62	\N	\N	c_all	00:01:29.883228	00:00:00	0	89.8832280000000026	1137.26704917355619
122	1	c_route_bus	c_route_bus	62	63	\N	\N	c_all	00:03:33.987494	00:00:00	0	213.987493999999998	2860.93742095668267
123	1	c_route_bus	c_route_bus	63	64	\N	\N	c_all	00:02:50.909185	00:00:00	0	170.909185000000008	2262.62757091444109
124	1	c_route_bus	c_route_station_input	1	59	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
125	1	c_route_bus	c_route_station_input	1	60	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
126	1	c_route_bus	c_route_station_input	1	61	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
127	1	c_route_bus	c_route_station_input	1	62	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
128	1	c_route_bus	c_route_station_input	1	63	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
129	1	c_route_bus	c_route_station_input	1	64	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
130	1	c_route_bus	c_route_bus	65	66	\N	\N	c_all	00:02:50.909185	00:00:00	0	170.909185000000008	2262.62757091442154
131	1	c_route_bus	c_route_bus	66	67	\N	\N	c_all	00:03:33.987494	00:00:00	0	213.987493999999998	2860.93742095662856
132	1	c_route_bus	c_route_bus	67	68	\N	\N	c_all	00:01:29.883228	00:00:00	0	89.8832280000000026	1137.26704917324469
133	1	c_route_bus	c_route_bus	68	69	\N	\N	c_all	00:01:14.799377	00:00:00	0	74.7993770000000069	927.769131150104045
134	1	c_route_bus	c_route_bus	69	70	\N	\N	c_all	00:01:41.135677	00:00:00	0	101.135677000000001	1293.5510631640243
135	1	c_route_bus	c_route_station_input	1	65	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
136	1	c_route_bus	c_route_station_input	1	66	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
137	1	c_route_bus	c_route_station_input	1	67	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
138	1	c_route_bus	c_route_station_input	1	68	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
139	1	c_route_bus	c_route_station_input	1	69	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
140	1	c_route_bus	c_route_station_input	1	70	06:00:00	22:00:00	c_all	00:00:00	00:05:00	3.5	150	0
141	1	c_route_trolley	c_route_transition	68	9	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
142	1	c_route_trolley	c_route_transition	61	9	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
143	1	c_route_trolley	c_route_transition	68	12	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
144	1	c_route_trolley	c_route_transition	61	12	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
145	1	c_route_metro	c_route_transition	66	25	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
146	1	c_route_metro	c_route_transition	63	25	06:00:00	22:00:00	c_all	00:00:00	00:05:00	2	150	0
147	1	c_route_bus	c_route_transition	12	61	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	3.5	335.697769999999991	257.913569180591651
148	1	c_route_bus	c_route_transition	9	61	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	3.5	335.697769999999991	257.913569180591651
149	1	c_route_bus	c_route_transition	25	63	06:00:00	22:00:00	c_all	00:02:42.55339	00:05:00	3.5	312.553389999999979	225.768597665409686
150	1	c_route_bus	c_route_transition	25	66	06:00:00	22:00:00	c_all	00:02:42.55339	00:05:00	3.5	312.553389999999979	225.768597665409686
151	1	c_route_bus	c_route_transition	12	68	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	3.5	335.697769999999991	257.913569180591651
152	1	c_route_bus	c_route_transition	9	68	06:00:00	22:00:00	c_all	00:03:05.69777	00:05:00	3.5	335.697769999999991	257.913569180591651
\.


--
-- Data for Name: import_objects; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY import_objects (id, city_id, route_type, route_number, obj) FROM stdin;
1	2	c_route_bus	5	{"cityID":2,"routeID":223,"routeType":"c_route_bus","number":"5","timeStart":21660,"timeFinish":82800,"intervalMin":1140,"intervalMax":1140,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4095458984375,"y":30.5193557739258,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Изюмская"},{"lang_id":"c_en","value":" Izumska St"},{"lang_id":"c_uk","value":" вул. Ізюмська"}]},{"city_id":0,"location":{"x":50.4173393249512,"y":30.5146617889404,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Байковое кладбище"},{"lang_id":"c_en","value":" Baykove kladovyshe"},{"lang_id":"c_uk","value":" Байкове кладовище"}]},{"city_id":0,"location":{"x":50.4183883666992,"y":30.5161800384521,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ямская"},{"lang_id":"c_en","value":" Yamska St"},{"lang_id":"c_uk","value":" вул. Ямська"}]},{"city_id":0,"location":{"x":50.4234237670898,"y":30.5189895629883,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Щорса"},{"lang_id":"c_en","value":" Shorsa St"},{"lang_id":"c_uk","value":" вул. Щорса"}]},{"city_id":0,"location":{"x":50.4254379272461,"y":30.5177345275879,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лабораторная"},{"lang_id":"c_en","value":" Laboratorna St"},{"lang_id":"c_uk","value":" вул. Лабораторна"}]},{"city_id":0,"location":{"x":50.4284324645996,"y":30.5161037445068,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Федорова"},{"lang_id":"c_en","value":" Fedorova St"},{"lang_id":"c_uk","value":" вул. Федорова"}]},{"city_id":0,"location":{"x":50.431583404541,"y":30.5160675048828,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Олимпийская"},{"lang_id":"c_en","value":" Olimpiyska"},{"lang_id":"c_uk","value":" ст. м. Олімпійська"}]},{"city_id":0,"location":{"x":50.4349060058594,"y":30.516040802002,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жилянская"},{"lang_id":"c_en","value":" Zhylyanska St"},{"lang_id":"c_uk","value":" вул. Жилянська"}]},{"city_id":0,"location":{"x":50.4359664916992,"y":30.5154438018799,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Красноармейская"},{"lang_id":"c_en","value":" Chervonoarmiyska St"},{"lang_id":"c_uk","value":" вул. Червоноармійська"}]},{"city_id":0,"location":{"x":50.4362716674805,"y":30.5077724456787,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ветеренарная аптека"},{"lang_id":"c_en","value":" Veterenarna apteka"},{"lang_id":"c_uk","value":" Ветеринарна аптека"}]},{"city_id":0,"location":{"x":50.4391288757324,"y":30.5024356842041,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Паньковская"},{"lang_id":"c_en","value":" Pankovska St"},{"lang_id":"c_uk","value":" вул. Паньковська"}]},{"city_id":0,"location":{"x":50.4415092468262,"y":30.4993343353271,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Льва Толстого"},{"lang_id":"c_en","value":" Lva Tolstoho St"},{"lang_id":"c_uk","value":" вул. Льва Толстого"}]},{"city_id":0,"location":{"x":50.44091033935547,"y":30.490140914916992,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/д вокзал Центральный"},{"lang_id":"c_en","value":" vokzal Tsentralnyi"},{"lang_id":"c_uk","value":" залізничний вокзал Центральний"}]}],"directRelations":[{"points":[{"x":50.4095458984375,"y":30.5193557739258},{"x":50.409515380859375,"y":30.51927375793457},{"x":50.40963363647461,"y":30.519145965576172},{"x":50.40971755981445,"y":30.519012451171875},{"x":50.409793853759766,"y":30.51863670349121},{"x":50.40969467163086,"y":30.518320083618164},{"x":50.409767150878906,"y":30.518239974975586},{"x":50.41117477416992,"y":30.5169677734375},{"x":50.412532806396484,"y":30.515745162963867},{"x":50.41294860839844,"y":30.5153751373291},{"x":50.413665771484375,"y":30.517118453979492},{"x":50.41379165649414,"y":30.517358779907227},{"x":50.414039611816406,"y":30.517986297607422},{"x":50.41440963745117,"y":30.51763916015625},{"x":50.4146728515625,"y":30.517370223999023},{"x":50.41586685180664,"y":30.516115188598633},{"x":50.41712951660156,"y":30.514789581298828},{"x":50.41731262207031,"y":30.514596939086914}]},{"points":[{"x":50.4173393249512,"y":30.5146617889404},{"x":50.41731262207031,"y":30.514596939086914},{"x":50.41767120361328,"y":30.514232635498047},{"x":50.4182014465332,"y":30.515573501586914},{"x":50.41843032836914,"y":30.516141891479492}]},{"points":[{"x":50.4183883666992,"y":30.5161800384521},{"x":50.41843032836914,"y":30.516141891479492},{"x":50.41843032836914,"y":30.516141891479492},{"x":50.418556213378906,"y":30.516437530517578},{"x":50.41876220703125,"y":30.516935348510742},{"x":50.41971206665039,"y":30.516324996948242},{"x":50.42075729370117,"y":30.515647888183594},{"x":50.42170715332031,"y":30.515058517456055},{"x":50.422264099121094,"y":30.516881942749023},{"x":50.42241668701172,"y":30.516984939575195},{"x":50.423099517822266,"y":30.519119262695312},{"x":50.42341613769531,"y":30.518930435180664}]},{"points":[{"x":50.4234237670898,"y":30.5189895629883},{"x":50.42341613769531,"y":30.518930435180664},{"x":50.42437744140625,"y":30.518325805664062},{"x":50.4251594543457,"y":30.517826080322266},{"x":50.425418853759766,"y":30.51766586303711}]},{"points":[{"x":50.4254379272461,"y":30.5177345275879},{"x":50.425418853759766,"y":30.51766586303711},{"x":50.42628479003906,"y":30.517127990722656},{"x":50.427066802978516,"y":30.51665687561035},{"x":50.42784881591797,"y":30.51617431640625},{"x":50.428043365478516,"y":30.516071319580078},{"x":50.42817306518555,"y":30.516035079956055},{"x":50.428436279296875,"y":30.516029357910156}]},{"points":[{"x":50.4284324645996,"y":30.5161037445068},{"x":50.428436279296875,"y":30.516029357910156},{"x":50.42933654785156,"y":30.516008377075195},{"x":50.42991638183594,"y":30.5159912109375},{"x":50.430755615234375,"y":30.5159912109375},{"x":50.43158721923828,"y":30.5159969329834}]},{"points":[{"x":50.431583404541,"y":30.5160675048828},{"x":50.43158721923828,"y":30.5159969329834},{"x":50.4319953918457,"y":30.5159969329834},{"x":50.43275833129883,"y":30.5159912109375},{"x":50.43394470214844,"y":30.515981674194336},{"x":50.43490982055664,"y":30.51596450805664}]},{"points":[{"x":50.4349060058594,"y":30.516040802002},{"x":50.43490982055664,"y":30.51596450805664},{"x":50.435672760009766,"y":30.515958786010742},{"x":50.43577575683594,"y":30.51597023010254},{"x":50.435916900634766,"y":30.51601791381836},{"x":50.4359130859375,"y":30.51563262939453},{"x":50.4359130859375,"y":30.515443801879883}]},{"points":[{"x":50.4359664916992,"y":30.5154438018799},{"x":50.4359130859375,"y":30.515443801879883},{"x":50.435916900634766,"y":30.513545989990234},{"x":50.43593215942383,"y":30.511634826660156},{"x":50.435943603515625,"y":30.509544372558594},{"x":50.43596649169922,"y":30.509307861328125},{"x":50.436214447021484,"y":30.507741928100586}]},{"points":[{"x":50.4362716674805,"y":30.5077724456787},{"x":50.436214447021484,"y":30.507741928100586},{"x":50.43642807006836,"y":30.506481170654297},{"x":50.43653106689453,"y":30.505916595458984},{"x":50.4366340637207,"y":30.50569725036621},{"x":50.43759536743164,"y":30.50439453125},{"x":50.43891906738281,"y":30.502613067626953},{"x":50.43909454345703,"y":30.502376556396484}]},{"points":[{"x":50.4391288757324,"y":30.5024356842041},{"x":50.43909454345703,"y":30.502376556396484},{"x":50.440372467041016,"y":30.500659942626953},{"x":50.441139221191406,"y":30.499635696411133},{"x":50.44148635864258,"y":30.499271392822266}]},{"points":[{"x":50.4415092468262,"y":30.4993343353271},{"x":50.44148635864258,"y":30.499271392822266},{"x":50.442386627197266,"y":30.498315811157227},{"x":50.443504333496094,"y":30.497135162353516},{"x":50.4437141418457,"y":30.496915817260742},{"x":50.443115234375,"y":30.495569229125977},{"x":50.44284439086914,"y":30.49494743347168},{"x":50.44245529174805,"y":30.494009017944336},{"x":50.441829681396484,"y":30.49253273010254},{"x":50.44151306152344,"y":30.491798400878906},{"x":50.44142150878906,"y":30.49094581604004},{"x":50.44136428833008,"y":30.490413665771484},{"x":50.44130325317383,"y":30.49014663696289},{"x":50.44123840332031,"y":30.489974975585938},{"x":50.44115447998047,"y":30.48993682861328},{"x":50.44105529785156,"y":30.48994255065918},{"x":50.44091033935547,"y":30.490140914916992}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4408950805664,"y":30.4901065826416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/д вокзал Центральный"},{"lang_id":"c_en","value":" vokzal Tsentralnyi"},{"lang_id":"c_uk","value":" залізничний вокзал Центральний"}]},{"city_id":0,"location":{"x":50.4423217773438,"y":30.495397567749,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жилянская"},{"lang_id":"c_en","value":" Zhylyanska St"},{"lang_id":"c_uk","value":" вул. Жилянська"}]},{"city_id":0,"location":{"x":50.4395904541016,"y":30.4983806610107,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Льва Толстого"},{"lang_id":"c_en","value":" Lva Tolstoho St"},{"lang_id":"c_uk","value":" вул. Льва Толстого"}]},{"city_id":0,"location":{"x":50.4374732971191,"y":30.5011425018311,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Паньковская"},{"lang_id":"c_en","value":" Pankovska St"},{"lang_id":"c_uk","value":" вул. Паньковська"}]},{"city_id":0,"location":{"x":50.435188293457,"y":30.5041313171387,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Центр занятости"},{"lang_id":"c_en","value":" Tsentr zanyatosti"},{"lang_id":"c_uk","value":" Центр занятості"}]},{"city_id":0,"location":{"x":50.4333305358887,"y":30.5134334564209,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Горького / ул. Жилянская"},{"lang_id":"c_en","value":" Horkoho St / Zhylyanska St"},{"lang_id":"c_uk","value":" вул. Горького / вул. Жилянська"}]},{"city_id":0,"location":{"x":50.4296073913574,"y":30.5133476257324,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Димитрова"},{"lang_id":"c_en","value":" Dymytrova St"},{"lang_id":"c_uk","value":" вул. Димитрова"}]},{"city_id":0,"location":{"x":50.4273300170898,"y":30.5137805938721,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ивана Федорова"},{"lang_id":"c_en","value":" Ivana Fedorova St"},{"lang_id":"c_uk","value":" вул. Івана Федорова"}]},{"city_id":0,"location":{"x":50.4241981506348,"y":30.5157318115234,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лабораторная"},{"lang_id":"c_en","value":" Laboratorna St"},{"lang_id":"c_uk","value":" вул. Лабораторна"}]},{"city_id":0,"location":{"x":50.418586730957,"y":30.5163993835449,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ямская"},{"lang_id":"c_en","value":" Yamska St"},{"lang_id":"c_uk","value":" вул. Ямська"}]},{"city_id":0,"location":{"x":50.41703796386719,"y":30.51460075378418,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Гринченко"},{"lang_id":"c_en","value":" Mykoly Hrinchenka St"},{"lang_id":"c_uk","value":" вул. Миколи Грінченка"}]},{"city_id":0,"location":{"x":50.409767150878906,"y":30.518239974975586,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Изюмская"},{"lang_id":"c_en","value":" Izumska St"},{"lang_id":"c_uk","value":" вул. Ізюмська"}]}],"reverseRelations":[{"points":[{"x":50.4408950805664,"y":30.4901065826416},{"x":50.44091033935547,"y":30.490140914916992},{"x":50.440773010253906,"y":30.490327835083008},{"x":50.44066619873047,"y":30.49048614501953},{"x":50.440643310546875,"y":30.490625381469727},{"x":50.440643310546875,"y":30.49077606201172},{"x":50.44086456298828,"y":30.49105453491211},{"x":50.441314697265625,"y":30.491580963134766},{"x":50.44151306152344,"y":30.491798400878906},{"x":50.441829681396484,"y":30.49253273010254},{"x":50.44245529174805,"y":30.494009017944336},{"x":50.44284439086914,"y":30.49494743347168},{"x":50.44264221191406,"y":30.495174407958984},{"x":50.442344665527344,"y":30.495464324951172}]},{"points":[{"x":50.4423217773438,"y":30.495397567749},{"x":50.442344665527344,"y":30.495464324951172},{"x":50.44142532348633,"y":30.49642562866211},{"x":50.44064712524414,"y":30.497224807739258},{"x":50.44028091430664,"y":30.49761390686035},{"x":50.440101623535156,"y":30.497844696044922},{"x":50.43962860107422,"y":30.498449325561523}]},{"points":[{"x":50.4395904541016,"y":30.4983806610107},{"x":50.43962860107422,"y":30.498449325561523},{"x":50.438758850097656,"y":30.499597549438477},{"x":50.437904357910156,"y":30.500713348388672},{"x":50.4375114440918,"y":30.501222610473633}]},{"points":[{"x":50.4374732971191,"y":30.5011425018311},{"x":50.4375114440918,"y":30.501222610473633},{"x":50.436431884765625,"y":30.502634048461914},{"x":50.435455322265625,"y":30.503883361816406},{"x":50.43522262573242,"y":30.50419044494629}]},{"points":[{"x":50.435188293457,"y":30.5041313171387},{"x":50.43522262573242,"y":30.50419044494629},{"x":50.43476486206055,"y":30.504791259765625},{"x":50.4347038269043,"y":30.504913330078125},{"x":50.43455123901367,"y":30.505741119384766},{"x":50.434120178222656,"y":30.50826644897461},{"x":50.434085845947266,"y":30.508508682250977},{"x":50.434051513671875,"y":30.50874900817871},{"x":50.434017181396484,"y":30.510574340820312},{"x":50.4339714050293,"y":30.513164520263672},{"x":50.4339714050293,"y":30.51352310180664},{"x":50.43333053588867,"y":30.51350212097168}]},{"points":[{"x":50.4333305358887,"y":30.5134334564209},{"x":50.43333053588867,"y":30.51350212097168},{"x":50.43272018432617,"y":30.513469696044922},{"x":50.432010650634766,"y":30.51347541809082},{"x":50.43097686767578,"y":30.513465881347656},{"x":50.429893493652344,"y":30.513437271118164},{"x":50.429595947265625,"y":30.5134334564209}]},{"points":[{"x":50.4296073913574,"y":30.5133476257324},{"x":50.429595947265625,"y":30.5134334564209},{"x":50.42891311645508,"y":30.513416290283203},{"x":50.42850112915039,"y":30.51344871520996},{"x":50.42799377441406,"y":30.513513565063477},{"x":50.4278564453125,"y":30.513551712036133},{"x":50.42734909057617,"y":30.513851165771484}]},{"points":[{"x":50.4273300170898,"y":30.5137805938721},{"x":50.42734909057617,"y":30.513851165771484},{"x":50.426544189453125,"y":30.514354705810547},{"x":50.425418853759766,"y":30.515079498291016},{"x":50.424564361572266,"y":30.515605926513672},{"x":50.424217224121094,"y":30.515830993652344}]},{"points":[{"x":50.4241981506348,"y":30.5157318115234},{"x":50.424217224121094,"y":30.515830993652344},{"x":50.423091888427734,"y":30.516550064086914},{"x":50.42241668701172,"y":30.516984939575195},{"x":50.422428131103516,"y":30.516775131225586},{"x":50.4221076965332,"y":30.515724182128906},{"x":50.421844482421875,"y":30.514955520629883},{"x":50.42170715332031,"y":30.515058517456055},{"x":50.42075729370117,"y":30.515647888183594},{"x":50.41971206665039,"y":30.516324996948242},{"x":50.41876220703125,"y":30.516935348510742},{"x":50.418556213378906,"y":30.516437530517578}]},{"points":[{"x":50.418586730957,"y":30.5163993835449},{"x":50.418556213378906,"y":30.516437530517578},{"x":50.41843032836914,"y":30.516141891479492},{"x":50.4182014465332,"y":30.515573501586914},{"x":50.41767120361328,"y":30.514232635498047},{"x":50.41731262207031,"y":30.514596939086914},{"x":50.41712951660156,"y":30.514789581298828}]},{"points":[{"x":50.41703796386719,"y":30.51460075378418},{"x":50.41712951660156,"y":30.514789581298828},{"x":50.41586685180664,"y":30.516115188598633},{"x":50.4146728515625,"y":30.517370223999023},{"x":50.41440963745117,"y":30.51763916015625},{"x":50.414276123046875,"y":30.51763343811035},{"x":50.41408920288086,"y":30.517580032348633},{"x":50.4139404296875,"y":30.51748275756836},{"x":50.41379165649414,"y":30.517358779907227},{"x":50.413665771484375,"y":30.517118453979492},{"x":50.41294860839844,"y":30.5153751373291},{"x":50.412532806396484,"y":30.515745162963867},{"x":50.41117477416992,"y":30.5169677734375},{"x":50.409767150878906,"y":30.518239974975586}]}]}
3	2	c_route_bus	1	{"cityID":2,"routeID":359,"routeType":"c_route_bus","number":"1","timeStart":21660,"timeFinish":82800,"intervalMin":1800,"intervalMax":1800,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.3785514831543,"y":30.471622467041016,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автостанция Южная"},{"lang_id":"c_en","value":" Autostantsia Pivdena"},{"lang_id":"c_uk","value":" Автостанція Південна"}]},{"city_id":0,"location":{"x":50.38149642944336,"y":30.478607177734375,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Выставочный центр"},{"lang_id":"c_en","value":" Vystavkovyi tsentr"},{"lang_id":"c_uk","value":" ст. м. Виставковий центр"}]},{"city_id":0,"location":{"x":50.3830528259277,"y":30.4824352264404,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" магазин-салон Приборы"},{"lang_id":"c_en","value":" Prylady"},{"lang_id":"c_uk","value":" магазин-салон Прилади"}]},{"city_id":0,"location":{"x":50.38433837890625,"y":30.485769271850586,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" отель Голосеевский"},{"lang_id":"c_en","value":" Golosiivs\\u0027kyi"},{"lang_id":"c_uk","value":" готель Голосіївський"}]},{"city_id":0,"location":{"x":50.3829460144043,"y":30.491090774536133,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Полковника Потехина"},{"lang_id":"c_en","value":" Polkovnyka Potekhina St"},{"lang_id":"c_uk","value":" вул. Полковника Потєхіна"}]},{"city_id":0,"location":{"x":50.3831901550293,"y":30.495616912841797,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 4"},{"lang_id":"c_en","value":" Korpus 4"},{"lang_id":"c_uk","value":" Корпус 4"}]},{"city_id":0,"location":{"x":50.383445739746094,"y":30.50069808959961,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 3"},{"lang_id":"c_en","value":" Korpus 3"},{"lang_id":"c_uk","value":" Корпус 3"}]},{"city_id":0,"location":{"x":50.38435363769531,"y":30.505107879638672,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 2"},{"lang_id":"c_en","value":" Korpus 2"},{"lang_id":"c_uk","value":" Корпус 2"}]},{"city_id":0,"location":{"x":50.38670349121094,"y":30.509313583374023,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Общежитие"},{"lang_id":"c_en","value":" Hurtozhytok"},{"lang_id":"c_uk","value":" Гуртожиток"}]},{"city_id":0,"location":{"x":50.38752746582031,"y":30.51797103881836,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Общежитие №8"},{"lang_id":"c_en","value":" Hurtozhyk 8"},{"lang_id":"c_uk","value":" Гуртожиток №8"}]},{"city_id":0,"location":{"x":50.390220642089844,"y":30.526844024658203,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Добрый Путь"},{"lang_id":"c_en","value":" Dobryi Shlyakh St"},{"lang_id":"c_uk","value":" вул. Добрий шлях"}]},{"city_id":0,"location":{"x":50.39284133911133,"y":30.522703170776367,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Конотопская"},{"lang_id":"c_en","value":" Konotopska St"},{"lang_id":"c_uk","value":" вул. Конотопська"}]},{"city_id":0,"location":{"x":50.39458084106445,"y":30.519886016845703,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Кошового"},{"lang_id":"c_en","value":" Koshovoho St"},{"lang_id":"c_uk","value":" вул. Кошового"}]},{"city_id":0,"location":{"x":50.39664077758789,"y":30.517370223999023,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ювелирная фабрика"},{"lang_id":"c_en","value":" Yuvelirna fabryka"},{"lang_id":"c_uk","value":" Ювелірна фабрика"}]},{"city_id":0,"location":{"x":50.397064208984375,"y":30.509742736816406,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Голосеевская"},{"lang_id":"c_en","value":" Holosiivska "},{"lang_id":"c_uk","value":" ст.м. Голосіївська"}]}],"directRelations":[{"points":[{"x":50.3785514831543,"y":30.471622467041016},{"x":50.37859344482422,"y":30.4715633392334},{"x":50.3791618347168,"y":30.472673416137695},{"x":50.379478454589844,"y":30.473371505737305},{"x":50.3797721862793,"y":30.4740047454834},{"x":50.3801383972168,"y":30.4749755859375},{"x":50.38087844848633,"y":30.476831436157227},{"x":50.38121795654297,"y":30.477731704711914},{"x":50.381526947021484,"y":30.478574752807617}]},{"points":[{"x":50.38149642944336,"y":30.478607177734375},{"x":50.381526947021484,"y":30.478574752807617},{"x":50.38187026977539,"y":30.4794979095459},{"x":50.38232421875,"y":30.48051643371582},{"x":50.38296890258789,"y":30.482131958007812},{"x":50.38308334350586,"y":30.482404708862305}]},{"points":[{"x":50.3830528259277,"y":30.4824352264404},{"x":50.38308334350586,"y":30.482404708862305},{"x":50.38363265991211,"y":30.48380470275879},{"x":50.384098052978516,"y":30.4849796295166},{"x":50.384376525878906,"y":30.485713958740234}]},{"points":[{"x":50.38433837890625,"y":30.485769271850586},{"x":50.384376525878906,"y":30.485713958740234},{"x":50.38447952270508,"y":30.4859561920166},{"x":50.383697509765625,"y":30.48673439025879},{"x":50.383567810058594,"y":30.486906051635742},{"x":50.38341522216797,"y":30.48737335205078},{"x":50.38300323486328,"y":30.489791870117188},{"x":50.38294982910156,"y":30.490156173706055},{"x":50.382965087890625,"y":30.490398406982422},{"x":50.38298416137695,"y":30.491085052490234}]},{"points":[{"x":50.3829460144043,"y":30.491090774536133},{"x":50.38298416137695,"y":30.491085052490234},{"x":50.38302993774414,"y":30.4919376373291},{"x":50.38319396972656,"y":30.494613647460938},{"x":50.38323974609375,"y":30.495607376098633}]},{"points":[{"x":50.3831901550293,"y":30.495616912841797},{"x":50.38323974609375,"y":30.495607376098633},{"x":50.383384704589844,"y":30.49822425842285},{"x":50.38343048095703,"y":30.499114990234375},{"x":50.38349151611328,"y":30.50069236755371}]},{"points":[{"x":50.383445739746094,"y":30.50069808959961},{"x":50.38349151611328,"y":30.50069236755371},{"x":50.383514404296875,"y":30.502565383911133},{"x":50.383541107177734,"y":30.504072189331055},{"x":50.383575439453125,"y":30.504253387451172},{"x":50.383644104003906,"y":30.504344940185547},{"x":50.38396453857422,"y":30.504549026489258},{"x":50.384185791015625,"y":30.504764556884766},{"x":50.38438034057617,"y":30.505043029785156}]},{"points":[{"x":50.38435363769531,"y":30.505107879638672},{"x":50.38438034057617,"y":30.505043029785156},{"x":50.385169982910156,"y":30.50588035583496},{"x":50.38600540161133,"y":30.50685691833496},{"x":50.38618469238281,"y":30.50714111328125},{"x":50.38642501831055,"y":30.507585525512695},{"x":50.386600494384766,"y":30.5080623626709},{"x":50.38671112060547,"y":30.50847053527832},{"x":50.38672637939453,"y":30.50898551940918},{"x":50.386749267578125,"y":30.50929069519043}]},{"points":[{"x":50.38670349121094,"y":30.509313583374023},{"x":50.386749267578125,"y":30.50929069519043},{"x":50.38679122924805,"y":30.509746551513672},{"x":50.386878967285156,"y":30.510225296020508},{"x":50.387115478515625,"y":30.51062774658203},{"x":50.387351989746094,"y":30.510976791381836},{"x":50.387691497802734,"y":30.511581420898438},{"x":50.387786865234375,"y":30.511920928955078},{"x":50.3878059387207,"y":30.512252807617188},{"x":50.38777160644531,"y":30.512510299682617},{"x":50.38764190673828,"y":30.512847900390625},{"x":50.387245178222656,"y":30.51329803466797},{"x":50.38685607910156,"y":30.513723373413086},{"x":50.386756896972656,"y":30.51394271850586},{"x":50.38669204711914,"y":30.51422691345215},{"x":50.386688232421875,"y":30.51447868347168},{"x":50.386775970458984,"y":30.514827728271484},{"x":50.38698959350586,"y":30.515331268310547},{"x":50.38713073730469,"y":30.515958786010742},{"x":50.38726043701172,"y":30.51652717590332},{"x":50.38748550415039,"y":30.51758575439453},{"x":50.387577056884766,"y":30.51791763305664}]},{"points":[{"x":50.38752746582031,"y":30.51797103881836},{"x":50.387577056884766,"y":30.51791763305664},{"x":50.387874603271484,"y":30.51871109008789},{"x":50.38814926147461,"y":30.519264221191406},{"x":50.38839340209961,"y":30.519805908203125},{"x":50.388553619384766,"y":30.520288467407227},{"x":50.38868713378906,"y":30.520851135253906},{"x":50.388771057128906,"y":30.521469116210938},{"x":50.38877487182617,"y":30.521812438964844},{"x":50.38867950439453,"y":30.522911071777344},{"x":50.388694763183594,"y":30.523366928100586},{"x":50.388771057128906,"y":30.52389907836914},{"x":50.388885498046875,"y":30.52436637878418},{"x":50.38941955566406,"y":30.525432586669922},{"x":50.38966751098633,"y":30.525985717773438},{"x":50.38979721069336,"y":30.526281356811523},{"x":50.389896392822266,"y":30.526704788208008},{"x":50.38997268676758,"y":30.527057647705078},{"x":50.390174865722656,"y":30.526796340942383}]},{"points":[{"x":50.390220642089844,"y":30.526844024658203},{"x":50.390174865722656,"y":30.526796340942383},{"x":50.39079666137695,"y":30.525787353515625},{"x":50.39189910888672,"y":30.524076461791992},{"x":50.39257049560547,"y":30.52299690246582},{"x":50.39279556274414,"y":30.522653579711914}]},{"points":[{"x":50.39284133911133,"y":30.522703170776367},{"x":50.39279556274414,"y":30.522653579711914},{"x":50.39330291748047,"y":30.521833419799805},{"x":50.39442443847656,"y":30.520042419433594},{"x":50.39453125,"y":30.519838333129883}]},{"points":[{"x":50.39458084106445,"y":30.519886016845703},{"x":50.39453125,"y":30.519838333129883},{"x":50.39496612548828,"y":30.5190486907959},{"x":50.39518356323242,"y":30.518775939941406},{"x":50.3956413269043,"y":30.518287658691406},{"x":50.396610260009766,"y":30.517284393310547}]},{"points":[{"x":50.39664077758789,"y":30.517370223999023},{"x":50.396610260009766,"y":30.517284393310547},{"x":50.39719009399414,"y":30.516586303710938},{"x":50.397396087646484,"y":30.51642608642578},{"x":50.3985710144043,"y":30.515674591064453},{"x":50.39881134033203,"y":30.515535354614258},{"x":50.39848327636719,"y":30.514114379882812},{"x":50.398006439208984,"y":30.512418746948242},{"x":50.39785385131836,"y":30.51198959350586},{"x":50.397491455078125,"y":30.51119041442871},{"x":50.397335052490234,"y":30.510879516601562},{"x":50.39720153808594,"y":30.510488510131836},{"x":50.397335052490234,"y":30.510053634643555},{"x":50.397369384765625,"y":30.50991439819336},{"x":50.397064208984375,"y":30.509742736816406}]}],"reverseStations":[{"city_id":0,"location":{"x":50.397396087646484,"y":30.508390426635742,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Голосеевская"},{"lang_id":"c_en","value":" Holosiivska "},{"lang_id":"c_uk","value":" ст.м. Голосіївська"}]},{"city_id":0,"location":{"x":50.39657974243164,"y":30.517187118530273,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ювелирная фабрика"},{"lang_id":"c_en","value":" Yuvelirna fabryka"},{"lang_id":"c_uk","value":" Ювелірна фабрика"}]},{"city_id":0,"location":{"x":50.394386291503906,"y":30.519989013671875,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Кошового"},{"lang_id":"c_en","value":" Koshovoho St"},{"lang_id":"c_uk","value":" вул. Кошового"}]},{"city_id":0,"location":{"x":50.39253234863281,"y":30.5229434967041,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Конотопская"},{"lang_id":"c_en","value":" Konotopska St"},{"lang_id":"c_uk","value":" вул. Конотопська"}]},{"city_id":0,"location":{"x":50.39015197753906,"y":30.526704788208008,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Добрый Путь"},{"lang_id":"c_en","value":" Dobryi Shlyakh St"},{"lang_id":"c_uk","value":" вул. Добрий шлях"}]},{"city_id":0,"location":{"x":50.38762283325195,"y":30.517885208129883,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Общежитие №8"},{"lang_id":"c_en","value":" Hurtozhyk 8"},{"lang_id":"c_uk","value":" Гуртожиток №8"}]},{"city_id":0,"location":{"x":50.386810302734375,"y":30.509275436401367,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Общежитие"},{"lang_id":"c_en","value":" Hurtozhytok"},{"lang_id":"c_uk","value":" Гуртожиток"}]},{"city_id":0,"location":{"x":50.38398361206055,"y":30.50448989868164,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 2"},{"lang_id":"c_en","value":" Korpus 2"},{"lang_id":"c_uk","value":" Корпус 2"}]},{"city_id":0,"location":{"x":50.383541107177734,"y":30.50069236755371,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 3"},{"lang_id":"c_en","value":" Korpus 3"},{"lang_id":"c_uk","value":" Корпус 3"}]},{"city_id":0,"location":{"x":50.38325119018555,"y":30.494604110717773,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корпус 10"},{"lang_id":"c_en","value":" Korpus 10"},{"lang_id":"c_uk","value":" Корпус 10"}]},{"city_id":0,"location":{"x":50.383052825927734,"y":30.48980712890625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Полковника Потехина"},{"lang_id":"c_en","value":" Polkovnyka Potekhina St"},{"lang_id":"c_uk","value":" вул. Полковника Потєхіна"}]},{"city_id":0,"location":{"x":50.3841438293457,"y":30.4849243164062,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" отель Голосеевский"},{"lang_id":"c_en","value":" Golosiivs\\u0027kyi"},{"lang_id":"c_uk","value":" готель Голосіївський"}]},{"city_id":0,"location":{"x":50.3830299377441,"y":30.4820747375488,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" магазин-салон Приборы"},{"lang_id":"c_en","value":" Prylady"},{"lang_id":"c_uk","value":" магазин-салон Прилади"}]},{"city_id":0,"location":{"x":50.380916595458984,"y":30.47629165649414,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Выставочный центр"},{"lang_id":"c_en","value":" Vystavkovyi tsentr"},{"lang_id":"c_uk","value":" ст. м. Виставковий центр"}]},{"city_id":0,"location":{"x":50.37832260131836,"y":30.47072410583496,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автостанция Южная"},{"lang_id":"c_en","value":" Autostantsia Pivdena"},{"lang_id":"c_uk","value":" Автостанція Південна"}]}],"reverseRelations":[{"points":[{"x":50.397396087646484,"y":30.508390426635742},{"x":50.397430419921875,"y":30.508352279663086},{"x":50.397708892822266,"y":30.50921058654785},{"x":50.397918701171875,"y":30.509790420532227},{"x":50.398193359375,"y":30.510257720947266},{"x":50.398040771484375,"y":30.51055145263672},{"x":50.397369384765625,"y":30.50991439819336},{"x":50.397335052490234,"y":30.510053634643555},{"x":50.39720153808594,"y":30.510488510131836},{"x":50.397335052490234,"y":30.510879516601562},{"x":50.397491455078125,"y":30.51119041442871},{"x":50.39785385131836,"y":30.51198959350586},{"x":50.398006439208984,"y":30.512418746948242},{"x":50.39848327636719,"y":30.514114379882812},{"x":50.39881134033203,"y":30.515535354614258},{"x":50.3985710144043,"y":30.515674591064453},{"x":50.397396087646484,"y":30.51642608642578},{"x":50.39719009399414,"y":30.516586303710938},{"x":50.396610260009766,"y":30.517284393310547}]},{"points":[{"x":50.39657974243164,"y":30.517187118530273},{"x":50.396610260009766,"y":30.517284393310547},{"x":50.3956413269043,"y":30.518287658691406},{"x":50.39518356323242,"y":30.518775939941406},{"x":50.39496612548828,"y":30.5190486907959},{"x":50.39453125,"y":30.519838333129883},{"x":50.39442443847656,"y":30.520042419433594}]},{"points":[{"x":50.394386291503906,"y":30.519989013671875},{"x":50.39442443847656,"y":30.520042419433594},{"x":50.39330291748047,"y":30.521833419799805},{"x":50.39279556274414,"y":30.522653579711914},{"x":50.39257049560547,"y":30.52299690246582}]},{"points":[{"x":50.39253234863281,"y":30.5229434967041},{"x":50.39257049560547,"y":30.52299690246582},{"x":50.39189910888672,"y":30.524076461791992},{"x":50.39079666137695,"y":30.525787353515625},{"x":50.390174865722656,"y":30.526796340942383}]},{"points":[{"x":50.39015197753906,"y":30.526704788208008},{"x":50.390174865722656,"y":30.526796340942383},{"x":50.38997268676758,"y":30.527057647705078},{"x":50.389896392822266,"y":30.526704788208008},{"x":50.38979721069336,"y":30.526281356811523},{"x":50.38966751098633,"y":30.525985717773438},{"x":50.38941955566406,"y":30.525432586669922},{"x":50.388885498046875,"y":30.52436637878418},{"x":50.388771057128906,"y":30.52389907836914},{"x":50.388694763183594,"y":30.523366928100586},{"x":50.38867950439453,"y":30.522911071777344},{"x":50.38877487182617,"y":30.521812438964844},{"x":50.388771057128906,"y":30.521469116210938},{"x":50.38868713378906,"y":30.520851135253906},{"x":50.388553619384766,"y":30.520288467407227},{"x":50.38839340209961,"y":30.519805908203125},{"x":50.38814926147461,"y":30.519264221191406},{"x":50.387874603271484,"y":30.51871109008789},{"x":50.387577056884766,"y":30.51791763305664}]},{"points":[{"x":50.38762283325195,"y":30.517885208129883},{"x":50.387577056884766,"y":30.51791763305664},{"x":50.38748550415039,"y":30.51758575439453},{"x":50.38726043701172,"y":30.51652717590332},{"x":50.38713073730469,"y":30.515958786010742},{"x":50.38698959350586,"y":30.515331268310547},{"x":50.386775970458984,"y":30.514827728271484},{"x":50.386688232421875,"y":30.51447868347168},{"x":50.38669204711914,"y":30.51422691345215},{"x":50.386756896972656,"y":30.51394271850586},{"x":50.38685607910156,"y":30.513723373413086},{"x":50.387245178222656,"y":30.51329803466797},{"x":50.38764190673828,"y":30.512847900390625},{"x":50.38777160644531,"y":30.512510299682617},{"x":50.3878059387207,"y":30.512252807617188},{"x":50.387786865234375,"y":30.511920928955078},{"x":50.387691497802734,"y":30.511581420898438},{"x":50.387351989746094,"y":30.510976791381836},{"x":50.387115478515625,"y":30.51062774658203},{"x":50.386878967285156,"y":30.510225296020508},{"x":50.38679122924805,"y":30.509746551513672},{"x":50.386749267578125,"y":30.50929069519043}]},{"points":[{"x":50.386810302734375,"y":30.509275436401367},{"x":50.386749267578125,"y":30.50929069519043},{"x":50.38672637939453,"y":30.50898551940918},{"x":50.38671112060547,"y":30.50847053527832},{"x":50.386600494384766,"y":30.5080623626709},{"x":50.38642501831055,"y":30.507585525512695},{"x":50.38618469238281,"y":30.50714111328125},{"x":50.38600540161133,"y":30.50685691833496},{"x":50.385169982910156,"y":30.50588035583496},{"x":50.38438034057617,"y":30.505043029785156},{"x":50.384185791015625,"y":30.504764556884766},{"x":50.38396453857422,"y":30.504549026489258}]},{"points":[{"x":50.38398361206055,"y":30.50448989868164},{"x":50.38396453857422,"y":30.504549026489258},{"x":50.383644104003906,"y":30.504344940185547},{"x":50.383575439453125,"y":30.504253387451172},{"x":50.383541107177734,"y":30.504072189331055},{"x":50.383514404296875,"y":30.502565383911133},{"x":50.38349151611328,"y":30.50069236755371}]},{"points":[{"x":50.383541107177734,"y":30.50069236755371},{"x":50.38349151611328,"y":30.50069236755371},{"x":50.38343048095703,"y":30.499114990234375},{"x":50.383384704589844,"y":30.49822425842285},{"x":50.38323974609375,"y":30.495607376098633},{"x":50.38319396972656,"y":30.494613647460938}]},{"points":[{"x":50.38325119018555,"y":30.494604110717773},{"x":50.38319396972656,"y":30.494613647460938},{"x":50.38302993774414,"y":30.4919376373291},{"x":50.38298416137695,"y":30.491085052490234},{"x":50.382965087890625,"y":30.490398406982422},{"x":50.38294982910156,"y":30.490156173706055},{"x":50.38300323486328,"y":30.489791870117188}]},{"points":[{"x":50.383052825927734,"y":30.48980712890625},{"x":50.38300323486328,"y":30.489791870117188},{"x":50.38341522216797,"y":30.48737335205078},{"x":50.383567810058594,"y":30.486906051635742},{"x":50.383697509765625,"y":30.48673439025879},{"x":50.38447952270508,"y":30.4859561920166},{"x":50.384376525878906,"y":30.485713958740234},{"x":50.384098052978516,"y":30.4849796295166}]},{"points":[{"x":50.3841438293457,"y":30.4849243164062},{"x":50.384098052978516,"y":30.4849796295166},{"x":50.38363265991211,"y":30.48380470275879},{"x":50.38308334350586,"y":30.482404708862305},{"x":50.38296890258789,"y":30.482131958007812}]},{"points":[{"x":50.3830299377441,"y":30.4820747375488},{"x":50.38296890258789,"y":30.482131958007812},{"x":50.38232421875,"y":30.48051643371582},{"x":50.38212966918945,"y":30.47995948791504},{"x":50.381710052490234,"y":30.47878074645996},{"x":50.3812255859375,"y":30.477413177490234},{"x":50.381072998046875,"y":30.476865768432617},{"x":50.3808708190918,"y":30.476329803466797}]},{"points":[{"x":50.380916595458984,"y":30.47629165649414},{"x":50.3808708190918,"y":30.476329803466797},{"x":50.380130767822266,"y":30.47449493408203},{"x":50.37986755371094,"y":30.473846435546875},{"x":50.37924575805664,"y":30.47252655029297},{"x":50.378692626953125,"y":30.471393585205078},{"x":50.37832260131836,"y":30.47072410583496}]}]}
2	2	c_route_bus	2	{"cityID":2,"routeID":222,"routeType":"c_route_bus","number":"2","timeStart":21660,"timeFinish":82800,"intervalMin":4560,"intervalMax":4560,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4124488830566,"y":30.4093894958496,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4126052856445,"y":30.4177417755127,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Борщаговский Химзавод"},{"lang_id":"c_en","value":" Borshahivskyi Khimzavod"},{"lang_id":"c_uk","value":" Борщагівський Хімзавод"}]},{"city_id":0,"location":{"x":50.4141960144043,"y":30.4235725402832,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Киев-Волынская"},{"lang_id":"c_en","value":" Kyiv-Volynska"},{"lang_id":"c_uk","value":" Київ-Волинська"}]},{"city_id":0,"location":{"x":50.412769317627,"y":30.4291305541992,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Пост-Волынский"},{"lang_id":"c_en","value":" Post-Volynskyi"},{"lang_id":"c_uk","value":" Пост-Волинський"}]},{"city_id":0,"location":{"x":50.4187316894531,"y":30.4335136413574,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ново-Полевая"},{"lang_id":"c_en","value":" Novo-Polova St"},{"lang_id":"c_uk","value":" вул. Ново-Польова"}]},{"city_id":0,"location":{"x":50.421932220459,"y":30.4339809417725,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Суздальская"},{"lang_id":"c_en","value":" Suzdalska St"},{"lang_id":"c_uk","value":" вул. Суздальська"}]},{"city_id":0,"location":{"x":50.4241790771484,"y":30.427339553833,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульвар Ивана Лепсе"},{"lang_id":"c_en","value":" Ivana Lepse Blvd"},{"lang_id":"c_uk","value":" бульвар Івана Лепсе"}]},{"city_id":0,"location":{"x":50.4289016723633,"y":30.4295234680176,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Отрадный"},{"lang_id":"c_en","value":" Otradnyi Ave"},{"lang_id":"c_uk","value":" пр. Отрадний"}]},{"city_id":0,"location":{"x":50.4304008483887,"y":30.4245548248291,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Тампере"},{"lang_id":"c_en","value":" kinoteatr Tempere"},{"lang_id":"c_uk","value":" кінотеатр Темпере"}]},{"city_id":0,"location":{"x":50.4333686828613,"y":30.4128341674805,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Медгородок"},{"lang_id":"c_en","value":" Medmistechko"},{"lang_id":"c_uk","value":" Медмістечко"}]},{"city_id":0,"location":{"x":50.4376068115234,"y":30.410285949707,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Лепсе"},{"lang_id":"c_en","value":" Lepse Blvd"},{"lang_id":"c_uk","value":" бул. Лепсе"}]},{"city_id":0,"location":{"x":50.4381370544434,"y":30.4107837677002,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Академика Каблукова"},{"lang_id":"c_en","value":" Akademika Kablukova St"},{"lang_id":"c_uk","value":" вул. Академіка Каблукова"}]},{"city_id":0,"location":{"x":50.4413719177246,"y":30.416690826416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Библиотека"},{"lang_id":"c_en","value":" Biblioteka"},{"lang_id":"c_uk","value":" Бібліотека"}]},{"city_id":0,"location":{"x":50.4468307495117,"y":30.4212245941162,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Завод реле и автоматики"},{"lang_id":"c_en","value":" Zavod"},{"lang_id":"c_uk","value":" Завод реле та автоматики"}]},{"city_id":0,"location":{"x":50.4468040466309,"y":30.4264869689941,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ПО Росток"},{"lang_id":"c_en","value":" Rostok"},{"lang_id":"c_uk","value":" ПО Росток"}]},{"city_id":0,"location":{"x":50.4468574523926,"y":30.432788848877,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом культуры"},{"lang_id":"c_en","value":" Dim kultury"},{"lang_id":"c_uk","value":" Дім культури"}]},{"city_id":0,"location":{"x":50.4511566162109,"y":30.4343891143799,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Большевик"},{"lang_id":"c_en","value":" Bilshovyk"},{"lang_id":"c_uk","value":" завод Більшовик"}]},{"city_id":0,"location":{"x":50.4558181762695,"y":30.4371185302734,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Гарматная"},{"lang_id":"c_en","value":" Harmatna St"},{"lang_id":"c_uk","value":" вул. Гарматна"}]},{"city_id":0,"location":{"x":50.45457458496094,"y":30.445085525512695,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Шулявская"},{"lang_id":"c_en","value":" Shulyavska "},{"lang_id":"c_uk","value":" ст. м. Шулявська"}]}],"directRelations":[{"points":[{"x":50.4124488830566,"y":30.4093894958496},{"x":50.41249084472656,"y":30.409448623657227},{"x":50.41230773925781,"y":30.409711837768555},{"x":50.412235260009766,"y":30.409889221191406},{"x":50.41224670410156,"y":30.410001754760742},{"x":50.41230392456055,"y":30.41008186340332},{"x":50.411685943603516,"y":30.411026000976562},{"x":50.41089630126953,"y":30.412254333496094},{"x":50.41040802001953,"y":30.413070678710938},{"x":50.40992736816406,"y":30.413864135742188},{"x":50.40970230102539,"y":30.414228439331055},{"x":50.40955352783203,"y":30.414518356323242},{"x":50.409847259521484,"y":30.41483497619629},{"x":50.41029357910156,"y":30.415279388427734},{"x":50.41059494018555,"y":30.415634155273438},{"x":50.41085433959961,"y":30.415992736816406},{"x":50.41094207763672,"y":30.416095733642578},{"x":50.411048889160156,"y":30.41611099243164},{"x":50.411468505859375,"y":30.416057586669922},{"x":50.41168212890625,"y":30.41611671447754},{"x":50.412017822265625,"y":30.41660499572754},{"x":50.4123649597168,"y":30.417264938354492},{"x":50.41263961791992,"y":30.417673110961914}]},{"points":[{"x":50.4126052856445,"y":30.4177417755127},{"x":50.41263961791992,"y":30.417673110961914},{"x":50.41299057006836,"y":30.418182373046875},{"x":50.41314697265625,"y":30.418481826782227},{"x":50.41330337524414,"y":30.418954849243164},{"x":50.4138298034668,"y":30.42070960998535},{"x":50.41417694091797,"y":30.42181968688965},{"x":50.414520263671875,"y":30.42273712158203},{"x":50.41440200805664,"y":30.422983169555664},{"x":50.414241790771484,"y":30.423601150512695}]},{"points":[{"x":50.4141960144043,"y":30.4235725402832},{"x":50.414241790771484,"y":30.423601150512695},{"x":50.413841247558594,"y":30.425146102905273},{"x":50.41336441040039,"y":30.42694854736328},{"x":50.412925720214844,"y":30.428606033325195},{"x":50.41282653808594,"y":30.42877769470215},{"x":50.41281509399414,"y":30.42905044555664}]},{"points":[{"x":50.412769317627,"y":30.4291305541992},{"x":50.41281509399414,"y":30.42905044555664},{"x":50.41292953491211,"y":30.429183959960938},{"x":50.413108825683594,"y":30.429210662841797},{"x":50.413150787353516,"y":30.429351806640625},{"x":50.4134521484375,"y":30.4295597076416},{"x":50.41459655761719,"y":30.430370330810547},{"x":50.415855407714844,"y":30.43126106262207},{"x":50.41695785522461,"y":30.432048797607422},{"x":50.41799545288086,"y":30.432788848876953},{"x":50.41861343383789,"y":30.433229446411133},{"x":50.41868209838867,"y":30.43328285217285},{"x":50.41877365112305,"y":30.433460235595703}]},{"points":[{"x":50.4187316894531,"y":30.4335136413574},{"x":50.41877365112305,"y":30.433460235595703},{"x":50.4195442199707,"y":30.434865951538086},{"x":50.420162200927734,"y":30.435274124145508},{"x":50.421363830566406,"y":30.435997009277344},{"x":50.42177200317383,"y":30.43436622619629},{"x":50.42188262939453,"y":30.433958053588867}]},{"points":[{"x":50.421932220459,"y":30.4339809417725},{"x":50.42188262939453,"y":30.433958053588867},{"x":50.42230987548828,"y":30.432371139526367},{"x":50.422760009765625,"y":30.430692672729492},{"x":50.42301940917969,"y":30.429752349853516},{"x":50.42323303222656,"y":30.42886734008789},{"x":50.42348861694336,"y":30.427978515625},{"x":50.42375564575195,"y":30.426979064941406},{"x":50.42420196533203,"y":30.42725372314453}]},{"points":[{"x":50.4241790771484,"y":30.427339553833},{"x":50.42420196533203,"y":30.42725372314453},{"x":50.42561340332031,"y":30.428176879882812},{"x":50.42662048339844,"y":30.42882537841797},{"x":50.42783737182617,"y":30.429624557495117},{"x":50.42816925048828,"y":30.429834365844727},{"x":50.42868423461914,"y":30.430171966552734},{"x":50.42885971069336,"y":30.429485321044922}]},{"points":[{"x":50.4289016723633,"y":30.4295234680176},{"x":50.42885971069336,"y":30.429485321044922},{"x":50.42943572998047,"y":30.42728614807129},{"x":50.42967224121094,"y":30.42638397216797},{"x":50.429840087890625,"y":30.42578887939453},{"x":50.42993927001953,"y":30.425457000732422},{"x":50.43008804321289,"y":30.425060272216797},{"x":50.4301643371582,"y":30.424915313720703},{"x":50.43036651611328,"y":30.424495697021484}]},{"points":[{"x":50.4304008483887,"y":30.4245548248291},{"x":50.43036651611328,"y":30.424495697021484},{"x":50.43049621582031,"y":30.42424964904785},{"x":50.43070602416992,"y":30.42391586303711},{"x":50.43104934692383,"y":30.423450469970703},{"x":50.431358337402344,"y":30.4231014251709},{"x":50.431732177734375,"y":30.422779083251953},{"x":50.43207550048828,"y":30.42251205444336},{"x":50.431793212890625,"y":30.42134666442871},{"x":50.43142318725586,"y":30.419795989990234},{"x":50.43102264404297,"y":30.418134689331055},{"x":50.43054962158203,"y":30.416154861450195},{"x":50.430206298828125,"y":30.414701461791992},{"x":50.43061447143555,"y":30.414443969726562},{"x":50.431175231933594,"y":30.41411018371582},{"x":50.43201446533203,"y":30.41360092163086},{"x":50.432926177978516,"y":30.413005828857422},{"x":50.433353424072266,"y":30.41275405883789}]},{"points":[{"x":50.4333686828613,"y":30.4128341674805},{"x":50.433353424072266,"y":30.41275405883789},{"x":50.43358612060547,"y":30.4126033782959},{"x":50.433815002441406,"y":30.41254425048828},{"x":50.43406677246094,"y":30.412437438964844},{"x":50.43430709838867,"y":30.412281036376953},{"x":50.434539794921875,"y":30.41208839416504},{"x":50.43476486206055,"y":30.411911010742188},{"x":50.435420989990234,"y":30.411502838134766},{"x":50.4359016418457,"y":30.411203384399414},{"x":50.43614196777344,"y":30.411041259765625},{"x":50.4370231628418,"y":30.410499572753906},{"x":50.43739700317383,"y":30.41026496887207},{"x":50.437583923339844,"y":30.410184860229492}]},{"points":[{"x":50.4376068115234,"y":30.410285949707},{"x":50.437583923339844,"y":30.410184860229492},{"x":50.43781661987305,"y":30.4100399017334},{"x":50.43797302246094,"y":30.409883499145508},{"x":50.43818283081055,"y":30.410757064819336}]},{"points":[{"x":50.4381370544434,"y":30.4107837677002},{"x":50.43818283081055,"y":30.410757064819336},{"x":50.43862533569336,"y":30.412490844726562},{"x":50.43889617919922,"y":30.4135799407959},{"x":50.43933868408203,"y":30.415311813354492},{"x":50.439903259277344,"y":30.417537689208984},{"x":50.44068145751953,"y":30.417049407958984},{"x":50.441349029541016,"y":30.4166202545166}]},{"points":[{"x":50.4413719177246,"y":30.416690826416},{"x":50.441349029541016,"y":30.4166202545166},{"x":50.44190979003906,"y":30.41627311706543},{"x":50.44267272949219,"y":30.41581153869629},{"x":50.44394302368164,"y":30.41506576538086},{"x":50.44491195678711,"y":30.414485931396484},{"x":50.445106506347656,"y":30.414379119873047},{"x":50.4454345703125,"y":30.4156494140625},{"x":50.44612503051758,"y":30.41829490661621},{"x":50.44670104980469,"y":30.420515060424805},{"x":50.44687271118164,"y":30.421201705932617}]},{"points":[{"x":50.4468307495117,"y":30.4212245941162},{"x":50.44687271118164,"y":30.421201705932617},{"x":50.44697189331055,"y":30.421728134155273},{"x":50.44705581665039,"y":30.422264099121094},{"x":50.44709777832031,"y":30.422657012939453},{"x":50.44713592529297,"y":30.42330551147461},{"x":50.44713592529297,"y":30.42399787902832},{"x":50.44712829589844,"y":30.42450714111328},{"x":50.447059631347656,"y":30.4250545501709},{"x":50.44698715209961,"y":30.42559051513672},{"x":50.446842193603516,"y":30.4265079498291}]},{"points":[{"x":50.4468040466309,"y":30.4264869689941},{"x":50.446842193603516,"y":30.4265079498291},{"x":50.44660186767578,"y":30.428009033203125},{"x":50.446231842041016,"y":30.430370330810547},{"x":50.4459228515625,"y":30.43235969543457},{"x":50.44609069824219,"y":30.432435989379883},{"x":50.44654846191406,"y":30.43259620666504},{"x":50.446868896484375,"y":30.432703018188477}]},{"points":[{"x":50.4468574523926,"y":30.432788848877},{"x":50.446868896484375,"y":30.432703018188477},{"x":50.44801712036133,"y":30.433116912841797},{"x":50.44880294799805,"y":30.433401107788086},{"x":50.450016021728516,"y":30.433835983276367},{"x":50.45053482055664,"y":30.434043884277344},{"x":50.451171875,"y":30.434297561645508}]},{"points":[{"x":50.4511566162109,"y":30.4343891143799},{"x":50.451171875,"y":30.434297561645508},{"x":50.45230484008789,"y":30.43475341796875},{"x":50.45342254638672,"y":30.435209274291992},{"x":50.455047607421875,"y":30.43585205078125},{"x":50.45600509643555,"y":30.436233520507812},{"x":50.45585632324219,"y":30.4371337890625}]},{"points":[{"x":50.4558181762695,"y":30.4371185302734},{"x":50.45585632324219,"y":30.4371337890625},{"x":50.455543518066406,"y":30.4390811920166},{"x":50.45523452758789,"y":30.441007614135742},{"x":50.45490646362305,"y":30.443052291870117},{"x":50.45457458496094,"y":30.445085525512695}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4497222900391,"y":30.4359111785889,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Общежитие"},{"lang_id":"c_en","value":" Hurtozhytok"},{"lang_id":"c_uk","value":" Гуртожиток"}]},{"city_id":0,"location":{"x":50.4465675354004,"y":30.4325218200684,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом культуры"},{"lang_id":"c_en","value":" Dim kultury"},{"lang_id":"c_uk","value":" Дім культури"}]},{"city_id":0,"location":{"x":50.447193145752,"y":30.4256706237793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ПО Росток"},{"lang_id":"c_en","value":" Rostok"},{"lang_id":"c_uk","value":" ПО Росток"}]},{"city_id":0,"location":{"x":50.4470558166504,"y":30.4208965301514,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Завод реле и автоматики"},{"lang_id":"c_en","value":" Zavod"},{"lang_id":"c_uk","value":" Завод реле та автоматики"}]},{"city_id":0,"location":{"x":50.4451560974121,"y":30.4136714935303,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Героев Севастополя"},{"lang_id":"c_en","value":" Heroiv Sevastopolya St"},{"lang_id":"c_uk","value":" вул. Героїв Севастополя"}]},{"city_id":0,"location":{"x":50.444450378418,"y":30.410816192627,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 6-й КАРЗ"},{"lang_id":"c_en","value":" Karz"},{"lang_id":"c_uk","value":" 6-й КАРЗ"}]},{"city_id":0,"location":{"x":50.4394302368164,"y":30.4085521697998,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Василия Чумака"},{"lang_id":"c_en","value":" Vasylya Chumaka St"},{"lang_id":"c_uk","value":" вул. Василя Чумака"}]},{"city_id":0,"location":{"x":50.4362335205078,"y":30.4126453399658,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Поликлиника"},{"lang_id":"c_en","value":" Poliklinika"},{"lang_id":"c_uk","value":" Поліклініка"}]},{"city_id":0,"location":{"x":50.4375076293945,"y":30.418981552124,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Комарова"},{"lang_id":"c_en","value":" Komarova Ave"},{"lang_id":"c_uk","value":" пр. Комарова"}]},{"city_id":0,"location":{"x":50.4317054748535,"y":30.4227142333984,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Академика Биленького"},{"lang_id":"c_en","value":" Akademika Bilenkoho St"},{"lang_id":"c_uk","value":" вул. Академіка Біленького"}]},{"city_id":0,"location":{"x":50.4301223754883,"y":30.4248657226562,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Тампере"},{"lang_id":"c_en","value":" kinoteatr Tempere"},{"lang_id":"c_uk","value":" кінотеатр Темпере"}]},{"city_id":0,"location":{"x":50.4281806945801,"y":30.4297580718994,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Героев Севастополя"},{"lang_id":"c_en","value":" Heroiv Sevastopolya St"},{"lang_id":"c_uk","value":" вул. Героїв Севастополя"}]},{"city_id":0,"location":{"x":50.4217262268066,"y":30.4343566894531,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Суздальская"},{"lang_id":"c_en","value":" Suzdalska St"},{"lang_id":"c_uk","value":" вул. Суздальська"}]},{"city_id":0,"location":{"x":50.4186210632324,"y":30.4331493377686,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ново-Полевая"},{"lang_id":"c_en","value":" Novo-Polova St"},{"lang_id":"c_uk","value":" вул. Ново-Польова"}]},{"city_id":0,"location":{"x":50.4126739501953,"y":30.4176082611084,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Борщаговский Химзавод"},{"lang_id":"c_en","value":" Borshahivskyi Khimzavod"},{"lang_id":"c_uk","value":" Борщагівський Хімзавод"}]},{"city_id":0,"location":{"x":50.412681579589844,"y":30.409488677978516,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]}],"reverseRelations":[{"points":[{"x":50.4497222900391,"y":30.4359111785889},{"x":50.449668884277344,"y":30.435901641845703},{"x":50.450016021728516,"y":30.433835983276367},{"x":50.44880294799805,"y":30.433401107788086},{"x":50.44801712036133,"y":30.433116912841797},{"x":50.446868896484375,"y":30.432703018188477},{"x":50.44654846191406,"y":30.43259620666504}]},{"points":[{"x":50.4465675354004,"y":30.4325218200684},{"x":50.44654846191406,"y":30.43259620666504},{"x":50.44609069824219,"y":30.432435989379883},{"x":50.446250915527344,"y":30.43136215209961},{"x":50.44658279418945,"y":30.429248809814453},{"x":50.44691467285156,"y":30.427087783813477},{"x":50.447147369384766,"y":30.42563247680664}]},{"points":[{"x":50.447193145752,"y":30.4256706237793},{"x":50.447147369384766,"y":30.42563247680664},{"x":50.447227478027344,"y":30.42506980895996},{"x":50.4472770690918,"y":30.42458152770996},{"x":50.44729995727539,"y":30.424190521240234},{"x":50.44729995727539,"y":30.423486709594727},{"x":50.44728088378906,"y":30.422929763793945},{"x":50.44723892211914,"y":30.422388076782227},{"x":50.447181701660156,"y":30.42188835144043},{"x":50.44709396362305,"y":30.42135238647461},{"x":50.44700622558594,"y":30.420928955078125}]},{"points":[{"x":50.4470558166504,"y":30.4208965301514},{"x":50.44700622558594,"y":30.420928955078125},{"x":50.44687271118164,"y":30.42040252685547},{"x":50.44673156738281,"y":30.419872283935547},{"x":50.44644546508789,"y":30.41880989074707},{"x":50.44609451293945,"y":30.417484283447266},{"x":50.44563674926758,"y":30.415752410888672},{"x":50.44525146484375,"y":30.414281845092773},{"x":50.44511032104492,"y":30.413692474365234}]},{"points":[{"x":50.4451560974121,"y":30.4136714935303},{"x":50.44511032104492,"y":30.413692474365234},{"x":50.444725036621094,"y":30.412179946899414},{"x":50.444393157958984,"y":30.410860061645508}]},{"points":[{"x":50.444450378418,"y":30.410816192627},{"x":50.444393157958984,"y":30.410860061645508},{"x":50.444217681884766,"y":30.410232543945312},{"x":50.444095611572266,"y":30.409835815429688},{"x":50.44379806518555,"y":30.409244537353516},{"x":50.44352340698242,"y":30.40882110595703},{"x":50.44310760498047,"y":30.408370971679688},{"x":50.442935943603516,"y":30.4082088470459},{"x":50.442626953125,"y":30.40803337097168},{"x":50.44229507446289,"y":30.40785026550293},{"x":50.44209671020508,"y":30.407791137695312},{"x":50.44179153442383,"y":30.407752990722656},{"x":50.44147872924805,"y":30.407726287841797},{"x":50.44114685058594,"y":30.40777587890625},{"x":50.44083023071289,"y":30.40784454345703},{"x":50.4405632019043,"y":30.407957077026367},{"x":50.439842224121094,"y":30.40838623046875},{"x":50.4394416809082,"y":30.408628463745117}]},{"points":[{"x":50.4394302368164,"y":30.4085521697998},{"x":50.4394416809082,"y":30.408628463745117},{"x":50.43852996826172,"y":30.409196853637695},{"x":50.43790054321289,"y":30.40957260131836},{"x":50.437469482421875,"y":30.409812927246094},{"x":50.436859130859375,"y":30.410226821899414},{"x":50.435813903808594,"y":30.410892486572266},{"x":50.43521499633789,"y":30.411256790161133},{"x":50.43446731567383,"y":30.411724090576172},{"x":50.434261322021484,"y":30.411792755126953},{"x":50.43394470214844,"y":30.411964416503906},{"x":50.43385314941406,"y":30.412067413330078},{"x":50.43384552001953,"y":30.412216186523438},{"x":50.43386459350586,"y":30.41236114501953},{"x":50.433963775634766,"y":30.412437438964844},{"x":50.43406677246094,"y":30.412437438964844},{"x":50.43430709838867,"y":30.412281036376953},{"x":50.434505462646484,"y":30.412189483642578},{"x":50.4346809387207,"y":30.412120819091797},{"x":50.434940338134766,"y":30.411949157714844},{"x":50.43534469604492,"y":30.411691665649414},{"x":50.435585021972656,"y":30.41157341003418},{"x":50.43573760986328,"y":30.41155242919922},{"x":50.435874938964844,"y":30.4116268157959},{"x":50.436100006103516,"y":30.411958694458008},{"x":50.436275482177734,"y":30.412614822387695}]},{"points":[{"x":50.4362335205078,"y":30.4126453399658},{"x":50.436275482177734,"y":30.412614822387695},{"x":50.43668746948242,"y":30.414154052734375},{"x":50.43688201904297,"y":30.41490936279297},{"x":50.43732833862305,"y":30.416664123535156},{"x":50.43771743774414,"y":30.418214797973633},{"x":50.437870025634766,"y":30.41886329650879},{"x":50.43752670288086,"y":30.419078826904297}]},{"points":[{"x":50.4375076293945,"y":30.418981552124},{"x":50.43752670288086,"y":30.419078826904297},{"x":50.43672180175781,"y":30.41958236694336},{"x":50.435882568359375,"y":30.420108795166016},{"x":50.434974670410156,"y":30.420677185058594},{"x":50.43399429321289,"y":30.42130470275879},{"x":50.43274688720703,"y":30.422086715698242},{"x":50.43207550048828,"y":30.42251205444336},{"x":50.431732177734375,"y":30.422779083251953}]},{"points":[{"x":50.4317054748535,"y":30.4227142333984},{"x":50.431732177734375,"y":30.422779083251953},{"x":50.431358337402344,"y":30.4231014251709},{"x":50.43104934692383,"y":30.423450469970703},{"x":50.43070602416992,"y":30.42391586303711},{"x":50.43049621582031,"y":30.42424964904785},{"x":50.43036651611328,"y":30.424495697021484},{"x":50.4301643371582,"y":30.424915313720703}]},{"points":[{"x":50.4301223754883,"y":30.4248657226562},{"x":50.4301643371582,"y":30.424915313720703},{"x":50.43008804321289,"y":30.425060272216797},{"x":50.42993927001953,"y":30.425457000732422},{"x":50.429840087890625,"y":30.42578887939453},{"x":50.42967224121094,"y":30.42638397216797},{"x":50.42943572998047,"y":30.42728614807129},{"x":50.42885971069336,"y":30.429485321044922},{"x":50.42868423461914,"y":30.430171966552734},{"x":50.42816925048828,"y":30.429834365844727}]},{"points":[{"x":50.4281806945801,"y":30.4297580718994},{"x":50.42816925048828,"y":30.429834365844727},{"x":50.42783737182617,"y":30.429624557495117},{"x":50.42662048339844,"y":30.42882537841797},{"x":50.42561340332031,"y":30.428176879882812},{"x":50.42420196533203,"y":30.42725372314453},{"x":50.42375564575195,"y":30.426979064941406},{"x":50.42348861694336,"y":30.427978515625},{"x":50.42323303222656,"y":30.42886734008789},{"x":50.42301940917969,"y":30.429752349853516},{"x":50.422760009765625,"y":30.430692672729492},{"x":50.42230987548828,"y":30.432371139526367},{"x":50.42188262939453,"y":30.433958053588867},{"x":50.42177200317383,"y":30.43436622619629}]},{"points":[{"x":50.4217262268066,"y":30.4343566894531},{"x":50.42177200317383,"y":30.43436622619629},{"x":50.421363830566406,"y":30.435997009277344},{"x":50.420162200927734,"y":30.435274124145508},{"x":50.4195442199707,"y":30.434865951538086},{"x":50.41877365112305,"y":30.433460235595703},{"x":50.41868209838867,"y":30.43328285217285},{"x":50.41861343383789,"y":30.433229446411133}]},{"points":[{"x":50.4186210632324,"y":30.4331493377686},{"x":50.41861343383789,"y":30.433229446411133},{"x":50.41799545288086,"y":30.432788848876953},{"x":50.41695785522461,"y":30.432048797607422},{"x":50.415855407714844,"y":30.43126106262207},{"x":50.41459655761719,"y":30.430370330810547},{"x":50.4134521484375,"y":30.4295597076416},{"x":50.413150787353516,"y":30.429351806640625},{"x":50.413108825683594,"y":30.429210662841797},{"x":50.412925720214844,"y":30.428606033325195},{"x":50.41336441040039,"y":30.42694854736328},{"x":50.413841247558594,"y":30.425146102905273},{"x":50.414241790771484,"y":30.423601150512695},{"x":50.41440200805664,"y":30.422983169555664},{"x":50.414520263671875,"y":30.42273712158203},{"x":50.41417694091797,"y":30.42181968688965},{"x":50.4138298034668,"y":30.42070960998535},{"x":50.41330337524414,"y":30.418954849243164},{"x":50.41314697265625,"y":30.418481826782227},{"x":50.41299057006836,"y":30.418182373046875},{"x":50.41263961791992,"y":30.417673110961914}]},{"points":[{"x":50.4126739501953,"y":30.4176082611084},{"x":50.41263961791992,"y":30.417673110961914},{"x":50.4123649597168,"y":30.417264938354492},{"x":50.412017822265625,"y":30.41660499572754},{"x":50.41168212890625,"y":30.41611671447754},{"x":50.411468505859375,"y":30.416057586669922},{"x":50.411048889160156,"y":30.41611099243164},{"x":50.41094207763672,"y":30.416095733642578},{"x":50.41085433959961,"y":30.415992736816406},{"x":50.41059494018555,"y":30.415634155273438},{"x":50.41029357910156,"y":30.415279388427734},{"x":50.409847259521484,"y":30.41483497619629},{"x":50.40955352783203,"y":30.414518356323242},{"x":50.40970230102539,"y":30.414228439331055},{"x":50.40992736816406,"y":30.413864135742188},{"x":50.41040802001953,"y":30.413070678710938},{"x":50.41089630126953,"y":30.412254333496094},{"x":50.411685943603516,"y":30.411026000976562},{"x":50.41230392456055,"y":30.41008186340332},{"x":50.412681579589844,"y":30.409488677978516}]}]}
4	2	c_route_bus	6	{"cityID":2,"routeID":224,"routeType":"c_route_bus","number":"6","timeStart":27180,"timeFinish":73800,"intervalMin":5820,"intervalMax":5820,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.5109748840332,"y":30.5803108215332,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Боженко"},{"lang_id":"c_en","value":" Bozhenko St"},{"lang_id":"c_uk","value":" вул. Боженко"}]},{"city_id":0,"location":{"x":50.5176849365234,"y":30.5849132537842,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сельсовет"},{"lang_id":"c_en","value":" Silrada"},{"lang_id":"c_uk","value":" Сільрада"}]},{"city_id":0,"location":{"x":50.521167755127,"y":30.5858631134033,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ленина"},{"lang_id":"c_en","value":" Lenina St"},{"lang_id":"c_uk","value":" вул. Леніна"}]},{"city_id":0,"location":{"x":50.5255088806152,"y":30.5847682952881,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Суворова"},{"lang_id":"c_en","value":" Suvorova St"},{"lang_id":"c_uk","value":" вул. Суворова"}]},{"city_id":0,"location":{"x":50.5283432006836,"y":30.5863189697266,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Троещина"},{"lang_id":"c_en","value":" Troeshina village"},{"lang_id":"c_uk","value":" село Троєщина"}]},{"city_id":0,"location":{"x":50.5306549072266,"y":30.5931529998779,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Славская"},{"lang_id":"c_en","value":" Slavska St"},{"lang_id":"c_uk","value":" вул. Славська"}]},{"city_id":0,"location":{"x":50.5310249328613,"y":30.5990600585938,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Милославская"},{"lang_id":"c_en","value":" Myloslavska St"},{"lang_id":"c_uk","value":" вул. Милославська"}]},{"city_id":0,"location":{"x":50.5283050537109,"y":30.6011619567871,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Будищанская"},{"lang_id":"c_en","value":" Budyshanska St"},{"lang_id":"c_uk","value":" вул. Будищанська"}]},{"city_id":0,"location":{"x":50.524097442627,"y":30.5999870300293,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лисковская"},{"lang_id":"c_en","value":" Lyskivska St"},{"lang_id":"c_uk","value":" вул. Лисківська"}]},{"city_id":0,"location":{"x":50.5220527648926,"y":30.5979118347168,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" магазин Радунь"},{"lang_id":"c_en","value":" magazyn Radun"},{"lang_id":"c_uk","value":" магазин Радунь"}]},{"city_id":0,"location":{"x":50.5198173522949,"y":30.5964679718018,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Радунская"},{"lang_id":"c_en","value":" Radunska St"},{"lang_id":"c_uk","value":" вул. Радунська"}]},{"city_id":0,"location":{"x":50.5169906616211,"y":30.6031799316406,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Градинская"},{"lang_id":"c_en","value":" Hradynska St"},{"lang_id":"c_uk","value":" вул. Градинська"}]},{"city_id":0,"location":{"x":50.5154876708984,"y":30.6043376922607,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Александра Сабурова"},{"lang_id":"c_en","value":" Oleksandra Saburova St"},{"lang_id":"c_uk","value":" вул. Олександра Сабурова"}]},{"city_id":0,"location":{"x":50.5130004882812,"y":30.6009159088135,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Викентия Беретти"},{"lang_id":"c_en","value":" Vikentiya Bereti St"},{"lang_id":"c_uk","value":" вул. Вікентія Береті"}]},{"city_id":0,"location":{"x":50.5085983276367,"y":30.5981216430664,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АТС"},{"lang_id":"c_en","value":" ATS"},{"lang_id":"c_uk","value":" АТС"}]},{"city_id":0,"location":{"x":50.5038719177246,"y":30.6020469665527,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Флоренция"},{"lang_id":"c_en","value":" kinoteatr Florentsia"},{"lang_id":"c_uk","value":" кінотеатр Флоренція"}]},{"city_id":0,"location":{"x":50.4983787536621,"y":30.6066551208496,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Закревского"},{"lang_id":"c_en","value":" Mykoly Zakrevskoho St"},{"lang_id":"c_uk","value":" вул. Миколи Закревського"}]},{"city_id":0,"location":{"x":50.4940757751465,"y":30.6079692840576,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Генерала Ватутина"},{"lang_id":"c_en","value":" Henerala Vatutina Ave"},{"lang_id":"c_uk","value":" пр. Генерала Ватутіна"}]},{"city_id":0,"location":{"x":50.4890441894531,"y":30.6102123260498,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Школа милиции"},{"lang_id":"c_en","value":" Shkola militsii"},{"lang_id":"c_uk","value":" Школа міліції"}]},{"city_id":0,"location":{"x":50.4861793518066,"y":30.6120853424072,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Сулеймана Стальского"},{"lang_id":"c_en","value":" Suleymana Stalskoho St"},{"lang_id":"c_uk","value":" вул. Сулеймана Стальского"}]},{"city_id":0,"location":{"x":50.4777946472168,"y":30.6177921295166,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Лесной"},{"lang_id":"c_en","value":" Lisovyi Ave"},{"lang_id":"c_uk","value":" пр. Лісовий"}]},{"city_id":0,"location":{"x":50.4749145507812,"y":30.6197547912598,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Медучилище"},{"lang_id":"c_en","value":" Meduchylyshe"},{"lang_id":"c_uk","value":" Медучилище"}]},{"city_id":0,"location":{"x":50.4702758789062,"y":30.6228618621826,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" рынок Лесной"},{"lang_id":"c_en","value":" rynok Lisnyi"},{"lang_id":"c_uk","value":" ринок Лісний"}]},{"city_id":0,"location":{"x":50.4657859802246,"y":30.6263008117676,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Бойченко"},{"lang_id":"c_en","value":" Boychenko St"},{"lang_id":"c_uk","value":" вул. Бойченко"}]},{"city_id":0,"location":{"x":50.4627647399902,"y":30.6280059814453,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Малышко"},{"lang_id":"c_en","value":" Malyshko St"},{"lang_id":"c_uk","value":" вул. Малишко"}]},{"city_id":0,"location":{"x":50.4589500427246,"y":30.6306247711182,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Черниговская"},{"lang_id":"c_en","value":" Chernihivska "},{"lang_id":"c_uk","value":" ст. м. Чернігівська"}]},{"city_id":0,"location":{"x":50.454891204834,"y":30.6326847076416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Крвсноткацкая"},{"lang_id":"c_en","value":" Chervonotkatska St"},{"lang_id":"c_uk","value":" вул. Червоноткацька"}]},{"city_id":0,"location":{"x":50.4508934020996,"y":30.6300182342529,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульв. Верховного Совета"},{"lang_id":"c_en","value":" Verkhovnoi Rady Blvd"},{"lang_id":"c_uk","value":" бульв. Верховної Ради"}]},{"city_id":0,"location":{"x":50.4470329284668,"y":30.62770652771,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Усенко"},{"lang_id":"c_en","value":" Pavla Usenko St"},{"lang_id":"c_uk","value":" вул. Павла Усенко"}]},{"city_id":0,"location":{"x":50.4437217712402,"y":30.6276035308838,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Ленинградская"},{"lang_id":"c_en","value":" Leninhradska square"},{"lang_id":"c_uk","value":" площа Ленінградська"}]}],"directRelations":[{"points":[{"x":50.5109748840332,"y":30.5803108215332},{"x":50.5109825134277,"y":30.5802307128906},{"x":50.5111465454102,"y":30.5803279876709},{"x":50.5113487243652,"y":30.5804672241211},{"x":50.5115814208984,"y":30.5806865692139},{"x":50.5120391845703,"y":30.5810947418213},{"x":50.5124053955078,"y":30.5814437866211},{"x":50.5126037597656,"y":30.5816459655762},{"x":50.5127067565918,"y":30.5817813873291},{"x":50.5128059387207,"y":30.581974029541},{"x":50.5130767822266,"y":30.58229637146},{"x":50.5133285522461,"y":30.5825595855713},{"x":50.5141372680664,"y":30.5833148956299},{"x":50.5149116516113,"y":30.5839595794678},{"x":50.5153541564941,"y":30.5843124389648},{"x":50.5156669616699,"y":30.5844955444336},{"x":50.5158195495605,"y":30.5845489501953},{"x":50.5160064697266,"y":30.5845813751221},{"x":50.5166053771973,"y":30.5846824645996},{"x":50.5174446105957,"y":30.5848178863525},{"x":50.5176811218262,"y":30.5848388671875}]},{"points":[{"x":50.5176849365234,"y":30.5849132537842},{"x":50.5176811218262,"y":30.5848388671875},{"x":50.5182228088379,"y":30.5849342346191},{"x":50.5186958312988,"y":30.5849838256836},{"x":50.518871307373,"y":30.5850315093994},{"x":50.5196113586426,"y":30.5852890014648},{"x":50.5203132629395,"y":30.5854930877686},{"x":50.520881652832,"y":30.5856761932373},{"x":50.5211791992188,"y":30.5857887268066}]},{"points":[{"x":50.521167755127,"y":30.5858631134033},{"x":50.5211791992188,"y":30.5857887268066},{"x":50.5217781066895,"y":30.5860404968262},{"x":50.5221710205078,"y":30.5861358642578},{"x":50.5224723815918,"y":30.5861740112305},{"x":50.5227165222168,"y":30.5861473083496},{"x":50.5229339599609,"y":30.5860824584961},{"x":50.5231552124023,"y":30.5859870910645},{"x":50.5233612060547,"y":30.5858478546143},{"x":50.5236320495605,"y":30.585620880127},{"x":50.5239944458008,"y":30.5853214263916},{"x":50.524242401123,"y":30.5851440429688},{"x":50.5244026184082,"y":30.585075378418},{"x":50.5247039794922,"y":30.5849838256836},{"x":50.5251998901367,"y":30.5848007202148},{"x":50.5254859924316,"y":30.5846939086914}]},{"points":[{"x":50.5255088806152,"y":30.5847682952881},{"x":50.5254859924316,"y":30.5846939086914},{"x":50.5257034301758,"y":30.5846290588379},{"x":50.5259132385254,"y":30.5846080780029},{"x":50.5260887145996,"y":30.5846290588379},{"x":50.5264129638672,"y":30.5847053527832},{"x":50.5267219543457,"y":30.5848178863525},{"x":50.5269393920898,"y":30.5849132537842},{"x":50.5271186828613,"y":30.5850639343262},{"x":50.5274124145508,"y":30.5853595733643},{"x":50.5279884338379,"y":30.585901260376},{"x":50.5283622741699,"y":30.5862445831299}]},{"points":[{"x":50.5283432006836,"y":30.5863189697266},{"x":50.5283622741699,"y":30.5862445831299},{"x":50.5286750793457,"y":30.5865116119385},{"x":50.5290870666504,"y":30.5868015289307},{"x":50.5295829772949,"y":30.587194442749},{"x":50.530143737793,"y":30.5876235961914},{"x":50.5300788879395,"y":30.5880298614502},{"x":50.5300483703613,"y":30.5886096954346},{"x":50.5300369262695,"y":30.5893707275391},{"x":50.5300369262695,"y":30.5898857116699},{"x":50.5300788879395,"y":30.5904865264893},{"x":50.5301971435547,"y":30.5912380218506},{"x":50.5302848815918,"y":30.5917110443115},{"x":50.530387878418,"y":30.592155456543},{"x":50.5306930541992,"y":30.593111038208}]},{"points":[{"x":50.5306549072266,"y":30.5931529998779},{"x":50.5306930541992,"y":30.593111038208},{"x":50.5308837890625,"y":30.5936851501465},{"x":50.5313911437988,"y":30.5952663421631},{"x":50.5316848754883,"y":30.5961360931396},{"x":50.5318145751953,"y":30.5966186523438},{"x":50.5318794250488,"y":30.5969886779785},{"x":50.5319023132324,"y":30.5972995758057},{"x":50.5318794250488,"y":30.5976104736328},{"x":50.5317916870117,"y":30.5978908538818},{"x":50.5316429138184,"y":30.5982704162598},{"x":50.5315055847168,"y":30.5985507965088},{"x":50.5313606262207,"y":30.5987911224365},{"x":50.5312271118164,"y":30.5989799499512},{"x":50.5310478210449,"y":30.5991287231445}]},{"points":[{"x":50.5310249328613,"y":30.5990600585938},{"x":50.5310478210449,"y":30.5991287231445},{"x":50.5306701660156,"y":30.5994300842285},{"x":50.5298805236816,"y":30.6000633239746},{"x":50.5289840698242,"y":30.6007595062256},{"x":50.5287017822266,"y":30.6009750366211},{"x":50.5284805297852,"y":30.6011257171631},{"x":50.5283126831055,"y":30.6012420654297}]},{"points":[{"x":50.5283050537109,"y":30.6011619567871},{"x":50.5283126831055,"y":30.6012420654297},{"x":50.5281600952148,"y":30.6013450622559},{"x":50.5279655456543,"y":30.6014423370361},{"x":50.5276947021484,"y":30.6015434265137},{"x":50.5273780822754,"y":30.6016407012939},{"x":50.5271339416504,"y":30.6016712188721},{"x":50.5268898010254,"y":30.6016883850098},{"x":50.5267066955566,"y":30.6016826629639},{"x":50.5263824462891,"y":30.6016445159912},{"x":50.5261154174805,"y":30.6015911102295},{"x":50.525764465332,"y":30.6014633178711},{"x":50.5254783630371,"y":30.6013126373291},{"x":50.525218963623,"y":30.6011562347412},{"x":50.5250244140625,"y":30.6010074615479},{"x":50.5249328613281,"y":30.6009368896484},{"x":50.5247230529785,"y":30.6007556915283},{"x":50.5244827270508,"y":30.6004981994629},{"x":50.5240631103516,"y":30.6000633239746}]},{"points":[{"x":50.524097442627,"y":30.5999870300293},{"x":50.5240631103516,"y":30.6000633239746},{"x":50.5235481262207,"y":30.5995426177979},{"x":50.5230941772461,"y":30.5990695953369},{"x":50.5228385925293,"y":30.5987911224365},{"x":50.522575378418,"y":30.5985336303711},{"x":50.5222854614258,"y":30.5982494354248},{"x":50.522216796875,"y":30.5981750488281},{"x":50.5220260620117,"y":30.5979804992676}]},{"points":[{"x":50.5220527648926,"y":30.5979118347168},{"x":50.5220260620117,"y":30.5979804992676},{"x":50.5216178894043,"y":30.5975570678711},{"x":50.5212211608887,"y":30.5971546173096},{"x":50.5208473205566,"y":30.5967750549316},{"x":50.5204391479492,"y":30.5963554382324},{"x":50.5200653076172,"y":30.5959758758545},{"x":50.5198554992676,"y":30.5965061187744}]},{"points":[{"x":50.5198173522949,"y":30.5964679718018},{"x":50.5198554992676,"y":30.5965061187744},{"x":50.5192985534668,"y":30.5978527069092},{"x":50.5183639526367,"y":30.6000690460205},{"x":50.5175018310547,"y":30.6021060943604},{"x":50.5170288085938,"y":30.6032161712646}]},{"points":[{"x":50.5169906616211,"y":30.6031799316406},{"x":50.5170288085938,"y":30.6032161712646},{"x":50.5167694091797,"y":30.6038398742676},{"x":50.5162391662598,"y":30.6052131652832},{"x":50.5154609680176,"y":30.6044178009033}]},{"points":[{"x":50.5154876708984,"y":30.6043376922607},{"x":50.5154609680176,"y":30.6044178009033},{"x":50.514892578125,"y":30.6038284301758},{"x":50.5143623352051,"y":30.6032161712646},{"x":50.5139541625977,"y":30.6026802062988},{"x":50.5133895874023,"y":30.6017265319824},{"x":50.5129585266113,"y":30.6009693145752}]},{"points":[{"x":50.5130004882812,"y":30.6009159088135},{"x":50.5129585266113,"y":30.6009693145752},{"x":50.5125427246094,"y":30.6002349853516},{"x":50.5123710632324,"y":30.5999126434326},{"x":50.5121154785156,"y":30.5993537902832},{"x":50.511833190918,"y":30.598690032959},{"x":50.5114784240723,"y":30.597728729248},{"x":50.5112419128418,"y":30.5970649719238},{"x":50.5109596252441,"y":30.5962390899658},{"x":50.510570526123,"y":30.596549987793},{"x":50.5103530883789,"y":30.596736907959},{"x":50.5097694396973,"y":30.5972194671631},{"x":50.509220123291,"y":30.5976810455322},{"x":50.5088996887207,"y":30.5979595184326},{"x":50.5086135864258,"y":30.5981903076172}]},{"points":[{"x":50.5085983276367,"y":30.5981216430664},{"x":50.5086135864258,"y":30.5981903076172},{"x":50.5080451965332,"y":30.5986785888672},{"x":50.5077018737793,"y":30.5989627838135},{"x":50.5069007873535,"y":30.5996341705322},{"x":50.506175994873,"y":30.6002349853516},{"x":50.5059700012207,"y":30.600399017334},{"x":50.5057830810547,"y":30.6005516052246},{"x":50.5055961608887,"y":30.6005783081055},{"x":50.5053901672363,"y":30.6005725860596},{"x":50.5052375793457,"y":30.6005191802979},{"x":50.5051155090332,"y":30.6005191802979},{"x":50.5049934387207,"y":30.6005783081055},{"x":50.5049057006836,"y":30.6006698608398},{"x":50.5048294067383,"y":30.6008720397949},{"x":50.5047721862793,"y":30.6010761260986},{"x":50.5046997070312,"y":30.6012649536133},{"x":50.5045700073242,"y":30.6015281677246},{"x":50.5044746398926,"y":30.6016445159912},{"x":50.5038986206055,"y":30.6021289825439}]},{"points":[{"x":50.5038719177246,"y":30.6020469665527},{"x":50.5038986206055,"y":30.6021289825439},{"x":50.5031509399414,"y":30.6027507781982},{"x":50.502555847168,"y":30.6032485961914},{"x":50.5016288757324,"y":30.6040439605713},{"x":50.5006103515625,"y":30.6048908233643},{"x":50.4997749328613,"y":30.6055927276611},{"x":50.4993743896484,"y":30.6059055328369},{"x":50.4988098144531,"y":30.6063919067383},{"x":50.4983940124512,"y":30.6067352294922}]},{"points":[{"x":50.4983787536621,"y":30.6066551208496},{"x":50.4983940124512,"y":30.6067352294922},{"x":50.4975433349609,"y":30.6074333190918},{"x":50.4970703125,"y":30.6078147888184},{"x":50.4968223571777,"y":30.6079864501953},{"x":50.4966430664062,"y":30.6080551147461},{"x":50.4964027404785,"y":30.6080780029297},{"x":50.4960975646973,"y":30.6080284118652},{"x":50.4958152770996,"y":30.6079692840576},{"x":50.4955101013184,"y":30.60791015625},{"x":50.4953765869141,"y":30.6078567504883},{"x":50.4952278137207,"y":30.6078090667725},{"x":50.4949035644531,"y":30.6078243255615},{"x":50.4945259094238,"y":30.6078948974609},{"x":50.4940795898438,"y":30.608039855957}]},{"points":[{"x":50.4940757751465,"y":30.6079692840576},{"x":50.4940795898438,"y":30.608039855957},{"x":50.4936408996582,"y":30.6082763671875},{"x":50.493106842041,"y":30.6085433959961},{"x":50.4923439025879,"y":30.6089134216309},{"x":50.4916610717773,"y":30.609224319458},{"x":50.490966796875,"y":30.6095314025879},{"x":50.4903869628906,"y":30.6097679138184},{"x":50.4900245666504,"y":30.6098957061768},{"x":50.4897117614746,"y":30.6099967956543},{"x":50.4894256591797,"y":30.6101150512695},{"x":50.4890518188477,"y":30.6103134155273}]},{"points":[{"x":50.4890441894531,"y":30.6102123260498},{"x":50.4890518188477,"y":30.6103134155273},{"x":50.4885787963867,"y":30.6105937957764},{"x":50.4881744384766,"y":30.61083984375},{"x":50.4877281188965,"y":30.6111450195312},{"x":50.4874000549316,"y":30.6113433837891},{"x":50.4869804382324,"y":30.6116180419922},{"x":50.4867248535156,"y":30.6117725372314},{"x":50.4861907958984,"y":30.6121654510498}]},{"points":[{"x":50.4861793518066,"y":30.6120853424072},{"x":50.4861907958984,"y":30.6121654510498},{"x":50.4855842590332,"y":30.6125888824463},{"x":50.4848899841309,"y":30.6130657196045},{"x":50.4840431213379,"y":30.6136455535889},{"x":50.4832420349121,"y":30.6141929626465},{"x":50.4824028015137,"y":30.61474609375},{"x":50.4815521240234,"y":30.6153240203857},{"x":50.4807243347168,"y":30.6158924102783},{"x":50.4797973632812,"y":30.6165370941162},{"x":50.4788551330566,"y":30.6171646118164},{"x":50.4780960083008,"y":30.6177005767822},{"x":50.4778137207031,"y":30.617883682251}]},{"points":[{"x":50.4777946472168,"y":30.6177921295166},{"x":50.4778137207031,"y":30.617883682251},{"x":50.4774398803711,"y":30.6181354522705},{"x":50.4770431518555,"y":30.6183986663818},{"x":50.4763832092285,"y":30.618860244751},{"x":50.4749336242676,"y":30.6198406219482}]},{"points":[{"x":50.4749145507812,"y":30.6197547912598},{"x":50.4749336242676,"y":30.6198406219482},{"x":50.474178314209,"y":30.6203556060791},{"x":50.4734573364258,"y":30.6208438873291},{"x":50.4732360839844,"y":30.6209945678711},{"x":50.4728927612305,"y":30.6212520599365},{"x":50.4726371765137,"y":30.6213798522949},{"x":50.4722900390625,"y":30.6215057373047},{"x":50.4716033935547,"y":30.621976852417},{"x":50.4706001281738,"y":30.6226997375488},{"x":50.4702949523926,"y":30.6229248046875}]},{"points":[{"x":50.4702758789062,"y":30.6228618621826},{"x":50.4702949523926,"y":30.6229248046875},{"x":50.4698715209961,"y":30.6232528686523},{"x":50.4688034057617,"y":30.6240921020508},{"x":50.4680709838867,"y":30.6246662139893},{"x":50.4675941467285,"y":30.6250743865967},{"x":50.4673347473145,"y":30.6253433227539},{"x":50.4667091369629,"y":30.6257877349854},{"x":50.4658050537109,"y":30.6263885498047}]},{"points":[{"x":50.4657859802246,"y":30.6263008117676},{"x":50.4658050537109,"y":30.6263885498047},{"x":50.4647178649902,"y":30.6271228790283},{"x":50.4641647338867,"y":30.6274890899658},{"x":50.4638824462891,"y":30.6276378631592},{"x":50.4633445739746,"y":30.6276912689209},{"x":50.4627876281738,"y":30.6280994415283}]},{"points":[{"x":50.4627647399902,"y":30.6280059814453},{"x":50.4627876281738,"y":30.6280994415283},{"x":50.462272644043,"y":30.628475189209},{"x":50.4616279602051,"y":30.6289367675781},{"x":50.4608154296875,"y":30.6294784545898},{"x":50.4601860046387,"y":30.629919052124},{"x":50.4599685668945,"y":30.6300792694092},{"x":50.4597549438477,"y":30.6301860809326},{"x":50.4593734741211,"y":30.6304225921631},{"x":50.4589653015137,"y":30.6307067871094}]},{"points":[{"x":50.4589500427246,"y":30.6306247711182},{"x":50.4589653015137,"y":30.6307067871094},{"x":50.4581985473633,"y":30.6312656402588},{"x":50.4573936462402,"y":30.6318340301514},{"x":50.4561958312988,"y":30.6326274871826},{"x":50.4555053710938,"y":30.6330890655518},{"x":50.4552421569824,"y":30.6329650878906},{"x":50.4548759460449,"y":30.6327610015869}]},{"points":[{"x":50.454891204834,"y":30.6326847076416},{"x":50.4548759460449,"y":30.6327610015869},{"x":50.4537582397461,"y":30.6320648193359},{"x":50.4529800415039,"y":30.6315822601318},{"x":50.4524192810059,"y":30.6311740875244},{"x":50.4522323608398,"y":30.6310024261475},{"x":50.4520149230957,"y":30.6308517456055},{"x":50.4516410827637,"y":30.6305885314941},{"x":50.4512252807617,"y":30.6303157806396},{"x":50.4508781433105,"y":30.6301002502441}]},{"points":[{"x":50.4508934020996,"y":30.6300182342529},{"x":50.4508781433105,"y":30.6301002502441},{"x":50.4499702453613,"y":30.6295585632324},{"x":50.4489707946777,"y":30.6289577484131},{"x":50.4481811523438,"y":30.6284866333008},{"x":50.4470100402832,"y":30.6277885437012}]},{"points":[{"x":50.4470329284668,"y":30.62770652771},{"x":50.4470100402832,"y":30.6277885437012},{"x":50.4460945129395,"y":30.6272468566895},{"x":50.445369720459,"y":30.626823425293},{"x":50.4441032409668,"y":30.6260719299316},{"x":50.4437217712402,"y":30.6276035308838}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4476356506348,"y":30.6284618377686,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Усенко"},{"lang_id":"c_en","value":" Pavla Usenko St"},{"lang_id":"c_uk","value":" вул. Павла Усенко"}]},{"city_id":0,"location":{"x":50.4509544372559,"y":30.6304798126221,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульв. Верховного Совета"},{"lang_id":"c_en","value":" Verkhovnoi Rady Blvd"},{"lang_id":"c_uk","value":" бульв. Верховної Ради"}]},{"city_id":0,"location":{"x":50.458984375,"y":30.6310749053955,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Черниговская"},{"lang_id":"c_en","value":" Chernihivska "},{"lang_id":"c_uk","value":" ст. м. Чернігівська"}]},{"city_id":0,"location":{"x":50.4626388549805,"y":30.6287307739258,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Малышко"},{"lang_id":"c_en","value":" Malyshko St"},{"lang_id":"c_uk","value":" вул. Малишко"}]},{"city_id":0,"location":{"x":50.4652061462402,"y":30.6270198822021,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Бойченко"},{"lang_id":"c_en","value":" Boychenko St"},{"lang_id":"c_uk","value":" вул. Бойченко"}]},{"city_id":0,"location":{"x":50.470401763916,"y":30.6234359741211,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" рынок Лесной"},{"lang_id":"c_en","value":" rynok Lisnyi"},{"lang_id":"c_uk","value":" ринок Лісний"}]},{"city_id":0,"location":{"x":50.4746170043945,"y":30.620325088501,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Медучилище"},{"lang_id":"c_en","value":" Meduchylyshe"},{"lang_id":"c_uk","value":" Медучилище"}]},{"city_id":0,"location":{"x":50.478832244873,"y":30.6174640655518,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Лесной"},{"lang_id":"c_en","value":" Lisovyi Ave"},{"lang_id":"c_uk","value":" пр. Лісовий"}]},{"city_id":0,"location":{"x":50.4872360229492,"y":30.6117515563965,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Крайняя"},{"lang_id":"c_en","value":" Kraynya St"},{"lang_id":"c_uk","value":" вул. Крайня"}]},{"city_id":0,"location":{"x":50.4896697998047,"y":30.6102542877197,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Школа милиции"},{"lang_id":"c_en","value":" Shkola militsii"},{"lang_id":"c_uk","value":" Школа міліції"}]},{"city_id":0,"location":{"x":50.4958229064941,"y":30.608039855957,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" рынок Троещина"},{"lang_id":"c_en","value":" rynok Troeshyna"},{"lang_id":"c_uk","value":" ринок Троєщина"}]},{"city_id":0,"location":{"x":50.499397277832,"y":30.6059627532959,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Закревского"},{"lang_id":"c_en","value":" Mykoly Zakrevskoho St"},{"lang_id":"c_uk","value":" вул. Миколи Закревського"}]},{"city_id":0,"location":{"x":50.5025825500488,"y":30.6033191680908,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Флоренция"},{"lang_id":"c_en","value":" kinoteatr Florentsia"},{"lang_id":"c_uk","value":" кінотеатр Флоренція"}]},{"city_id":0,"location":{"x":50.5060005187988,"y":30.6004810333252,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Владимира Маяковского"},{"lang_id":"c_en","value":" Volodymyra Mayakovskoho Ave"},{"lang_id":"c_uk","value":" пр. Володимира Мояковського"}]},{"city_id":0,"location":{"x":50.508056640625,"y":30.5987434387207,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АТС"},{"lang_id":"c_en","value":" ATS"},{"lang_id":"c_uk","value":" АТС"}]},{"city_id":0,"location":{"x":50.5106048583984,"y":30.5966186523438,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Бальзака"},{"lang_id":"c_en","value":" Balzaka St"},{"lang_id":"c_uk","value":" вул. Бальзака"}]},{"city_id":0,"location":{"x":50.5112075805664,"y":30.597095489502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Дрейзера"},{"lang_id":"c_en","value":" Dreyzera St"},{"lang_id":"c_uk","value":" вул. Дрейзера"}]},{"city_id":0,"location":{"x":50.512508392334,"y":30.6002883911133,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Викентия Беретти"},{"lang_id":"c_en","value":" Vikentiya Bereti St"},{"lang_id":"c_uk","value":" вул. Вікентія Береті"}]},{"city_id":0,"location":{"x":50.5154304504395,"y":30.6044998168945,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Александра Сабурова"},{"lang_id":"c_en","value":" Oleksandra Saburova St"},{"lang_id":"c_uk","value":" вул. Олександра Сабурова"}]},{"city_id":0,"location":{"x":50.5170745849609,"y":30.6032600402832,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Градинская"},{"lang_id":"c_en","value":" Hradynska St"},{"lang_id":"c_uk","value":" вул. Градинська"}]},{"city_id":0,"location":{"x":50.5204200744629,"y":30.596435546875,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Радунская"},{"lang_id":"c_en","value":" Radunska St"},{"lang_id":"c_uk","value":" вул. Радунська"}]},{"city_id":0,"location":{"x":50.5221900939941,"y":30.5982437133789,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" магазин Радунь"},{"lang_id":"c_en","value":" magazyn Radun"},{"lang_id":"c_uk","value":" магазин Радунь"}]},{"city_id":0,"location":{"x":50.5249176025391,"y":30.601001739502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лисковская"},{"lang_id":"c_en","value":" Lyskivska St"},{"lang_id":"c_uk","value":" вул. Лисківська"}]},{"city_id":0,"location":{"x":50.5289993286133,"y":30.6008415222168,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Будищанская/ ул. Радунская"},{"lang_id":"c_en","value":" Budyshanska St / Radunska St"},{"lang_id":"c_uk","value":" вул. Будищанська / вул. Радунська"}]},{"city_id":0,"location":{"x":50.531063079834,"y":30.5992050170898,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Милославская"},{"lang_id":"c_en","value":" Myloslavska St"},{"lang_id":"c_uk","value":" вул. Милославська"}]},{"city_id":0,"location":{"x":50.5309295654297,"y":30.593635559082,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Славская"},{"lang_id":"c_en","value":" Slavska St"},{"lang_id":"c_uk","value":" вул. Славська"}]},{"city_id":0,"location":{"x":50.528377532959,"y":30.5861415863037,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Троещина"},{"lang_id":"c_en","value":" Troeshina village"},{"lang_id":"c_uk","value":" село Троєщина"}]},{"city_id":0,"location":{"x":50.5251922607422,"y":30.5847206115723,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Суворова"},{"lang_id":"c_en","value":" Suvorova St"},{"lang_id":"c_uk","value":" вул. Суворова"}]},{"city_id":0,"location":{"x":50.5208969116211,"y":30.5855731964111,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ленина"},{"lang_id":"c_en","value":" Lenina St"},{"lang_id":"c_uk","value":" вул. Леніна"}]},{"city_id":0,"location":{"x":50.5174522399902,"y":30.5847320556641,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сельсовет"},{"lang_id":"c_en","value":" Silrada"},{"lang_id":"c_uk","value":" Сільрада"}]},{"city_id":0,"location":{"x":50.5054397583008,"y":30.5809173583984,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автостоянка"},{"lang_id":"c_en","value":" Autostoyanka"},{"lang_id":"c_uk","value":" Автостоянка"}]}],"reverseRelations":[{"points":[{"x":50.4476356506348,"y":30.6284618377686},{"x":50.4476509094238,"y":30.628396987915},{"x":50.4489555358887,"y":30.629186630249},{"x":50.4502334594727,"y":30.6299533843994},{"x":50.4509658813477,"y":30.6304092407227}]},{"points":[{"x":50.4509544372559,"y":30.6304798126221},{"x":50.4509658813477,"y":30.6304092407227},{"x":50.4514236450195,"y":30.6306781768799},{"x":50.4516448974609,"y":30.6308708190918},{"x":50.451774597168,"y":30.6310806274414},{"x":50.4518928527832,"y":30.6313972473145},{"x":50.4520149230957,"y":30.6318416595459},{"x":50.4524612426758,"y":30.6333980560303},{"x":50.45263671875,"y":30.6340351104736},{"x":50.4527435302734,"y":30.634298324585},{"x":50.4528617858887,"y":30.6344699859619},{"x":50.453010559082,"y":30.6345767974854},{"x":50.4531860351562,"y":30.6346416473389},{"x":50.4534454345703,"y":30.6346588134766},{"x":50.4544067382812,"y":30.6340255737305},{"x":50.4554634094238,"y":30.6333484649658},{"x":50.4562950134277,"y":30.6328125},{"x":50.4575080871582,"y":30.6319541931152},{"x":50.4584846496582,"y":30.6313152313232},{"x":50.4589767456055,"y":30.6310214996338}]},{"points":[{"x":50.458984375,"y":30.6310749053955},{"x":50.4589767456055,"y":30.6310214996338},{"x":50.4594116210938,"y":30.6307468414307},{"x":50.4598579406738,"y":30.6303768157959},{"x":50.4600410461426,"y":30.6302433013916},{"x":50.4604339599609,"y":30.6300182342529},{"x":50.4608879089355,"y":30.6296901702881},{"x":50.4612655639648,"y":30.6294326782227},{"x":50.4615287780762,"y":30.6292514801025},{"x":50.4618797302246,"y":30.6290798187256},{"x":50.4623336791992,"y":30.6288642883301},{"x":50.4626274108887,"y":30.6286773681641}]},{"points":[{"x":50.4626388549805,"y":30.6287307739258},{"x":50.4626274108887,"y":30.6286773681641},{"x":50.4635314941406,"y":30.6280765533447},{"x":50.4640579223633,"y":30.627721786499},{"x":50.4649848937988,"y":30.6270942687988},{"x":50.4651947021484,"y":30.6269550323486}]},{"points":[{"x":50.4652061462402,"y":30.6270198822021},{"x":50.4651947021484,"y":30.6269550323486},{"x":50.4659233093262,"y":30.6264724731445},{"x":50.4668159484863,"y":30.6258659362793},{"x":50.4674606323242,"y":30.6254367828369},{"x":50.4677658081055,"y":30.6252918243408},{"x":50.467960357666,"y":30.6251850128174},{"x":50.4681587219238,"y":30.6250667572021},{"x":50.4684181213379,"y":30.6248626708984},{"x":50.469051361084,"y":30.6243629455566},{"x":50.4698753356934,"y":30.6237354278564},{"x":50.4701690673828,"y":30.6235370635986},{"x":50.4703826904297,"y":30.6233654022217}]},{"points":[{"x":50.470401763916,"y":30.6234359741211},{"x":50.4703826904297,"y":30.6233654022217},{"x":50.4712677001953,"y":30.6226787567139},{"x":50.472110748291,"y":30.6220989227295},{"x":50.4726219177246,"y":30.6217079162598},{"x":50.4727935791016,"y":30.6215209960938},{"x":50.4729156494141,"y":30.6213760375977},{"x":50.4733619689941,"y":30.6210861206055},{"x":50.4746017456055,"y":30.6202602386475}]},{"points":[{"x":50.4746170043945,"y":30.620325088501},{"x":50.4746017456055,"y":30.6202602386475},{"x":50.4755249023438,"y":30.6196384429932},{"x":50.4760246276855,"y":30.6193046569824},{"x":50.4770011901855,"y":30.6186122894287},{"x":50.477668762207,"y":30.6181621551514},{"x":50.4782638549805,"y":30.6177806854248},{"x":50.4788131713867,"y":30.6174068450928}]},{"points":[{"x":50.478832244873,"y":30.6174640655518},{"x":50.4788131713867,"y":30.6174068450928},{"x":50.4799766540527,"y":30.6166019439697},{"x":50.4807586669922,"y":30.6160907745361},{"x":50.4812469482422,"y":30.6157760620117},{"x":50.4823570251465,"y":30.6150035858154},{"x":50.4836616516113,"y":30.614107131958},{"x":50.4849128723145,"y":30.6132545471191},{"x":50.4861793518066,"y":30.6124057769775},{"x":50.4868469238281,"y":30.6119613647461},{"x":50.4872245788574,"y":30.6116981506348}]},{"points":[{"x":50.4872360229492,"y":30.6117515563965},{"x":50.4872245788574,"y":30.6116981506348},{"x":50.4879188537598,"y":30.6112098693848},{"x":50.4883766174316,"y":30.6108875274658},{"x":50.4886169433594,"y":30.6107330322266},{"x":50.4889640808105,"y":30.6105403900146},{"x":50.4892463684082,"y":30.6103839874268},{"x":50.4896545410156,"y":30.6101913452148}]},{"points":[{"x":50.4896697998047,"y":30.6102542877197},{"x":50.4896545410156,"y":30.6101913452148},{"x":50.4900360107422,"y":30.6100559234619},{"x":50.4905471801758,"y":30.6098747253418},{"x":50.4913215637207,"y":30.6095638275146},{"x":50.4919128417969,"y":30.6093273162842},{"x":50.492431640625,"y":30.6090755462646},{"x":50.4933204650879,"y":30.6086139678955},{"x":50.4939384460449,"y":30.6082973480225},{"x":50.4942436218262,"y":30.6081581115723},{"x":50.4947700500488,"y":30.6080513000488},{"x":50.4951133728027,"y":30.6080074310303},{"x":50.4952964782715,"y":30.6079864501953},{"x":50.4955101013184,"y":30.60791015625},{"x":50.4958152770996,"y":30.6079692840576}]},{"points":[{"x":50.4958229064941,"y":30.608039855957},{"x":50.4958152770996,"y":30.6079692840576},{"x":50.4960975646973,"y":30.6080284118652},{"x":50.4964027404785,"y":30.6080780029297},{"x":50.4966430664062,"y":30.6080551147461},{"x":50.4968223571777,"y":30.6079864501953},{"x":50.4970703125,"y":30.6078147888184},{"x":50.4975433349609,"y":30.6074333190918},{"x":50.4983940124512,"y":30.6067352294922},{"x":50.4988098144531,"y":30.6063919067383},{"x":50.4993743896484,"y":30.6059055328369}]},{"points":[{"x":50.499397277832,"y":30.6059627532959},{"x":50.4993743896484,"y":30.6059055328369},{"x":50.4997749328613,"y":30.6055927276611},{"x":50.5006103515625,"y":30.6048908233643},{"x":50.5016288757324,"y":30.6040439605713},{"x":50.502555847168,"y":30.6032485961914}]},{"points":[{"x":50.5025825500488,"y":30.6033191680908},{"x":50.502555847168,"y":30.6032485961914},{"x":50.5031509399414,"y":30.6027507781982},{"x":50.5038986206055,"y":30.6021289825439},{"x":50.5044746398926,"y":30.6016445159912},{"x":50.5046615600586,"y":30.6015701293945},{"x":50.5049095153809,"y":30.6015586853027},{"x":50.5051193237305,"y":30.6016445159912},{"x":50.5052680969238,"y":30.6016407012939},{"x":50.5053749084473,"y":30.6015701293945},{"x":50.5054893493652,"y":30.6013832092285},{"x":50.505558013916,"y":30.6010704040527},{"x":50.5056419372559,"y":30.6008567810059},{"x":50.5057830810547,"y":30.6005516052246},{"x":50.5059700012207,"y":30.600399017334}]},{"points":[{"x":50.5060005187988,"y":30.6004810333252},{"x":50.5059700012207,"y":30.600399017334},{"x":50.506175994873,"y":30.6002349853516},{"x":50.5069007873535,"y":30.5996341705322},{"x":50.5077018737793,"y":30.5989627838135},{"x":50.5080451965332,"y":30.5986785888672}]},{"points":[{"x":50.508056640625,"y":30.5987434387207},{"x":50.5080451965332,"y":30.5986785888672},{"x":50.5086135864258,"y":30.5981903076172},{"x":50.5088996887207,"y":30.5979595184326},{"x":50.509220123291,"y":30.5976810455322},{"x":50.5097694396973,"y":30.5972194671631},{"x":50.5103530883789,"y":30.596736907959},{"x":50.510570526123,"y":30.596549987793}]},{"points":[{"x":50.5106048583984,"y":30.5966186523438},{"x":50.510570526123,"y":30.596549987793},{"x":50.5109596252441,"y":30.5962390899658},{"x":50.5112419128418,"y":30.5970649719238}]},{"points":[{"x":50.5112075805664,"y":30.597095489502},{"x":50.5112419128418,"y":30.5970649719238},{"x":50.5114784240723,"y":30.597728729248},{"x":50.511833190918,"y":30.598690032959},{"x":50.5121154785156,"y":30.5993537902832},{"x":50.5123710632324,"y":30.5999126434326},{"x":50.5125427246094,"y":30.6002349853516}]},{"points":[{"x":50.512508392334,"y":30.6002883911133},{"x":50.5125427246094,"y":30.6002349853516},{"x":50.5129585266113,"y":30.6009693145752},{"x":50.5133895874023,"y":30.6017265319824},{"x":50.5139541625977,"y":30.6026802062988},{"x":50.5143623352051,"y":30.6032161712646},{"x":50.514892578125,"y":30.6038284301758},{"x":50.5154609680176,"y":30.6044178009033}]},{"points":[{"x":50.5154304504395,"y":30.6044998168945},{"x":50.5154609680176,"y":30.6044178009033},{"x":50.5162391662598,"y":30.6052131652832},{"x":50.5167694091797,"y":30.6038398742676},{"x":50.5170288085938,"y":30.6032161712646}]},{"points":[{"x":50.5170745849609,"y":30.6032600402832},{"x":50.5170288085938,"y":30.6032161712646},{"x":50.5175018310547,"y":30.6021060943604},{"x":50.5183639526367,"y":30.6000690460205},{"x":50.5192985534668,"y":30.5978527069092},{"x":50.5198554992676,"y":30.5965061187744},{"x":50.5200653076172,"y":30.5959758758545},{"x":50.5204391479492,"y":30.5963554382324}]},{"points":[{"x":50.5204200744629,"y":30.596435546875},{"x":50.5204391479492,"y":30.5963554382324},{"x":50.5208473205566,"y":30.5967750549316},{"x":50.5212211608887,"y":30.5971546173096},{"x":50.5216178894043,"y":30.5975570678711},{"x":50.5220260620117,"y":30.5979804992676},{"x":50.522216796875,"y":30.5981750488281}]},{"points":[{"x":50.5221900939941,"y":30.5982437133789},{"x":50.522216796875,"y":30.5981750488281},{"x":50.5222854614258,"y":30.5982494354248},{"x":50.522575378418,"y":30.5985336303711},{"x":50.5228385925293,"y":30.5987911224365},{"x":50.5230941772461,"y":30.5990695953369},{"x":50.5235481262207,"y":30.5995426177979},{"x":50.5240631103516,"y":30.6000633239746},{"x":50.5244827270508,"y":30.6004981994629},{"x":50.5247230529785,"y":30.6007556915283},{"x":50.5249328613281,"y":30.6009368896484}]},{"points":[{"x":50.5249176025391,"y":30.601001739502},{"x":50.5249328613281,"y":30.6009368896484},{"x":50.5250244140625,"y":30.6010074615479},{"x":50.525218963623,"y":30.6011562347412},{"x":50.5254783630371,"y":30.6013126373291},{"x":50.525764465332,"y":30.6014633178711},{"x":50.5261154174805,"y":30.6015911102295},{"x":50.5263824462891,"y":30.6016445159912},{"x":50.5267066955566,"y":30.6016826629639},{"x":50.5268898010254,"y":30.6016883850098},{"x":50.5271339416504,"y":30.6016712188721},{"x":50.5273780822754,"y":30.6016407012939},{"x":50.5276947021484,"y":30.6015434265137},{"x":50.5279655456543,"y":30.6014423370361},{"x":50.5281600952148,"y":30.6013450622559},{"x":50.5283126831055,"y":30.6012420654297},{"x":50.5284805297852,"y":30.6011257171631},{"x":50.5287017822266,"y":30.6009750366211},{"x":50.5289840698242,"y":30.6007595062256}]},{"points":[{"x":50.5289993286133,"y":30.6008415222168},{"x":50.5289840698242,"y":30.6007595062256},{"x":50.5298805236816,"y":30.6000633239746},{"x":50.5306701660156,"y":30.5994300842285},{"x":50.5310478210449,"y":30.5991287231445}]},{"points":[{"x":50.531063079834,"y":30.5992050170898},{"x":50.5310478210449,"y":30.5991287231445},{"x":50.5312271118164,"y":30.5989799499512},{"x":50.5313034057617,"y":30.5989627838135},{"x":50.5315895080566,"y":30.59885597229},{"x":50.531909942627,"y":30.5988349914551},{"x":50.5320930480957,"y":30.5988349914551},{"x":50.5322303771973,"y":30.5987434387207},{"x":50.5323257446289,"y":30.5985870361328},{"x":50.5323677062988,"y":30.5984153747559},{"x":50.5323791503906,"y":30.5981636047363},{"x":50.5323143005371,"y":30.5979595184326},{"x":50.5322113037109,"y":30.5976333618164},{"x":50.5320205688477,"y":30.597095489502},{"x":50.5319175720215,"y":30.5968017578125},{"x":50.5318145751953,"y":30.5966186523438},{"x":50.5316848754883,"y":30.5961360931396},{"x":50.5313911437988,"y":30.5952663421631},{"x":50.5308837890625,"y":30.5936851501465}]},{"points":[{"x":50.5309295654297,"y":30.593635559082},{"x":50.5308837890625,"y":30.5936851501465},{"x":50.5306930541992,"y":30.593111038208},{"x":50.530387878418,"y":30.592155456543},{"x":50.5302848815918,"y":30.5917110443115},{"x":50.5301971435547,"y":30.5912380218506},{"x":50.5300788879395,"y":30.5904865264893},{"x":50.5300369262695,"y":30.5898857116699},{"x":50.5300369262695,"y":30.5893707275391},{"x":50.5300483703613,"y":30.5886096954346},{"x":50.5300788879395,"y":30.5880298614502},{"x":50.530143737793,"y":30.5876235961914},{"x":50.5295829772949,"y":30.587194442749},{"x":50.5290870666504,"y":30.5868015289307},{"x":50.5286750793457,"y":30.5865116119385},{"x":50.5283622741699,"y":30.5862445831299}]},{"points":[{"x":50.528377532959,"y":30.5861415863037},{"x":50.5283622741699,"y":30.5862445831299},{"x":50.5279884338379,"y":30.585901260376},{"x":50.5274124145508,"y":30.5853595733643},{"x":50.5271186828613,"y":30.5850639343262},{"x":50.5269393920898,"y":30.5849132537842},{"x":50.5267219543457,"y":30.5848178863525},{"x":50.5264129638672,"y":30.5847053527832},{"x":50.5260887145996,"y":30.5846290588379},{"x":50.5259132385254,"y":30.5846080780029},{"x":50.5257034301758,"y":30.5846290588379},{"x":50.5254859924316,"y":30.5846939086914},{"x":50.5251998901367,"y":30.5848007202148}]},{"points":[{"x":50.5251922607422,"y":30.5847206115723},{"x":50.5251998901367,"y":30.5848007202148},{"x":50.5247039794922,"y":30.5849838256836},{"x":50.5244026184082,"y":30.585075378418},{"x":50.524242401123,"y":30.5851440429688},{"x":50.5239944458008,"y":30.5853214263916},{"x":50.5236320495605,"y":30.585620880127},{"x":50.5233612060547,"y":30.5858478546143},{"x":50.5231552124023,"y":30.5859870910645},{"x":50.5229339599609,"y":30.5860824584961},{"x":50.5227165222168,"y":30.5861473083496},{"x":50.5224723815918,"y":30.5861740112305},{"x":50.5221710205078,"y":30.5861358642578},{"x":50.5217781066895,"y":30.5860404968262},{"x":50.5211791992188,"y":30.5857887268066},{"x":50.520881652832,"y":30.5856761932373}]},{"points":[{"x":50.5208969116211,"y":30.5855731964111},{"x":50.520881652832,"y":30.5856761932373},{"x":50.5203132629395,"y":30.5854930877686},{"x":50.5196113586426,"y":30.5852890014648},{"x":50.518871307373,"y":30.5850315093994},{"x":50.5186958312988,"y":30.5849838256836},{"x":50.5182228088379,"y":30.5849342346191},{"x":50.5176811218262,"y":30.5848388671875},{"x":50.5174446105957,"y":30.5848178863525}]},{"points":[{"x":50.5174522399902,"y":30.5847320556641},{"x":50.5174446105957,"y":30.5848178863525},{"x":50.5166053771973,"y":30.5846824645996},{"x":50.5160064697266,"y":30.5845813751221},{"x":50.5158195495605,"y":30.5845489501953},{"x":50.5156669616699,"y":30.5844955444336},{"x":50.5153541564941,"y":30.5843124389648},{"x":50.5149116516113,"y":30.5839595794678},{"x":50.5141372680664,"y":30.5833148956299},{"x":50.5133285522461,"y":30.5825595855713},{"x":50.5130767822266,"y":30.58229637146},{"x":50.5128059387207,"y":30.581974029541},{"x":50.5127067565918,"y":30.5817813873291},{"x":50.5126037597656,"y":30.5816459655762},{"x":50.5124053955078,"y":30.5814437866211},{"x":50.5120391845703,"y":30.5810947418213},{"x":50.5115814208984,"y":30.5806865692139},{"x":50.5113525390625,"y":30.5812397003174},{"x":50.5107879638672,"y":30.5825958251953},{"x":50.510612487793,"y":30.5830421447754},{"x":50.5103912353516,"y":30.583927154541},{"x":50.5101623535156,"y":30.5851917266846},{"x":50.5099716186523,"y":30.5861263275146},{"x":50.5094985961914,"y":30.5856533050537},{"x":50.5092697143555,"y":30.58544921875},{"x":50.5091247558594,"y":30.5854072570801},{"x":50.5088996887207,"y":30.5853691101074},{"x":50.5086555480957,"y":30.5853328704834},{"x":50.5083923339844,"y":30.5855083465576},{"x":50.5081176757812,"y":30.5849666595459},{"x":50.5079193115234,"y":30.5845756530762},{"x":50.5071830749512,"y":30.5834541320801},{"x":50.5063209533691,"y":30.5821990966797},{"x":50.5056419372559,"y":30.5812129974365},{"x":50.5054397583008,"y":30.5809173583984}]}]}
5	2	c_route_bus	7	{"cityID":2,"routeID":418,"routeType":"c_route_bus","number":"7","timeStart":25200,"timeFinish":69300,"intervalMin":1800,"intervalMax":1800,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4408950805664,"y":30.4901065826416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/д вокзал Центральный"},{"lang_id":"c_en","value":" vokzal Tsentralnyi"},{"lang_id":"c_uk","value":" залізничний вокзал Центральний"}]},{"city_id":0,"location":{"x":50.4452629089355,"y":30.4953575134277,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Саксаганского"},{"lang_id":"c_en","value":" Saksahanskoho St"},{"lang_id":"c_uk","value":" вул. Саксаганського"}]},{"city_id":0,"location":{"x":50.4480056762695,"y":30.4915618896484,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Цирк"},{"lang_id":"c_en","value":" Tsyrk"},{"lang_id":"c_uk","value":" Цирк"}]},{"city_id":0,"location":{"x":50.4514312744141,"y":30.4989566802979,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ортопедический институт"},{"lang_id":"c_en","value":" Ortopedychyi instytut"},{"lang_id":"c_uk","value":" Ортопедичний інститут"}]},{"city_id":0,"location":{"x":50.4526062011719,"y":30.5017738342285,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Центральный рынок"},{"lang_id":"c_en","value":" Tsentralnyi rynok"},{"lang_id":"c_uk","value":" Центральний ринок"}]},{"city_id":0,"location":{"x":50.45439910888672,"y":30.505355834960938,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Львовская площадь"},{"lang_id":"c_en","value":" Lvivska plosha"},{"lang_id":"c_uk","value":" Львівська площа"}]}],"directRelations":[{"points":[{"x":50.4408950805664,"y":30.4901065826416},{"x":50.44091033935547,"y":30.490137100219727},{"x":50.44078826904297,"y":30.49030876159668},{"x":50.440704345703125,"y":30.49042510986328},{"x":50.4406623840332,"y":30.490520477294922},{"x":50.440643310546875,"y":30.490657806396484},{"x":50.440643310546875,"y":30.490787506103516},{"x":50.44075393676758,"y":30.49091339111328},{"x":50.44097900390625,"y":30.491180419921875},{"x":50.4412956237793,"y":30.49155616760254},{"x":50.4415283203125,"y":30.491832733154297},{"x":50.441680908203125,"y":30.492206573486328},{"x":50.441986083984375,"y":30.492897033691406},{"x":50.442264556884766,"y":30.493566513061523},{"x":50.44254684448242,"y":30.494239807128906},{"x":50.442771911621094,"y":30.49477195739746},{"x":50.44284439086914,"y":30.494943618774414},{"x":50.443031311035156,"y":30.495370864868164},{"x":50.44334030151367,"y":30.496078491210938},{"x":50.44371032714844,"y":30.49691390991211},{"x":50.44404983520508,"y":30.496551513671875},{"x":50.44453430175781,"y":30.496030807495117},{"x":50.445098876953125,"y":30.495426177978516},{"x":50.44523239135742,"y":30.495285034179688}]},{"points":[{"x":50.4452629089355,"y":30.4953575134277},{"x":50.44523239135742,"y":30.495285034179688},{"x":50.445579528808594,"y":30.49492835998535},{"x":50.44584655761719,"y":30.494651794433594},{"x":50.4459114074707,"y":30.494606018066406},{"x":50.44611358642578,"y":30.494504928588867},{"x":50.44638442993164,"y":30.49439239501953},{"x":50.446659088134766,"y":30.49428939819336},{"x":50.44719696044922,"y":30.491125106811523},{"x":50.44723129272461,"y":30.490835189819336},{"x":50.447425842285156,"y":30.490915298461914},{"x":50.447776794433594,"y":30.491086959838867},{"x":50.4479866027832,"y":30.491350173950195},{"x":50.44805145263672,"y":30.491519927978516}]},{"points":[{"x":50.4480056762695,"y":30.4915618896484},{"x":50.44805145263672,"y":30.491519927978516},{"x":50.44820022583008,"y":30.491865158081055},{"x":50.44847106933594,"y":30.492664337158203},{"x":50.44853591918945,"y":30.492835998535156},{"x":50.448875427246094,"y":30.493431091308594},{"x":50.4493293762207,"y":30.49421501159668},{"x":50.449832916259766,"y":30.495147705078125},{"x":50.450355529785156,"y":30.496349334716797},{"x":50.45087814331055,"y":30.49755096435547},{"x":50.45147705078125,"y":30.498903274536133}]},{"points":[{"x":50.4514312744141,"y":30.4989566802979},{"x":50.45147705078125,"y":30.498903274536133},{"x":50.451683044433594,"y":30.499418258666992},{"x":50.452205657958984,"y":30.500640869140625},{"x":50.452392578125,"y":30.501113891601562},{"x":50.4526481628418,"y":30.501724243164062}]},{"points":[{"x":50.4526062011719,"y":30.5017738342285},{"x":50.4526481628418,"y":30.501724243164062},{"x":50.45296859741211,"y":30.502492904663086},{"x":50.4535026550293,"y":30.503747940063477},{"x":50.453819274902344,"y":30.504493713378906},{"x":50.45388412475586,"y":30.504634857177734},{"x":50.454185485839844,"y":30.50539207458496},{"x":50.45427322387695,"y":30.505407333374023},{"x":50.454341888427734,"y":30.505401611328125},{"x":50.45439910888672,"y":30.505355834960938}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4538650512695,"y":30.5044288635254,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Львовская площадь"},{"lang_id":"c_en","value":" Lvivska plosha"},{"lang_id":"c_uk","value":" Львівська площа"}]},{"city_id":0,"location":{"x":50.4530220031738,"y":30.5024280548096,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Центральный рынок"},{"lang_id":"c_en","value":" Tsentralnyi rynok"},{"lang_id":"c_uk","value":" Центральний ринок"}]},{"city_id":0,"location":{"x":50.4517250061035,"y":30.4993801116943,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ортопедический институт"},{"lang_id":"c_en","value":" Ortopedychyi instytut"},{"lang_id":"c_uk","value":" Ортопедичний інститут"}]},{"city_id":0,"location":{"x":50.4467582702637,"y":30.4917049407959,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Победы"},{"lang_id":"c_en","value":" Peremogy square"},{"lang_id":"c_uk","value":" площа Перемоги"}]},{"city_id":0,"location":{"x":50.4446258544922,"y":30.4929332733154,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жилянская"},{"lang_id":"c_en","value":" Zhylyanska St"},{"lang_id":"c_uk","value":" вул. Жилянська"}]},{"city_id":0,"location":{"x":50.44091033935547,"y":30.490137100219727,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/д вокзал Центральный"},{"lang_id":"c_en","value":" vokzal Tsentralnyi"},{"lang_id":"c_uk","value":" залізничний вокзал Центральний"}]}],"reverseRelations":[{"points":[{"x":50.4538650512695,"y":30.5044288635254},{"x":50.453819274902344,"y":30.504493713378906},{"x":50.4535026550293,"y":30.503747940063477},{"x":50.45296859741211,"y":30.502492904663086}]},{"points":[{"x":50.4530220031738,"y":30.5024280548096},{"x":50.45296859741211,"y":30.502492904663086},{"x":50.4526481628418,"y":30.501724243164062},{"x":50.452392578125,"y":30.501113891601562},{"x":50.452205657958984,"y":30.500640869140625},{"x":50.451683044433594,"y":30.499418258666992}]},{"points":[{"x":50.4517250061035,"y":30.4993801116943},{"x":50.451683044433594,"y":30.499418258666992},{"x":50.45147705078125,"y":30.498903274536133},{"x":50.45087814331055,"y":30.49755096435547},{"x":50.450355529785156,"y":30.496349334716797},{"x":50.449832916259766,"y":30.495147705078125},{"x":50.4493293762207,"y":30.49421501159668},{"x":50.448875427246094,"y":30.493431091308594},{"x":50.44853591918945,"y":30.492835998535156},{"x":50.44847106933594,"y":30.492664337158203},{"x":50.44820022583008,"y":30.491865158081055},{"x":50.44805145263672,"y":30.491519927978516},{"x":50.4479866027832,"y":30.491350173950195},{"x":50.447776794433594,"y":30.491086959838867},{"x":50.447425842285156,"y":30.490915298461914},{"x":50.44723129272461,"y":30.490835189819336},{"x":50.44694900512695,"y":30.490747451782227},{"x":50.44680404663086,"y":30.49171257019043}]},{"points":[{"x":50.4467582702637,"y":30.4917049407959},{"x":50.44680404663086,"y":30.49171257019043},{"x":50.446590423583984,"y":30.493064880371094},{"x":50.446434020996094,"y":30.49404525756836},{"x":50.44633865356445,"y":30.494068145751953},{"x":50.4461784362793,"y":30.494077682495117},{"x":50.44602584838867,"y":30.494035720825195},{"x":50.445858001708984,"y":30.493932723999023},{"x":50.44559860229492,"y":30.493467330932617},{"x":50.445125579833984,"y":30.492523193359375},{"x":50.44465255737305,"y":30.493026733398438}]},{"points":[{"x":50.4446258544922,"y":30.4929332733154},{"x":50.44465255737305,"y":30.493026733398438},{"x":50.44395446777344,"y":30.49376106262207},{"x":50.44284439086914,"y":30.494943618774414},{"x":50.442771911621094,"y":30.49477195739746},{"x":50.44254684448242,"y":30.494239807128906},{"x":50.442264556884766,"y":30.493566513061523},{"x":50.441986083984375,"y":30.492897033691406},{"x":50.441680908203125,"y":30.492206573486328},{"x":50.4415283203125,"y":30.491832733154297},{"x":50.441436767578125,"y":30.49106788635254},{"x":50.44135284423828,"y":30.490371704101562},{"x":50.4412727355957,"y":30.49004364013672},{"x":50.441200256347656,"y":30.489952087402344},{"x":50.44109344482422,"y":30.489925384521484},{"x":50.4410285949707,"y":30.489974975585938},{"x":50.44091033935547,"y":30.490137100219727}]}]}
6	2	c_route_bus	9	{"cityID":2,"routeID":226,"routeType":"c_route_bus","number":"9","timeStart":21180,"timeFinish":68880,"intervalMin":2940,"intervalMax":2940,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4118347167969,"y":30.4089126586914,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4104881286621,"y":30.4043102264404,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Детский сад"},{"lang_id":"c_en","value":" Dytyachyi sadok"},{"lang_id":"c_uk","value":" Дитячий садок"}]},{"city_id":0,"location":{"x":50.4096374511719,"y":30.3998470306396,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4121170043945,"y":30.3966865539551,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Григоровича-Барского"},{"lang_id":"c_en","value":" Hryhorovycha-Barskoho St"},{"lang_id":"c_uk","value":" вул. Григоровича-Барського"}]},{"city_id":0,"location":{"x":50.4147491455078,"y":30.3951263427734,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жолудева"},{"lang_id":"c_en","value":" Zholudeva St"},{"lang_id":"c_uk","value":" вул. Жолудєва"}]},{"city_id":0,"location":{"x":50.4176635742188,"y":30.388801574707,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Кольцова"},{"lang_id":"c_en","value":" Koltsova Blvd"},{"lang_id":"c_uk","value":" бул. Кольцова"}]},{"city_id":0,"location":{"x":50.420337677002,"y":30.3818225860596,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом быта"},{"lang_id":"c_en","value":" Budynok pobutu"},{"lang_id":"c_uk","value":" Будинок побуту"}]},{"city_id":0,"location":{"x":50.422721862793,"y":30.3779811859131,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" школа №131"},{"lang_id":"c_en","value":" shkola 131"},{"lang_id":"c_uk","value":" школа №131"}]},{"city_id":0,"location":{"x":50.4266624450684,"y":30.3753414154053,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульвар Кольцова"},{"lang_id":"c_en","value":" Koltsova Blvd"},{"lang_id":"c_uk","value":" бульвар Кольцова"}]},{"city_id":0,"location":{"x":50.4280166625977,"y":30.3807392120361,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Владимира Ульянова"},{"lang_id":"c_en","value":" Volodymyra Ulyanova St"},{"lang_id":"c_uk","value":" вул. Володимира Ул\\u0027янова"}]},{"city_id":0,"location":{"x":50.4297714233398,"y":30.3874549865723,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Лейпциг"},{"lang_id":"c_en","value":" kinoteatr Leyptsyg"},{"lang_id":"c_uk","value":" кінотеатр Лейпциг"}]},{"city_id":0,"location":{"x":50.4310531616211,"y":30.3925342559814,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Академика Королева"},{"lang_id":"c_en","value":" Akademika Korolova St"},{"lang_id":"c_uk","value":" вул. Академіка Корольова"}]},{"city_id":0,"location":{"x":50.4341087341309,"y":30.4044322967529,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" станция Борщаговка"},{"lang_id":"c_en","value":" stantsiya Borshagivka"},{"lang_id":"c_uk","value":" станція Борщагівка"}]},{"city_id":0,"location":{"x":50.4376068115234,"y":30.410285949707,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Лепсе"},{"lang_id":"c_en","value":" Lepse Blvd"},{"lang_id":"c_uk","value":" бул. Лепсе"}]},{"city_id":0,"location":{"x":50.4397125244141,"y":30.4088478088379,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Василия Чумака"},{"lang_id":"c_en","value":" Vasylya Chumaka St"},{"lang_id":"c_uk","value":" вул. Василя Чумака"}]},{"city_id":0,"location":{"x":50.4439163208008,"y":30.4101257324219,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 6-й КАРЗ"},{"lang_id":"c_en","value":" Karz"},{"lang_id":"c_uk","value":" 6-й КАРЗ"}]},{"city_id":0,"location":{"x":50.4449768066406,"y":30.4140625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Героев Севастополя"},{"lang_id":"c_en","value":" Heroiv Sevastopolya St"},{"lang_id":"c_uk","value":" вул. Героїв Севастополя"}]},{"city_id":0,"location":{"x":50.4471130371094,"y":30.4203224182129,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Василенко"},{"lang_id":"c_en","value":" Mykoly Vasylenka St"},{"lang_id":"c_uk","value":" вул. Миколи Василенка"}]},{"city_id":0,"location":{"x":50.4504051208496,"y":30.4182472229004,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Фабрика ремонта обуви"},{"lang_id":"c_en","value":" Fabryka remontu vzuttya"},{"lang_id":"c_uk","value":" Фабрика ремонту взуття"}]},{"city_id":0,"location":{"x":50.4545135498047,"y":30.417501449585,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Козелецкая"},{"lang_id":"c_en","value":" Kozeletska St"},{"lang_id":"c_uk","value":" вул. Козелецька"}]},{"city_id":0,"location":{"x":50.4579124450684,"y":30.4200878143311,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Берестейская"},{"lang_id":"c_en","value":" Beresteyska"},{"lang_id":"c_uk","value":" ст. м. Берестейська"}]},{"city_id":0,"location":{"x":50.4606132507324,"y":30.4294261932373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Шпака"},{"lang_id":"c_en","value":" Mykoly Shpaka St"},{"lang_id":"c_uk","value":" вул. Миколи Шпака"}]},{"city_id":0,"location":{"x":50.4620170593262,"y":30.4367637634277,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ивана Шевцова"},{"lang_id":"c_en","value":" Ivana Shevtsova St"},{"lang_id":"c_uk","value":" вул. Івана Шевцова"}]},{"city_id":0,"location":{"x":50.4626159667969,"y":30.442289352417,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт Газа"},{"lang_id":"c_en","value":" Instytut Hazu"},{"lang_id":"c_uk","value":" Інститут Газу"}]},{"city_id":0,"location":{"x":50.4628829956055,"y":30.4512748718262,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Елены Телиги"},{"lang_id":"c_en","value":" Oleny Telihy St"},{"lang_id":"c_uk","value":" вул. Олени Теліги"}]},{"city_id":0,"location":{"x":50.4629707336426,"y":30.4553413391113,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Больница"},{"lang_id":"c_en","value":" Likarnya"},{"lang_id":"c_uk","value":" Лікарня"}]},{"city_id":0,"location":{"x":50.4629592895508,"y":30.460319519043,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Хлебокомбинат"},{"lang_id":"c_en","value":" Khlibokombinat"},{"lang_id":"c_uk","value":" Хлібокомбінат"}]},{"city_id":0,"location":{"x":50.4624824523926,"y":30.4653034210205,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Зоологическая"},{"lang_id":"c_en","value":" Zoolohichna St"},{"lang_id":"c_uk","value":" вул. Зоологічна"}]},{"city_id":0,"location":{"x":50.4622001647949,"y":30.4739322662354,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Довнар-Запольского"},{"lang_id":"c_en","value":" Dovnar-Zapolskoho St"},{"lang_id":"c_uk","value":" вул. Довнар-Запольского"}]},{"city_id":0,"location":{"x":50.4639129638672,"y":30.4749641418457,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Довнар-Запольского"},{"lang_id":"c_en","value":" Dovnar-Zapolskoho St"},{"lang_id":"c_uk","value":" вул. Довнар-Запольского"}]},{"city_id":0,"location":{"x":50.4618911743164,"y":30.4804611206055,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Лукьяновская"},{"lang_id":"c_en","value":" plosha Lukyanivska"},{"lang_id":"c_uk","value":" площа Лук\\u0027янівська"}]}],"directRelations":[{"points":[{"x":50.4118347167969,"y":30.4089126586914},{"x":50.4117965698242,"y":30.408971786499},{"x":50.4112892150879,"y":30.4081726074219},{"x":50.4110794067383,"y":30.4078559875488},{"x":50.4109268188477,"y":30.4076251983643},{"x":50.4108390808105,"y":30.4074058532715},{"x":50.4106903076172,"y":30.4069766998291},{"x":50.4106559753418,"y":30.4067344665527},{"x":50.4105339050293,"y":30.4054412841797},{"x":50.4104804992676,"y":30.4049472808838},{"x":50.4104347229004,"y":30.4043159484863}]},{"points":[{"x":50.4104881286621,"y":30.4043102264404},{"x":50.4104347229004,"y":30.4043159484863},{"x":50.410343170166,"y":30.4029102325439},{"x":50.4102935791016,"y":30.4025173187256},{"x":50.4102058410645,"y":30.4020023345947},{"x":50.4101295471191,"y":30.4017448425293},{"x":50.4100151062012,"y":30.4015140533447},{"x":50.4097061157227,"y":30.4011402130127},{"x":50.4092330932617,"y":30.4005489349365},{"x":50.4096031188965,"y":30.399787902832}]},{"points":[{"x":50.4096374511719,"y":30.3998470306396},{"x":50.4096031188965,"y":30.399787902832},{"x":50.4101409912109,"y":30.3988170623779},{"x":50.4106826782227,"y":30.3980770111084},{"x":50.4113616943359,"y":30.3972549438477},{"x":50.4115524291992,"y":30.3970623016357},{"x":50.4121017456055,"y":30.3966217041016}]},{"points":[{"x":50.4121170043945,"y":30.3966865539551},{"x":50.4121017456055,"y":30.3966217041016},{"x":50.4123039245605,"y":30.3964557647705},{"x":50.4126586914062,"y":30.3962249755859},{"x":50.4130210876465,"y":30.3959999084473},{"x":50.4135360717773,"y":30.3957424163818},{"x":50.4140357971191,"y":30.3954963684082},{"x":50.4143867492676,"y":30.3952980041504},{"x":50.4146423339844,"y":30.3951263427734},{"x":50.4147338867188,"y":30.3950500488281}]},{"points":[{"x":50.4147491455078,"y":30.3951263427734},{"x":50.4147338867188,"y":30.3950500488281},{"x":50.4149742126465,"y":30.394847869873},{"x":50.4151954650879,"y":30.3946056365967},{"x":50.4153518676758,"y":30.3944225311279},{"x":50.4155158996582,"y":30.3941764831543},{"x":50.4156951904297,"y":30.3938655853271},{"x":50.4158821105957,"y":30.3934688568115},{"x":50.4160232543945,"y":30.393087387085},{"x":50.416187286377,"y":30.3924922943115},{"x":50.416431427002,"y":30.3915042877197},{"x":50.4165229797363,"y":30.3911457061768},{"x":50.4167556762695,"y":30.3902931213379},{"x":50.4170722961426,"y":30.3904914855957},{"x":50.4172401428223,"y":30.3905773162842},{"x":50.4173965454102,"y":30.3905277252197},{"x":50.417537689209,"y":30.3904209136963},{"x":50.4176254272461,"y":30.3902435302734},{"x":50.4177894592285,"y":30.3895740509033},{"x":50.4178009033203,"y":30.3892517089844},{"x":50.417724609375,"y":30.3889617919922},{"x":50.4176368713379,"y":30.3888759613037}]},{"points":[{"x":50.4176635742188,"y":30.388801574707},{"x":50.4176368713379,"y":30.3888759613037},{"x":50.4170989990234,"y":30.3884468078613},{"x":50.417667388916,"y":30.3872089385986},{"x":50.4179992675781,"y":30.3864898681641},{"x":50.4185791015625,"y":30.3852291107178},{"x":50.419116973877,"y":30.3840484619141},{"x":50.4193496704102,"y":30.3835391998291},{"x":50.4196586608887,"y":30.3829479217529},{"x":50.4200782775879,"y":30.3821487426758},{"x":50.4203033447266,"y":30.3817691802979}]},{"points":[{"x":50.420337677002,"y":30.3818225860596},{"x":50.4203033447266,"y":30.3817691802979},{"x":50.421215057373,"y":30.3802871704102},{"x":50.4221000671387,"y":30.3788776397705},{"x":50.4226875305176,"y":30.3779392242432}]},{"points":[{"x":50.422721862793,"y":30.3779811859131},{"x":50.4226875305176,"y":30.3779392242432},{"x":50.4230880737305,"y":30.3773212432861},{"x":50.423957824707,"y":30.3760719299316},{"x":50.4241333007812,"y":30.3758087158203},{"x":50.4249992370605,"y":30.3749389648438},{"x":50.4253425598145,"y":30.3745956420898},{"x":50.425537109375,"y":30.3744678497314},{"x":50.4258155822754,"y":30.3743495941162},{"x":50.4259643554688,"y":30.3743286132812},{"x":50.4261054992676,"y":30.374361038208},{"x":50.4266014099121,"y":30.3749294281006},{"x":50.4266967773438,"y":30.3753204345703}]},{"points":[{"x":50.4266624450684,"y":30.3753414154053},{"x":50.4266967773438,"y":30.3753204345703},{"x":50.427433013916,"y":30.3782329559326},{"x":50.4280624389648,"y":30.3807163238525}]},{"points":[{"x":50.4280166625977,"y":30.3807392120361},{"x":50.4280624389648,"y":30.3807163238525},{"x":50.4287033081055,"y":30.3832111358643},{"x":50.4288902282715,"y":30.3839302062988},{"x":50.4289512634277,"y":30.3842468261719},{"x":50.428955078125,"y":30.3844890594482},{"x":50.4289131164551,"y":30.3847942352295},{"x":50.4288597106934,"y":30.3850517272949},{"x":50.4288597106934,"y":30.3852977752686},{"x":50.4289054870605,"y":30.3854923248291},{"x":50.4290046691895,"y":30.3857326507568},{"x":50.4291191101074,"y":30.3859100341797},{"x":50.4291648864746,"y":30.3859252929688},{"x":50.4292602539062,"y":30.3859691619873},{"x":50.4293899536133,"y":30.3861198425293},{"x":50.429500579834,"y":30.3863124847412},{"x":50.4295997619629,"y":30.3866291046143},{"x":50.4297027587891,"y":30.3869934082031},{"x":50.4298133850098,"y":30.3874340057373}]},{"points":[{"x":50.4297714233398,"y":30.3874549865723},{"x":50.4298133850098,"y":30.3874340057373},{"x":50.4300956726074,"y":30.3885593414307},{"x":50.4303665161133,"y":30.3896217346191},{"x":50.4306793212891,"y":30.3908882141113},{"x":50.431095123291,"y":30.3925075531006}]},{"points":[{"x":50.4310531616211,"y":30.3925342559814},{"x":50.431095123291,"y":30.3925075531006},{"x":50.4314804077148,"y":30.394063949585},{"x":50.4318008422852,"y":30.3953189849854},{"x":50.4320945739746,"y":30.3964786529541},{"x":50.4324035644531,"y":30.3977222442627},{"x":50.4328193664551,"y":30.3993530273438},{"x":50.4333229064941,"y":30.4013061523438},{"x":50.4337005615234,"y":30.4027328491211},{"x":50.4340591430664,"y":30.4040470123291},{"x":50.4341506958008,"y":30.404411315918}]},{"points":[{"x":50.4341087341309,"y":30.4044322967529},{"x":50.4341506958008,"y":30.404411315918},{"x":50.4345855712891,"y":30.4060325622559},{"x":50.4350090026855,"y":30.4077053070068},{"x":50.4353904724121,"y":30.4092388153076},{"x":50.4356307983398,"y":30.4101734161377},{"x":50.4356117248535,"y":30.4103717803955},{"x":50.4355545043945,"y":30.4106178283691},{"x":50.4354782104492,"y":30.4108333587646},{"x":50.4352912902832,"y":30.4110584259033},{"x":50.4349975585938,"y":30.4112091064453},{"x":50.4345016479492,"y":30.4115467071533},{"x":50.4342613220215,"y":30.411792755127},{"x":50.4339447021484,"y":30.4119644165039},{"x":50.4338531494141,"y":30.4120674133301},{"x":50.4338455200195,"y":30.4122161865234},{"x":50.4338645935059,"y":30.4123611450195},{"x":50.4339637756348,"y":30.4124374389648},{"x":50.4340667724609,"y":30.4124374389648},{"x":50.4343070983887,"y":30.412281036377},{"x":50.4345397949219,"y":30.412088394165},{"x":50.4347648620605,"y":30.4119110107422},{"x":50.4354209899902,"y":30.4115028381348},{"x":50.4359016418457,"y":30.4112033843994},{"x":50.4361419677734,"y":30.4110412597656},{"x":50.4370231628418,"y":30.4104995727539},{"x":50.4373970031738,"y":30.4102649688721},{"x":50.4375915527344,"y":30.4101886749268}]},{"points":[{"x":50.4376068115234,"y":30.410285949707},{"x":50.4375915527344,"y":30.4101886749268},{"x":50.437816619873,"y":30.4100399017334},{"x":50.4379730224609,"y":30.4098834991455},{"x":50.4381065368652,"y":30.4097595214844},{"x":50.4386177062988,"y":30.4094429016113},{"x":50.4397010803223,"y":30.4087677001953}]},{"points":[{"x":50.4397125244141,"y":30.4088478088379},{"x":50.4397010803223,"y":30.4087677001953},{"x":50.440242767334,"y":30.4084300994873},{"x":50.440616607666,"y":30.4082145690918},{"x":50.4407806396484,"y":30.4081344604492},{"x":50.4410629272461,"y":30.4080600738525},{"x":50.4413452148438,"y":30.4080104827881},{"x":50.441722869873,"y":30.4080104827881},{"x":50.4419555664062,"y":30.4080543518066},{"x":50.442253112793,"y":30.408145904541},{"x":50.4425888061523,"y":30.4083271026611},{"x":50.4429321289062,"y":30.4085903167725},{"x":50.4432563781738,"y":30.4089279174805},{"x":50.4436225891113,"y":30.4094429016113},{"x":50.4438743591309,"y":30.4099159240723},{"x":50.4439582824707,"y":30.4100818634033}]},{"points":[{"x":50.4439163208008,"y":30.4101257324219},{"x":50.4439582824707,"y":30.4100818634033},{"x":50.4440574645996,"y":30.4103393554688},{"x":50.4444198608398,"y":30.4117183685303},{"x":50.445011138916,"y":30.4140357971191}]},{"points":[{"x":50.4449768066406,"y":30.4140625},{"x":50.445011138916,"y":30.4140357971191},{"x":50.4451065063477,"y":30.414379119873},{"x":50.4454345703125,"y":30.4156494140625},{"x":50.4461250305176,"y":30.4182949066162},{"x":50.4467010498047,"y":30.4205150604248},{"x":50.4468727111816,"y":30.4204025268555},{"x":50.4471015930176,"y":30.4202575683594}]},{"points":[{"x":50.4471130371094,"y":30.4203224182129},{"x":50.4471015930176,"y":30.4202575683594},{"x":50.4482002258301,"y":30.4195671081543},{"x":50.4494552612305,"y":30.4187660217285},{"x":50.4499282836914,"y":30.4184722900391},{"x":50.4503936767578,"y":30.4181823730469}]},{"points":[{"x":50.4504051208496,"y":30.4182472229004},{"x":50.4503936767578,"y":30.4181823730469},{"x":50.4511604309082,"y":30.4176998138428},{"x":50.4515228271484,"y":30.417501449585},{"x":50.451789855957,"y":30.4174098968506},{"x":50.4520568847656,"y":30.4173564910889},{"x":50.4524688720703,"y":30.4173393249512},{"x":50.4532279968262,"y":30.4173927307129},{"x":50.4541931152344,"y":30.4174480438232},{"x":50.454517364502,"y":30.4174423217773}]},{"points":[{"x":50.4545135498047,"y":30.417501449585},{"x":50.454517364502,"y":30.4174423217773},{"x":50.455451965332,"y":30.4174365997314},{"x":50.4558868408203,"y":30.4174480438232},{"x":50.4560890197754,"y":30.4174747467041},{"x":50.4562911987305,"y":30.417537689209},{"x":50.4564437866211,"y":30.4176025390625},{"x":50.4571914672852,"y":30.4185199737549},{"x":50.4574813842773,"y":30.4189929962158},{"x":50.4577560424805,"y":30.4195442199707},{"x":50.4579734802246,"y":30.4200172424316}]},{"points":[{"x":50.4579124450684,"y":30.4200878143311},{"x":50.4579734802246,"y":30.4200172424316},{"x":50.4580764770508,"y":30.4202747344971},{"x":50.4582557678223,"y":30.4207897186279},{"x":50.458309173584,"y":30.4209976196289},{"x":50.458366394043,"y":30.421215057373},{"x":50.4584846496582,"y":30.4218063354492},{"x":50.4587669372559,"y":30.4228134155273},{"x":50.4591598510742,"y":30.4242153167725},{"x":50.4595718383789,"y":30.4256954193115},{"x":50.4600410461426,"y":30.427417755127},{"x":50.460205078125,"y":30.4278736114502},{"x":50.4604911804199,"y":30.4288444519043},{"x":50.4606513977051,"y":30.4293956756592}]},{"points":[{"x":50.4606132507324,"y":30.4294261932373},{"x":50.4606513977051,"y":30.4293956756592},{"x":50.4612236022949,"y":30.4313335418701},{"x":50.4613761901855,"y":30.43186378479},{"x":50.461540222168,"y":30.4325675964355},{"x":50.4616355895996,"y":30.4331130981445},{"x":50.4616851806641,"y":30.4334087371826},{"x":50.4618492126465,"y":30.4349708557129},{"x":50.4620170593262,"y":30.4363708496094},{"x":50.4620628356934,"y":30.4367561340332}]},{"points":[{"x":50.4620170593262,"y":30.4367637634277},{"x":50.4620628356934,"y":30.4367561340332},{"x":50.4623031616211,"y":30.438928604126},{"x":50.4625244140625,"y":30.4410057067871},{"x":50.4626617431641,"y":30.4422702789307}]},{"points":[{"x":50.4626159667969,"y":30.442289352417},{"x":50.4626617431641,"y":30.4422702789307},{"x":50.4627075195312,"y":30.442699432373},{"x":50.4627685546875,"y":30.4442081451416},{"x":50.4627952575684,"y":30.4451465606689},{"x":50.4628677368164,"y":30.4473781585693},{"x":50.4629287719727,"y":30.4501075744629},{"x":50.4629287719727,"y":30.4512786865234}]},{"points":[{"x":50.4628829956055,"y":30.4512748718262},{"x":50.4629287719727,"y":30.4512786865234},{"x":50.462963104248,"y":30.45334815979},{"x":50.4629898071289,"y":30.4543838500977},{"x":50.4630126953125,"y":30.4553337097168}]},{"points":[{"x":50.4629707336426,"y":30.4553413391113},{"x":50.4630126953125,"y":30.4553337097168},{"x":50.4630470275879,"y":30.4575805664062},{"x":50.463062286377,"y":30.4588317871094},{"x":50.4630432128906,"y":30.4594688415527},{"x":50.4630012512207,"y":30.4603328704834}]},{"points":[{"x":50.4629592895508,"y":30.460319519043},{"x":50.4630012512207,"y":30.4603328704834},{"x":50.4628944396973,"y":30.4617538452148},{"x":50.4626693725586,"y":30.4637985229492},{"x":50.4625244140625,"y":30.465311050415}]},{"points":[{"x":50.4624824523926,"y":30.4653034210205},{"x":50.4625244140625,"y":30.465311050415},{"x":50.4624557495117,"y":30.4661426544189},{"x":50.4623413085938,"y":30.4673557281494},{"x":50.462230682373,"y":30.4695014953613},{"x":50.4621238708496,"y":30.471549987793},{"x":50.4620208740234,"y":30.473503112793},{"x":50.4620018005371,"y":30.4738235473633},{"x":50.4622039794922,"y":30.4738597869873}]},{"points":[{"x":50.4622001647949,"y":30.4739322662354},{"x":50.4622039794922,"y":30.4738597869873},{"x":50.4636154174805,"y":30.4740581512451},{"x":50.4640426635742,"y":30.4741382598877},{"x":50.4641723632812,"y":30.474250793457},{"x":50.4639511108398,"y":30.4749965667725}]},{"points":[{"x":50.4639129638672,"y":30.4749641418457},{"x":50.4639511108398,"y":30.4749965667725},{"x":50.4633560180664,"y":30.4770355224609},{"x":50.4628639221191,"y":30.4787082672119},{"x":50.4627990722656,"y":30.4788761138916},{"x":50.462345123291,"y":30.4798240661621},{"x":50.4621620178223,"y":30.4802303314209},{"x":50.4620819091797,"y":30.4801979064941},{"x":50.4619903564453,"y":30.4801921844482},{"x":50.4619064331055,"y":30.4802665710449},{"x":50.4618797302246,"y":30.4803695678711},{"x":50.4618911743164,"y":30.4804611206055}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4618530273438,"y":30.4804840087891,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Лукьяновская"},{"lang_id":"c_en","value":" plosha Lukyanivska"},{"lang_id":"c_uk","value":" площа Лук\\u0027янівська"}]},{"city_id":0,"location":{"x":50.4620819091797,"y":30.4734973907471,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Довнар-Запольского"},{"lang_id":"c_en","value":" Dovnar-Zapolskoho St"},{"lang_id":"c_uk","value":" вул. Довнар-Запольского"}]},{"city_id":0,"location":{"x":50.4625015258789,"y":30.4661560058594,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Зоологическая"},{"lang_id":"c_en","value":" Zoolohichna St"},{"lang_id":"c_uk","value":" вул. Зоологічна"}]},{"city_id":0,"location":{"x":50.4630889892578,"y":30.4594879150391,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Хлебокомбинат"},{"lang_id":"c_en","value":" Khlibokombinat"},{"lang_id":"c_uk","value":" Хлібокомбінат"}]},{"city_id":0,"location":{"x":50.4630393981934,"y":30.4543762207031,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Больница"},{"lang_id":"c_en","value":" Likarnya"},{"lang_id":"c_uk","value":" Лікарня"}]},{"city_id":0,"location":{"x":50.4629745483398,"y":30.4512691497803,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Елены Телиги"},{"lang_id":"c_en","value":" Oleny Telihy St"},{"lang_id":"c_uk","value":" вул. Олени Теліги"}]},{"city_id":0,"location":{"x":50.4627151489258,"y":30.442253112793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт Газа"},{"lang_id":"c_en","value":" Instytut Hazu"},{"lang_id":"c_uk","value":" Інститут Газу"}]},{"city_id":0,"location":{"x":50.4620666503906,"y":30.436351776123,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ивана Шевцова"},{"lang_id":"c_en","value":" Ivana Shevtsova St"},{"lang_id":"c_uk","value":" вул. Івана Шевцова"}]},{"city_id":0,"location":{"x":50.4605407714844,"y":30.4288082122803,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Шпака"},{"lang_id":"c_en","value":" Mykoly Shpaka St"},{"lang_id":"c_uk","value":" вул. Миколи Шпака"}]},{"city_id":0,"location":{"x":50.4580268859863,"y":30.4199409484863,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Берестейская"},{"lang_id":"c_en","value":" Beresteyska"},{"lang_id":"c_uk","value":" ст. м. Берестейська"}]},{"city_id":0,"location":{"x":50.4541893005371,"y":30.4173774719238,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Козелецкая"},{"lang_id":"c_en","value":" Kozeletska St"},{"lang_id":"c_uk","value":" вул. Козелецька"}]},{"city_id":0,"location":{"x":50.4499130249023,"y":30.4183959960938,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Фабрика ремонта обуви"},{"lang_id":"c_en","value":" Fabryka remontu vzuttya"},{"lang_id":"c_uk","value":" Фабрика ремонту взуття"}]},{"city_id":0,"location":{"x":50.4470863342285,"y":30.4201946258545,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Василенко"},{"lang_id":"c_en","value":" Mykoly Vasylenka St"},{"lang_id":"c_uk","value":" вул. Миколи Василенка"}]},{"city_id":0,"location":{"x":50.4451560974121,"y":30.4136714935303,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Героев Севастополя"},{"lang_id":"c_en","value":" Heroiv Sevastopolya St"},{"lang_id":"c_uk","value":" вул. Героїв Севастополя"}]},{"city_id":0,"location":{"x":50.444450378418,"y":30.410816192627,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 6-й КАРЗ"},{"lang_id":"c_en","value":" Karz"},{"lang_id":"c_uk","value":" 6-й КАРЗ"}]},{"city_id":0,"location":{"x":50.4394302368164,"y":30.4085521697998,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Василия Чумака"},{"lang_id":"c_en","value":" Vasylya Chumaka St"},{"lang_id":"c_uk","value":" вул. Василя Чумака"}]},{"city_id":0,"location":{"x":50.4366340637207,"y":30.410135269165,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" рынок Отрадный"},{"lang_id":"c_en","value":" rynok Otradnyi"},{"lang_id":"c_uk","value":" ринок Отрадний"}]},{"city_id":0,"location":{"x":50.433235168457,"y":30.3997554779053,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" станция Борщаговка"},{"lang_id":"c_en","value":" stantsiya Borshagivka"},{"lang_id":"c_uk","value":" станція Борщагівка"}]},{"city_id":0,"location":{"x":50.4318771362305,"y":30.3944225311279,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Василия Верховинца"},{"lang_id":"c_en","value":" Vasylya Verhovyntsya St"},{"lang_id":"c_uk","value":" вул. Василя Верховинця"}]},{"city_id":0,"location":{"x":50.4305686950684,"y":30.3892135620117,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Лейпциг"},{"lang_id":"c_en","value":" kinoteatr Leyptsyg"},{"lang_id":"c_uk","value":" кінотеатр Лейпциг"}]},{"city_id":0,"location":{"x":50.4257888793945,"y":30.3843269348145,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Генерала Потапова"},{"lang_id":"c_en","value":" Henerala Potapova St"},{"lang_id":"c_uk","value":" вул. Генерала Потапова"}]},{"city_id":0,"location":{"x":50.4200401306152,"y":30.3820953369141,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом быта"},{"lang_id":"c_en","value":" Budynok pobutu"},{"lang_id":"c_uk","value":" Будинок побуту"}]},{"city_id":0,"location":{"x":50.4176292419434,"y":30.3871650695801,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Семьи Сосниных"},{"lang_id":"c_en","value":" Simyi Sosninykh"},{"lang_id":"c_uk","value":" вул. Сім\\u0027ї Сосніних"}]},{"city_id":0,"location":{"x":50.4142723083496,"y":30.3948097229004,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жолудева"},{"lang_id":"c_en","value":" Zholudeva St"},{"lang_id":"c_uk","value":" вул. Жолудєва"}]},{"city_id":0,"location":{"x":50.4106407165527,"y":30.3974323272705,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Григоровича-Барского"},{"lang_id":"c_en","value":" Hryhorovycha-Barskoho St"},{"lang_id":"c_uk","value":" вул. Григоровича-Барського"}]},{"city_id":0,"location":{"x":50.408504486084,"y":30.401273727417,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4096717834473,"y":30.4012203216553,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4104347229004,"y":30.4049644470215,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Детский сад"},{"lang_id":"c_en","value":" Dytyachyi sadok"},{"lang_id":"c_uk","value":" Дитячий садок"}]},{"city_id":0,"location":{"x":50.4119529724121,"y":30.4092178344727,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]}],"reverseRelations":[{"points":[{"x":50.4618530273438,"y":30.4804840087891},{"x":50.4618911743164,"y":30.4804611206055},{"x":50.4619178771973,"y":30.480562210083},{"x":50.4619750976562,"y":30.4806365966797},{"x":50.461841583252,"y":30.4809112548828},{"x":50.4616279602051,"y":30.4808254241943},{"x":50.4616470336914,"y":30.4805088043213},{"x":50.4616584777832,"y":30.4802722930908},{"x":50.4618453979492,"y":30.4769191741943},{"x":50.4619750976562,"y":30.4744033813477},{"x":50.4620208740234,"y":30.473503112793}]},{"points":[{"x":50.4620819091797,"y":30.4734973907471},{"x":50.4620208740234,"y":30.473503112793},{"x":50.4621238708496,"y":30.471549987793},{"x":50.462230682373,"y":30.4695014953613},{"x":50.4623413085938,"y":30.4673557281494},{"x":50.4624557495117,"y":30.4661426544189}]},{"points":[{"x":50.4625015258789,"y":30.4661560058594},{"x":50.4624557495117,"y":30.4661426544189},{"x":50.4625244140625,"y":30.465311050415},{"x":50.4626693725586,"y":30.4637985229492},{"x":50.4628944396973,"y":30.4617538452148},{"x":50.4630012512207,"y":30.4603328704834},{"x":50.4630432128906,"y":30.4594688415527}]},{"points":[{"x":50.4630889892578,"y":30.4594879150391},{"x":50.4630432128906,"y":30.4594688415527},{"x":50.463062286377,"y":30.4588317871094},{"x":50.4630470275879,"y":30.4575805664062},{"x":50.4630126953125,"y":30.4553337097168},{"x":50.4629898071289,"y":30.4543838500977}]},{"points":[{"x":50.4630393981934,"y":30.4543762207031},{"x":50.4629898071289,"y":30.4543838500977},{"x":50.462963104248,"y":30.45334815979},{"x":50.4629287719727,"y":30.4512786865234}]},{"points":[{"x":50.4629745483398,"y":30.4512691497803},{"x":50.4629287719727,"y":30.4512786865234},{"x":50.4629287719727,"y":30.4501075744629},{"x":50.4630584716797,"y":30.4491634368896},{"x":50.4630126953125,"y":30.4480476379395},{"x":50.462947845459,"y":30.4458446502686},{"x":50.4629249572754,"y":30.4450874328613},{"x":50.4627685546875,"y":30.4442081451416},{"x":50.4627075195312,"y":30.442699432373},{"x":50.4626617431641,"y":30.4422702789307}]},{"points":[{"x":50.4627151489258,"y":30.442253112793},{"x":50.4626617431641,"y":30.4422702789307},{"x":50.4625244140625,"y":30.4410057067871},{"x":50.4623031616211,"y":30.438928604126},{"x":50.4620628356934,"y":30.4367561340332},{"x":50.4620170593262,"y":30.4363708496094}]},{"points":[{"x":50.4620666503906,"y":30.436351776123},{"x":50.4620170593262,"y":30.4363708496094},{"x":50.4618492126465,"y":30.4349708557129},{"x":50.4616851806641,"y":30.4334087371826},{"x":50.4616355895996,"y":30.4331130981445},{"x":50.461540222168,"y":30.4325675964355},{"x":50.4613761901855,"y":30.43186378479},{"x":50.4612236022949,"y":30.4313335418701},{"x":50.4606513977051,"y":30.4293956756592},{"x":50.4604911804199,"y":30.4288444519043}]},{"points":[{"x":50.4605407714844,"y":30.4288082122803},{"x":50.4604911804199,"y":30.4288444519043},{"x":50.460205078125,"y":30.4278736114502},{"x":50.4601249694824,"y":30.4273910522461},{"x":50.4601058959961,"y":30.4270839691162},{"x":50.4600791931152,"y":30.4266815185547},{"x":50.4600448608398,"y":30.4262638092041},{"x":50.4599227905273,"y":30.4256191253662},{"x":50.4595603942871,"y":30.4243907928467},{"x":50.4592590332031,"y":30.4234066009521},{"x":50.4592208862305,"y":30.4233055114746},{"x":50.4590034484863,"y":30.4229564666748},{"x":50.4588890075684,"y":30.4227313995361},{"x":50.4588050842285,"y":30.4225158691406},{"x":50.4587173461914,"y":30.4222316741943},{"x":50.4585800170898,"y":30.4217395782471},{"x":50.4584693908691,"y":30.421443939209},{"x":50.458309173584,"y":30.4209976196289},{"x":50.4582557678223,"y":30.4207897186279},{"x":50.4580764770508,"y":30.4202747344971},{"x":50.4579734802246,"y":30.4200172424316}]},{"points":[{"x":50.4580268859863,"y":30.4199409484863},{"x":50.4579734802246,"y":30.4200172424316},{"x":50.4577560424805,"y":30.4195442199707},{"x":50.4574813842773,"y":30.4189929962158},{"x":50.4571914672852,"y":30.4185199737549},{"x":50.4564437866211,"y":30.4176025390625},{"x":50.4562911987305,"y":30.417537689209},{"x":50.4560890197754,"y":30.4174747467041},{"x":50.4558868408203,"y":30.4174480438232},{"x":50.455451965332,"y":30.4174365997314},{"x":50.454517364502,"y":30.4174423217773},{"x":50.4541931152344,"y":30.4174480438232}]},{"points":[{"x":50.4541893005371,"y":30.4173774719238},{"x":50.4541931152344,"y":30.4174480438232},{"x":50.4532279968262,"y":30.4173927307129},{"x":50.4524688720703,"y":30.4173393249512},{"x":50.4520568847656,"y":30.4173564910889},{"x":50.451789855957,"y":30.4174098968506},{"x":50.4515228271484,"y":30.417501449585},{"x":50.4511604309082,"y":30.4176998138428},{"x":50.4503936767578,"y":30.4181823730469},{"x":50.4499282836914,"y":30.4184722900391}]},{"points":[{"x":50.4499130249023,"y":30.4183959960938},{"x":50.4499282836914,"y":30.4184722900391},{"x":50.4494552612305,"y":30.4187660217285},{"x":50.4482002258301,"y":30.4195671081543},{"x":50.4471015930176,"y":30.4202575683594}]},{"points":[{"x":50.4470863342285,"y":30.4201946258545},{"x":50.4471015930176,"y":30.4202575683594},{"x":50.4468727111816,"y":30.4204025268555},{"x":50.4467315673828,"y":30.4198722839355},{"x":50.4464454650879,"y":30.4188098907471},{"x":50.4460945129395,"y":30.4174842834473},{"x":50.4456367492676,"y":30.4157524108887},{"x":50.4452514648438,"y":30.4142818450928},{"x":50.4451103210449,"y":30.4136924743652}]},{"points":[{"x":50.4451560974121,"y":30.4136714935303},{"x":50.4451103210449,"y":30.4136924743652},{"x":50.4447250366211,"y":30.4121799468994},{"x":50.444393157959,"y":30.4108600616455}]},{"points":[{"x":50.444450378418,"y":30.410816192627},{"x":50.444393157959,"y":30.4108600616455},{"x":50.4442176818848,"y":30.4102325439453},{"x":50.4440956115723,"y":30.4098358154297},{"x":50.4437980651855,"y":30.4092445373535},{"x":50.4435234069824,"y":30.408821105957},{"x":50.4431076049805,"y":30.4083709716797},{"x":50.4429359436035,"y":30.4082088470459},{"x":50.442626953125,"y":30.4080333709717},{"x":50.4422950744629,"y":30.4078502655029},{"x":50.4420967102051,"y":30.4077911376953},{"x":50.4417915344238,"y":30.4077529907227},{"x":50.441478729248,"y":30.4077262878418},{"x":50.4411468505859,"y":30.4077758789062},{"x":50.4408302307129,"y":30.407844543457},{"x":50.4405632019043,"y":30.4079570770264},{"x":50.4398422241211,"y":30.4083862304688},{"x":50.4394416809082,"y":30.4086284637451}]},{"points":[{"x":50.4394302368164,"y":30.4085521697998},{"x":50.4394416809082,"y":30.4086284637451},{"x":50.4385299682617,"y":30.4091968536377},{"x":50.4379005432129,"y":30.4095726013184},{"x":50.4374694824219,"y":30.4098129272461},{"x":50.4373092651367,"y":30.4098300933838},{"x":50.4372100830078,"y":30.4098682403564},{"x":50.4366455078125,"y":30.4102153778076}]},{"points":[{"x":50.4366340637207,"y":30.410135269165},{"x":50.4366455078125,"y":30.4102153778076},{"x":50.4364318847656,"y":30.4103507995605},{"x":50.4362945556641,"y":30.4103660583496},{"x":50.4361763000488,"y":30.4103393554688},{"x":50.4360313415527,"y":30.4102210998535},{"x":50.4359016418457,"y":30.4100704193115},{"x":50.4358444213867,"y":30.4099960327148},{"x":50.4355239868164,"y":30.408805847168},{"x":50.4349060058594,"y":30.4064655303955},{"x":50.4345664978027,"y":30.4051742553711},{"x":50.4341506958008,"y":30.4036064147949},{"x":50.4338607788086,"y":30.4025020599365},{"x":50.4334373474121,"y":30.4008502960205},{"x":50.4331703186035,"y":30.3997936248779}]},{"points":[{"x":50.433235168457,"y":30.3997554779053},{"x":50.4331703186035,"y":30.3997936248779},{"x":50.432804107666,"y":30.3983116149902},{"x":50.4323425292969,"y":30.3964786529541},{"x":50.4318313598633,"y":30.3944492340088}]},{"points":[{"x":50.4318771362305,"y":30.3944225311279},{"x":50.4318313598633,"y":30.3944492340088},{"x":50.4314117431641,"y":30.3928031921387},{"x":50.4310836791992,"y":30.3914947509766},{"x":50.4306983947754,"y":30.3899383544922},{"x":50.4305191040039,"y":30.3892402648926}]},{"points":[{"x":50.4305686950684,"y":30.3892135620117},{"x":50.4305191040039,"y":30.3892402648926},{"x":50.4300689697266,"y":30.3874492645264},{"x":50.4297981262207,"y":30.3863277435303},{"x":50.4297523498535,"y":30.3860759735107},{"x":50.4297409057617,"y":30.3857536315918},{"x":50.4297485351562,"y":30.3856391906738},{"x":50.4298057556152,"y":30.3854732513428},{"x":50.4298324584961,"y":30.3851833343506},{"x":50.429817199707,"y":30.384952545166},{"x":50.429759979248,"y":30.3847751617432},{"x":50.4296875,"y":30.3845767974854},{"x":50.4296569824219,"y":30.3844985961914},{"x":50.4296379089355,"y":30.3844776153564},{"x":50.4294891357422,"y":30.384370803833},{"x":50.429256439209,"y":30.3844242095947},{"x":50.4290580749512,"y":30.3845520019531},{"x":50.4289131164551,"y":30.3847942352295},{"x":50.4288063049316,"y":30.3849601745605},{"x":50.4286804199219,"y":30.3851203918457},{"x":50.428524017334,"y":30.3852348327637},{"x":50.4283218383789,"y":30.3853034973145},{"x":50.4281158447266,"y":30.3853206634521},{"x":50.427906036377,"y":30.3852977752686},{"x":50.4273529052734,"y":30.3850898742676},{"x":50.4263534545898,"y":30.3846645355225},{"x":50.4257774353027,"y":30.3844127655029}]},{"points":[{"x":50.4257888793945,"y":30.3843269348145},{"x":50.4257774353027,"y":30.3844127655029},{"x":50.4250373840332,"y":30.3841133117676},{"x":50.4242858886719,"y":30.3837757110596},{"x":50.4233436584473,"y":30.3833465576172},{"x":50.4231033325195,"y":30.3831844329834},{"x":50.4228591918945,"y":30.3829212188721},{"x":50.4224472045898,"y":30.3822727203369},{"x":50.4217185974121,"y":30.3811454772949},{"x":50.421215057373,"y":30.3802871704102},{"x":50.4203033447266,"y":30.3817691802979},{"x":50.4200782775879,"y":30.3821487426758}]},{"points":[{"x":50.4200401306152,"y":30.3820953369141},{"x":50.4200782775879,"y":30.3821487426758},{"x":50.4196586608887,"y":30.3829479217529},{"x":50.4193496704102,"y":30.3835391998291},{"x":50.419116973877,"y":30.3840484619141},{"x":50.4185791015625,"y":30.3852291107178},{"x":50.4179992675781,"y":30.3864898681641},{"x":50.417667388916,"y":30.3872089385986}]},{"points":[{"x":50.4176292419434,"y":30.3871650695801},{"x":50.417667388916,"y":30.3872089385986},{"x":50.4170989990234,"y":30.3884468078613},{"x":50.4167518615723,"y":30.3892574310303},{"x":50.4166374206543,"y":30.3895797729492},{"x":50.4164924621582,"y":30.3900623321533},{"x":50.4161491394043,"y":30.391414642334},{"x":50.4158477783203,"y":30.3926162719727},{"x":50.4156265258789,"y":30.3931312561035},{"x":50.4153747558594,"y":30.3936138153076},{"x":50.4150886535645,"y":30.39404296875},{"x":50.4147453308105,"y":30.3944873809814},{"x":50.4145698547363,"y":30.3946762084961},{"x":50.4142875671387,"y":30.394889831543}]},{"points":[{"x":50.4142723083496,"y":30.3948097229004},{"x":50.4142875671387,"y":30.394889831543},{"x":50.4137763977051,"y":30.3951530456543},{"x":50.4132461547852,"y":30.3953990936279},{"x":50.4128608703613,"y":30.3956146240234},{"x":50.4123954772949,"y":30.395881652832},{"x":50.4119148254395,"y":30.3962211608887},{"x":50.4115982055664,"y":30.3964672088623},{"x":50.4113235473633,"y":30.3967361450195},{"x":50.4106636047363,"y":30.3975028991699}]},{"points":[{"x":50.4106407165527,"y":30.3974323272705},{"x":50.4106636047363,"y":30.3975028991699},{"x":50.4102554321289,"y":30.3980236053467},{"x":50.4098320007324,"y":30.3986396789551},{"x":50.4094505310059,"y":30.399299621582},{"x":50.4091186523438,"y":30.3999214172363},{"x":50.4088401794434,"y":30.4005279541016},{"x":50.4085350036621,"y":30.4013156890869}]},{"points":[{"x":50.408504486084,"y":30.401273727417},{"x":50.4085350036621,"y":30.4013156890869},{"x":50.4083061218262,"y":30.4019985198975},{"x":50.4081077575684,"y":30.4026794433594},{"x":50.4078521728516,"y":30.4036445617676},{"x":50.4076042175293,"y":30.4048080444336},{"x":50.4075584411621,"y":30.4050331115723},{"x":50.4078483581543,"y":30.4051742553711},{"x":50.4079322814941,"y":30.404727935791},{"x":50.4081192016602,"y":30.4038600921631},{"x":50.408390045166,"y":30.4027652740479},{"x":50.4086418151855,"y":30.4019813537598},{"x":50.4089508056641,"y":30.4011707305908},{"x":50.4092330932617,"y":30.4005489349365},{"x":50.4097061157227,"y":30.4011402130127}]},{"points":[{"x":50.4096717834473,"y":30.4012203216553},{"x":50.4097061157227,"y":30.4011402130127},{"x":50.4100151062012,"y":30.4015140533447},{"x":50.4101295471191,"y":30.4017448425293},{"x":50.4102058410645,"y":30.4020023345947},{"x":50.4102935791016,"y":30.4025173187256},{"x":50.410343170166,"y":30.4029102325439},{"x":50.4104347229004,"y":30.4043159484863},{"x":50.4104804992676,"y":30.4049472808838}]},{"points":[{"x":50.4104347229004,"y":30.4049644470215},{"x":50.4104804992676,"y":30.4049472808838},{"x":50.4105339050293,"y":30.4054412841797},{"x":50.4106559753418,"y":30.4067344665527},{"x":50.4106903076172,"y":30.4069766998291},{"x":50.4108390808105,"y":30.4074058532715},{"x":50.4109268188477,"y":30.4076251983643},{"x":50.4110794067383,"y":30.4078559875488},{"x":50.4112892150879,"y":30.4081726074219},{"x":50.4117965698242,"y":30.408971786499},{"x":50.4119529724121,"y":30.4092178344727}]}]}
7	2	c_route_bus	11	{"cityID":2,"routeID":227,"routeType":"c_route_bus","number":"11","timeStart":22740,"timeFinish":80580,"intervalMin":1080,"intervalMax":1080,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.465690612793,"y":30.6444435119629,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лесная"},{"lang_id":"c_en","value":" Lisna"},{"lang_id":"c_uk","value":" ст. м. Лісна"}]},{"city_id":0,"location":{"x":50.4704513549805,"y":30.657075881958,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Лесничество"},{"lang_id":"c_en","value":" Lisnytstvo"},{"lang_id":"c_uk","value":" Лісництво"}]},{"city_id":0,"location":{"x":50.4715309143066,"y":30.6653156280518,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Минутка"},{"lang_id":"c_en","value":" Khvylynka"},{"lang_id":"c_uk","value":" Хвилинка"}]},{"city_id":0,"location":{"x":50.4729690551758,"y":30.6705131530762,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Школа"},{"lang_id":"c_en","value":" Shkola"},{"lang_id":"c_uk","value":" Школа"}]},{"city_id":0,"location":{"x":50.4769401550293,"y":30.6693058013916,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Быковнянский"},{"lang_id":"c_en","value":" Bykovnyanskyi Ln"},{"lang_id":"c_uk","value":" пров. Биковнянський"}]},{"city_id":0,"location":{"x":50.4811782836914,"y":30.6692523956299,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Радистов"},{"lang_id":"c_en","value":" Radystiv St"},{"lang_id":"c_uk","value":" вул. Радистів"}]},{"city_id":0,"location":{"x":50.4856796264648,"y":30.6691932678223,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Радиоцентр"},{"lang_id":"c_en","value":" Radiotsentr"},{"lang_id":"c_uk","value":" Радіоцентр"}]}],"directRelations":[{"points":[{"x":50.465690612793,"y":30.6444435119629},{"x":50.4657287597656,"y":30.6444053649902},{"x":50.4658546447754,"y":30.6448612213135},{"x":50.4661750793457,"y":30.644962310791},{"x":50.4664154052734,"y":30.6450157165527},{"x":50.466625213623,"y":30.6450157165527},{"x":50.4672889709473,"y":30.647403717041},{"x":50.467945098877,"y":30.6498394012451},{"x":50.4685440063477,"y":30.6520595550537},{"x":50.4691505432129,"y":30.6542549133301},{"x":50.4693450927734,"y":30.6548595428467},{"x":50.4695129394531,"y":30.6551990509033},{"x":50.470287322998,"y":30.6565494537354},{"x":50.4704551696777,"y":30.6569042205811},{"x":50.4704971313477,"y":30.6570224761963}]},{"points":[{"x":50.4704513549805,"y":30.657075881958},{"x":50.4704971313477,"y":30.6570224761963},{"x":50.470645904541,"y":30.6574897766113},{"x":50.4707832336426,"y":30.6581535339355},{"x":50.4708366394043,"y":30.6586627960205},{"x":50.4708671569824,"y":30.659366607666},{"x":50.4709053039551,"y":30.6599292755127},{"x":50.4709587097168,"y":30.6603488922119},{"x":50.4710388183594,"y":30.6607398986816},{"x":50.4712829589844,"y":30.6616401672363},{"x":50.4715385437012,"y":30.6625423431396},{"x":50.4718055725098,"y":30.6634750366211},{"x":50.4720687866211,"y":30.664457321167},{"x":50.4714584350586,"y":30.6648540496826},{"x":50.4715690612793,"y":30.665283203125}]},{"points":[{"x":50.4715309143066,"y":30.6653156280518},{"x":50.4715690612793,"y":30.665283203125},{"x":50.4722137451172,"y":30.6675624847412},{"x":50.4724159240723,"y":30.6682720184326},{"x":50.4728813171387,"y":30.6700096130371},{"x":50.473014831543,"y":30.6704921722412}]},{"points":[{"x":50.4729690551758,"y":30.6705131530762},{"x":50.473014831543,"y":30.6704921722412},{"x":50.4733276367188,"y":30.6716461181641},{"x":50.4736022949219,"y":30.6714515686035},{"x":50.4739303588867,"y":30.6712265014648},{"x":50.4745826721191,"y":30.6707706451416},{"x":50.4755859375,"y":30.6700839996338},{"x":50.4762115478516,"y":30.6696491241455},{"x":50.4767570495605,"y":30.6693496704102},{"x":50.476936340332,"y":30.6692485809326}]},{"points":[{"x":50.4769401550293,"y":30.6693058013916},{"x":50.476936340332,"y":30.6692485809326},{"x":50.4771385192871,"y":30.6691989898682},{"x":50.4774055480957,"y":30.6691722869873},{"x":50.4784469604492,"y":30.6691665649414},{"x":50.4798202514648,"y":30.6691780090332},{"x":50.4811820983887,"y":30.6691837310791}]},{"points":[{"x":50.4811782836914,"y":30.6692523956299},{"x":50.4811820983887,"y":30.6691837310791},{"x":50.4824180603027,"y":30.6691932678223},{"x":50.4836845397949,"y":30.6691989898682},{"x":50.485050201416,"y":30.6691989898682},{"x":50.4856796264648,"y":30.6691932678223}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4856834411621,"y":30.6691246032715,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Радиоцентр"},{"lang_id":"c_en","value":" Radiotsentr"},{"lang_id":"c_uk","value":" Радіоцентр"}]},{"city_id":0,"location":{"x":50.4811744689941,"y":30.6691074371338,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Радистов"},{"lang_id":"c_en","value":" Radystiv St"},{"lang_id":"c_uk","value":" вул. Радистів"}]},{"city_id":0,"location":{"x":50.4767379760742,"y":30.6692752838135,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Быковнянский"},{"lang_id":"c_en","value":" Bykovnyanskyi Ln"},{"lang_id":"c_uk","value":" пров. Биковнянський"}]},{"city_id":0,"location":{"x":50.4722938537598,"y":30.6714096069336,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Быковня"},{"lang_id":"c_en","value":" Bykovnya"},{"lang_id":"c_uk","value":" Биковня"}]},{"city_id":0,"location":{"x":50.4687805175781,"y":30.658727645874,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ДЭУ Днепровского района"},{"lang_id":"c_en","value":" DEU"},{"lang_id":"c_uk","value":" ДЕУ Дніпровського району"}]},{"city_id":0,"location":{"x":50.4657287597656,"y":30.6444053649902,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лесная"},{"lang_id":"c_en","value":" Lisna"},{"lang_id":"c_uk","value":" ст. м. Лісна"}]}],"reverseRelations":[{"points":[{"x":50.4856834411621,"y":30.6691246032715},{"x":50.4856796264648,"y":30.6691932678223},{"x":50.485050201416,"y":30.6691989898682},{"x":50.4836845397949,"y":30.6691989898682},{"x":50.4824180603027,"y":30.6691932678223},{"x":50.4811820983887,"y":30.6691837310791}]},{"points":[{"x":50.4811744689941,"y":30.6691074371338},{"x":50.4811820983887,"y":30.6691837310791},{"x":50.4798202514648,"y":30.6691780090332},{"x":50.4784469604492,"y":30.6691665649414},{"x":50.4774055480957,"y":30.6691722869873},{"x":50.4771385192871,"y":30.6691989898682},{"x":50.476936340332,"y":30.6692485809326},{"x":50.4767570495605,"y":30.6693496704102}]},{"points":[{"x":50.4767379760742,"y":30.6692752838135},{"x":50.4767570495605,"y":30.6693496704102},{"x":50.4762115478516,"y":30.6696491241455},{"x":50.4755859375,"y":30.6700839996338},{"x":50.4745826721191,"y":30.6707706451416},{"x":50.4739303588867,"y":30.6712265014648},{"x":50.4736022949219,"y":30.6714515686035},{"x":50.4733276367188,"y":30.6716461181641},{"x":50.4726600646973,"y":30.672082901001},{"x":50.4724655151367,"y":30.6722373962402},{"x":50.4722518920898,"y":30.6714496612549}]},{"points":[{"x":50.4722938537598,"y":30.6714096069336},{"x":50.4722518920898,"y":30.6714496612549},{"x":50.4718246459961,"y":30.6699256896973},{"x":50.4712104797363,"y":30.6676845550537},{"x":50.4705810546875,"y":30.6654529571533},{"x":50.4699745178223,"y":30.663236618042},{"x":50.4695281982422,"y":30.6616115570068},{"x":50.469165802002,"y":30.6603126525879},{"x":50.4687385559082,"y":30.6587677001953}]},{"points":[{"x":50.4687805175781,"y":30.658727645874},{"x":50.4687385559082,"y":30.6587677001953},{"x":50.4683685302734,"y":30.6573886871338},{"x":50.4678802490234,"y":30.6555652618408},{"x":50.4673538208008,"y":30.6536178588867},{"x":50.466926574707,"y":30.6520729064941},{"x":50.4664421081543,"y":30.6503238677979},{"x":50.465892791748,"y":30.6483345031738},{"x":50.4668922424316,"y":30.6476745605469},{"x":50.4672889709473,"y":30.647403717041},{"x":50.466625213623,"y":30.6450157165527},{"x":50.4661483764648,"y":30.643383026123},{"x":50.4660530090332,"y":30.6433124542236},{"x":50.4659194946289,"y":30.6432704925537},{"x":50.4657897949219,"y":30.6433086395264},{"x":50.4655876159668,"y":30.6439361572266},{"x":50.4657287597656,"y":30.6444053649902}]}]}
8	2	c_route_bus	12	{"cityID":2,"routeID":228,"routeType":"c_route_bus","number":"12","timeStart":24780,"timeFinish":75420,"intervalMin":1500,"intervalMax":1500,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4315605163574,"y":30.4690780639648,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Соломенская "},{"lang_id":"c_en","value":" Solom\\u0027yanska square"},{"lang_id":"c_uk","value":" площа Солом\\u0027янська "}]},{"city_id":0,"location":{"x":50.4304313659668,"y":30.4723949432373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Соломенская"},{"lang_id":"c_en","value":" Solomyanska St"},{"lang_id":"c_uk","value":" вул. Солом\\u0027янська"}]},{"city_id":0,"location":{"x":50.4270935058594,"y":30.4758071899414,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Государственный университет"},{"lang_id":"c_en","value":" Derzhavnyi universytet"},{"lang_id":"c_uk","value":" Державний університет"}]},{"city_id":0,"location":{"x":50.4225997924805,"y":30.4755592346191,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Алексеевская"},{"lang_id":"c_en","value":" Oleksiivska St"},{"lang_id":"c_uk","value":" вул. Олексіївська"}]},{"city_id":0,"location":{"x":50.4180297851562,"y":30.4831295013428,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Университетская"},{"lang_id":"c_en","value":" Universytetska St"},{"lang_id":"c_uk","value":" вул. Університетська"}]},{"city_id":0,"location":{"x":50.4183387756348,"y":30.4866542816162,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Зенитная"},{"lang_id":"c_en","value":" Zenitna St"},{"lang_id":"c_uk","value":" вул. Зенітна"}]},{"city_id":0,"location":{"x":50.4186515808105,"y":30.4917526245117,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сахарный институт"},{"lang_id":"c_en","value":" Tsukrovyi instytut"},{"lang_id":"c_uk","value":" Цукровий інститут"}]},{"city_id":0,"location":{"x":50.4211654663086,"y":30.5004634857178,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Тубинститут"},{"lang_id":"c_en","value":" Tubinstytut"},{"lang_id":"c_uk","value":" Тубінститут"}]},{"city_id":0,"location":{"x":50.418041229248,"y":30.4902210235596,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Божков Яр"},{"lang_id":"c_en","value":" Bozhkov Yar"},{"lang_id":"c_uk","value":" Божков Яр"}]},{"city_id":0,"location":{"x":50.4159698486328,"y":30.490650177002,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Гаевая"},{"lang_id":"c_en","value":" Haeva St"},{"lang_id":"c_uk","value":" вул. Гаєва"}]},{"city_id":0,"location":{"x":50.4137001037598,"y":30.4902362823486,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Нечуй-Левицкого"},{"lang_id":"c_en","value":" Nechui-Levytskoho St"},{"lang_id":"c_uk","value":" вул. Нечуй-Левицького"}]},{"city_id":0,"location":{"x":50.4125289916992,"y":30.497537612915,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Почта"},{"lang_id":"c_en","value":" Poshta"},{"lang_id":"c_uk","value":" Пошта"}]},{"city_id":0,"location":{"x":50.4106216430664,"y":30.5074157714844,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Фрометовский спуск"},{"lang_id":"c_en","value":" Frometivskyi descent"},{"lang_id":"c_uk","value":" Фрометівський узвіз"}]},{"city_id":0,"location":{"x":50.4124717712402,"y":30.5140628814697,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Изюмская"},{"lang_id":"c_en","value":" Izumska St"},{"lang_id":"c_uk","value":" вул. Ізюмська"}]},{"city_id":0,"location":{"x":50.4097633361816,"y":30.5182437896729,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Изюмская"},{"lang_id":"c_en","value":" Izumska St"},{"lang_id":"c_uk","value":" вул. Ізюмська"}]}],"directRelations":[{"points":[{"x":50.4315605163574,"y":30.4690780639648},{"x":50.431583404541,"y":30.46901512146},{"x":50.4320869445801,"y":30.4695415496826},{"x":50.4311904907227,"y":30.471794128418},{"x":50.4309692382812,"y":30.4718856811523},{"x":50.4308586120605,"y":30.4720096588135},{"x":50.4304618835449,"y":30.4724597930908}]},{"points":[{"x":50.4304313659668,"y":30.4723949432373},{"x":50.4304618835449,"y":30.4724597930908},{"x":50.4302635192871,"y":30.4727115631104},{"x":50.429759979248,"y":30.4732856750488},{"x":50.428882598877,"y":30.4742679595947},{"x":50.4280662536621,"y":30.4751796722412},{"x":50.4278678894043,"y":30.4753875732422},{"x":50.4277610778809,"y":30.4754791259766},{"x":50.4274215698242,"y":30.4757270812988},{"x":50.4271278381348,"y":30.4759197235107}]},{"points":[{"x":50.4270935058594,"y":30.4758071899414},{"x":50.4271278381348,"y":30.4759197235107},{"x":50.4265098571777,"y":30.4763050079346},{"x":50.4257049560547,"y":30.4768104553223},{"x":50.4252815246582,"y":30.4770622253418},{"x":50.4251861572266,"y":30.4768199920654},{"x":50.4250869750977,"y":30.4765796661377},{"x":50.4249839782715,"y":30.4763965606689},{"x":50.4248580932617,"y":30.4762420654297},{"x":50.4242095947266,"y":30.4755821228027},{"x":50.4232749938965,"y":30.4746265411377},{"x":50.4226379394531,"y":30.4756145477295}]},{"points":[{"x":50.4225997924805,"y":30.4755592346191},{"x":50.4226379394531,"y":30.4756145477295},{"x":50.4220008850098,"y":30.4766120910645},{"x":50.4208335876465,"y":30.4782695770264},{"x":50.4207038879395,"y":30.4784564971924},{"x":50.4205322265625,"y":30.4785594940186},{"x":50.4200859069824,"y":30.478982925415},{"x":50.4199256896973,"y":30.479133605957},{"x":50.4194641113281,"y":30.4801254272461},{"x":50.4191627502441,"y":30.480785369873},{"x":50.4180679321289,"y":30.4831676483154}]},{"points":[{"x":50.4180297851562,"y":30.4831295013428},{"x":50.4180679321289,"y":30.4831676483154},{"x":50.4179496765137,"y":30.4834251403809},{"x":50.4182662963867,"y":30.4837131500244},{"x":50.4183578491211,"y":30.4840145111084},{"x":50.4185752868652,"y":30.4845886230469},{"x":50.4187088012695,"y":30.4850826263428},{"x":50.4187240600586,"y":30.4854412078857},{"x":50.4186706542969,"y":30.4858226776123},{"x":50.4185028076172,"y":30.4863319396973},{"x":50.418384552002,"y":30.4866905212402}]},{"points":[{"x":50.4183387756348,"y":30.4866542816162},{"x":50.418384552002,"y":30.4866905212402},{"x":50.4182739257812,"y":30.4870834350586},{"x":50.4179458618164,"y":30.4883861541748},{"x":50.4178810119629,"y":30.4886608123779},{"x":50.4178771972656,"y":30.4888000488281},{"x":50.4179229736328,"y":30.4889755249023},{"x":50.4179840087891,"y":30.489143371582},{"x":50.4181175231934,"y":30.4894485473633},{"x":50.4182662963867,"y":30.4899158477783},{"x":50.4184112548828,"y":30.4903869628906},{"x":50.4184837341309,"y":30.4907836914062},{"x":50.418701171875,"y":30.4917392730713}]},{"points":[{"x":50.4186515808105,"y":30.4917526245117},{"x":50.418701171875,"y":30.4917392730713},{"x":50.4189414978027,"y":30.4928016662598},{"x":50.4191360473633,"y":30.4933319091797},{"x":50.4192657470703,"y":30.4936656951904},{"x":50.4198799133301,"y":30.4953556060791},{"x":50.4201850891113,"y":30.4961814880371},{"x":50.4204177856445,"y":30.4989166259766},{"x":50.4204597473145,"y":30.4990406036377},{"x":50.421199798584,"y":30.5003910064697}]},{"points":[{"x":50.4211654663086,"y":30.5004634857178},{"x":50.421199798584,"y":30.5003910064697},{"x":50.4204597473145,"y":30.4990406036377},{"x":50.4204177856445,"y":30.4989166259766},{"x":50.4201850891113,"y":30.4961814880371},{"x":50.4198799133301,"y":30.4953556060791},{"x":50.4192657470703,"y":30.4936656951904},{"x":50.4191360473633,"y":30.4933319091797},{"x":50.4189414978027,"y":30.4928016662598},{"x":50.418701171875,"y":30.4917392730713},{"x":50.4184837341309,"y":30.4907836914062},{"x":50.4182510375977,"y":30.4905643463135},{"x":50.4180068969727,"y":30.4902801513672}]},{"points":[{"x":50.418041229248,"y":30.4902210235596},{"x":50.4180068969727,"y":30.4902801513672},{"x":50.4175796508789,"y":30.4898300170898},{"x":50.4174194335938,"y":30.4901733398438},{"x":50.417179107666,"y":30.4906921386719},{"x":50.4168167114258,"y":30.4916000366211},{"x":50.4165267944336,"y":30.4913520812988},{"x":50.4159317016602,"y":30.4907245635986}]},{"points":[{"x":50.4159698486328,"y":30.490650177002},{"x":50.4159317016602,"y":30.4907245635986},{"x":50.4153900146484,"y":30.4901504516602},{"x":50.4151229858398,"y":30.4898891448975},{"x":50.4149284362793,"y":30.4897594451904},{"x":50.4147338867188,"y":30.4896469116211},{"x":50.4145011901855,"y":30.4896259307861},{"x":50.4143104553223,"y":30.4897327423096},{"x":50.4140396118164,"y":30.4899044036865},{"x":50.4138412475586,"y":30.4901237487793},{"x":50.413745880127,"y":30.4902744293213}]},{"points":[{"x":50.4137001037598,"y":30.4902362823486},{"x":50.413745880127,"y":30.4902744293213},{"x":50.4135131835938,"y":30.4906978607178},{"x":50.4134330749512,"y":30.4908428192139},{"x":50.4134101867676,"y":30.4909610748291},{"x":50.4133567810059,"y":30.4914646148682},{"x":50.4132118225098,"y":30.4925918579102},{"x":50.4129943847656,"y":30.4942226409912},{"x":50.4127349853516,"y":30.496072769165},{"x":50.4126586914062,"y":30.4967174530029},{"x":50.4125900268555,"y":30.4972591400146},{"x":50.4125633239746,"y":30.497537612915}]},{"points":[{"x":50.4125289916992,"y":30.497537612915},{"x":50.4125633239746,"y":30.497537612915},{"x":50.4124526977539,"y":30.4987831115723},{"x":50.4123840332031,"y":30.4994106292725},{"x":50.4123916625977,"y":30.4998989105225},{"x":50.4124298095703,"y":30.5004463195801},{"x":50.4124336242676,"y":30.5009021759033},{"x":50.4123802185059,"y":30.5017337799072},{"x":50.4123191833496,"y":30.5024890899658},{"x":50.4122467041016,"y":30.5027141571045},{"x":50.412036895752,"y":30.5033054351807},{"x":50.4116554260254,"y":30.5043125152588},{"x":50.4114875793457,"y":30.5045967102051},{"x":50.4112892150879,"y":30.5048923492432},{"x":50.4110870361328,"y":30.5053119659424},{"x":50.4109077453613,"y":30.5056762695312},{"x":50.4107322692871,"y":30.5061149597168},{"x":50.4105110168457,"y":30.5066261291504},{"x":50.410530090332,"y":30.506872177124},{"x":50.410587310791,"y":30.5071239471436},{"x":50.4106559753418,"y":30.507381439209}]},{"points":[{"x":50.4106216430664,"y":30.5074157714844},{"x":50.4106559753418,"y":30.507381439209},{"x":50.4108695983887,"y":30.5080413818359},{"x":50.4111175537109,"y":30.5087718963623},{"x":50.4116668701172,"y":30.5104713439941},{"x":50.4118270874023,"y":30.5110397338867},{"x":50.4120979309082,"y":30.5121784210205},{"x":50.4123687744141,"y":30.5134429931641},{"x":50.4124336242676,"y":30.513765335083},{"x":50.4125099182129,"y":30.5140285491943}]},{"points":[{"x":50.4124717712402,"y":30.5140628814697},{"x":50.4125099182129,"y":30.5140285491943},{"x":50.4129371643066,"y":30.5153694152832},{"x":50.412410736084,"y":30.5158519744873},{"x":50.4113845825195,"y":30.5167694091797},{"x":50.410099029541,"y":30.5179386138916},{"x":50.4097633361816,"y":30.5182437896729}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4095458984375,"y":30.5193557739258,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Изюмская"},{"lang_id":"c_en","value":" Izumska St"},{"lang_id":"c_uk","value":" вул. Ізюмська"}]},{"city_id":0,"location":{"x":50.412410736084,"y":30.5134086608887,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Кировоградская"},{"lang_id":"c_en","value":" Kyrovohradska St"},{"lang_id":"c_uk","value":" вул. Кировоградська"}]},{"city_id":0,"location":{"x":50.4106292724609,"y":30.5070781707764,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Фрометовский спуск"},{"lang_id":"c_en","value":" Frometivskyi descent"},{"lang_id":"c_uk","value":" Фрометівський узвіз"}]},{"city_id":0,"location":{"x":50.4120826721191,"y":30.5033416748047,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Магазин"},{"lang_id":"c_en","value":" Magazin"},{"lang_id":"c_uk","value":" Магазин"}]},{"city_id":0,"location":{"x":50.4127082824707,"y":30.4967231750488,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Почта"},{"lang_id":"c_en","value":" Poshta"},{"lang_id":"c_uk","value":" Пошта"}]},{"city_id":0,"location":{"x":50.4137840270996,"y":30.4903335571289,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Нечуй-Левицкого"},{"lang_id":"c_en","value":" Nechui-Levytskoho St"},{"lang_id":"c_uk","value":" вул. Нечуй-Левицького"}]},{"city_id":0,"location":{"x":50.4159164428711,"y":30.4908103942871,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Гаевая"},{"lang_id":"c_en","value":" Haeva St"},{"lang_id":"c_uk","value":" вул. Гаєва"}]},{"city_id":0,"location":{"x":50.4174575805664,"y":30.4902324676514,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Яслинская"},{"lang_id":"c_en","value":" Yaslinska St"},{"lang_id":"c_uk","value":" вул. Яслінська"}]},{"city_id":0,"location":{"x":50.4186515808105,"y":30.4917526245117,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сахарный институт"},{"lang_id":"c_en","value":" Tsukrovyi instytut"},{"lang_id":"c_uk","value":" Цукровий інститут"}]},{"city_id":0,"location":{"x":50.4211654663086,"y":30.5004634857178,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Тубинститут"},{"lang_id":"c_en","value":" Tubinstytut"},{"lang_id":"c_uk","value":" Тубінститут"}]},{"city_id":0,"location":{"x":50.4183120727539,"y":30.4898853302002,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сахарный институт"},{"lang_id":"c_en","value":" Tsukrovyi instytut"},{"lang_id":"c_uk","value":" Цукровий інститут"}]},{"city_id":0,"location":{"x":50.4185409545898,"y":30.4863586425781,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Зенитная"},{"lang_id":"c_en","value":" Zenitna St"},{"lang_id":"c_uk","value":" вул. Зенітна"}]},{"city_id":0,"location":{"x":50.4181060791016,"y":30.4832096099854,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Университетская"},{"lang_id":"c_en","value":" Universytetska St"},{"lang_id":"c_uk","value":" вул. Університетська"}]},{"city_id":0,"location":{"x":50.4195251464844,"y":30.4801731109619,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Андрея Головко"},{"lang_id":"c_en","value":" Andriya Holovko St"},{"lang_id":"c_uk","value":" вул. Андрія Головко"}]},{"city_id":0,"location":{"x":50.4226760864258,"y":30.4756774902344,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Алексеевская"},{"lang_id":"c_en","value":" Oleksiivska St"},{"lang_id":"c_uk","value":" вул. Олексіївська"}]},{"city_id":0,"location":{"x":50.431583404541,"y":30.46901512146,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Соломенская "},{"lang_id":"c_en","value":" Solom\\u0027yanska square"},{"lang_id":"c_uk","value":" площа Солом\\u0027янська "}]}],"reverseRelations":[{"points":[{"x":50.4095458984375,"y":30.5193557739258},{"x":50.4095153808594,"y":30.5192852020264},{"x":50.4097213745117,"y":30.5190277099609},{"x":50.409782409668,"y":30.5187225341797},{"x":50.4097862243652,"y":30.5186309814453},{"x":50.4096946716309,"y":30.5183143615723},{"x":50.4097633361816,"y":30.5182437896729},{"x":50.410099029541,"y":30.5179386138916},{"x":50.4113845825195,"y":30.5167694091797},{"x":50.412410736084,"y":30.5158519744873},{"x":50.4129371643066,"y":30.5153694152832},{"x":50.4125099182129,"y":30.5140285491943},{"x":50.4124336242676,"y":30.513765335083},{"x":50.4123687744141,"y":30.5134429931641}]},{"points":[{"x":50.412410736084,"y":30.5134086608887},{"x":50.4123687744141,"y":30.5134429931641},{"x":50.4120979309082,"y":30.5121784210205},{"x":50.4118270874023,"y":30.5110397338867},{"x":50.4116668701172,"y":30.5104713439941},{"x":50.4111175537109,"y":30.5087718963623},{"x":50.4108695983887,"y":30.5080413818359},{"x":50.4106559753418,"y":30.507381439209},{"x":50.410587310791,"y":30.5071239471436}]},{"points":[{"x":50.4106292724609,"y":30.5070781707764},{"x":50.410587310791,"y":30.5071239471436},{"x":50.410530090332,"y":30.506872177124},{"x":50.4105110168457,"y":30.5066261291504},{"x":50.4107322692871,"y":30.5061149597168},{"x":50.4109077453613,"y":30.5056762695312},{"x":50.4110870361328,"y":30.5053119659424},{"x":50.4112892150879,"y":30.5048923492432},{"x":50.4114875793457,"y":30.5045967102051},{"x":50.4116554260254,"y":30.5043125152588},{"x":50.412036895752,"y":30.5033054351807}]},{"points":[{"x":50.4120826721191,"y":30.5033416748047},{"x":50.412036895752,"y":30.5033054351807},{"x":50.4122467041016,"y":30.5027141571045},{"x":50.4123191833496,"y":30.5024890899658},{"x":50.4123802185059,"y":30.5017337799072},{"x":50.4124336242676,"y":30.5009021759033},{"x":50.4124298095703,"y":30.5004463195801},{"x":50.4123916625977,"y":30.4998989105225},{"x":50.4123840332031,"y":30.4994106292725},{"x":50.4124526977539,"y":30.4987831115723},{"x":50.4125633239746,"y":30.497537612915},{"x":50.4125900268555,"y":30.4972591400146},{"x":50.4126586914062,"y":30.4967174530029}]},{"points":[{"x":50.4127082824707,"y":30.4967231750488},{"x":50.4126586914062,"y":30.4967174530029},{"x":50.4127349853516,"y":30.496072769165},{"x":50.4129943847656,"y":30.4942226409912},{"x":50.4132118225098,"y":30.4925918579102},{"x":50.4133567810059,"y":30.4914646148682},{"x":50.4134101867676,"y":30.4909610748291},{"x":50.4134330749512,"y":30.4908428192139},{"x":50.4135131835938,"y":30.4906978607178},{"x":50.413745880127,"y":30.4902744293213}]},{"points":[{"x":50.4137840270996,"y":30.4903335571289},{"x":50.413745880127,"y":30.4902744293213},{"x":50.4138412475586,"y":30.4901237487793},{"x":50.4140396118164,"y":30.4899044036865},{"x":50.4143104553223,"y":30.4897327423096},{"x":50.4145011901855,"y":30.4896259307861},{"x":50.4147338867188,"y":30.4896469116211},{"x":50.4149284362793,"y":30.4897594451904},{"x":50.4151229858398,"y":30.4898891448975},{"x":50.4153900146484,"y":30.4901504516602},{"x":50.4159317016602,"y":30.4907245635986}]},{"points":[{"x":50.4159164428711,"y":30.4908103942871},{"x":50.4159317016602,"y":30.4907245635986},{"x":50.4165267944336,"y":30.4913520812988},{"x":50.4168167114258,"y":30.4916000366211},{"x":50.417179107666,"y":30.4906921386719},{"x":50.4174194335938,"y":30.4901733398438}]},{"points":[{"x":50.4174575805664,"y":30.4902324676514},{"x":50.4174194335938,"y":30.4901733398438},{"x":50.4175796508789,"y":30.4898300170898},{"x":50.4180068969727,"y":30.4902801513672},{"x":50.4182510375977,"y":30.4905643463135},{"x":50.4184837341309,"y":30.4907836914062},{"x":50.418701171875,"y":30.4917392730713}]},{"points":[{"x":50.4186515808105,"y":30.4917526245117},{"x":50.418701171875,"y":30.4917392730713},{"x":50.4189414978027,"y":30.4928016662598},{"x":50.4191360473633,"y":30.4933319091797},{"x":50.4192657470703,"y":30.4936656951904},{"x":50.4198799133301,"y":30.4953556060791},{"x":50.4201850891113,"y":30.4961814880371},{"x":50.4204177856445,"y":30.4989166259766},{"x":50.4204597473145,"y":30.4990406036377},{"x":50.421199798584,"y":30.5003910064697}]},{"points":[{"x":50.4211654663086,"y":30.5004634857178},{"x":50.421199798584,"y":30.5003910064697},{"x":50.4204597473145,"y":30.4990406036377},{"x":50.4204177856445,"y":30.4989166259766},{"x":50.4201850891113,"y":30.4961814880371},{"x":50.4198799133301,"y":30.4953556060791},{"x":50.4192657470703,"y":30.4936656951904},{"x":50.4189414978027,"y":30.4928016662598},{"x":50.418701171875,"y":30.4917392730713},{"x":50.4184837341309,"y":30.4907836914062},{"x":50.4184112548828,"y":30.4903869628906},{"x":50.4182662963867,"y":30.4899158477783}]},{"points":[{"x":50.4183120727539,"y":30.4898853302002},{"x":50.4182662963867,"y":30.4899158477783},{"x":50.4181175231934,"y":30.4894485473633},{"x":50.4179840087891,"y":30.489143371582},{"x":50.4179229736328,"y":30.4889755249023},{"x":50.4178771972656,"y":30.4888000488281},{"x":50.4178810119629,"y":30.4886608123779},{"x":50.4179458618164,"y":30.4883861541748},{"x":50.4182739257812,"y":30.4870834350586},{"x":50.418384552002,"y":30.4866905212402},{"x":50.4185028076172,"y":30.4863319396973}]},{"points":[{"x":50.4185409545898,"y":30.4863586425781},{"x":50.4185028076172,"y":30.4863319396973},{"x":50.4186706542969,"y":30.4858226776123},{"x":50.4187240600586,"y":30.4854412078857},{"x":50.4187088012695,"y":30.4850826263428},{"x":50.4185752868652,"y":30.4845886230469},{"x":50.4183578491211,"y":30.4840145111084},{"x":50.4182662963867,"y":30.4837131500244},{"x":50.4179496765137,"y":30.4834251403809},{"x":50.4180679321289,"y":30.4831676483154}]},{"points":[{"x":50.4181060791016,"y":30.4832096099854},{"x":50.4180679321289,"y":30.4831676483154},{"x":50.4191627502441,"y":30.480785369873},{"x":50.4194641113281,"y":30.4801254272461}]},{"points":[{"x":50.4195251464844,"y":30.4801731109619},{"x":50.4194641113281,"y":30.4801254272461},{"x":50.4199256896973,"y":30.479133605957},{"x":50.4200859069824,"y":30.478982925415},{"x":50.4205322265625,"y":30.4785594940186},{"x":50.4207038879395,"y":30.4784564971924},{"x":50.4208335876465,"y":30.4782695770264},{"x":50.4220008850098,"y":30.4766120910645},{"x":50.4226379394531,"y":30.4756145477295}]},{"points":[{"x":50.4226760864258,"y":30.4756774902344},{"x":50.4226379394531,"y":30.4756145477295},{"x":50.4232749938965,"y":30.4746265411377},{"x":50.4236946105957,"y":30.4738426208496},{"x":50.4240264892578,"y":30.473258972168},{"x":50.4248466491699,"y":30.4720191955566},{"x":50.4251403808594,"y":30.4715805053711},{"x":50.4260215759277,"y":30.4703674316406},{"x":50.4263763427734,"y":30.4698638916016},{"x":50.4273262023926,"y":30.4688167572021},{"x":50.428108215332,"y":30.4679527282715},{"x":50.4292373657227,"y":30.4666976928711},{"x":50.4303398132324,"y":30.4677925109863},{"x":50.431396484375,"y":30.4688377380371},{"x":50.431583404541,"y":30.46901512146}]}]}
9	2	c_route_bus	14	{"cityID":2,"routeID":229,"routeType":"c_route_bus","number":"14","timeStart":24180,"timeFinish":74220,"intervalMin":1320,"intervalMax":1320,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4997138977051,"y":30.3647518157959,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Синеозерная"},{"lang_id":"c_en","value":" Synoozerna St"},{"lang_id":"c_uk","value":" вул. Синьоозерна"}]},{"city_id":0,"location":{"x":50.4965057373047,"y":30.3705024719238,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Берковцы"},{"lang_id":"c_en","value":" Berkovtsi"},{"lang_id":"c_uk","value":" Берковці"}]},{"city_id":0,"location":{"x":50.49311065673828,"y":30.379348754882812,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Газопроводная"},{"lang_id":"c_en","value":" Hazoprovidna St"},{"lang_id":"c_uk","value":" вул. Газопровідна"}]},{"city_id":0,"location":{"x":50.4887809753418,"y":30.3905010223389,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АП-5"},{"lang_id":"c_en","value":" AP-5"},{"lang_id":"c_uk","value":" АП-5"}]},{"city_id":0,"location":{"x":50.4874382019043,"y":30.3939304351807,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Городское кладбище"},{"lang_id":"c_en","value":" Miskyi tsvyntar"},{"lang_id":"c_uk","value":" Міський цвинтар"}]},{"city_id":0,"location":{"x":50.4857444763184,"y":30.3972015380859,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сады"},{"lang_id":"c_en","value":" Sady"},{"lang_id":"c_uk","value":" Сади"}]},{"city_id":0,"location":{"x":50.481819152832,"y":30.4045181274414,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Интернациональная"},{"lang_id":"c_en","value":" Internatsionalna square"},{"lang_id":"c_uk","value":" площа Інтернаціональна"}]},{"city_id":0,"location":{"x":50.4804573059082,"y":30.40569305419922,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Стеценко"},{"lang_id":"c_en","value":" Stytsenko St"},{"lang_id":"c_uk","value":" вул. Стеценка"}]},{"city_id":0,"location":{"x":50.4764747619629,"y":30.4056987762451,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Поликлиника"},{"lang_id":"c_en","value":" Poliklinika"},{"lang_id":"c_uk","value":" Поліклініка"}]},{"city_id":0,"location":{"x":50.4714965820312,"y":30.4057102203369,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Салютная"},{"lang_id":"c_en","value":" Salutna St"},{"lang_id":"c_uk","value":" вул. Салютна"}]},{"city_id":0,"location":{"x":50.4675903320312,"y":30.405725479126,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Краснодарская"},{"lang_id":"c_en","value":" Krasnodarska St"},{"lang_id":"c_uk","value":" вул. Краснодарська"}]},{"city_id":0,"location":{"x":50.4639739990234,"y":30.4057483673096,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Эстонская"},{"lang_id":"c_en","value":" Estonska St"},{"lang_id":"c_uk","value":" вул. Естонська"}]},{"city_id":0,"location":{"x":50.459163665771484,"y":30.405467987060547,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Нивки"},{"lang_id":"c_en","value":" Nyvky"},{"lang_id":"c_uk","value":" ст. м. Нивки"}]}],"directRelations":[{"points":[{"x":50.4997138977051,"y":30.3647518157959},{"x":50.49972152709961,"y":30.36482810974121},{"x":50.4991455078125,"y":30.36488151550293},{"x":50.498268127441406,"y":30.36498260498047},{"x":50.497154235839844,"y":30.36513328552246},{"x":50.49690628051758,"y":30.36518096923828},{"x":50.49699020385742,"y":30.366666793823242},{"x":50.49705123901367,"y":30.367799758911133},{"x":50.49705505371094,"y":30.368314743041992},{"x":50.497032165527344,"y":30.368717193603516},{"x":50.49692916870117,"y":30.369409561157227},{"x":50.49673080444336,"y":30.370019912719727},{"x":50.496551513671875,"y":30.370534896850586}]},{"points":[{"x":50.4965057373047,"y":30.3705024719238},{"x":50.496551513671875,"y":30.370534896850586},{"x":50.49622344970703,"y":30.371532440185547},{"x":50.49613952636719,"y":30.371814727783203},{"x":50.49599838256836,"y":30.372201919555664},{"x":50.49568176269531,"y":30.372995376586914},{"x":50.495296478271484,"y":30.373981475830078},{"x":50.49497985839844,"y":30.374792098999023},{"x":50.4936637878418,"y":30.378156661987305},{"x":50.4931755065918,"y":30.37939453125}]},{"points":[{"x":50.49311065673828,"y":30.379348754882812},{"x":50.4931755065918,"y":30.37939453125},{"x":50.492347717285156,"y":30.381513595581055},{"x":50.49143981933594,"y":30.38383674621582},{"x":50.49088668823242,"y":30.385242462158203},{"x":50.49021530151367,"y":30.386953353881836},{"x":50.48941421508789,"y":30.38902473449707},{"x":50.488826751708984,"y":30.39052963256836}]},{"points":[{"x":50.4887809753418,"y":30.3905010223389},{"x":50.488826751708984,"y":30.39052963256836},{"x":50.48767852783203,"y":30.393465042114258},{"x":50.48747634887695,"y":30.39396858215332}]},{"points":[{"x":50.4874382019043,"y":30.3939304351807},{"x":50.48747634887695,"y":30.39396858215332},{"x":50.48722839355469,"y":30.39457130432129},{"x":50.48703384399414,"y":30.394819259643555},{"x":50.486541748046875,"y":30.395233154296875},{"x":50.48638153076172,"y":30.395366668701172},{"x":50.486331939697266,"y":30.395389556884766},{"x":50.486228942871094,"y":30.395448684692383},{"x":50.48617935180664,"y":30.395662307739258},{"x":50.48617935180664,"y":30.395872116088867},{"x":50.486236572265625,"y":30.39604949951172},{"x":50.486244201660156,"y":30.396215438842773},{"x":50.48621368408203,"y":30.39642906188965},{"x":50.486000061035156,"y":30.396852493286133},{"x":50.485782623291016,"y":30.39725112915039}]},{"points":[{"x":50.4857444763184,"y":30.3972015380859},{"x":50.485782623291016,"y":30.39725112915039},{"x":50.48501968383789,"y":30.39865493774414},{"x":50.48406219482422,"y":30.400415420532227},{"x":50.48334884643555,"y":30.40176773071289},{"x":50.48247146606445,"y":30.403419494628906},{"x":50.48240661621094,"y":30.4035587310791},{"x":50.48185348510742,"y":30.40456771850586}]},{"points":[{"x":50.481819152832,"y":30.4045181274414},{"x":50.48185348510742,"y":30.40456771850586},{"x":50.481414794921875,"y":30.405393600463867},{"x":50.48121643066406,"y":30.405763626098633},{"x":50.4806022644043,"y":30.405757904052734},{"x":50.480445861816406,"y":30.40576934814453}]},{"points":[{"x":50.4804573059082,"y":30.40569305419922},{"x":50.480445861816406,"y":30.40576934814453},{"x":50.47932434082031,"y":30.40577507019043},{"x":50.477970123291016,"y":30.40577507019043},{"x":50.476470947265625,"y":30.405784606933594}]},{"points":[{"x":50.4764747619629,"y":30.4056987762451},{"x":50.476470947265625,"y":30.405784606933594},{"x":50.475120544433594,"y":30.405784606933594},{"x":50.47372817993164,"y":30.40579605102539},{"x":50.472434997558594,"y":30.405790328979492},{"x":50.471492767333984,"y":30.40579605102539}]},{"points":[{"x":50.4714965820312,"y":30.4057102203369},{"x":50.471492767333984,"y":30.40579605102539},{"x":50.47025680541992,"y":30.40579605102539},{"x":50.468910217285156,"y":30.405811309814453},{"x":50.46803665161133,"y":30.405811309814453},{"x":50.46759033203125,"y":30.40581703186035}]},{"points":[{"x":50.4675903320312,"y":30.405725479126},{"x":50.46759033203125,"y":30.40581703186035},{"x":50.46630096435547,"y":30.40581703186035},{"x":50.465206146240234,"y":30.40582275390625},{"x":50.46459197998047,"y":30.40582275390625},{"x":50.46397018432617,"y":30.40582275390625}]},{"points":[{"x":50.4639739990234,"y":30.4057483673096},{"x":50.46397018432617,"y":30.40582275390625},{"x":50.46269607543945,"y":30.40582847595215},{"x":50.46171188354492,"y":30.405834197998047},{"x":50.46071243286133,"y":30.405838012695312},{"x":50.45994567871094,"y":30.40582847595215},{"x":50.45970153808594,"y":30.405805587768555},{"x":50.459510803222656,"y":30.405757904052734},{"x":50.45927810668945,"y":30.40558624267578},{"x":50.459163665771484,"y":30.405467987060547}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4597015380859,"y":30.4058971405029,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Нивки"},{"lang_id":"c_en","value":" Nyvky"},{"lang_id":"c_uk","value":" ст. м. Нивки"}]},{"city_id":0,"location":{"x":50.4645919799805,"y":30.4058876037598,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Эстонская"},{"lang_id":"c_en","value":" Estonska St"},{"lang_id":"c_uk","value":" вул. Естонська"}]},{"city_id":0,"location":{"x":50.4680366516113,"y":30.4058876037598,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Краснодарская"},{"lang_id":"c_en","value":" Krasnodarska St"},{"lang_id":"c_uk","value":" вул. Краснодарська"}]},{"city_id":0,"location":{"x":50.4702568054199,"y":30.4058704376221,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Вильгельма Пика"},{"lang_id":"c_en","value":" Vilhelma Pika St"},{"lang_id":"c_uk","value":" вул. Вільгельма Піка"}]},{"city_id":0,"location":{"x":50.4724349975586,"y":30.405876159668,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Салютная"},{"lang_id":"c_en","value":" Salutna St"},{"lang_id":"c_uk","value":" вул. Салютна"}]},{"city_id":0,"location":{"x":50.4751167297363,"y":30.4058704376221,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Поликлиника"},{"lang_id":"c_en","value":" Poliklinika"},{"lang_id":"c_uk","value":" Поліклініка"}]},{"city_id":0,"location":{"x":50.48060989379883,"y":30.40582847595215,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Стеценко"},{"lang_id":"c_en","value":" Stetsenko St"},{"lang_id":"c_uk","value":" вул. Стеценка"}]},{"city_id":0,"location":{"x":50.4828948974609,"y":30.4030284881592,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Интернациональная"},{"lang_id":"c_en","value":" Internatsionalna square"},{"lang_id":"c_uk","value":" площа Інтернаціональна"}]},{"city_id":0,"location":{"x":50.4859085083008,"y":30.3974170684814,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Сады"},{"lang_id":"c_en","value":" Sady"},{"lang_id":"c_uk","value":" Сади"}]},{"city_id":0,"location":{"x":50.4877166748047,"y":30.3935012817383,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Городское кладбище"},{"lang_id":"c_en","value":" Miskyi tsvyntar"},{"lang_id":"c_uk","value":" Міський цвинтар"}]},{"city_id":0,"location":{"x":50.4888763427734,"y":30.3905658721924,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АП-5"},{"lang_id":"c_en","value":" AP-5"},{"lang_id":"c_uk","value":" АП-5"}]},{"city_id":0,"location":{"x":50.4937057495117,"y":30.3781967163086,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Газопроводная"},{"lang_id":"c_en","value":" Hazoprovidna St"},{"lang_id":"c_uk","value":" вул. Газопровідна"}]},{"city_id":0,"location":{"x":50.4969100952148,"y":30.369966506958,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Берковцы"},{"lang_id":"c_en","value":" Berkovtsi"},{"lang_id":"c_uk","value":" Берковці"}]},{"city_id":0,"location":{"x":50.499446868896484,"y":30.3651065826416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Лесорассадник"},{"lang_id":"c_en","value":" Lisorozsadnyk"},{"lang_id":"c_uk","value":" Лісорозсадник"}]}],"reverseRelations":[{"points":[{"x":50.4597015380859,"y":30.4058971405029},{"x":50.45970153808594,"y":30.405805587768555},{"x":50.45994567871094,"y":30.40582847595215},{"x":50.46071243286133,"y":30.405838012695312},{"x":50.46171188354492,"y":30.405834197998047},{"x":50.46269607543945,"y":30.40582847595215},{"x":50.46397018432617,"y":30.40582275390625},{"x":50.46459197998047,"y":30.40582275390625}]},{"points":[{"x":50.4645919799805,"y":30.4058876037598},{"x":50.46459197998047,"y":30.40582275390625},{"x":50.465206146240234,"y":30.40582275390625},{"x":50.46630096435547,"y":30.40581703186035},{"x":50.46759033203125,"y":30.40581703186035},{"x":50.46803665161133,"y":30.405811309814453}]},{"points":[{"x":50.4680366516113,"y":30.4058876037598},{"x":50.46803665161133,"y":30.405811309814453},{"x":50.468910217285156,"y":30.405811309814453},{"x":50.47025680541992,"y":30.40579605102539}]},{"points":[{"x":50.4702568054199,"y":30.4058704376221},{"x":50.47025680541992,"y":30.40579605102539},{"x":50.471492767333984,"y":30.40579605102539},{"x":50.472434997558594,"y":30.405790328979492}]},{"points":[{"x":50.4724349975586,"y":30.405876159668},{"x":50.472434997558594,"y":30.405790328979492},{"x":50.47372817993164,"y":30.40579605102539},{"x":50.475120544433594,"y":30.405784606933594}]},{"points":[{"x":50.4751167297363,"y":30.4058704376221},{"x":50.475120544433594,"y":30.405784606933594},{"x":50.476470947265625,"y":30.405784606933594},{"x":50.477970123291016,"y":30.40577507019043},{"x":50.47932434082031,"y":30.40577507019043},{"x":50.480445861816406,"y":30.40576934814453},{"x":50.4806022644043,"y":30.405757904052734}]},{"points":[{"x":50.48060989379883,"y":30.40582847595215},{"x":50.4806022644043,"y":30.405757904052734},{"x":50.48121643066406,"y":30.405763626098633},{"x":50.48080825805664,"y":30.40651512145996},{"x":50.48066329956055,"y":30.406782150268555},{"x":50.480655670166016,"y":30.406959533691406},{"x":50.480682373046875,"y":30.40712547302246},{"x":50.48076629638672,"y":30.40726089477539},{"x":50.48088455200195,"y":30.40729331970215},{"x":50.48094940185547,"y":30.407249450683594},{"x":50.48104476928711,"y":30.407175064086914},{"x":50.481204986572266,"y":30.40685272216797},{"x":50.481834411621094,"y":30.40569305419922},{"x":50.482093811035156,"y":30.405216217041016},{"x":50.48223114013672,"y":30.404970169067383},{"x":50.48228073120117,"y":30.40474510192871},{"x":50.4823112487793,"y":30.404455184936523},{"x":50.48234558105469,"y":30.404191970825195},{"x":50.48241424560547,"y":30.403913497924805},{"x":50.48249816894531,"y":30.403671264648438},{"x":50.48286056518555,"y":30.402996063232422}]},{"points":[{"x":50.4828948974609,"y":30.4030284881592},{"x":50.48286056518555,"y":30.402996063232422},{"x":50.483253479003906,"y":30.402244567871094},{"x":50.48357391357422,"y":30.401649475097656},{"x":50.48390579223633,"y":30.401037216186523},{"x":50.48441696166992,"y":30.400083541870117},{"x":50.48503494262695,"y":30.39891815185547},{"x":50.48541259765625,"y":30.398225784301758},{"x":50.48587417602539,"y":30.39739418029785}]},{"points":[{"x":50.4859085083008,"y":30.3974170684814},{"x":50.48587417602539,"y":30.39739418029785},{"x":50.486122131347656,"y":30.396934509277344},{"x":50.486305236816406,"y":30.3966121673584},{"x":50.486454010009766,"y":30.39634895324707},{"x":50.486576080322266,"y":30.396156311035156},{"x":50.486656188964844,"y":30.396011352539062},{"x":50.48686218261719,"y":30.395509719848633},{"x":50.48722839355469,"y":30.39457130432129},{"x":50.48747634887695,"y":30.39396858215332},{"x":50.48767852783203,"y":30.393465042114258}]},{"points":[{"x":50.4877166748047,"y":30.3935012817383},{"x":50.48767852783203,"y":30.393465042114258},{"x":50.488826751708984,"y":30.39052963256836}]},{"points":[{"x":50.4888763427734,"y":30.3905658721924},{"x":50.488826751708984,"y":30.39052963256836},{"x":50.48941421508789,"y":30.38902473449707},{"x":50.49021530151367,"y":30.386953353881836},{"x":50.49088668823242,"y":30.385242462158203},{"x":50.49143981933594,"y":30.38383674621582},{"x":50.492347717285156,"y":30.381513595581055},{"x":50.4931755065918,"y":30.37939453125},{"x":50.4936637878418,"y":30.378156661987305}]},{"points":[{"x":50.4937057495117,"y":30.3781967163086},{"x":50.4936637878418,"y":30.378156661987305},{"x":50.49497985839844,"y":30.374792098999023},{"x":50.495296478271484,"y":30.373981475830078},{"x":50.49568176269531,"y":30.372995376586914},{"x":50.49599838256836,"y":30.372201919555664},{"x":50.49613952636719,"y":30.371814727783203},{"x":50.496299743652344,"y":30.37143325805664},{"x":50.496620178222656,"y":30.370586395263672},{"x":50.49686813354492,"y":30.369937896728516}]},{"points":[{"x":50.4969100952148,"y":30.369966506958},{"x":50.49686813354492,"y":30.369937896728516},{"x":50.4969596862793,"y":30.369680404663086},{"x":50.49751663208008,"y":30.3681583404541},{"x":50.49782943725586,"y":30.367279052734375},{"x":50.49821090698242,"y":30.36629295349121},{"x":50.49836730957031,"y":30.365938186645508},{"x":50.498531341552734,"y":30.365659713745117},{"x":50.498661041259766,"y":30.365497589111328},{"x":50.49885177612305,"y":30.36532211303711},{"x":50.499088287353516,"y":30.365154266357422},{"x":50.499446868896484,"y":30.3651065826416}]}]}
10	2	c_route_bus	16	{"cityID":2,"routeID":230,"routeType":"c_route_bus","number":"16","timeStart":25920,"timeFinish":61260,"intervalMin":1320,"intervalMax":1320,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.3904762268066,"y":30.6670913696289,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Станция Аэрации"},{"lang_id":"c_en","value":" Stantsiya Aeratsii"},{"lang_id":"c_uk","value":" Станція Аерації"}]},{"city_id":0,"location":{"x":50.3942070007324,"y":30.6717319488525,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Орасительная система"},{"lang_id":"c_en","value":" Zroshuvalna systema"},{"lang_id":"c_uk","value":" Зрошувальна система"}]},{"city_id":0,"location":{"x":50.3982315063477,"y":30.6774063110352,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Радиоизмеритель"},{"lang_id":"c_en","value":" zavod Radiovymiruvach"},{"lang_id":"c_uk","value":" завод Радіовимірювач"}]},{"city_id":0,"location":{"x":50.4010047912598,"y":30.6813182830811,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Харьковская"},{"lang_id":"c_en","value":" Kharkivska square"},{"lang_id":"c_uk","value":" площа Харківська"}]},{"city_id":0,"location":{"x":50.4033546447754,"y":30.6830234527588,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Бориспольская"},{"lang_id":"c_en","value":" Boryspilska"},{"lang_id":"c_uk","value":" ст. м. Бориспільська"}]}],"directRelations":[{"points":[{"x":50.3904762268066,"y":30.6670913696289},{"x":50.3905143737793,"y":30.6670169830322},{"x":50.3910636901855,"y":30.6677989959717},{"x":50.391242980957,"y":30.6674823760986},{"x":50.3921699523926,"y":30.6687812805176},{"x":50.3930206298828,"y":30.6699714660645},{"x":50.3939933776855,"y":30.6713237762451},{"x":50.3942375183105,"y":30.6716728210449}]},{"points":[{"x":50.3942070007324,"y":30.6717319488525},{"x":50.3942375183105,"y":30.6716728210449},{"x":50.3947448730469,"y":30.6723747253418},{"x":50.3959426879883,"y":30.6740646362305},{"x":50.3971214294434,"y":30.6757278442383},{"x":50.3976287841797,"y":30.6764354705811},{"x":50.3982620239258,"y":30.6773586273193}]},{"points":[{"x":50.3982315063477,"y":30.6774063110352},{"x":50.3982620239258,"y":30.6773586273193},{"x":50.3991394042969,"y":30.678581237793},{"x":50.4001197814941,"y":30.6799774169922},{"x":50.4010391235352,"y":30.6812419891357}]},{"points":[{"x":50.4010047912598,"y":30.6813182830811},{"x":50.4010391235352,"y":30.6812419891357},{"x":50.4011383056641,"y":30.6814670562744},{"x":50.4012336730957,"y":30.6817512512207},{"x":50.4012298583984,"y":30.682014465332},{"x":50.4012107849121,"y":30.6823310852051},{"x":50.4011306762695,"y":30.6827125549316},{"x":50.4010963439941,"y":30.6830177307129},{"x":50.4011001586914,"y":30.683313369751},{"x":50.4011573791504,"y":30.6837043762207},{"x":50.4012298583984,"y":30.6840152740479},{"x":50.4013290405273,"y":30.6842727661133},{"x":50.4014701843262,"y":30.6844940185547},{"x":50.4016227722168,"y":30.6846694946289},{"x":50.4017944335938,"y":30.6847991943359},{"x":50.4019889831543,"y":30.6848907470703},{"x":50.4021873474121,"y":30.6849117279053},{"x":50.402400970459,"y":30.6849002838135},{"x":50.4025993347168,"y":30.6848526000977},{"x":50.4027633666992,"y":30.6847839355469},{"x":50.4028587341309,"y":30.6847076416016},{"x":50.4030113220215,"y":30.6844444274902},{"x":50.4031562805176,"y":30.6841659545898},{"x":50.403247833252,"y":30.6839141845703},{"x":50.4033088684082,"y":30.6836624145508},{"x":50.4033546447754,"y":30.6833515167236},{"x":50.4033546447754,"y":30.6830234527588}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4033966064453,"y":30.6830043792725,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Бориспольская"},{"lang_id":"c_en","value":" Boryspilska"},{"lang_id":"c_uk","value":" ст. м. Бориспільська"}]},{"city_id":0,"location":{"x":50.401065826416,"y":30.6811828613281,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Харьковская"},{"lang_id":"c_en","value":" Kharkivska square"},{"lang_id":"c_uk","value":" площа Харківська"}]},{"city_id":0,"location":{"x":50.3991546630859,"y":30.6785221099854,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Радиоизмеритель"},{"lang_id":"c_en","value":" zavod Radiovymiruvach"},{"lang_id":"c_uk","value":" завод Радіовимірювач"}]},{"city_id":0,"location":{"x":50.3940277099609,"y":30.6712760925293,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Орасительная система"},{"lang_id":"c_en","value":" Zroshuvalna systema"},{"lang_id":"c_uk","value":" Зрошувальна система"}]},{"city_id":0,"location":{"x":50.3905143737793,"y":30.6670169830322,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Станция Аэрации"},{"lang_id":"c_en","value":" Stantsiya Aeratsii"},{"lang_id":"c_uk","value":" Станція Аерації"}]}],"reverseRelations":[{"points":[{"x":50.4033966064453,"y":30.6830043792725},{"x":50.4033546447754,"y":30.6830234527588},{"x":50.4033355712891,"y":30.6827812194824},{"x":50.4032669067383,"y":30.6824436187744},{"x":50.4032020568848,"y":30.6821441650391},{"x":50.4030113220215,"y":30.681697845459},{"x":50.4029121398926,"y":30.6814842224121},{"x":50.4025993347168,"y":30.6813869476318},{"x":50.4024620056152,"y":30.6813659667969},{"x":50.4021339416504,"y":30.681360244751},{"x":50.4019470214844,"y":30.6814136505127},{"x":50.4017562866211,"y":30.6815166473389},{"x":50.4015998840332,"y":30.6815490722656},{"x":50.4014472961426,"y":30.6815586090088},{"x":50.4013290405273,"y":30.681526184082},{"x":50.4012031555176,"y":30.6814308166504},{"x":50.4010391235352,"y":30.6812419891357}]},{"points":[{"x":50.401065826416,"y":30.6811828613281},{"x":50.4010391235352,"y":30.6812419891357},{"x":50.4001197814941,"y":30.6799774169922},{"x":50.3991394042969,"y":30.678581237793}]},{"points":[{"x":50.3991546630859,"y":30.6785221099854},{"x":50.3991394042969,"y":30.678581237793},{"x":50.3982620239258,"y":30.6773586273193},{"x":50.3976287841797,"y":30.6764354705811},{"x":50.3971214294434,"y":30.6757278442383},{"x":50.3959426879883,"y":30.6740646362305},{"x":50.3947448730469,"y":30.6723747253418},{"x":50.3942375183105,"y":30.6716728210449},{"x":50.3939933776855,"y":30.6713237762451}]},{"points":[{"x":50.3940277099609,"y":30.6712760925293},{"x":50.3939933776855,"y":30.6713237762451},{"x":50.3930206298828,"y":30.6699714660645},{"x":50.3921699523926,"y":30.6687812805176},{"x":50.391242980957,"y":30.6674823760986},{"x":50.3908042907715,"y":30.6668395996094},{"x":50.3906402587891,"y":30.6667003631592},{"x":50.3905296325684,"y":30.6666736602783},{"x":50.3904457092285,"y":30.6669082641602},{"x":50.3905143737793,"y":30.6670169830322}]}]}
11	2	c_route_bus	21	{"cityID":2,"routeID":233,"routeType":"c_route_bus","number":"21","timeStart":22800,"timeFinish":80700,"intervalMin":420,"intervalMax":420,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.5302734375,"y":30.6101417541504,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Милославская"},{"lang_id":"c_en","value":" Myloslavska St"},{"lang_id":"c_uk","value":" вул. Милославська"}]},{"city_id":0,"location":{"x":50.5229606628418,"y":30.6092739105225,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Марины Цветаевой"},{"lang_id":"c_en","value":" Matyny Tsvetaevoi St"},{"lang_id":"c_uk","value":" вул. Марини Цвєтаєвої"}]},{"city_id":0,"location":{"x":50.5196571350098,"y":30.608060836792,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Константина Данькевича"},{"lang_id":"c_en","value":" Kostyantyna Dankevycha St"},{"lang_id":"c_uk","value":" вул. Костянтина Данкевича"}]},{"city_id":0,"location":{"x":50.5154876708984,"y":30.6043376922607,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Александра Сабурова"},{"lang_id":"c_en","value":" Oleksandra Saburova St"},{"lang_id":"c_uk","value":" вул. Олександра Сабурова"}]},{"city_id":0,"location":{"x":50.5130004882812,"y":30.6009159088135,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Викентия Беретти"},{"lang_id":"c_en","value":" Vikentiya Bereti St"},{"lang_id":"c_uk","value":" вул. Вікентія Береті"}]},{"city_id":0,"location":{"x":50.5107536315918,"y":30.595422744751,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Дрейзера"},{"lang_id":"c_en","value":" Dreyzera St"},{"lang_id":"c_uk","value":" вул. Дрейзера"}]},{"city_id":0,"location":{"x":50.5097732543945,"y":30.5925426483154,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Архитектора Николаева"},{"lang_id":"c_en","value":" Architektora Nikolaeva St"},{"lang_id":"c_uk","value":" вул. Архітектора Ніколаєва"}]},{"city_id":0,"location":{"x":50.5083122253418,"y":30.5882606506348,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Блок услуг"},{"lang_id":"c_en","value":" Blok poslug"},{"lang_id":"c_uk","value":" Блок послуг"}]},{"city_id":0,"location":{"x":50.5065307617188,"y":30.5849189758301,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Каштановая"},{"lang_id":"c_en","value":" Kashtanova St"},{"lang_id":"c_uk","value":" вул. Каштанова"}]},{"city_id":0,"location":{"x":50.5029182434082,"y":30.5840721130371,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" микрорайон №3"},{"lang_id":"c_en","value":" mikrorayon nomer try"},{"lang_id":"c_uk","value":" мікрорайон №3"}]},{"city_id":0,"location":{"x":50.5014190673828,"y":30.585578918457,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" микрорайон №2"},{"lang_id":"c_en","value":" mikrorayon nomer dva"},{"lang_id":"c_uk","value":" мікрорайон №2"}]},{"city_id":0,"location":{"x":50.5003433227539,"y":30.5889854431152,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Универсам"},{"lang_id":"c_en","value":" Universam"},{"lang_id":"c_uk","value":" Універсам"}]},{"city_id":0,"location":{"x":50.4973640441895,"y":30.5892963409424,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Закревского"},{"lang_id":"c_en","value":" Mykoly Zakrevskoho St"},{"lang_id":"c_uk","value":" вул. Миколи Закревського"}]},{"city_id":0,"location":{"x":50.4955558776855,"y":30.5818824768066,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" массив Радужный"},{"lang_id":"c_en","value":" masyv Raduzhnyi"},{"lang_id":"c_uk","value":" масив Радужний"}]},{"city_id":0,"location":{"x":50.4956092834473,"y":30.5733165740967,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" станция Генерал Ватутина"},{"lang_id":"c_en","value":" stantsiya Henerala Vatutina"},{"lang_id":"c_uk","value":" станція Генерала Ватутіна"}]},{"city_id":0,"location":{"x":50.4953269958496,"y":30.5591049194336,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Торговый центр"},{"lang_id":"c_en","value":" Torhivelnyi tsentr"},{"lang_id":"c_uk","value":" Торгівельний центр"}]},{"city_id":0,"location":{"x":50.4932823181152,"y":30.5439891815186,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" парк Дружбы народов"},{"lang_id":"c_en","value":" park Druzhby narodiv"},{"lang_id":"c_uk","value":" парк Дружби народів"}]},{"city_id":0,"location":{"x":50.4883117675781,"y":30.5240230560303,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Героев Сталинграда"},{"lang_id":"c_en","value":" Heroiv Stalinhradu Ave"},{"lang_id":"c_uk","value":" пр. Героїв Сталінграду"}]},{"city_id":0,"location":{"x":50.4888687133789,"y":30.5079135894775,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лайоша Гавро"},{"lang_id":"c_en","value":" Layosha Gavro St"},{"lang_id":"c_uk","value":" вул. Лайоша Гавро"}]},{"city_id":0,"location":{"x":50.4872093200684,"y":30.4975681304932,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Петровка"},{"lang_id":"c_en","value":" Petrivka"},{"lang_id":"c_uk","value":" ст. м. Петрівка"}]}],"directRelations":[{"points":[{"x":50.5302734375,"y":30.6101417541504},{"x":50.5302734375,"y":30.6102066040039},{"x":50.5299301147461,"y":30.610164642334},{"x":50.5290260314941,"y":30.6100559234619},{"x":50.5280838012695,"y":30.6099548339844},{"x":50.52734375,"y":30.6098690032959},{"x":50.526252746582,"y":30.6097507476807},{"x":50.5251770019531,"y":30.6096115112305},{"x":50.5242805480957,"y":30.609504699707},{"x":50.5234527587891,"y":30.6094284057617},{"x":50.5229644775391,"y":30.6093597412109}]},{"points":[{"x":50.5229606628418,"y":30.6092739105225},{"x":50.5229644775391,"y":30.6093597412109},{"x":50.5223922729492,"y":30.6092624664307},{"x":50.5220642089844,"y":30.609188079834},{"x":50.5216407775879,"y":30.6090755462646},{"x":50.5210914611816,"y":30.608865737915},{"x":50.5202331542969,"y":30.6085014343262},{"x":50.5197334289551,"y":30.6082057952881},{"x":50.519645690918,"y":30.6081581115723}]},{"points":[{"x":50.5196571350098,"y":30.608060836792},{"x":50.519645690918,"y":30.6081581115723},{"x":50.5191612243652,"y":30.6078510284424},{"x":50.5187644958496,"y":30.6075782775879},{"x":50.517749786377,"y":30.6067409515381},{"x":50.5167579650879,"y":30.6057605743408},{"x":50.5162391662598,"y":30.6052131652832},{"x":50.5154609680176,"y":30.6044139862061}]},{"points":[{"x":50.5154876708984,"y":30.6043376922607},{"x":50.5154609680176,"y":30.6044139862061},{"x":50.5150985717773,"y":30.6040267944336},{"x":50.5148429870605,"y":30.6037750244141},{"x":50.5144920349121,"y":30.6033611297607},{"x":50.5142478942871,"y":30.6030673980713},{"x":50.5139579772949,"y":30.6026916503906},{"x":50.5136413574219,"y":30.602165222168},{"x":50.5134010314941,"y":30.6017570495605},{"x":50.5129547119141,"y":30.6009578704834}]},{"points":[{"x":50.5130004882812,"y":30.6009159088135},{"x":50.5129547119141,"y":30.6009578704834},{"x":50.5125465393066,"y":30.6002407073975},{"x":50.5123977661133,"y":30.5999603271484},{"x":50.5121612548828,"y":30.5994510650635},{"x":50.5118827819824,"y":30.5988235473633},{"x":50.5116806030273,"y":30.5982875823975},{"x":50.5114555358887,"y":30.5976428985596},{"x":50.5112419128418,"y":30.597053527832},{"x":50.5109596252441,"y":30.596227645874},{"x":50.5107002258301,"y":30.5954551696777}]},{"points":[{"x":50.5107536315918,"y":30.595422744751},{"x":50.5107002258301,"y":30.5954551696777},{"x":50.5102424621582,"y":30.5941181182861},{"x":50.509937286377,"y":30.5931911468506},{"x":50.5097236633301,"y":30.5925788879395}]},{"points":[{"x":50.5097732543945,"y":30.5925426483154},{"x":50.5097236633301,"y":30.5925788879395},{"x":50.5092964172363,"y":30.5912971496582},{"x":50.5088653564453,"y":30.5900535583496},{"x":50.5085144042969,"y":30.5889854431152},{"x":50.5082740783691,"y":30.5882930755615}]},{"points":[{"x":50.5083122253418,"y":30.5882606506348},{"x":50.5082740783691,"y":30.5882930755615},{"x":50.5079917907715,"y":30.5875644683838},{"x":50.507698059082,"y":30.5868873596191},{"x":50.5074310302734,"y":30.5863933563232},{"x":50.5071601867676,"y":30.5859222412109},{"x":50.5069808959961,"y":30.5856800079346},{"x":50.5066108703613,"y":30.5851497650146},{"x":50.5064926147461,"y":30.5850200653076}]},{"points":[{"x":50.5065307617188,"y":30.5849189758301},{"x":50.5064926147461,"y":30.5850200653076},{"x":50.5062713623047,"y":30.5847473144531},{"x":50.506160736084,"y":30.5846080780029},{"x":50.5057983398438,"y":30.5838947296143},{"x":50.5057029724121,"y":30.5837059020996},{"x":50.5056114196777,"y":30.5835933685303},{"x":50.5055084228516,"y":30.5835933685303},{"x":50.505428314209,"y":30.5836696624756},{"x":50.5053825378418,"y":30.5837707519531},{"x":50.5053024291992,"y":30.5838298797607},{"x":50.505184173584,"y":30.5838737487793},{"x":50.5050277709961,"y":30.5839042663574},{"x":50.5046844482422,"y":30.5838680267334},{"x":50.5043296813965,"y":30.5838146209717},{"x":50.5040397644043,"y":30.5838031768799},{"x":50.503791809082,"y":30.5838031768799},{"x":50.5035705566406,"y":30.5838508605957},{"x":50.5033683776855,"y":30.5839157104492},{"x":50.5029296875,"y":30.5841407775879}]},{"points":[{"x":50.5029182434082,"y":30.5840721130371},{"x":50.5029296875,"y":30.5841407775879},{"x":50.5025444030762,"y":30.5844249725342},{"x":50.5022850036621,"y":30.5846195220947},{"x":50.5020446777344,"y":30.5848274230957},{"x":50.5017585754395,"y":30.5851554870605},{"x":50.5014533996582,"y":30.5856113433838}]},{"points":[{"x":50.5014190673828,"y":30.585578918457},{"x":50.5014533996582,"y":30.5856113433838},{"x":50.5011940002441,"y":30.586109161377},{"x":50.501049041748,"y":30.5864429473877},{"x":50.5009002685547,"y":30.5869083404541},{"x":50.5007095336914,"y":30.587574005127},{"x":50.500545501709,"y":30.5882873535156},{"x":50.5003814697266,"y":30.5890064239502}]},{"points":[{"x":50.5003433227539,"y":30.5889854431152},{"x":50.5003814697266,"y":30.5890064239502},{"x":50.5002746582031,"y":30.5894794464111},{"x":50.5000152587891,"y":30.5905685424805},{"x":50.4995803833008,"y":30.5903263092041},{"x":50.4990463256836,"y":30.5900268554688},{"x":50.4986381530762,"y":30.5898056030273},{"x":50.4983444213867,"y":30.5896663665771},{"x":50.4981117248535,"y":30.5895481109619},{"x":50.4979629516602,"y":30.5894889831543},{"x":50.4978790283203,"y":30.5894565582275},{"x":50.4976501464844,"y":30.5894145965576},{"x":50.4974555969238,"y":30.5893974304199},{"x":50.4973564147949,"y":30.5893878936768}]},{"points":[{"x":50.4973640441895,"y":30.5892963409424},{"x":50.4973564147949,"y":30.5893878936768},{"x":50.4968109130859,"y":30.5893669128418},{"x":50.4965667724609,"y":30.5892810821533},{"x":50.4963417053223,"y":30.5891189575195},{"x":50.4961357116699,"y":30.5888519287109},{"x":50.4958953857422,"y":30.5884971618652},{"x":50.4957122802734,"y":30.5881004333496},{"x":50.495548248291,"y":30.5876178741455},{"x":50.4955673217773,"y":30.5857391357422},{"x":50.4955749511719,"y":30.5842590332031},{"x":50.4955635070801,"y":30.5834655761719},{"x":50.495532989502,"y":30.5828971862793},{"x":50.4955062866211,"y":30.5818881988525}]},{"points":[{"x":50.4955558776855,"y":30.5818824768066},{"x":50.4955062866211,"y":30.5818881988525},{"x":50.4955101013184,"y":30.5809326171875},{"x":50.4955215454102,"y":30.5791301727295},{"x":50.4955253601074,"y":30.5778923034668},{"x":50.4955368041992,"y":30.5770111083984},{"x":50.4955635070801,"y":30.5747909545898},{"x":50.4955635070801,"y":30.5733203887939}]},{"points":[{"x":50.4956092834473,"y":30.5733165740967},{"x":50.4955635070801,"y":30.5733203887939},{"x":50.4955596923828,"y":30.5722312927246},{"x":50.4955596923828,"y":30.570686340332},{"x":50.4955787658691,"y":30.5688953399658},{"x":50.4955863952637,"y":30.5675868988037},{"x":50.4955940246582,"y":30.5661334991455},{"x":50.4955902099609,"y":30.5646743774414},{"x":50.4955711364746,"y":30.5634613037109},{"x":50.4955406188965,"y":30.5625877380371},{"x":50.4954833984375,"y":30.5616436004639},{"x":50.4954223632812,"y":30.5607147216797},{"x":50.4953346252441,"y":30.5596904754639},{"x":50.4952774047852,"y":30.5591163635254}]},{"points":[{"x":50.4953269958496,"y":30.5591049194336},{"x":50.4952774047852,"y":30.5591163635254},{"x":50.4951972961426,"y":30.5583438873291},{"x":50.4950790405273,"y":30.5574111938477},{"x":50.4949836730957,"y":30.5566387176514},{"x":50.4948196411133,"y":30.5553874969482},{"x":50.4945602416992,"y":30.5534515380859},{"x":50.4943580627441,"y":30.5518856048584},{"x":50.494140625,"y":30.5502700805664},{"x":50.4939231872559,"y":30.5486068725586},{"x":50.4937782287598,"y":30.5474700927734},{"x":50.4936752319336,"y":30.5466918945312},{"x":50.4935874938965,"y":30.5460224151611},{"x":50.4934768676758,"y":30.5453357696533},{"x":50.4933471679688,"y":30.5446224212646},{"x":50.4932136535645,"y":30.5440254211426}]},{"points":[{"x":50.4932823181152,"y":30.5439891815186},{"x":50.4932136535645,"y":30.5440254211426},{"x":50.4930000305176,"y":30.5432376861572},{"x":50.4927787780762,"y":30.5424976348877},{"x":50.4924736022949,"y":30.541467666626},{"x":50.4921379089355,"y":30.5403881072998},{"x":50.4918479919434,"y":30.5394668579102},{"x":50.4914512634277,"y":30.538179397583},{"x":50.491081237793,"y":30.5369453430176},{"x":50.4907188415527,"y":30.5357532501221},{"x":50.4898681640625,"y":30.5329055786133},{"x":50.4892578125,"y":30.5309104919434},{"x":50.4891319274902,"y":30.5304756164551},{"x":50.4889678955078,"y":30.5298004150391},{"x":50.4888076782227,"y":30.529016494751},{"x":50.4885749816895,"y":30.5277881622314},{"x":50.4884452819824,"y":30.5269947052002},{"x":50.4883766174316,"y":30.5264358520508},{"x":50.4883422851562,"y":30.5260181427002},{"x":50.4882659912109,"y":30.5248756408691},{"x":50.4882354736328,"y":30.5243759155273},{"x":50.4882354736328,"y":30.5240230560303}]},{"points":[{"x":50.4883117675781,"y":30.5240230560303},{"x":50.4882354736328,"y":30.5240230560303},{"x":50.488224029541,"y":30.5232124328613},{"x":50.4882431030273,"y":30.5222568511963},{"x":50.4882698059082,"y":30.5213394165039},{"x":50.4883117675781,"y":30.5201969146729},{"x":50.4883575439453,"y":30.5190334320068},{"x":50.4884071350098,"y":30.5178470611572},{"x":50.4884490966797,"y":30.5168876647949},{"x":50.4884986877441,"y":30.5156059265137},{"x":50.4885597229004,"y":30.5141677856445},{"x":50.4886093139648,"y":30.5129070281982},{"x":50.488655090332,"y":30.5117168426514},{"x":50.4887161254883,"y":30.5102844238281},{"x":50.4887657165527,"y":30.5090293884277},{"x":50.4888153076172,"y":30.5079135894775}]},{"points":[{"x":50.4888687133789,"y":30.5079135894775},{"x":50.4888153076172,"y":30.5079135894775},{"x":50.4888687133789,"y":30.5064582824707},{"x":50.4889373779297,"y":30.5050315856934},{"x":50.4889831542969,"y":30.503604888916},{"x":50.4891090393066,"y":30.50270652771},{"x":50.4892196655273,"y":30.5021057128906},{"x":50.4893531799316,"y":30.5016174316406},{"x":50.4896812438965,"y":30.50071144104},{"x":50.4898986816406,"y":30.500072479248},{"x":50.4916343688965,"y":30.4975776672363},{"x":50.4924278259277,"y":30.4963932037354},{"x":50.4926452636719,"y":30.4963397979736},{"x":50.4928245544434,"y":30.496488571167},{"x":50.492862701416,"y":30.4967575073242},{"x":50.4927978515625,"y":30.4970474243164},{"x":50.4925765991211,"y":30.4973583221436},{"x":50.4922714233398,"y":30.4976367950439},{"x":50.4916343688965,"y":30.4975776672363},{"x":50.4911918640137,"y":30.4976043701172},{"x":50.4893074035645,"y":30.4975624084473},{"x":50.4879302978516,"y":30.4975719451904},{"x":50.4872093200684,"y":30.4975681304932}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4854049682617,"y":30.4986763000488,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Петровка"},{"lang_id":"c_en","value":" Petrivka"},{"lang_id":"c_uk","value":" ст. м. Петрівка"}]},{"city_id":0,"location":{"x":50.4884796142578,"y":30.501148223877,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Торговий центр"},{"lang_id":"c_en","value":" Torhivelnyi tsentr"},{"lang_id":"c_uk","value":" Торгівельний центр"}]},{"city_id":0,"location":{"x":50.4886054992676,"y":30.5078868865967,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лайоша Гавро"},{"lang_id":"c_en","value":" Layosha Gavro St"},{"lang_id":"c_uk","value":" вул. Лайоша Гавро"}]},{"city_id":0,"location":{"x":50.4884567260742,"y":30.5119209289551,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" супермаркет Домострой"},{"lang_id":"c_en","value":" supermarket Domostroi"},{"lang_id":"c_uk","value":" супермаркет Домострой"}]},{"city_id":0,"location":{"x":50.4881172180176,"y":30.5200099945068,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" супермаркет"},{"lang_id":"c_en","value":" supermarket"},{"lang_id":"c_uk","value":" супермаркет"}]},{"city_id":0,"location":{"x":50.488452911377,"y":30.5288238525391,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Героев Сталинграда"},{"lang_id":"c_en","value":" Heroiv Stalinhradu Ave"},{"lang_id":"c_uk","value":" пр. Героїв Сталінграду"}]},{"city_id":0,"location":{"x":50.4930305480957,"y":30.5442199707031,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" парк Дружбы народов"},{"lang_id":"c_en","value":" park Druzhby narodiv"},{"lang_id":"c_uk","value":" парк Дружби народів"}]},{"city_id":0,"location":{"x":50.4951057434082,"y":30.5593147277832,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Торговый центр"},{"lang_id":"c_en","value":" Torhivelnyi tsentr"},{"lang_id":"c_uk","value":" Торгівельний центр"}]},{"city_id":0,"location":{"x":50.4953460693359,"y":30.5733909606934,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" станция Генерал Ватутина"},{"lang_id":"c_en","value":" stantsiya Henerala Vatutina"},{"lang_id":"c_uk","value":" станція Генерала Ватутіна"}]},{"city_id":0,"location":{"x":50.4953193664551,"y":30.5817699432373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" массив Радужный"},{"lang_id":"c_en","value":" masyv Raduzhnyi"},{"lang_id":"c_uk","value":" масив Радужний"}]},{"city_id":0,"location":{"x":50.497875213623,"y":30.5895481109619,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Николая Закревского"},{"lang_id":"c_en","value":" Mykoly Zakrevskoho St"},{"lang_id":"c_uk","value":" вул. Миколи Закревського"}]},{"city_id":0,"location":{"x":50.5003280639648,"y":30.589506149292,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Универсам"},{"lang_id":"c_en","value":" Universam"},{"lang_id":"c_uk","value":" Універсам"}]},{"city_id":0,"location":{"x":50.5029525756836,"y":30.5842113494873,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" микрорайон №3"},{"lang_id":"c_en","value":" mikrorayon nomer try"},{"lang_id":"c_uk","value":" мікрорайон №3"}]},{"city_id":0,"location":{"x":50.5069465637207,"y":30.585729598999,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Каштановая"},{"lang_id":"c_en","value":" Kashtanova St"},{"lang_id":"c_uk","value":" вул. Каштанова"}]},{"city_id":0,"location":{"x":50.5084648132324,"y":30.5890274047852,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Блок услуг"},{"lang_id":"c_en","value":" Blok poslug"},{"lang_id":"c_uk","value":" Блок послуг"}]},{"city_id":0,"location":{"x":50.510196685791,"y":30.5941467285156,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Архитектора Николаева"},{"lang_id":"c_en","value":" Architektora Nikolaeva St"},{"lang_id":"c_uk","value":" вул. Архітектора Ніколаєва"}]},{"city_id":0,"location":{"x":50.5112075805664,"y":30.597095489502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Дрейзера"},{"lang_id":"c_en","value":" Dreyzera St"},{"lang_id":"c_uk","value":" вул. Дрейзера"}]},{"city_id":0,"location":{"x":50.512508392334,"y":30.6002883911133,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Викентия Беретти"},{"lang_id":"c_en","value":" Vikentiya Bereti St"},{"lang_id":"c_uk","value":" вул. Вікентія Береті"}]},{"city_id":0,"location":{"x":50.516731262207,"y":30.6058406829834,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Александра Сабурова"},{"lang_id":"c_en","value":" Oleksandra Saburova St"},{"lang_id":"c_uk","value":" вул. Олександра Сабурова"}]},{"city_id":0,"location":{"x":50.5197219848633,"y":30.6082649230957,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Константина Данькевича"},{"lang_id":"c_en","value":" Kostyantyna Dankevycha St"},{"lang_id":"c_uk","value":" вул. Костянтина Данкевича"}]},{"city_id":0,"location":{"x":50.5242805480957,"y":30.6095848083496,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Марины Цветаевой"},{"lang_id":"c_en","value":" Matyny Tsvetaevoi St"},{"lang_id":"c_uk","value":" вул. Марини Цвєтаєвої"}]},{"city_id":0,"location":{"x":50.5304412841797,"y":30.6102237701416,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Милославская"},{"lang_id":"c_en","value":" Myloslavska St"},{"lang_id":"c_uk","value":" вул. Милославська"}]}],"reverseRelations":[{"points":[{"x":50.4854049682617,"y":30.4986763000488},{"x":50.4854545593262,"y":30.498685836792},{"x":50.4853134155273,"y":30.500804901123},{"x":50.4851913452148,"y":30.5028533935547},{"x":50.4850158691406,"y":30.5052528381348},{"x":50.484935760498,"y":30.5060844421387},{"x":50.485164642334,"y":30.5058536529541},{"x":50.4856796264648,"y":30.5051498413086},{"x":50.4864158630371,"y":30.5040454864502},{"x":50.4873313903809,"y":30.5026874542236},{"x":50.4882392883301,"y":30.5013523101807},{"x":50.4884414672852,"y":30.5010776519775}]},{"points":[{"x":50.4884796142578,"y":30.501148223877},{"x":50.4884414672852,"y":30.5010776519775},{"x":50.4888114929199,"y":30.500638961792},{"x":50.4888114929199,"y":30.501277923584},{"x":50.4888076782227,"y":30.5016899108887},{"x":50.4888038635254,"y":30.5019092559814},{"x":50.4888763427734,"y":30.502799987793},{"x":50.4888648986816,"y":30.5030632019043},{"x":50.4888305664062,"y":30.5036220550537},{"x":50.4887771606445,"y":30.5049362182617},{"x":50.4887351989746,"y":30.5060024261475},{"x":50.4886932373047,"y":30.506893157959},{"x":50.488655090332,"y":30.5078868865967}]},{"points":[{"x":50.4886054992676,"y":30.5078868865967},{"x":50.488655090332,"y":30.5078868865967},{"x":50.4886169433594,"y":30.508825302124},{"x":50.4885711669922,"y":30.5099353790283},{"x":50.4885520935059,"y":30.5104656219482},{"x":50.4885215759277,"y":30.5113506317139},{"x":50.4884948730469,"y":30.5119209289551}]},{"points":[{"x":50.4884567260742,"y":30.5119209289551},{"x":50.4884948730469,"y":30.5119209289551},{"x":50.4884490966797,"y":30.5130939483643},{"x":50.4883918762207,"y":30.5145053863525},{"x":50.4883613586426,"y":30.5153541564941},{"x":50.4883079528809,"y":30.5165977478027},{"x":50.4882354736328,"y":30.5182819366455},{"x":50.4881782531738,"y":30.519660949707},{"x":50.4881629943848,"y":30.5200157165527}]},{"points":[{"x":50.4881172180176,"y":30.5200099945068},{"x":50.4881629943848,"y":30.5200157165527},{"x":50.4881172180176,"y":30.5206165313721},{"x":50.4880752563477,"y":30.5215873718262},{"x":50.4880332946777,"y":30.5225734710693},{"x":50.4880180358887,"y":30.5240001678467},{"x":50.4880332946777,"y":30.5246391296387},{"x":50.4880828857422,"y":30.5254974365234},{"x":50.488151550293,"y":30.5262107849121},{"x":50.4881896972656,"y":30.5266189575195},{"x":50.4882850646973,"y":30.5274066925049},{"x":50.488395690918,"y":30.5281105041504},{"x":50.4885215759277,"y":30.5287799835205}]},{"points":[{"x":50.488452911377,"y":30.5288238525391},{"x":50.4885215759277,"y":30.5287799835205},{"x":50.4886169433594,"y":30.5292949676514},{"x":50.488697052002,"y":30.5296649932861},{"x":50.4888076782227,"y":30.5300140380859},{"x":50.4890174865723,"y":30.5307388305664},{"x":50.489387512207,"y":30.531946182251},{"x":50.4897270202637,"y":30.5330829620361},{"x":50.4903450012207,"y":30.5350894927979},{"x":50.4909439086914,"y":30.5370407104492},{"x":50.4919891357422,"y":30.5404968261719},{"x":50.4923095703125,"y":30.5415477752686},{"x":50.4928016662598,"y":30.543140411377},{"x":50.4928932189941,"y":30.543478012085},{"x":50.4930000305176,"y":30.5438594818115},{"x":50.4930877685547,"y":30.5441875457764}]},{"points":[{"x":50.4930305480957,"y":30.5442199707031},{"x":50.4930877685547,"y":30.5441875457764},{"x":50.493221282959,"y":30.5447559356689},{"x":50.4933547973633,"y":30.5454750061035},{"x":50.4934997558594,"y":30.5462627410889},{"x":50.4936714172363,"y":30.5474967956543},{"x":50.4938011169434,"y":30.5485858917236},{"x":50.494010925293,"y":30.5501518249512},{"x":50.4941864013672,"y":30.551477432251},{"x":50.494441986084,"y":30.5534725189209},{"x":50.4946937561035,"y":30.5553665161133},{"x":50.4948616027832,"y":30.5566749572754},{"x":50.4949722290039,"y":30.5575332641602},{"x":50.4950752258301,"y":30.5584087371826},{"x":50.4951591491699,"y":30.5593032836914}]},{"points":[{"x":50.4951057434082,"y":30.5593147277832},{"x":50.4951591491699,"y":30.5593032836914},{"x":50.4953117370605,"y":30.5610694885254},{"x":50.4953842163086,"y":30.5624904632568},{"x":50.495433807373,"y":30.5636596679688},{"x":50.4954643249512,"y":30.5654888153076},{"x":50.4954528808594,"y":30.5668468475342},{"x":50.4954528808594,"y":30.5686225891113},{"x":50.4954261779785,"y":30.5705795288086},{"x":50.495418548584,"y":30.5722274780273},{"x":50.4954109191895,"y":30.5733852386475}]},{"points":[{"x":50.4953460693359,"y":30.5733909606934},{"x":50.4954109191895,"y":30.5733852386475},{"x":50.4953956604004,"y":30.5747528076172},{"x":50.4953880310059,"y":30.5758361816406},{"x":50.4953880310059,"y":30.5773334503174},{"x":50.4953880310059,"y":30.5784397125244},{"x":50.4953804016113,"y":30.5799255371094},{"x":50.4953651428223,"y":30.5817756652832}]},{"points":[{"x":50.4953193664551,"y":30.5817699432373},{"x":50.4953651428223,"y":30.5817756652832},{"x":50.4953422546387,"y":30.5822582244873},{"x":50.495304107666,"y":30.5829296112061},{"x":50.4952545166016,"y":30.5837707519531},{"x":50.4952392578125,"y":30.5843620300293},{"x":50.4952392578125,"y":30.5851230621338},{"x":50.4952430725098,"y":30.586706161499},{"x":50.495231628418,"y":30.5876541137695},{"x":50.4951972961426,"y":30.5893936157227},{"x":50.4952011108398,"y":30.5896244049072},{"x":50.4954414367676,"y":30.5895805358887},{"x":50.4956474304199,"y":30.5895118713379},{"x":50.4957885742188,"y":30.5894088745117},{"x":50.4964866638184,"y":30.5893821716309},{"x":50.4968109130859,"y":30.5893669128418},{"x":50.4973564147949,"y":30.5893878936768},{"x":50.4974555969238,"y":30.5893974304199},{"x":50.4976501464844,"y":30.5894145965576},{"x":50.4978790283203,"y":30.5894565582275}]},{"points":[{"x":50.497875213623,"y":30.5895481109619},{"x":50.4978790283203,"y":30.5894565582275},{"x":50.4979629516602,"y":30.5894889831543},{"x":50.4981117248535,"y":30.5895481109619},{"x":50.4983444213867,"y":30.5896663665771},{"x":50.4986381530762,"y":30.5898056030273},{"x":50.4990463256836,"y":30.5900268554688},{"x":50.4995803833008,"y":30.5903263092041},{"x":50.5000152587891,"y":30.5905685424805},{"x":50.5002746582031,"y":30.5894794464111}]},{"points":[{"x":50.5003280639648,"y":30.589506149292},{"x":50.5002746582031,"y":30.5894794464111},{"x":50.5003814697266,"y":30.5890064239502},{"x":50.500545501709,"y":30.5882873535156},{"x":50.5007095336914,"y":30.587574005127},{"x":50.5009002685547,"y":30.5869083404541},{"x":50.501049041748,"y":30.5864429473877},{"x":50.5011940002441,"y":30.586109161377},{"x":50.5014533996582,"y":30.5856113433838},{"x":50.5017585754395,"y":30.5851554870605},{"x":50.5020446777344,"y":30.5848274230957},{"x":50.5022850036621,"y":30.5846195220947},{"x":50.5025444030762,"y":30.5844249725342},{"x":50.5029296875,"y":30.5841407775879}]},{"points":[{"x":50.5029525756836,"y":30.5842113494873},{"x":50.5029296875,"y":30.5841407775879},{"x":50.5033683776855,"y":30.5839157104492},{"x":50.5035705566406,"y":30.5838508605957},{"x":50.503791809082,"y":30.5838031768799},{"x":50.5040397644043,"y":30.5838031768799},{"x":50.5043296813965,"y":30.5838146209717},{"x":50.5046844482422,"y":30.5838680267334},{"x":50.5050277709961,"y":30.5839042663574},{"x":50.5053253173828,"y":30.584041595459},{"x":50.5054550170898,"y":30.5840950012207},{"x":50.5055732727051,"y":30.5841846466064},{"x":50.5058746337891,"y":30.5844058990479},{"x":50.5061531066895,"y":30.5846328735352},{"x":50.5062713623047,"y":30.5847473144531},{"x":50.5064926147461,"y":30.5850200653076},{"x":50.5066108703613,"y":30.5851497650146},{"x":50.5069808959961,"y":30.5856800079346}]},{"points":[{"x":50.5069465637207,"y":30.585729598999},{"x":50.5069808959961,"y":30.5856800079346},{"x":50.5071601867676,"y":30.5859222412109},{"x":50.5074310302734,"y":30.5863933563232},{"x":50.507698059082,"y":30.5868873596191},{"x":50.5079917907715,"y":30.5875644683838},{"x":50.5082740783691,"y":30.5882930755615},{"x":50.5085144042969,"y":30.5889854431152}]},{"points":[{"x":50.5084648132324,"y":30.5890274047852},{"x":50.5085144042969,"y":30.5889854431152},{"x":50.5088653564453,"y":30.5900535583496},{"x":50.5092964172363,"y":30.5912971496582},{"x":50.5097236633301,"y":30.5925788879395},{"x":50.509937286377,"y":30.5931911468506},{"x":50.5102424621582,"y":30.5941181182861}]},{"points":[{"x":50.510196685791,"y":30.5941467285156},{"x":50.5102424621582,"y":30.5941181182861},{"x":50.5107002258301,"y":30.5954551696777},{"x":50.5109596252441,"y":30.596227645874},{"x":50.5112419128418,"y":30.597053527832}]},{"points":[{"x":50.5112075805664,"y":30.597095489502},{"x":50.5112419128418,"y":30.597053527832},{"x":50.5114555358887,"y":30.5976428985596},{"x":50.5116806030273,"y":30.5982875823975},{"x":50.5118827819824,"y":30.5988235473633},{"x":50.5121612548828,"y":30.5994510650635},{"x":50.5123977661133,"y":30.5999603271484},{"x":50.5125465393066,"y":30.6002407073975}]},{"points":[{"x":50.512508392334,"y":30.6002883911133},{"x":50.5125465393066,"y":30.6002407073975},{"x":50.5129547119141,"y":30.6009578704834},{"x":50.5134010314941,"y":30.6017570495605},{"x":50.5136413574219,"y":30.602165222168},{"x":50.5139579772949,"y":30.6026916503906},{"x":50.5142478942871,"y":30.6030673980713},{"x":50.5144920349121,"y":30.6033611297607},{"x":50.5148429870605,"y":30.6037750244141},{"x":50.5150985717773,"y":30.6040267944336},{"x":50.5154609680176,"y":30.6044139862061},{"x":50.5162391662598,"y":30.6052131652832},{"x":50.5167579650879,"y":30.6057605743408}]},{"points":[{"x":50.516731262207,"y":30.6058406829834},{"x":50.5167579650879,"y":30.6057605743408},{"x":50.517749786377,"y":30.6067409515381},{"x":50.5187644958496,"y":30.6075782775879},{"x":50.5191612243652,"y":30.6078510284424},{"x":50.519645690918,"y":30.6081581115723},{"x":50.5197334289551,"y":30.6082057952881}]},{"points":[{"x":50.5197219848633,"y":30.6082649230957},{"x":50.5197334289551,"y":30.6082057952881},{"x":50.5202331542969,"y":30.6085014343262},{"x":50.5210914611816,"y":30.608865737915},{"x":50.5216407775879,"y":30.6090755462646},{"x":50.5220642089844,"y":30.609188079834},{"x":50.5223922729492,"y":30.6092624664307},{"x":50.5229644775391,"y":30.6093597412109},{"x":50.5234527587891,"y":30.6094284057617},{"x":50.5242805480957,"y":30.609504699707}]},{"points":[{"x":50.5242805480957,"y":30.6095848083496},{"x":50.5242805480957,"y":30.609504699707},{"x":50.5251770019531,"y":30.6096115112305},{"x":50.526252746582,"y":30.6097507476807},{"x":50.52734375,"y":30.6098690032959},{"x":50.5280838012695,"y":30.6099548339844},{"x":50.5290260314941,"y":30.6100559234619},{"x":50.5299301147461,"y":30.610164642334},{"x":50.5302734375,"y":30.6102066040039},{"x":50.5304412841797,"y":30.6102237701416}]}]}
12	2	c_route_bus	20	{"cityID":2,"routeID":369,"routeType":"c_route_bus","number":"20","timeStart":22800,"timeFinish":79500,"intervalMin":600,"intervalMax":600,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4125556945801,"y":30.5239505767822,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лыбедская"},{"lang_id":"c_en","value":" Lybidska "},{"lang_id":"c_uk","value":" ст. м. Либідська"}]},{"city_id":0,"location":{"x":50.4077606201172,"y":30.5201015472412,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автовокзал"},{"lang_id":"c_en","value":" Autovokzal"},{"lang_id":"c_uk","value":" Автовокзал"}]},{"city_id":0,"location":{"x":50.404945373535156,"y":30.522768020629883,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Науки"},{"lang_id":"c_en","value":" Nauky Ave"},{"lang_id":"c_uk","value":" пр. Науки"}]},{"city_id":0,"location":{"x":50.3993339538574,"y":30.5295429229736,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кинотеатр Салют"},{"lang_id":"c_en","value":" Kinoteatr Salut"},{"lang_id":"c_uk","value":" Кінотеатр Салют"}]},{"city_id":0,"location":{"x":50.3956451416016,"y":30.5313396453857,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Грабовского"},{"lang_id":"c_en","value":" Pavla Hrabovskoho St"},{"lang_id":"c_uk","value":" вул. Павла Грабовського"}]},{"city_id":0,"location":{"x":50.3929405212402,"y":30.530689239502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Гидрометеорологическая"},{"lang_id":"c_en","value":" Hidrometeolohochna"},{"lang_id":"c_uk","value":" Гідрометеологічна"}]},{"city_id":0,"location":{"x":50.3901062011719,"y":30.5293006896973,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лысогорская"},{"lang_id":"c_en","value":" Lysohorska St"},{"lang_id":"c_uk","value":" вул. Лисогорська"}]},{"city_id":0,"location":{"x":50.3856010437012,"y":30.5307807922363,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт физики"},{"lang_id":"c_en","value":" Instytut phizyky"},{"lang_id":"c_uk","value":" Інститут фізики"}]},{"city_id":0,"location":{"x":50.3788871765137,"y":30.5347290039062,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Багриновая гора"},{"lang_id":"c_en","value":" Bahrinova hora"},{"lang_id":"c_uk","value":" Багрінова гора"}]},{"city_id":0,"location":{"x":50.3769378662109,"y":30.5375881195068,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Маршальская"},{"lang_id":"c_en","value":" Marshalska St"},{"lang_id":"c_uk","value":" вул. Маршальська"}]},{"city_id":0,"location":{"x":50.37255859375,"y":30.5450611114502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Китаевская"},{"lang_id":"c_en","value":" Kytaevska St"},{"lang_id":"c_uk","value":" вул. Китаєвська"}]},{"city_id":0,"location":{"x":50.37075424194336,"y":30.55097770690918,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Набережно-Корчеватская"},{"lang_id":"c_en","value":" Naberezhno-Korchuvatska St"},{"lang_id":"c_uk","value":" вул. Набережно-Корчуватська"}]},{"city_id":0,"location":{"x":50.36868667602539,"y":30.552865982055664,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Остановка"},{"lang_id":"c_en","value":" Stop"},{"lang_id":"c_uk","value":" Зупинка"}]},{"city_id":0,"location":{"x":50.36592102050781,"y":30.557157516479492,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Укрпочта"},{"lang_id":"c_en","value":" Ukrposhta"},{"lang_id":"c_uk","value":" Укрпошта"}]},{"city_id":0,"location":{"x":50.36363983154297,"y":30.559803009033203,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Школа"},{"lang_id":"c_en","value":" Shkola"},{"lang_id":"c_uk","value":" Школа"}]},{"city_id":0,"location":{"x":50.36091995239258,"y":30.55855369567871,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/м Корчувате"},{"lang_id":"c_en","value":" Korchuvate"},{"lang_id":"c_uk","value":" ж/м Корчувате"}]}],"directRelations":[{"points":[{"x":50.4125556945801,"y":30.5239505767822},{"x":50.41259002685547,"y":30.524038314819336},{"x":50.41228485107422,"y":30.52444076538086},{"x":50.41182327270508,"y":30.52497673034668},{"x":50.41163635253906,"y":30.525175094604492},{"x":50.41105270385742,"y":30.5258731842041},{"x":50.410926818847656,"y":30.52590560913086},{"x":50.410804748535156,"y":30.525882720947266},{"x":50.41065979003906,"y":30.52582550048828},{"x":50.410579681396484,"y":30.525728225708008},{"x":50.41020584106445,"y":30.5250301361084},{"x":50.40966796875,"y":30.524097442626953},{"x":50.409423828125,"y":30.523550033569336},{"x":50.409183502197266,"y":30.52302360534668},{"x":50.40890884399414,"y":30.522499084472656},{"x":50.40852355957031,"y":30.521774291992188},{"x":50.408164978027344,"y":30.521087646484375},{"x":50.40791702270508,"y":30.520620346069336},{"x":50.407711029052734,"y":30.520143508911133}]},{"points":[{"x":50.4077606201172,"y":30.5201015472412},{"x":50.407711029052734,"y":30.520143508911133},{"x":50.40739822387695,"y":30.51943016052246},{"x":50.407222747802734,"y":30.51902198791504},{"x":50.40701675415039,"y":30.518678665161133},{"x":50.4068603515625,"y":30.518367767333984},{"x":50.406612396240234,"y":30.518056869506836},{"x":50.40632629394531,"y":30.517793655395508},{"x":50.405792236328125,"y":30.517440795898438},{"x":50.40510559082031,"y":30.517005920410156},{"x":50.40471649169922,"y":30.51675796508789},{"x":50.40436553955078,"y":30.516544342041016},{"x":50.40391159057617,"y":30.516286849975586},{"x":50.40382385253906,"y":30.516334533691406},{"x":50.403778076171875,"y":30.516469955444336},{"x":50.40378189086914,"y":30.516695022583008},{"x":50.404048919677734,"y":30.516887664794922},{"x":50.40459442138672,"y":30.51720428466797},{"x":50.40499496459961,"y":30.517444610595703},{"x":50.40530776977539,"y":30.517648696899414},{"x":50.4053840637207,"y":30.51778793334961},{"x":50.405418395996094,"y":30.518056869506836},{"x":50.40544891357422,"y":30.518598556518555},{"x":50.405452728271484,"y":30.5190486907959},{"x":50.40547561645508,"y":30.519344329833984},{"x":50.405521392822266,"y":30.519731521606445},{"x":50.40574645996094,"y":30.520164489746094},{"x":50.40598678588867,"y":30.520626068115234},{"x":50.406009674072266,"y":30.520904541015625},{"x":50.406009674072266,"y":30.521190643310547},{"x":50.405941009521484,"y":30.521656036376953},{"x":50.40552520751953,"y":30.52225685119629},{"x":50.40513229370117,"y":30.52274513244629},{"x":50.405006408691406,"y":30.522911071777344}]},{"points":[{"x":50.404945373535156,"y":30.522768020629883},{"x":50.405006408691406,"y":30.522911071777344},{"x":50.4044189453125,"y":30.52372169494629},{"x":50.40418243408203,"y":30.524049758911133},{"x":50.404029846191406,"y":30.524248123168945},{"x":50.40386199951172,"y":30.524568557739258},{"x":50.40339279174805,"y":30.525346755981445},{"x":50.40312576293945,"y":30.52572250366211},{"x":50.402713775634766,"y":30.526329040527344},{"x":50.402252197265625,"y":30.5269718170166},{"x":50.4021110534668,"y":30.52716064453125},{"x":50.40208053588867,"y":30.52725601196289},{"x":50.40143585205078,"y":30.527809143066406},{"x":50.40088653564453,"y":30.528297424316406},{"x":50.40020751953125,"y":30.528871536254883},{"x":50.39978790283203,"y":30.529258728027344},{"x":50.39936828613281,"y":30.52960205078125}]},{"points":[{"x":50.3993339538574,"y":30.5295429229736},{"x":50.39936828613281,"y":30.52960205078125},{"x":50.398841857910156,"y":30.530052185058594},{"x":50.398193359375,"y":30.530555725097656},{"x":50.397586822509766,"y":30.53090476989746},{"x":50.39720153808594,"y":30.531082153320312},{"x":50.39678955078125,"y":30.53123664855957},{"x":50.396263122558594,"y":30.5313663482666},{"x":50.39603805541992,"y":30.53139305114746},{"x":50.39581298828125,"y":30.531408309936523},{"x":50.39565658569336,"y":30.53141975402832}]},{"points":[{"x":50.3956451416016,"y":30.5313396453857},{"x":50.39565658569336,"y":30.53141975402832},{"x":50.395286560058594,"y":30.53144073486328},{"x":50.3949089050293,"y":30.531431198120117},{"x":50.39447021484375,"y":30.53134536743164},{"x":50.39364242553711,"y":30.531118392944336},{"x":50.393367767333984,"y":30.53098487854004},{"x":50.39292907714844,"y":30.53077507019043}]},{"points":[{"x":50.3929405212402,"y":30.530689239502},{"x":50.39292907714844,"y":30.53077507019043},{"x":50.39254379272461,"y":30.530582427978516},{"x":50.39139938354492,"y":30.529998779296875},{"x":50.390724182128906,"y":30.529638290405273},{"x":50.390316009521484,"y":30.529434204101562},{"x":50.39011001586914,"y":30.529386520385742}]},{"points":[{"x":50.3901062011719,"y":30.5293006896973},{"x":50.39011001586914,"y":30.529386520385742},{"x":50.38990020751953,"y":30.52937126159668},{"x":50.389686584472656,"y":30.52939796447754},{"x":50.389373779296875,"y":30.529504776000977},{"x":50.387916564941406,"y":30.5300350189209},{"x":50.387168884277344,"y":30.530298233032227},{"x":50.38607406616211,"y":30.53067398071289},{"x":50.385623931884766,"y":30.530860900878906}]},{"points":[{"x":50.3856010437012,"y":30.5307807922363},{"x":50.385623931884766,"y":30.530860900878906},{"x":50.38520431518555,"y":30.531049728393555},{"x":50.3843879699707,"y":30.53141975402832},{"x":50.38364028930664,"y":30.531768798828125},{"x":50.38240051269531,"y":30.5323429107666},{"x":50.381683349609375,"y":30.532686233520508},{"x":50.381404876708984,"y":30.532873153686523},{"x":50.38087844848633,"y":30.53323745727539},{"x":50.380245208740234,"y":30.533689498901367},{"x":50.37980651855469,"y":30.533994674682617},{"x":50.3795051574707,"y":30.534252166748047},{"x":50.379188537597656,"y":30.534563064575195},{"x":50.37893295288086,"y":30.534826278686523}]},{"points":[{"x":50.3788871765137,"y":30.5347290039062},{"x":50.37893295288086,"y":30.534826278686523},{"x":50.37860870361328,"y":30.53514862060547},{"x":50.37843322753906,"y":30.535383224487305},{"x":50.37823486328125,"y":30.535663604736328},{"x":50.377960205078125,"y":30.536087036132812},{"x":50.37723922729492,"y":30.537208557128906},{"x":50.37697219848633,"y":30.537647247314453}]},{"points":[{"x":50.3769378662109,"y":30.5375881195068},{"x":50.37697219848633,"y":30.537647247314453},{"x":50.376678466796875,"y":30.538179397583008},{"x":50.37595748901367,"y":30.53965950012207},{"x":50.37539291381836,"y":30.540834426879883},{"x":50.37511444091797,"y":30.541316986083984},{"x":50.374961853027344,"y":30.541521072387695},{"x":50.37480163574219,"y":30.541627883911133},{"x":50.37462615966797,"y":30.54166030883789},{"x":50.37443542480469,"y":30.541645050048828},{"x":50.37428665161133,"y":30.541595458984375},{"x":50.3741569519043,"y":30.54148292541504},{"x":50.3737678527832,"y":30.541086196899414},{"x":50.373634338378906,"y":30.541038513183594},{"x":50.37350082397461,"y":30.541080474853516},{"x":50.37337875366211,"y":30.541215896606445},{"x":50.3733024597168,"y":30.5413875579834},{"x":50.37324142456055,"y":30.54168701171875},{"x":50.37291717529297,"y":30.543420791625977},{"x":50.3726692199707,"y":30.544734954833984},{"x":50.37260818481445,"y":30.545082092285156}]},{"points":[{"x":50.37255859375,"y":30.5450611114502},{"x":50.37260818481445,"y":30.545082092285156},{"x":50.37253952026367,"y":30.545377731323242},{"x":50.37245178222656,"y":30.545673370361328},{"x":50.3723258972168,"y":30.546085357666016},{"x":50.37222671508789,"y":30.546375274658203},{"x":50.37184143066406,"y":30.547422409057617},{"x":50.371360778808594,"y":30.548751831054688},{"x":50.3712043762207,"y":30.549148559570312},{"x":50.37117385864258,"y":30.549283981323242},{"x":50.37118148803711,"y":30.549503326416016},{"x":50.37118148803711,"y":30.549755096435547},{"x":50.37117385864258,"y":30.550029754638672},{"x":50.37082290649414,"y":30.550024032592773},{"x":50.37080764770508,"y":30.550989151000977}]},{"points":[{"x":50.37075424194336,"y":30.55097770690918},{"x":50.37080764770508,"y":30.550989151000977},{"x":50.370792388916016,"y":30.551172256469727},{"x":50.3707160949707,"y":30.551332473754883},{"x":50.37051010131836,"y":30.551498413085938},{"x":50.369285583496094,"y":30.55242156982422},{"x":50.369014739990234,"y":30.55262565612793},{"x":50.36888122558594,"y":30.552776336669922},{"x":50.36872100830078,"y":30.552942276000977}]},{"points":[{"x":50.36868667602539,"y":30.552865982055664},{"x":50.36872100830078,"y":30.552942276000977},{"x":50.36786651611328,"y":30.554014205932617},{"x":50.367557525634766,"y":30.554460525512695},{"x":50.36674118041992,"y":30.55585479736328},{"x":50.36597442626953,"y":30.55721664428711}]},{"points":[{"x":50.36592102050781,"y":30.557157516479492},{"x":50.36597442626953,"y":30.55721664428711},{"x":50.36561584472656,"y":30.557861328125},{"x":50.36531066894531,"y":30.55844497680664},{"x":50.365081787109375,"y":30.558923721313477},{"x":50.36494445800781,"y":30.559228897094727},{"x":50.364864349365234,"y":30.559341430664062},{"x":50.36474609375,"y":30.5594425201416},{"x":50.36457443237305,"y":30.559560775756836},{"x":50.36418533325195,"y":30.559755325317383},{"x":50.363956451416016,"y":30.559856414794922},{"x":50.363746643066406,"y":30.559900283813477},{"x":50.36362838745117,"y":30.55990982055664}]},{"points":[{"x":50.36363983154297,"y":30.559803009033203},{"x":50.36362838745117,"y":30.55990982055664},{"x":50.36330795288086,"y":30.55998992919922},{"x":50.362571716308594,"y":30.56014060974121},{"x":50.36214065551758,"y":30.56018829345703},{"x":50.361942291259766,"y":30.560184478759766},{"x":50.36158752441406,"y":30.56006622314453},{"x":50.36128616333008,"y":30.559947967529297},{"x":50.36105728149414,"y":30.559755325317383},{"x":50.3609619140625,"y":30.55950164794922},{"x":50.36085891723633,"y":30.559207916259766},{"x":50.36085891723633,"y":30.558879852294922},{"x":50.36091995239258,"y":30.55855369567871}]}],"reverseStations":[{"city_id":0,"location":{"x":50.3609619140625,"y":30.558591842651367,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ж/м Корчувате"},{"lang_id":"c_en","value":" Korchuvate"},{"lang_id":"c_uk","value":" ж/м Корчувате"}]},{"city_id":0,"location":{"x":50.3626670837402,"y":30.5558223724365,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Овощная база"},{"lang_id":"c_en","value":" Ovocheva baza"},{"lang_id":"c_uk","value":" Овочева база"}]},{"city_id":0,"location":{"x":50.3639106750488,"y":30.5499210357666,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корчеватое 2"},{"lang_id":"c_en","value":" Korchevate 2"},{"lang_id":"c_uk","value":" Корчевате 2"}]},{"city_id":0,"location":{"x":50.3698768615723,"y":30.5500602722168,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Корчеватский КБМ"},{"lang_id":"c_en","value":" Korchevatskyi KBM"},{"lang_id":"c_uk","value":" Корчеватський КБМ"}]},{"city_id":0,"location":{"x":50.3725852966309,"y":30.54541015625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Китаевская"},{"lang_id":"c_en","value":" Kytaevska St"},{"lang_id":"c_uk","value":" вул. Китаєвська"}]},{"city_id":0,"location":{"x":50.377269744873,"y":30.5372772216797,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Маршальская"},{"lang_id":"c_en","value":" Marshalska St"},{"lang_id":"c_uk","value":" вул. Маршальська"}]},{"city_id":0,"location":{"x":50.3808975219727,"y":30.5333194732666,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Багриновая гора"},{"lang_id":"c_en","value":" Bahrinova hora"},{"lang_id":"c_uk","value":" Багрінова гора"}]},{"city_id":0,"location":{"x":50.3852195739746,"y":30.531135559082,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт физики"},{"lang_id":"c_en","value":" Instytut phizyky"},{"lang_id":"c_uk","value":" Інститут фізики"}]},{"city_id":0,"location":{"x":50.3907127380371,"y":30.5297183990479,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лысогорская"},{"lang_id":"c_en","value":" Lysohorska St"},{"lang_id":"c_uk","value":" вул. Лисогорська"}]},{"city_id":0,"location":{"x":50.3929214477539,"y":30.5308666229248,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Гидрометеорологическая"},{"lang_id":"c_en","value":" Hidrometeolohochna"},{"lang_id":"c_uk","value":" Гідрометеологічна"}]},{"city_id":0,"location":{"x":50.3958168029785,"y":30.5314846038818,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Грабовского"},{"lang_id":"c_en","value":" Pavla Hrabovskoho St"},{"lang_id":"c_uk","value":" вул. Павла Грабовського"}]},{"city_id":0,"location":{"x":50.4002380371094,"y":30.5289421081543,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кинотеатр Салют"},{"lang_id":"c_en","value":" Kinoteatr Salut"},{"lang_id":"c_uk","value":" Кінотеатр Салют"}]},{"city_id":0,"location":{"x":50.4058647155762,"y":30.5221710205078,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кондитерская фабрика"},{"lang_id":"c_en","value":" Kondyterska fabryka"},{"lang_id":"c_uk","value":" Кондитерська фабрика"}]},{"city_id":0,"location":{"x":50.4077644348145,"y":30.5210933685303,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автовокзал"},{"lang_id":"c_en","value":" Autovokzal"},{"lang_id":"c_uk","value":" Автовокзал"}]},{"city_id":0,"location":{"x":50.4128532409668,"y":30.525550842285156,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лыбедская"},{"lang_id":"c_en","value":" Lybidska "},{"lang_id":"c_uk","value":" ст. м. Либідська"}]}],"reverseRelations":[{"points":[{"x":50.3609619140625,"y":30.558591842651367},{"x":50.36091995239258,"y":30.55855369567871},{"x":50.36159133911133,"y":30.557479858398438},{"x":50.362464904785156,"y":30.556026458740234},{"x":50.36262893676758,"y":30.555763244628906}]},{"points":[{"x":50.3626670837402,"y":30.5558223724365},{"x":50.36262893676758,"y":30.555763244628906},{"x":50.36284637451172,"y":30.55539894104004},{"x":50.36351013183594,"y":30.554277420043945},{"x":50.3636360168457,"y":30.553611755371094},{"x":50.36370849609375,"y":30.552865982055664},{"x":50.36370849609375,"y":30.552324295043945},{"x":50.363624572753906,"y":30.551353454589844},{"x":50.363555908203125,"y":30.55069351196289},{"x":50.36355209350586,"y":30.550506591796875},{"x":50.36356735229492,"y":30.550168991088867},{"x":50.3636360168457,"y":30.549846649169922},{"x":50.36373519897461,"y":30.549846649169922},{"x":50.3639030456543,"y":30.54985237121582}]},{"points":[{"x":50.3639106750488,"y":30.5499210357666},{"x":50.3639030456543,"y":30.54985237121582},{"x":50.364646911621094,"y":30.54987335205078},{"x":50.3655891418457,"y":30.549888610839844},{"x":50.36629867553711,"y":30.549915313720703},{"x":50.36735153198242,"y":30.549959182739258},{"x":50.36818313598633,"y":30.54998016357422},{"x":50.369136810302734,"y":30.549985885620117},{"x":50.369876861572266,"y":30.549991607666016}]},{"points":[{"x":50.3698768615723,"y":30.5500602722168},{"x":50.369876861572266,"y":30.549991607666016},{"x":50.37085723876953,"y":30.550006866455078},{"x":50.37117385864258,"y":30.550029754638672},{"x":50.37118148803711,"y":30.549755096435547},{"x":50.37118148803711,"y":30.549503326416016},{"x":50.37117385864258,"y":30.549283981323242},{"x":50.3712043762207,"y":30.549148559570312},{"x":50.371360778808594,"y":30.548751831054688},{"x":50.37184143066406,"y":30.547422409057617},{"x":50.37222671508789,"y":30.546375274658203},{"x":50.3723258972168,"y":30.546085357666016},{"x":50.37245178222656,"y":30.545673370361328},{"x":50.37253952026367,"y":30.545377731323242}]},{"points":[{"x":50.3725852966309,"y":30.54541015625},{"x":50.37253952026367,"y":30.545377731323242},{"x":50.37260818481445,"y":30.545082092285156},{"x":50.3726692199707,"y":30.544734954833984},{"x":50.37291717529297,"y":30.543420791625977},{"x":50.37324142456055,"y":30.54168701171875},{"x":50.3733024597168,"y":30.5413875579834},{"x":50.37337875366211,"y":30.541215896606445},{"x":50.37350082397461,"y":30.541080474853516},{"x":50.373634338378906,"y":30.541038513183594},{"x":50.3737678527832,"y":30.541086196899414},{"x":50.3741569519043,"y":30.54148292541504},{"x":50.37428665161133,"y":30.541595458984375},{"x":50.37443542480469,"y":30.541645050048828},{"x":50.37462615966797,"y":30.54166030883789},{"x":50.37480163574219,"y":30.541627883911133},{"x":50.374961853027344,"y":30.541521072387695},{"x":50.37511444091797,"y":30.541316986083984},{"x":50.37539291381836,"y":30.540834426879883},{"x":50.37595748901367,"y":30.53965950012207},{"x":50.376678466796875,"y":30.538179397583008},{"x":50.37697219848633,"y":30.537647247314453},{"x":50.37723922729492,"y":30.537208557128906}]},{"points":[{"x":50.377269744873,"y":30.5372772216797},{"x":50.37723922729492,"y":30.537208557128906},{"x":50.377960205078125,"y":30.536087036132812},{"x":50.37823486328125,"y":30.535663604736328},{"x":50.37843322753906,"y":30.535383224487305},{"x":50.37860870361328,"y":30.53514862060547},{"x":50.37893295288086,"y":30.534826278686523},{"x":50.379188537597656,"y":30.534563064575195},{"x":50.3795051574707,"y":30.534252166748047},{"x":50.37980651855469,"y":30.533994674682617},{"x":50.380245208740234,"y":30.533689498901367},{"x":50.38087844848633,"y":30.53323745727539}]},{"points":[{"x":50.3808975219727,"y":30.5333194732666},{"x":50.38087844848633,"y":30.53323745727539},{"x":50.381404876708984,"y":30.532873153686523},{"x":50.381683349609375,"y":30.532686233520508},{"x":50.38240051269531,"y":30.5323429107666},{"x":50.38364028930664,"y":30.531768798828125},{"x":50.3843879699707,"y":30.53141975402832},{"x":50.38520431518555,"y":30.531049728393555}]},{"points":[{"x":50.3852195739746,"y":30.531135559082},{"x":50.38520431518555,"y":30.531049728393555},{"x":50.385623931884766,"y":30.530860900878906},{"x":50.38607406616211,"y":30.53067398071289},{"x":50.387168884277344,"y":30.530298233032227},{"x":50.387916564941406,"y":30.5300350189209},{"x":50.389373779296875,"y":30.529504776000977},{"x":50.389686584472656,"y":30.52939796447754},{"x":50.38990020751953,"y":30.52937126159668},{"x":50.39011001586914,"y":30.529386520385742},{"x":50.390316009521484,"y":30.529434204101562},{"x":50.390724182128906,"y":30.529638290405273}]},{"points":[{"x":50.3907127380371,"y":30.5297183990479},{"x":50.390724182128906,"y":30.529638290405273},{"x":50.39139938354492,"y":30.529998779296875},{"x":50.39254379272461,"y":30.530582427978516},{"x":50.39292907714844,"y":30.53077507019043}]},{"points":[{"x":50.3929214477539,"y":30.5308666229248},{"x":50.39292907714844,"y":30.53077507019043},{"x":50.393367767333984,"y":30.53098487854004},{"x":50.39364242553711,"y":30.531118392944336},{"x":50.39447021484375,"y":30.53134536743164},{"x":50.3949089050293,"y":30.531431198120117},{"x":50.395286560058594,"y":30.53144073486328},{"x":50.39565658569336,"y":30.53141975402832},{"x":50.39581298828125,"y":30.531408309936523}]},{"points":[{"x":50.3958168029785,"y":30.5314846038818},{"x":50.39581298828125,"y":30.531408309936523},{"x":50.39603805541992,"y":30.53139305114746},{"x":50.396263122558594,"y":30.5313663482666},{"x":50.39678955078125,"y":30.53123664855957},{"x":50.39720153808594,"y":30.531082153320312},{"x":50.397586822509766,"y":30.53090476989746},{"x":50.398193359375,"y":30.530555725097656},{"x":50.398841857910156,"y":30.530052185058594},{"x":50.39936828613281,"y":30.52960205078125},{"x":50.39978790283203,"y":30.529258728027344},{"x":50.40020751953125,"y":30.528871536254883}]},{"points":[{"x":50.4002380371094,"y":30.5289421081543},{"x":50.40020751953125,"y":30.528871536254883},{"x":50.40088653564453,"y":30.528297424316406},{"x":50.40143585205078,"y":30.527809143066406},{"x":50.40208053588867,"y":30.52725601196289},{"x":50.40225601196289,"y":30.527128219604492},{"x":50.40239334106445,"y":30.52695655822754},{"x":50.40314483642578,"y":30.525985717773438},{"x":50.40336227416992,"y":30.52567481994629},{"x":50.40350341796875,"y":30.52548599243164},{"x":50.40396499633789,"y":30.524961471557617},{"x":50.40438461303711,"y":30.52446174621582},{"x":50.40461730957031,"y":30.524017333984375},{"x":50.4047737121582,"y":30.52366828918457},{"x":50.4048957824707,"y":30.52346420288086},{"x":50.40552520751953,"y":30.522546768188477},{"x":50.40583419799805,"y":30.522111892700195}]},{"points":[{"x":50.4058647155762,"y":30.5221710205078},{"x":50.40583419799805,"y":30.522111892700195},{"x":50.4063835144043,"y":30.521329879760742},{"x":50.40658950805664,"y":30.521039962768555},{"x":50.40681457519531,"y":30.52068519592285},{"x":50.406951904296875,"y":30.520545959472656},{"x":50.40708923339844,"y":30.520465850830078},{"x":50.40724563598633,"y":30.520471572875977},{"x":50.407474517822266,"y":30.520566940307617},{"x":50.407623291015625,"y":30.520732879638672},{"x":50.40780258178711,"y":30.52104949951172}]},{"points":[{"x":50.4077644348145,"y":30.5210933685303},{"x":50.40780258178711,"y":30.52104949951172},{"x":50.40803527832031,"y":30.5214786529541},{"x":50.4081916809082,"y":30.521780014038086},{"x":50.408485412597656,"y":30.52210235595703},{"x":50.40911102294922,"y":30.523239135742188},{"x":50.40937423706055,"y":30.523813247680664},{"x":50.40948486328125,"y":30.524215698242188},{"x":50.40952682495117,"y":30.524505615234375},{"x":50.409515380859375,"y":30.524799346923828},{"x":50.4094352722168,"y":30.52510643005371},{"x":50.409278869628906,"y":30.52546501159668},{"x":50.409149169921875,"y":30.52577018737793},{"x":50.40909957885742,"y":30.526086807250977},{"x":50.409088134765625,"y":30.526382446289062},{"x":50.40915298461914,"y":30.52674102783203},{"x":50.40925979614258,"y":30.52700424194336},{"x":50.40940475463867,"y":30.527193069458008},{"x":50.40960693359375,"y":30.527347564697266},{"x":50.409793853759766,"y":30.52739715576172},{"x":50.40997314453125,"y":30.527347564697266},{"x":50.410160064697266,"y":30.52725601196289},{"x":50.410343170166016,"y":30.52716064453125},{"x":50.410770416259766,"y":30.526865005493164},{"x":50.411460876464844,"y":30.526426315307617},{"x":50.412109375,"y":30.526023864746094},{"x":50.4124755859375,"y":30.525793075561523},{"x":50.4128532409668,"y":30.525550842285156}]}]}
13	2	c_route_bus	23	{"cityID":2,"routeID":234,"routeType":"c_route_bus","number":"23","timeStart":21960,"timeFinish":78660,"intervalMin":300,"intervalMax":480,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4719772338867,"y":30.404878616333,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Салютная"},{"lang_id":"c_en","value":" Salutna St"},{"lang_id":"c_uk","value":" вул. Салютна"}]},{"city_id":0,"location":{"x":50.4718132019043,"y":30.3958072662354,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Салютная"},{"lang_id":"c_en","value":" Salutna St"},{"lang_id":"c_uk","value":" вул. Салютна"}]},{"city_id":0,"location":{"x":50.4643173217773,"y":30.3959045410156,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Эстонская"},{"lang_id":"c_en","value":" Estonska St"},{"lang_id":"c_uk","value":" вул. Естонська"}]},{"city_id":0,"location":{"x":50.4587478637695,"y":30.3959350585938,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод 50-летия Октября"},{"lang_id":"c_en","value":" zavod pyatydesyatyrichya Zhovtnya"},{"lang_id":"c_uk","value":" завод 50-річчя Жовтня"}]},{"city_id":0,"location":{"x":50.4579200744629,"y":30.3933563232422,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Святошин"},{"lang_id":"c_en","value":" Svyatoshyn"},{"lang_id":"c_uk","value":" ст. м. Святошин"}]},{"city_id":0,"location":{"x":50.4572792053223,"y":30.3839950561523,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Генерала Витрука"},{"lang_id":"c_en","value":" Henerala Vitruka St"},{"lang_id":"c_uk","value":" вул. Генерала Вітрука"}]},{"city_id":0,"location":{"x":50.4569435119629,"y":30.3788394927979,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Академика Вернадского"},{"lang_id":"c_en","value":" Akademika Vernadskoho Blvd"},{"lang_id":"c_uk","value":" бул. Академіка Вернадського"}]},{"city_id":0,"location":{"x":50.4565086364746,"y":30.3724346160889,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ивана Крамского"},{"lang_id":"c_en","value":" Ivana Kramskoho St"},{"lang_id":"c_uk","value":" вул. Івана Крамського"}]},{"city_id":0,"location":{"x":50.4560317993164,"y":30.3651809692383,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Житомирская"},{"lang_id":"c_en","value":" Zhytomyrska"},{"lang_id":"c_uk","value":" ст. м. Житомирська"}]},{"city_id":0,"location":{"x":50.4549980163574,"y":30.356840133667,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Победы"},{"lang_id":"c_en","value":" Peremohy Ave"},{"lang_id":"c_uk","value":" пр. Перемоги"}]},{"city_id":0,"location":{"x":50.4519691467285,"y":30.3572959899902,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Верховинная"},{"lang_id":"c_en","value":" Verkhovynna St"},{"lang_id":"c_uk","value":" вул. Верховинна"}]},{"city_id":0,"location":{"x":50.4480628967285,"y":30.3576183319092,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Святошинское кладбище"},{"lang_id":"c_en","value":" Svyatoshynske kladovyshe"},{"lang_id":"c_uk","value":" Святошинське кладовище"}]},{"city_id":0,"location":{"x":50.4435043334961,"y":30.3582611083984,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Янтарная"},{"lang_id":"c_en","value":" Yantarna St"},{"lang_id":"c_uk","value":" вул. Янтарна"}]},{"city_id":0,"location":{"x":50.4363899230957,"y":30.3593997955322,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жмеринская"},{"lang_id":"c_en","value":" Zhmerynska St"},{"lang_id":"c_uk","value":" вул. Жмеринська"}]},{"city_id":0,"location":{"x":50.431510925293,"y":30.3612594604492,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Электронмаш"},{"lang_id":"c_en","value":" zavod Elektronmash"},{"lang_id":"c_uk","value":" завод Електронмаш"}]},{"city_id":0,"location":{"x":50.425048828125,"y":30.3662338256836,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Леся Курбаса"},{"lang_id":"c_en","value":" Lesya Kurbasa Ave"},{"lang_id":"c_uk","value":" пр. Леся Курбаса"}]},{"city_id":0,"location":{"x":50.4250564575195,"y":30.369140625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кольцевая дорога"},{"lang_id":"c_en","value":" Kiltseva doroga"},{"lang_id":"c_uk","value":" Кільцева дорога"}]},{"city_id":0,"location":{"x":50.4253158569336,"y":30.374532699585,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Кольцова"},{"lang_id":"c_en","value":" Koltsova Blvd"},{"lang_id":"c_uk","value":" бул. Кольцова"}]},{"city_id":0,"location":{"x":50.4230575561523,"y":30.3772678375244,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" школа №131"},{"lang_id":"c_en","value":" shkola 131"},{"lang_id":"c_uk","value":" школа №131"}]},{"city_id":0,"location":{"x":50.4200401306152,"y":30.3820953369141,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом быта"},{"lang_id":"c_en","value":" Budynok pobutu"},{"lang_id":"c_uk","value":" Будинок побуту"}]},{"city_id":0,"location":{"x":50.4176292419434,"y":30.3871650695801,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Семьи Сосниных"},{"lang_id":"c_en","value":" Simyi Sosninykh"},{"lang_id":"c_uk","value":" вул. Сім\\u0027ї Сосніних"}]},{"city_id":0,"location":{"x":50.4142723083496,"y":30.3948097229004,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жолудева"},{"lang_id":"c_en","value":" Zholudeva St"},{"lang_id":"c_uk","value":" вул. Жолудєва"}]},{"city_id":0,"location":{"x":50.4106407165527,"y":30.3974323272705,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Григоровича-Барского"},{"lang_id":"c_en","value":" Hryhorovycha-Barskoho St"},{"lang_id":"c_uk","value":" вул. Григоровича-Барського"}]},{"city_id":0,"location":{"x":50.408504486084,"y":30.401273727417,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4073715209961,"y":30.4089660644531,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Симиренко"},{"lang_id":"c_en","value":" Symyrenka St"},{"lang_id":"c_uk","value":" вул. Симиренка"}]}],"directRelations":[{"points":[{"x":50.4719772338867,"y":30.404878616333},{"x":50.4719276428223,"y":30.404878616333},{"x":50.4719314575195,"y":30.4024810791016},{"x":50.4719390869141,"y":30.4004421234131},{"x":50.4719429016113,"y":30.398006439209},{"x":50.4719429016113,"y":30.3958873748779},{"x":50.4718170166016,"y":30.3958873748779}]},{"points":[{"x":50.4718132019043,"y":30.3958072662354},{"x":50.4718170166016,"y":30.3958873748779},{"x":50.4706573486328,"y":30.3959197998047},{"x":50.4694976806641,"y":30.3959312438965},{"x":50.468074798584,"y":30.3959522247314},{"x":50.4664840698242,"y":30.3959789276123},{"x":50.4650764465332,"y":30.3959846496582},{"x":50.464656829834,"y":30.3959903717041},{"x":50.4643173217773,"y":30.3959941864014}]},{"points":[{"x":50.4643173217773,"y":30.3959045410156},{"x":50.4643173217773,"y":30.3959941864014},{"x":50.4629364013672,"y":30.3960056304932},{"x":50.4613952636719,"y":30.3960208892822},{"x":50.4605178833008,"y":30.3960380554199},{"x":50.4592933654785,"y":30.396017074585},{"x":50.4587554931641,"y":30.3960208892822}]},{"points":[{"x":50.4587478637695,"y":30.3959350585938},{"x":50.4587554931641,"y":30.3960208892822},{"x":50.4585304260254,"y":30.3960266113281},{"x":50.4580612182617,"y":30.3960208892822},{"x":50.4579925537109,"y":30.3950824737549},{"x":50.457935333252,"y":30.3943157196045},{"x":50.4578704833984,"y":30.3933601379395}]},{"points":[{"x":50.4579200744629,"y":30.3933563232422},{"x":50.4578704833984,"y":30.3933601379395},{"x":50.4577598571777,"y":30.3918704986572},{"x":50.457633972168,"y":30.3900566101074},{"x":50.4575271606445,"y":30.3885059356689},{"x":50.4574127197266,"y":30.3868274688721},{"x":50.4572257995605,"y":30.3840007781982}]},{"points":[{"x":50.4572792053223,"y":30.3839950561523},{"x":50.4572257995605,"y":30.3840007781982},{"x":50.4570999145508,"y":30.382080078125},{"x":50.4570083618164,"y":30.3804759979248},{"x":50.4568939208984,"y":30.3788452148438}]},{"points":[{"x":50.4569435119629,"y":30.3788394927979},{"x":50.4568939208984,"y":30.3788452148438},{"x":50.4568023681641,"y":30.3774509429932},{"x":50.4566535949707,"y":30.3753795623779},{"x":50.4565238952637,"y":30.3734531402588},{"x":50.4564552307129,"y":30.3724403381348}]},{"points":[{"x":50.4565086364746,"y":30.3724346160889},{"x":50.4564552307129,"y":30.3724403381348},{"x":50.4563484191895,"y":30.3708305358887},{"x":50.456241607666,"y":30.3691558837891},{"x":50.456111907959,"y":30.3671932220459},{"x":50.4559860229492,"y":30.3651866912842}]},{"points":[{"x":50.4560317993164,"y":30.3651809692383},{"x":50.4559860229492,"y":30.3651866912842},{"x":50.4558906555176,"y":30.3637657165527},{"x":50.455753326416,"y":30.3617115020752},{"x":50.4556541442871,"y":30.3602848052979},{"x":50.4555397033691,"y":30.3585453033447},{"x":50.4554290771484,"y":30.356653213501},{"x":50.4553146362305,"y":30.3550224304199},{"x":50.4553604125977,"y":30.3548183441162},{"x":50.4554443359375,"y":30.3545703887939},{"x":50.4555168151855,"y":30.3544635772705},{"x":50.455638885498,"y":30.3543663024902},{"x":50.4557685852051,"y":30.3542766571045},{"x":50.455940246582,"y":30.3542537689209},{"x":50.4561462402344,"y":30.3543186187744},{"x":50.456298828125,"y":30.3544788360596},{"x":50.4564247131348,"y":30.3547534942627},{"x":50.4564781188965,"y":30.3552894592285},{"x":50.4565315246582,"y":30.3558750152588},{"x":50.456470489502,"y":30.3562774658203},{"x":50.4563674926758,"y":30.3565120697021},{"x":50.4562339782715,"y":30.3566360473633},{"x":50.456111907959,"y":30.3567543029785},{"x":50.455493927002,"y":30.3568458557129},{"x":50.4549942016602,"y":30.3569374084473}]},{"points":[{"x":50.4549980163574,"y":30.356840133667},{"x":50.4549942016602,"y":30.3569374084473},{"x":50.454158782959,"y":30.3570709228516},{"x":50.4530181884766,"y":30.3572254180908},{"x":50.4524230957031,"y":30.3573112487793},{"x":50.4519653320312,"y":30.3573608398438}]},{"points":[{"x":50.4519691467285,"y":30.3572959899902},{"x":50.4519653320312,"y":30.3573608398438},{"x":50.451301574707,"y":30.3574028015137},{"x":50.4505195617676,"y":30.357479095459},{"x":50.4495582580566,"y":30.3575477600098},{"x":50.4489631652832,"y":30.3575973510742},{"x":50.4484367370605,"y":30.3576602935791},{"x":50.448055267334,"y":30.3577041625977}]},{"points":[{"x":50.4480628967285,"y":30.3576183319092},{"x":50.448055267334,"y":30.3577041625977},{"x":50.4472579956055,"y":30.357795715332},{"x":50.4464378356934,"y":30.3578853607178},{"x":50.4460258483887,"y":30.3579235076904},{"x":50.4452323913574,"y":30.3580532073975},{"x":50.4444961547852,"y":30.3581809997559},{"x":50.4435043334961,"y":30.3583374023438}]},{"points":[{"x":50.4435043334961,"y":30.3582611083984},{"x":50.4435043334961,"y":30.3583374023438},{"x":50.4426231384277,"y":30.3584594726562},{"x":50.4417381286621,"y":30.3586158752441},{"x":50.4405326843262,"y":30.358793258667},{"x":50.4391899108887,"y":30.3590126037598},{"x":50.4377632141113,"y":30.3592433929443},{"x":50.4363822937012,"y":30.3594799041748}]},{"points":[{"x":50.4363899230957,"y":30.3593997955322},{"x":50.4363822937012,"y":30.3594799041748},{"x":50.4357261657715,"y":30.3595657348633},{"x":50.4348182678223,"y":30.3597469329834},{"x":50.4344329833984,"y":30.3598289489746},{"x":50.434009552002,"y":30.3599300384521},{"x":50.433650970459,"y":30.3600425720215},{"x":50.4332046508789,"y":30.3602027893066},{"x":50.4325065612793,"y":30.3606109619141},{"x":50.4315376281738,"y":30.3613510131836}]},{"points":[{"x":50.431510925293,"y":30.3612594604492},{"x":50.4315376281738,"y":30.3613510131836},{"x":50.4306449890137,"y":30.3620433807373},{"x":50.4296875,"y":30.3627738952637},{"x":50.4287300109863,"y":30.3634967803955},{"x":50.4276390075684,"y":30.3643455505371},{"x":50.4267463684082,"y":30.3650207519531},{"x":50.425838470459,"y":30.3657188415527},{"x":50.4250679016113,"y":30.3663196563721}]},{"points":[{"x":50.425048828125,"y":30.3662338256836},{"x":50.4250679016113,"y":30.3663196563721},{"x":50.424488067627,"y":30.3667755126953},{"x":50.4237518310547,"y":30.367338180542},{"x":50.423511505127,"y":30.3673496246338},{"x":50.4233436584473,"y":30.3672637939453},{"x":50.4232482910156,"y":30.3671245574951},{"x":50.4231796264648,"y":30.3668670654297},{"x":50.4232177734375,"y":30.3665866851807},{"x":50.4233207702637,"y":30.3664054870605},{"x":50.4238433837891,"y":30.3660182952881},{"x":50.4240798950195,"y":30.3660087585449},{"x":50.424243927002,"y":30.3661251068115},{"x":50.4243965148926,"y":30.3664474487305},{"x":50.424488067627,"y":30.3667755126953},{"x":50.4251136779785,"y":30.3690986633301}]},{"points":[{"x":50.4250564575195,"y":30.369140625},{"x":50.4251136779785,"y":30.3690986633301},{"x":50.4260139465332,"y":30.3726711273193},{"x":50.4259872436523,"y":30.3731212615967},{"x":50.4258804321289,"y":30.3738193511963},{"x":50.4257469177246,"y":30.3741073608398},{"x":50.4256134033203,"y":30.3742904663086},{"x":50.4253387451172,"y":30.3745956420898}]},{"points":[{"x":50.4253158569336,"y":30.374532699585},{"x":50.4253387451172,"y":30.3745956420898},{"x":50.424633026123,"y":30.3753089904785},{"x":50.4241371154785,"y":30.3758087158203},{"x":50.423656463623,"y":30.3765163421631},{"x":50.4230880737305,"y":30.3773212432861}]},{"points":[{"x":50.4230575561523,"y":30.3772678375244},{"x":50.4230880737305,"y":30.3773212432861},{"x":50.4226913452148,"y":30.3779277801514},{"x":50.4222602844238,"y":30.3786144256592},{"x":50.4220924377441,"y":30.3788833618164},{"x":50.421215057373,"y":30.3802871704102},{"x":50.4203033447266,"y":30.3817691802979},{"x":50.4200782775879,"y":30.3821487426758}]},{"points":[{"x":50.4200401306152,"y":30.3820953369141},{"x":50.4200782775879,"y":30.3821487426758},{"x":50.4196586608887,"y":30.3829479217529},{"x":50.4193496704102,"y":30.3835391998291},{"x":50.419116973877,"y":30.3840484619141},{"x":50.4185791015625,"y":30.3852291107178},{"x":50.4179992675781,"y":30.3864898681641},{"x":50.417667388916,"y":30.3872089385986}]},{"points":[{"x":50.4176292419434,"y":30.3871650695801},{"x":50.417667388916,"y":30.3872089385986},{"x":50.4170989990234,"y":30.3884468078613},{"x":50.4167518615723,"y":30.3892574310303},{"x":50.4166374206543,"y":30.3895797729492},{"x":50.4164924621582,"y":30.3900623321533},{"x":50.4161491394043,"y":30.391414642334},{"x":50.4158477783203,"y":30.3926162719727},{"x":50.4156265258789,"y":30.3931312561035},{"x":50.4153747558594,"y":30.3936138153076},{"x":50.4150886535645,"y":30.39404296875},{"x":50.4147453308105,"y":30.3944873809814},{"x":50.4145698547363,"y":30.3946762084961},{"x":50.4142875671387,"y":30.394889831543}]},{"points":[{"x":50.4142723083496,"y":30.3948097229004},{"x":50.4142875671387,"y":30.394889831543},{"x":50.4137763977051,"y":30.3951530456543},{"x":50.4132461547852,"y":30.3953990936279},{"x":50.4128608703613,"y":30.3956146240234},{"x":50.4123954772949,"y":30.395881652832},{"x":50.4119148254395,"y":30.3962211608887},{"x":50.4116134643555,"y":30.3964557647705},{"x":50.4113235473633,"y":30.3967361450195},{"x":50.4106636047363,"y":30.3975028991699}]},{"points":[{"x":50.4106407165527,"y":30.3974323272705},{"x":50.4106636047363,"y":30.3975028991699},{"x":50.4102554321289,"y":30.3980236053467},{"x":50.4098320007324,"y":30.3986396789551},{"x":50.4094505310059,"y":30.399299621582},{"x":50.4091186523438,"y":30.3999214172363},{"x":50.4088401794434,"y":30.4005279541016},{"x":50.4085350036621,"y":30.4013156890869}]},{"points":[{"x":50.408504486084,"y":30.401273727417},{"x":50.4085350036621,"y":30.4013156890869},{"x":50.4083061218262,"y":30.4019985198975},{"x":50.4081077575684,"y":30.4026794433594},{"x":50.4078521728516,"y":30.4036445617676},{"x":50.4076042175293,"y":30.4048080444336},{"x":50.4073867797852,"y":30.4060478210449},{"x":50.4072265625,"y":30.4070777893066},{"x":50.4071388244629,"y":30.4077587127686},{"x":50.4071426391602,"y":30.4081993103027},{"x":50.4072227478027,"y":30.4085311889648},{"x":50.4073715209961,"y":30.4089660644531}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4078903198242,"y":30.407506942749,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Симиренко"},{"lang_id":"c_en","value":" Symyrenka St"},{"lang_id":"c_uk","value":" вул. Симиренка"}]},{"city_id":0,"location":{"x":50.4096374511719,"y":30.3998470306396,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Булгакова"},{"lang_id":"c_en","value":" Bulhakova St"},{"lang_id":"c_uk","value":" вул. Булгакова"}]},{"city_id":0,"location":{"x":50.4121170043945,"y":30.3966865539551,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Григоровича-Барского"},{"lang_id":"c_en","value":" Hryhorovycha-Barskoho St"},{"lang_id":"c_uk","value":" вул. Григоровича-Барського"}]},{"city_id":0,"location":{"x":50.4147491455078,"y":30.3951263427734,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жолудева"},{"lang_id":"c_en","value":" Zholudeva St"},{"lang_id":"c_uk","value":" вул. Жолудєва"}]},{"city_id":0,"location":{"x":50.4176635742188,"y":30.388801574707,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Кольцова"},{"lang_id":"c_en","value":" Koltsova Blvd"},{"lang_id":"c_uk","value":" бул. Кольцова"}]},{"city_id":0,"location":{"x":50.420337677002,"y":30.3818225860596,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Дом быта"},{"lang_id":"c_en","value":" Budynok pobutu"},{"lang_id":"c_uk","value":" Будинок побуту"}]},{"city_id":0,"location":{"x":50.4220237731934,"y":30.3781261444092,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" школа №131"},{"lang_id":"c_en","value":" shkola 131"},{"lang_id":"c_uk","value":" школа №131"}]},{"city_id":0,"location":{"x":50.4198570251465,"y":30.3733081817627,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Зодчих"},{"lang_id":"c_en","value":" Zodchych St"},{"lang_id":"c_uk","value":" вул. Зодчих"}]},{"city_id":0,"location":{"x":50.4262390136719,"y":30.3659496307373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Леся Курбаса"},{"lang_id":"c_en","value":" Lesya Kurbasa Ave"},{"lang_id":"c_uk","value":" пр. Леся Курбаса"}]},{"city_id":0,"location":{"x":50.4308395385742,"y":30.3625583648682,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ПО Электронмаш"},{"lang_id":"c_en","value":" Elektronmash"},{"lang_id":"c_uk","value":" ПО Електронмаш"}]},{"city_id":0,"location":{"x":50.436408996582,"y":30.3601131439209,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жмеринская"},{"lang_id":"c_en","value":" Zhmerynska St"},{"lang_id":"c_uk","value":" вул. Жмеринська"}]},{"city_id":0,"location":{"x":50.4433746337891,"y":30.3589382171631,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Янтарная"},{"lang_id":"c_en","value":" Yantarna St"},{"lang_id":"c_uk","value":" вул. Янтарна"}]},{"city_id":0,"location":{"x":50.4481658935547,"y":30.3582134246826,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Святошинское кладбище"},{"lang_id":"c_en","value":" Svyatoshynske kladovyshe"},{"lang_id":"c_uk","value":" Святошинське кладовище"}]},{"city_id":0,"location":{"x":50.4520072937012,"y":30.3577098846436,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Верховинная"},{"lang_id":"c_en","value":" Verkhovynna St"},{"lang_id":"c_uk","value":" вул. Верховинна"}]},{"city_id":0,"location":{"x":50.4554824829102,"y":30.3601818084717,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Победы"},{"lang_id":"c_en","value":" Peremohy Ave"},{"lang_id":"c_uk","value":" пр. Перемоги"}]},{"city_id":0,"location":{"x":50.4558029174805,"y":30.3649730682373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Житомирская"},{"lang_id":"c_en","value":" Zhytomyrska"},{"lang_id":"c_uk","value":" ст. м. Житомирська"}]},{"city_id":0,"location":{"x":50.4563179016113,"y":30.3726329803467,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ивана Крамского"},{"lang_id":"c_en","value":" Ivana Kramskoho St"},{"lang_id":"c_uk","value":" вул. Івана Крамського"}]},{"city_id":0,"location":{"x":50.4567604064941,"y":30.3794460296631,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бул. Академика Вернадского"},{"lang_id":"c_en","value":" Akademika Vernadskoho Blvd"},{"lang_id":"c_uk","value":" бул. Академіка Вернадського"}]},{"city_id":0,"location":{"x":50.4570503234863,"y":30.3836307525635,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Генерала Витрука"},{"lang_id":"c_en","value":" Henerala Vitruka St"},{"lang_id":"c_uk","value":" вул. Генерала Вітрука"}]},{"city_id":0,"location":{"x":50.4576988220215,"y":30.393404006958,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Святошин"},{"lang_id":"c_en","value":" Svyatoshyn"},{"lang_id":"c_uk","value":" ст. м. Святошин"}]},{"city_id":0,"location":{"x":50.4581298828125,"y":30.3997707366943,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Невская"},{"lang_id":"c_en","value":" Nevska St"},{"lang_id":"c_uk","value":" вул. Невська"}]},{"city_id":0,"location":{"x":50.458309173584,"y":30.4035797119141,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Щербакова"},{"lang_id":"c_en","value":" Sherbakova St"},{"lang_id":"c_uk","value":" вул. Щербакова"}]},{"city_id":0,"location":{"x":50.4597015380859,"y":30.4058971405029,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Нивки"},{"lang_id":"c_en","value":" Nyvky"},{"lang_id":"c_uk","value":" ст. м. Нивки"}]},{"city_id":0,"location":{"x":50.4645919799805,"y":30.4058876037598,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Эстонская"},{"lang_id":"c_en","value":" Estonska St"},{"lang_id":"c_uk","value":" вул. Естонська"}]},{"city_id":0,"location":{"x":50.4680366516113,"y":30.4058876037598,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Краснодарская"},{"lang_id":"c_en","value":" Krasnodarska St"},{"lang_id":"c_uk","value":" вул. Краснодарська"}]},{"city_id":0,"location":{"x":50.4702568054199,"y":30.4058704376221,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Вильгельма Пика"},{"lang_id":"c_en","value":" Vilhelma Pika St"},{"lang_id":"c_uk","value":" вул. Вільгельма Піка"}]},{"city_id":0,"location":{"x":50.4719276428223,"y":30.404878616333,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Салютная"},{"lang_id":"c_en","value":" Salutna St"},{"lang_id":"c_uk","value":" вул. Салютна"}]}],"reverseRelations":[{"points":[{"x":50.4078903198242,"y":30.407506942749},{"x":50.4078407287598,"y":30.4075126647949},{"x":50.4077796936035,"y":30.4067668914795},{"x":50.4078483581543,"y":30.4051742553711},{"x":50.4079322814941,"y":30.404727935791},{"x":50.4081192016602,"y":30.4038600921631},{"x":50.408390045166,"y":30.4027652740479},{"x":50.4086418151855,"y":30.4019813537598},{"x":50.4089508056641,"y":30.4011707305908},{"x":50.4092330932617,"y":30.4005489349365},{"x":50.4096031188965,"y":30.399787902832}]},{"points":[{"x":50.4096374511719,"y":30.3998470306396},{"x":50.4096031188965,"y":30.399787902832},{"x":50.4101409912109,"y":30.3988170623779},{"x":50.4106826782227,"y":30.3980770111084},{"x":50.4113616943359,"y":30.3972549438477},{"x":50.4115524291992,"y":30.3970623016357},{"x":50.4121017456055,"y":30.3966217041016}]},{"points":[{"x":50.4121170043945,"y":30.3966865539551},{"x":50.4121017456055,"y":30.3966217041016},{"x":50.4123039245605,"y":30.3964557647705},{"x":50.4126586914062,"y":30.3962249755859},{"x":50.4130210876465,"y":30.3959999084473},{"x":50.4135360717773,"y":30.3957424163818},{"x":50.4140357971191,"y":30.3954963684082},{"x":50.4143867492676,"y":30.3952980041504},{"x":50.4146423339844,"y":30.3951263427734},{"x":50.4147338867188,"y":30.3950500488281}]},{"points":[{"x":50.4147491455078,"y":30.3951263427734},{"x":50.4147338867188,"y":30.3950500488281},{"x":50.4149513244629,"y":30.394868850708},{"x":50.415168762207,"y":30.3946380615234},{"x":50.4153518676758,"y":30.3944282531738},{"x":50.4155616760254,"y":30.3941059112549},{"x":50.4157524108887,"y":30.3937530517578},{"x":50.4159088134766,"y":30.3933982849121},{"x":50.4160270690918,"y":30.39306640625},{"x":50.4161338806152,"y":30.3927116394043},{"x":50.4162673950195,"y":30.3921432495117},{"x":50.4165229797363,"y":30.3911457061768},{"x":50.4167556762695,"y":30.3902931213379},{"x":50.4170722961426,"y":30.3904914855957},{"x":50.4172401428223,"y":30.3905773162842},{"x":50.417423248291,"y":30.3905239105225},{"x":50.4175567626953,"y":30.3903942108154},{"x":50.4176368713379,"y":30.3901748657227},{"x":50.4177780151367,"y":30.3896160125732},{"x":50.4178009033203,"y":30.3893051147461},{"x":50.4177742004395,"y":30.3890972137451},{"x":50.4177017211914,"y":30.3889293670654},{"x":50.4176445007324,"y":30.3888702392578}]},{"points":[{"x":50.4176635742188,"y":30.388801574707},{"x":50.4176445007324,"y":30.3888702392578},{"x":50.4170989990234,"y":30.3884468078613},{"x":50.417667388916,"y":30.3872089385986},{"x":50.4179992675781,"y":30.3864898681641},{"x":50.4185791015625,"y":30.3852291107178},{"x":50.419116973877,"y":30.3840484619141},{"x":50.4193496704102,"y":30.3835391998291},{"x":50.4196586608887,"y":30.3829479217529},{"x":50.4200782775879,"y":30.3821487426758},{"x":50.4203033447266,"y":30.3817691802979}]},{"points":[{"x":50.420337677002,"y":30.3818225860596},{"x":50.4203033447266,"y":30.3817691802979},{"x":50.421215057373,"y":30.3802871704102},{"x":50.4220924377441,"y":30.3788833618164},{"x":50.4222602844238,"y":30.3786144256592},{"x":50.4219856262207,"y":30.3781852722168}]},{"points":[{"x":50.4220237731934,"y":30.3781261444092},{"x":50.4219856262207,"y":30.3781852722168},{"x":50.4211273193359,"y":30.3768501281738},{"x":50.4204444885254,"y":30.3757877349854},{"x":50.4193382263184,"y":30.374044418335},{"x":50.4195251464844,"y":30.3737277984619},{"x":50.4198188781738,"y":30.3732490539551}]},{"points":[{"x":50.4198570251465,"y":30.3733081817627},{"x":50.4198188781738,"y":30.3732490539551},{"x":50.4203071594238,"y":30.3724555969238},{"x":50.4210205078125,"y":30.3713073730469},{"x":50.4213485717773,"y":30.3707714080811},{"x":50.4214096069336,"y":30.3704719543457},{"x":50.4214477539062,"y":30.3701591491699},{"x":50.421516418457,"y":30.3699398040771},{"x":50.4216041564941,"y":30.3697853088379},{"x":50.4216690063477,"y":30.3695964813232},{"x":50.4221954345703,"y":30.3690433502197},{"x":50.4224281311035,"y":30.368803024292},{"x":50.4230422973633,"y":30.3682613372803},{"x":50.4235534667969,"y":30.3678207397461},{"x":50.4244956970215,"y":30.3671016693115},{"x":50.4252853393555,"y":30.3665008544922},{"x":50.4255752563477,"y":30.3662929534912},{"x":50.4262313842773,"y":30.365873336792}]},{"points":[{"x":50.4262390136719,"y":30.3659496307373},{"x":50.4262313842773,"y":30.365873336792},{"x":50.4266967773438,"y":30.3655738830566},{"x":50.4271697998047,"y":30.3652248382568},{"x":50.4280815124512,"y":30.3645439147949},{"x":50.4290466308594,"y":30.3638191223145},{"x":50.4296951293945,"y":30.3633422851562},{"x":50.4305000305176,"y":30.3627300262451},{"x":50.4308242797852,"y":30.3624782562256}]},{"points":[{"x":50.4308395385742,"y":30.3625583648682},{"x":50.4308242797852,"y":30.3624782562256},{"x":50.4314842224121,"y":30.3619747161865},{"x":50.4320220947266,"y":30.3615608215332},{"x":50.4325141906738,"y":30.3611698150635},{"x":50.4327354431152,"y":30.3610343933105},{"x":50.4330635070801,"y":30.3608417510986},{"x":50.4334144592285,"y":30.3607025146484},{"x":50.4340362548828,"y":30.3604831695557},{"x":50.4344673156738,"y":30.3603706359863},{"x":50.4352264404297,"y":30.3602294921875},{"x":50.4357528686523,"y":30.3601398468018},{"x":50.4364013671875,"y":30.3600273132324}]},{"points":[{"x":50.436408996582,"y":30.3601131439209},{"x":50.4364013671875,"y":30.3600273132324},{"x":50.4372673034668,"y":30.3599033355713},{"x":50.4383010864258,"y":30.3597373962402},{"x":50.4394187927246,"y":30.3595600128174},{"x":50.4405250549316,"y":30.3593616485596},{"x":50.4413642883301,"y":30.3592109680176},{"x":50.4420318603516,"y":30.3590984344482},{"x":50.4428215026855,"y":30.3589649200439},{"x":50.4433746337891,"y":30.3588619232178}]},{"points":[{"x":50.4433746337891,"y":30.3589382171631},{"x":50.4433746337891,"y":30.3588619232178},{"x":50.4439125061035,"y":30.3587875366211},{"x":50.4451484680176,"y":30.3585834503174},{"x":50.4461250305176,"y":30.3584384918213},{"x":50.4472770690918,"y":30.3582668304443},{"x":50.4481658935547,"y":30.3581390380859}]},{"points":[{"x":50.4481658935547,"y":30.3582134246826},{"x":50.4481658935547,"y":30.3581390380859},{"x":50.449104309082,"y":30.3579940795898},{"x":50.4501762390137,"y":30.3578433990479},{"x":50.451000213623,"y":30.3577365875244},{"x":50.4520034790039,"y":30.3576393127441}]},{"points":[{"x":50.4520072937012,"y":30.3577098846436},{"x":50.4520034790039,"y":30.3576393127441},{"x":50.4525184631348,"y":30.3575649261475},{"x":50.4530448913574,"y":30.357479095459},{"x":50.4532012939453,"y":30.3574466705322},{"x":50.4533805847168,"y":30.3575801849365},{"x":50.4536209106445,"y":30.3577632904053},{"x":50.453800201416,"y":30.3579978942871},{"x":50.4538993835449,"y":30.3582668304443},{"x":50.454029083252,"y":30.35862159729},{"x":50.454158782959,"y":30.3588199615479},{"x":50.4542922973633,"y":30.3589324951172},{"x":50.454475402832,"y":30.3589973449707},{"x":50.4546356201172,"y":30.3589973449707},{"x":50.454891204834,"y":30.3589649200439},{"x":50.4551124572754,"y":30.3589916229248},{"x":50.4553070068359,"y":30.3591632843018},{"x":50.4554862976074,"y":30.3594532012939},{"x":50.4555282592773,"y":30.3601760864258}]},{"points":[{"x":50.4554824829102,"y":30.3601818084717},{"x":50.4555282592773,"y":30.3601760864258},{"x":50.4556922912598,"y":30.3625965118408},{"x":50.4558448791504,"y":30.3649559020996}]},{"points":[{"x":50.4558029174805,"y":30.3649730682373},{"x":50.4558448791504,"y":30.3649559020996},{"x":50.4559516906738,"y":30.3665065765381},{"x":50.4560928344727,"y":30.3685455322266},{"x":50.4562339782715,"y":30.3706111907959},{"x":50.4563674926758,"y":30.3726215362549}]},{"points":[{"x":50.4563179016113,"y":30.3726329803467},{"x":50.4563674926758,"y":30.3726215362549},{"x":50.45654296875,"y":30.3754501342773},{"x":50.4566688537598,"y":30.3774280548096},{"x":50.4567756652832,"y":30.3790378570557},{"x":50.4568023681641,"y":30.3794403076172}]},{"points":[{"x":50.4567604064941,"y":30.3794460296631},{"x":50.4568023681641,"y":30.3794403076172},{"x":50.4569854736328,"y":30.3821754455566},{"x":50.457088470459,"y":30.3836307525635}]},{"points":[{"x":50.4570503234863,"y":30.3836307525635},{"x":50.457088470459,"y":30.3836307525635},{"x":50.4572143554688,"y":30.3856201171875},{"x":50.4573593139648,"y":30.3878364562988},{"x":50.4575309753418,"y":30.390287399292},{"x":50.4576873779297,"y":30.3925609588623},{"x":50.4577445983887,"y":30.3933982849121}]},{"points":[{"x":50.4576988220215,"y":30.393404006958},{"x":50.4577445983887,"y":30.3933982849121},{"x":50.4579200744629,"y":30.3958606719971},{"x":50.4580726623535,"y":30.3981895446777},{"x":50.4581718444824,"y":30.3997611999512}]},{"points":[{"x":50.4581298828125,"y":30.3997707366943},{"x":50.4581718444824,"y":30.3997611999512},{"x":50.4581909179688,"y":30.4002590179443},{"x":50.4581985473633,"y":30.4009246826172},{"x":50.4582328796387,"y":30.4014930725098},{"x":50.4583511352539,"y":30.4035739898682}]},{"points":[{"x":50.458309173584,"y":30.4035797119141},{"x":50.4583511352539,"y":30.4035739898682},{"x":50.4584808349609,"y":30.4054794311523},{"x":50.4585380554199,"y":30.4063854217529},{"x":50.4586372375488,"y":30.4064826965332},{"x":50.4587478637695,"y":30.4065208435059},{"x":50.4589729309082,"y":30.4064445495605},{"x":50.4592819213867,"y":30.4060955047607},{"x":50.4594764709473,"y":30.4059200286865},{"x":50.4597015380859,"y":30.4058055877686}]},{"points":[{"x":50.4597015380859,"y":30.4058971405029},{"x":50.4597015380859,"y":30.4058055877686},{"x":50.4599456787109,"y":30.4058284759521},{"x":50.4607124328613,"y":30.4058380126953},{"x":50.4617118835449,"y":30.405834197998},{"x":50.4626960754395,"y":30.4058284759521},{"x":50.4639701843262,"y":30.4058227539062},{"x":50.4645919799805,"y":30.4058227539062}]},{"points":[{"x":50.4645919799805,"y":30.4058876037598},{"x":50.4645919799805,"y":30.4058227539062},{"x":50.4652061462402,"y":30.4058227539062},{"x":50.4663009643555,"y":30.4058170318604},{"x":50.4675903320312,"y":30.4058170318604},{"x":50.4680366516113,"y":30.4058113098145}]},{"points":[{"x":50.4680366516113,"y":30.4058876037598},{"x":50.4680366516113,"y":30.4058113098145},{"x":50.4689102172852,"y":30.4058113098145},{"x":50.4702568054199,"y":30.4057960510254}]},{"points":[{"x":50.4702568054199,"y":30.4058704376221},{"x":50.4702568054199,"y":30.4057960510254},{"x":50.471492767334,"y":30.4057960510254},{"x":50.4719276428223,"y":30.4057960510254},{"x":50.4719276428223,"y":30.404878616333}]}]}
14	2	c_route_bus	24	{"cityID":2,"routeID":235,"routeType":"c_route_bus","number":"24","timeStart":28320,"timeFinish":68160,"intervalMin":660,"intervalMax":660,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.4330139160156,"y":30.5555534362793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Музей Истории Великой Отечественной войны"},{"lang_id":"c_en","value":" Muzey Istorii Velykoi Vitchyznyanoi viyny"},{"lang_id":"c_uk","value":" Музей Історії Великої Вітчизняної війни"}]},{"city_id":0,"location":{"x":50.4367713928223,"y":30.5530433654785,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Киево-Печерский заповедник"},{"lang_id":"c_en","value":" Kyevo-Pecherskyi zapovidnyk"},{"lang_id":"c_uk","value":" Києво-Печерський заповідник"}]},{"city_id":0,"location":{"x":50.4410133361816,"y":30.5495891571045,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Славы"},{"lang_id":"c_en","value":" plosha Slavy"},{"lang_id":"c_uk","value":" площа Слави"}]},{"city_id":0,"location":{"x":50.4438667297363,"y":30.5445251464844,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Арсенальная"},{"lang_id":"c_en","value":" plosha Arsenalna"},{"lang_id":"c_uk","value":" площа Арсенальна"}]},{"city_id":0,"location":{"x":50.4454803466797,"y":30.5394763946533,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Крепостной"},{"lang_id":"c_en","value":" Krepostnyi Ln"},{"lang_id":"c_uk","value":" пров. Крепостний"}]},{"city_id":0,"location":{"x":50.4480781555176,"y":30.5346336364746,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Садовая"},{"lang_id":"c_en","value":" Sadova St"},{"lang_id":"c_uk","value":" вул. Садова"}]},{"city_id":0,"location":{"x":50.4515800476074,"y":30.5285606384277,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Европейская площадь"},{"lang_id":"c_en","value":" Evropeyska square"},{"lang_id":"c_uk","value":" Євпропейська площа"}]},{"city_id":0,"location":{"x":50.4515762329102,"y":30.5258884429932,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Гостиница Крещатик"},{"lang_id":"c_en","value":" Hotel Khreshchatyk"},{"lang_id":"c_uk","value":" Готель Хрещатик"}]},{"city_id":0,"location":{"x":50.449089050293,"y":30.5226802825928,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Архитектора Городецкого"},{"lang_id":"c_en","value":" Arkhitektora Horodetskoho St"},{"lang_id":"c_uk","value":" вул. Архітектора Городецького"}]},{"city_id":0,"location":{"x":50.4440956115723,"y":30.5206527709961,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Крещатик"},{"lang_id":"c_en","value":" Khreshatyk St"},{"lang_id":"c_uk","value":" вул. Хрещатик"}]},{"city_id":0,"location":{"x":50.43941116333008,"y":30.51642608642578,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Льва Толстого"},{"lang_id":"c_en","value":" Lwa Tolstoho"},{"lang_id":"c_uk","value":" ст. м. Льва Толстого"}]}],"directRelations":[{"points":[{"x":50.4330139160156,"y":30.5555534362793},{"x":50.432979583740234,"y":30.555500030517578},{"x":50.43319320678711,"y":30.555194854736328},{"x":50.433311462402344,"y":30.555011749267578},{"x":50.43348693847656,"y":30.554786682128906},{"x":50.433589935302734,"y":30.554718017578125},{"x":50.433956146240234,"y":30.554664611816406},{"x":50.434242248535156,"y":30.554594039916992},{"x":50.43451690673828,"y":30.55449676513672},{"x":50.434783935546875,"y":30.55438995361328},{"x":50.4350471496582,"y":30.554224014282227},{"x":50.435760498046875,"y":30.553720474243164},{"x":50.43635559082031,"y":30.553268432617188},{"x":50.43675231933594,"y":30.552963256835938}]},{"points":[{"x":50.4367713928223,"y":30.5530433654785},{"x":50.43675231933594,"y":30.552963256835938},{"x":50.43770980834961,"y":30.552255630493164},{"x":50.43879318237305,"y":30.55143928527832},{"x":50.4398078918457,"y":30.550657272338867},{"x":50.43998718261719,"y":30.550533294677734},{"x":50.440147399902344,"y":30.550426483154297},{"x":50.44032669067383,"y":30.5502872467041},{"x":50.44050216674805,"y":30.550092697143555},{"x":50.440773010253906,"y":30.549814224243164},{"x":50.44098663330078,"y":30.549535751342773}]},{"points":[{"x":50.4410133361816,"y":30.5495891571045},{"x":50.44098663330078,"y":30.549535751342773},{"x":50.441246032714844,"y":30.549198150634766},{"x":50.441585540771484,"y":30.54877281188965},{"x":50.441837310791016,"y":30.548429489135742},{"x":50.44216537475586,"y":30.54792594909668},{"x":50.4426383972168,"y":30.54720115661621},{"x":50.443275451660156,"y":30.546215057373047},{"x":50.44353103637695,"y":30.545812606811523},{"x":50.44362258911133,"y":30.54561424255371},{"x":50.443687438964844,"y":30.545425415039062},{"x":50.44371795654297,"y":30.545312881469727},{"x":50.443763732910156,"y":30.545087814331055},{"x":50.443809509277344,"y":30.54450798034668}]},{"points":[{"x":50.4438667297363,"y":30.5445251464844},{"x":50.443809509277344,"y":30.54450798034668},{"x":50.443878173828125,"y":30.543622970581055},{"x":50.443939208984375,"y":30.542882919311523},{"x":50.44403839111328,"y":30.542421340942383},{"x":50.444252014160156,"y":30.54163360595703},{"x":50.44526290893555,"y":30.539745330810547},{"x":50.44544219970703,"y":30.539417266845703}]},{"points":[{"x":50.4454803466797,"y":30.5394763946533},{"x":50.44544219970703,"y":30.539417266845703},{"x":50.44563674926758,"y":30.53907012939453},{"x":50.44625473022461,"y":30.537948608398438},{"x":50.44706726074219,"y":30.536439895629883},{"x":50.447608947753906,"y":30.53544807434082},{"x":50.44783020019531,"y":30.535018920898438},{"x":50.448028564453125,"y":30.534584045410156}]},{"points":[{"x":50.4480781555176,"y":30.5346336364746},{"x":50.448028564453125,"y":30.534584045410156},{"x":50.44865036010742,"y":30.533254623413086},{"x":50.44937515258789,"y":30.53169822692871},{"x":50.450042724609375,"y":30.53026008605957},{"x":50.450462341308594,"y":30.529510498046875},{"x":50.450706481933594,"y":30.529247283935547},{"x":50.45089340209961,"y":30.52914047241211},{"x":50.45156478881836,"y":30.528486251831055}]},{"points":[{"x":50.4515800476074,"y":30.5285606384277},{"x":50.45156478881836,"y":30.528486251831055},{"x":50.45189666748047,"y":30.52816390991211},{"x":50.452110290527344,"y":30.527971267700195},{"x":50.45223617553711,"y":30.52785301208496},{"x":50.45233917236328,"y":30.527708053588867},{"x":50.452396392822266,"y":30.52751922607422},{"x":50.452430725097656,"y":30.52736473083496},{"x":50.45242691040039,"y":30.527198791503906},{"x":50.452110290527344,"y":30.52674674987793},{"x":50.451541900634766,"y":30.525964736938477}]},{"points":[{"x":50.4515762329102,"y":30.5258884429932},{"x":50.451541900634766,"y":30.525964736938477},{"x":50.450809478759766,"y":30.52497100830078},{"x":50.450401306152344,"y":30.524396896362305},{"x":50.45006561279297,"y":30.523937225341797},{"x":50.449649810791016,"y":30.523378372192383},{"x":50.44936752319336,"y":30.523046493530273},{"x":50.44906234741211,"y":30.522762298583984}]},{"points":[{"x":50.449089050293,"y":30.5226802825928},{"x":50.44906234741211,"y":30.522762298583984},{"x":50.448822021484375,"y":30.522552490234375},{"x":50.44854736328125,"y":30.522348403930664},{"x":50.448246002197266,"y":30.522171020507812},{"x":50.4479866027832,"y":30.522037506103516},{"x":50.44773483276367,"y":30.52195167541504},{"x":50.44691467285156,"y":30.52167320251465},{"x":50.44593811035156,"y":30.521350860595703},{"x":50.445194244384766,"y":30.521108627319336},{"x":50.44476318359375,"y":30.520954132080078},{"x":50.4440803527832,"y":30.520729064941406}]},{"points":[{"x":50.4440956115723,"y":30.5206527709961},{"x":50.4440803527832,"y":30.520729064941406},{"x":50.44329071044922,"y":30.520465850830078},{"x":50.44247817993164,"y":30.520187377929688},{"x":50.442195892333984,"y":30.520057678222656},{"x":50.44136047363281,"y":30.51976776123047},{"x":50.44081115722656,"y":30.519563674926758},{"x":50.44068908691406,"y":30.519521713256836},{"x":50.440616607666016,"y":30.519418716430664},{"x":50.44019317626953,"y":30.518529891967773},{"x":50.439693450927734,"y":30.517444610595703},{"x":50.43942642211914,"y":30.516834259033203},{"x":50.439353942871094,"y":30.516677856445312},{"x":50.43941116333008,"y":30.51642608642578}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4422416687012,"y":30.5194511413574,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Бессарабская"},{"lang_id":"c_en","value":" Bessarabska square"},{"lang_id":"c_uk","value":" площа Бессарабська"}]},{"city_id":0,"location":{"x":50.4434394836426,"y":30.5207710266113,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Центральный универмаг"},{"lang_id":"c_en","value":" Tsentralnyi univermah"},{"lang_id":"c_uk","value":" Центральний універмаг"}]},{"city_id":0,"location":{"x":50.448657989502,"y":30.5226917266846,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Архитектора Городецкого"},{"lang_id":"c_en","value":" Arkhitektora Horodetskoho St"},{"lang_id":"c_uk","value":" вул. Архітектора Городецького"}]},{"city_id":0,"location":{"x":50.4509239196777,"y":30.5254821777344,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Европейская площадь"},{"lang_id":"c_en","value":" Evropeyska square"},{"lang_id":"c_uk","value":" Євпропейська площа"}]},{"city_id":0,"location":{"x":50.4512519836426,"y":30.5284862518311,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Грушевского"},{"lang_id":"c_en","value":" Hrushevskoho St"},{"lang_id":"c_uk","value":" вул. Грушевського"}]},{"city_id":0,"location":{"x":50.4475631713867,"y":30.5353832244873,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Садовая"},{"lang_id":"c_en","value":" Sadova St"},{"lang_id":"c_uk","value":" вул. Садова"}]},{"city_id":0,"location":{"x":50.4455986022949,"y":30.539005279541,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Крепостной"},{"lang_id":"c_en","value":" Krepostnyi Ln"},{"lang_id":"c_uk","value":" пров. Крепостний"}]},{"city_id":0,"location":{"x":50.4434814453125,"y":30.545768737793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Арсенальная"},{"lang_id":"c_en","value":" plosha Arsenalna"},{"lang_id":"c_uk","value":" площа Арсенальна"}]},{"city_id":0,"location":{"x":50.4399604797363,"y":30.5504531860352,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Славы"},{"lang_id":"c_en","value":" plosha Slavy"},{"lang_id":"c_uk","value":" площа Слави"}]},{"city_id":0,"location":{"x":50.4363212585449,"y":30.5531883239746,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Киево-Печерский заповедник"},{"lang_id":"c_en","value":" Kyevo-Pecherskyi zapovidnyk"},{"lang_id":"c_uk","value":" Києво-Печерський заповідник"}]},{"city_id":0,"location":{"x":50.43190383911133,"y":30.556438446044922,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Музей Истории Великой Отечественной войны"},{"lang_id":"c_en","value":" Muzey Istorii Velykoi Vitchyznyanoi viyny"},{"lang_id":"c_uk","value":" Музей Історії Великої Вітчизняної війни"}]}],"reverseRelations":[{"points":[{"x":50.4422416687012,"y":30.5194511413574},{"x":50.44229507446289,"y":30.519474029541016},{"x":50.442195892333984,"y":30.520057678222656},{"x":50.442176818847656,"y":30.52022361755371},{"x":50.44261932373047,"y":30.52040672302246},{"x":50.44344711303711,"y":30.520702362060547}]},{"points":[{"x":50.4434394836426,"y":30.5207710266113},{"x":50.44344711303711,"y":30.520702362060547},{"x":50.444759368896484,"y":30.521141052246094},{"x":50.44620132446289,"y":30.52161979675293},{"x":50.44680404663086,"y":30.521812438964844},{"x":50.44759750366211,"y":30.522075653076172},{"x":50.44791793823242,"y":30.522192001342773},{"x":50.448341369628906,"y":30.522401809692383},{"x":50.448673248291016,"y":30.522621154785156}]},{"points":[{"x":50.448657989502,"y":30.5226917266846},{"x":50.448673248291016,"y":30.522621154785156},{"x":50.44894790649414,"y":30.52284812927246},{"x":50.44926834106445,"y":30.52315902709961},{"x":50.449554443359375,"y":30.523496627807617},{"x":50.449928283691406,"y":30.52400016784668},{"x":50.45033645629883,"y":30.5245418548584},{"x":50.450958251953125,"y":30.525400161743164}]},{"points":[{"x":50.4509239196777,"y":30.5254821777344},{"x":50.450958251953125,"y":30.525400161743164},{"x":50.45185852050781,"y":30.526634216308594},{"x":50.45186233520508,"y":30.526918411254883},{"x":50.451778411865234,"y":30.527942657470703},{"x":50.45151138305664,"y":30.528318405151367},{"x":50.45127487182617,"y":30.528566360473633}]},{"points":[{"x":50.4512519836426,"y":30.5284862518311},{"x":50.45127487182617,"y":30.528566360473633},{"x":50.450904846191406,"y":30.5289363861084},{"x":50.45081329345703,"y":30.529043197631836},{"x":50.450706481933594,"y":30.529247283935547},{"x":50.450462341308594,"y":30.529510498046875},{"x":50.450042724609375,"y":30.53026008605957},{"x":50.44937515258789,"y":30.53169822692871},{"x":50.44865036010742,"y":30.533254623413086},{"x":50.448028564453125,"y":30.534584045410156},{"x":50.44783020019531,"y":30.535018920898438},{"x":50.447608947753906,"y":30.53544807434082}]},{"points":[{"x":50.4475631713867,"y":30.5353832244873},{"x":50.447608947753906,"y":30.53544807434082},{"x":50.44706726074219,"y":30.536439895629883},{"x":50.44625473022461,"y":30.537948608398438},{"x":50.44563674926758,"y":30.53907012939453}]},{"points":[{"x":50.4455986022949,"y":30.539005279541},{"x":50.44563674926758,"y":30.53907012939453},{"x":50.44544219970703,"y":30.539417266845703},{"x":50.44526290893555,"y":30.539745330810547},{"x":50.444252014160156,"y":30.54163360595703},{"x":50.44403839111328,"y":30.542421340942383},{"x":50.443939208984375,"y":30.542882919311523},{"x":50.443878173828125,"y":30.543622970581055},{"x":50.443809509277344,"y":30.54450798034668},{"x":50.443763732910156,"y":30.545087814331055},{"x":50.44371795654297,"y":30.545312881469727},{"x":50.443687438964844,"y":30.545425415039062},{"x":50.44362258911133,"y":30.54561424255371},{"x":50.44353103637695,"y":30.545812606811523}]},{"points":[{"x":50.4434814453125,"y":30.545768737793},{"x":50.44353103637695,"y":30.545812606811523},{"x":50.443275451660156,"y":30.546215057373047},{"x":50.4426383972168,"y":30.54720115661621},{"x":50.44216537475586,"y":30.54792594909668},{"x":50.441837310791016,"y":30.548429489135742},{"x":50.441585540771484,"y":30.54877281188965},{"x":50.441246032714844,"y":30.549198150634766},{"x":50.44098663330078,"y":30.549535751342773},{"x":50.440773010253906,"y":30.549814224243164},{"x":50.44050216674805,"y":30.550092697143555},{"x":50.44032669067383,"y":30.5502872467041},{"x":50.440147399902344,"y":30.550426483154297},{"x":50.43998718261719,"y":30.550533294677734}]},{"points":[{"x":50.4399604797363,"y":30.5504531860352},{"x":50.43998718261719,"y":30.550533294677734},{"x":50.4398078918457,"y":30.550657272338867},{"x":50.43879318237305,"y":30.55143928527832},{"x":50.43770980834961,"y":30.552255630493164},{"x":50.43675231933594,"y":30.552963256835938},{"x":50.43635559082031,"y":30.553268432617188}]},{"points":[{"x":50.4363212585449,"y":30.5531883239746},{"x":50.43635559082031,"y":30.553268432617188},{"x":50.435760498046875,"y":30.553720474243164},{"x":50.4350471496582,"y":30.554224014282227},{"x":50.434783935546875,"y":30.55438995361328},{"x":50.43451690673828,"y":30.55449676513672},{"x":50.434242248535156,"y":30.554594039916992},{"x":50.433956146240234,"y":30.554664611816406},{"x":50.433589935302734,"y":30.554718017578125},{"x":50.43348693847656,"y":30.554786682128906},{"x":50.433311462402344,"y":30.555011749267578},{"x":50.433143615722656,"y":30.55514144897461},{"x":50.432411193847656,"y":30.555543899536133},{"x":50.4317626953125,"y":30.555908203125},{"x":50.43182373046875,"y":30.55614471435547},{"x":50.43190383911133,"y":30.556438446044922}]}]}
15	2	c_route_bus	27	{"cityID":2,"routeID":236,"routeType":"c_route_bus","number":"27","timeStart":22260,"timeFinish":80340,"intervalMin":1200,"intervalMax":1200,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.3460235595703,"y":30.5350513458252,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" с. Пирогов"},{"lang_id":"c_en","value":" Pirihov"},{"lang_id":"c_uk","value":" с. Пірогов"}]},{"city_id":0,"location":{"x":50.3487129211426,"y":30.5378456115723,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АТП-1007"},{"lang_id":"c_en","value":" ATP-1007"},{"lang_id":"c_uk","value":" АТП-1007"}]},{"city_id":0,"location":{"x":50.3526039123535,"y":30.5408496856689,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Славутич"},{"lang_id":"c_en","value":" zavod Slavutych"},{"lang_id":"c_uk","value":" завод Славутич"}]},{"city_id":0,"location":{"x":50.3587837219238,"y":30.5440101623535,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Краснознаменная"},{"lang_id":"c_en","value":" Chervonoznamenna St"},{"lang_id":"c_uk","value":" вул. Червонознаменна"}]},{"city_id":0,"location":{"x":50.3599586486816,"y":30.5445518493652,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод ЖБК"},{"lang_id":"c_en","value":" zavod ZBK"},{"lang_id":"c_uk","value":" завод ЗБК"}]},{"city_id":0,"location":{"x":50.3725852966309,"y":30.54541015625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Китаевская"},{"lang_id":"c_en","value":" Kytaevska St"},{"lang_id":"c_uk","value":" вул. Китаєвська"}]},{"city_id":0,"location":{"x":50.377269744873,"y":30.5372772216797,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Маршальская"},{"lang_id":"c_en","value":" Marshalska St"},{"lang_id":"c_uk","value":" вул. Маршальська"}]},{"city_id":0,"location":{"x":50.3808975219727,"y":30.5333194732666,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Багриновая гора"},{"lang_id":"c_en","value":" Bahrinova hora"},{"lang_id":"c_uk","value":" Багрінова гора"}]},{"city_id":0,"location":{"x":50.3852195739746,"y":30.531135559082,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт физики"},{"lang_id":"c_en","value":" Instytut phizyky"},{"lang_id":"c_uk","value":" Інститут фізики"}]},{"city_id":0,"location":{"x":50.3907127380371,"y":30.5297183990479,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лысогорская"},{"lang_id":"c_en","value":" Lysohorska St"},{"lang_id":"c_uk","value":" вул. Лисогорська"}]},{"city_id":0,"location":{"x":50.3929214477539,"y":30.5308666229248,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Гидрометеорологическая"},{"lang_id":"c_en","value":" Hidrometeolohochna"},{"lang_id":"c_uk","value":" Гідрометеологічна"}]},{"city_id":0,"location":{"x":50.3958168029785,"y":30.5314846038818,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Грабовского"},{"lang_id":"c_en","value":" Pavla Hrabovskoho St"},{"lang_id":"c_uk","value":" вул. Павла Грабовського"}]},{"city_id":0,"location":{"x":50.4002380371094,"y":30.5289421081543,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кинотеатр Салют"},{"lang_id":"c_en","value":" Kinoteatr Salut"},{"lang_id":"c_uk","value":" Кінотеатр Салют"}]},{"city_id":0,"location":{"x":50.4058647155762,"y":30.5221710205078,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кондитерская фабрика"},{"lang_id":"c_en","value":" Kondyterska fabryka"},{"lang_id":"c_uk","value":" Кондитерська фабрика"}]},{"city_id":0,"location":{"x":50.4077644348145,"y":30.5210933685303,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автовокзал"},{"lang_id":"c_en","value":" Autovokzal"},{"lang_id":"c_uk","value":" Автовокзал"}]},{"city_id":0,"location":{"x":50.4128532409668,"y":30.5255508422852,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лыбедская"},{"lang_id":"c_en","value":" Lybidska "},{"lang_id":"c_uk","value":" ст. м. Либідська"}]}],"directRelations":[{"points":[{"x":50.3460235595703,"y":30.5350513458252},{"x":50.3460540771484,"y":30.5349769592285},{"x":50.3461990356445,"y":30.535062789917},{"x":50.3462524414062,"y":30.5349178314209},{"x":50.3465919494629,"y":30.5353088378906},{"x":50.3471298217773,"y":30.5359535217285},{"x":50.3475227355957,"y":30.5364513397217},{"x":50.3477668762207,"y":30.5367412567139},{"x":50.3484992980957,"y":30.537525177002},{"x":50.3487396240234,"y":30.5377826690674}]},{"points":[{"x":50.3487129211426,"y":30.5378456115723},{"x":50.3487396240234,"y":30.5377826690674},{"x":50.3491744995117,"y":30.5382480621338},{"x":50.3501663208008,"y":30.5394134521484},{"x":50.3504905700684,"y":30.5397777557373},{"x":50.3508071899414,"y":30.5399971008301},{"x":50.35107421875,"y":30.5401477813721},{"x":50.3517570495605,"y":30.5404376983643},{"x":50.3523216247559,"y":30.540657043457},{"x":50.3526153564453,"y":30.5407810211182}]},{"points":[{"x":50.3526039123535,"y":30.5408496856689},{"x":50.3526153564453,"y":30.5407810211182},{"x":50.3533210754395,"y":30.5410747528076},{"x":50.3537635803223,"y":30.5412464141846},{"x":50.3541488647461,"y":30.541482925415},{"x":50.3545532226562,"y":30.5417137145996},{"x":50.3551216125488,"y":30.5420417785645},{"x":50.3555717468262,"y":30.5422821044922},{"x":50.3562431335449,"y":30.5426959991455},{"x":50.356861114502,"y":30.5430450439453},{"x":50.3573417663574,"y":30.5432796478271},{"x":50.3580513000488,"y":30.5435962677002},{"x":50.3585968017578,"y":30.5438385009766},{"x":50.3587913513184,"y":30.5439357757568}]},{"points":[{"x":50.3587837219238,"y":30.5440101623535},{"x":50.3587913513184,"y":30.5439357757568},{"x":50.3592796325684,"y":30.5441646575928},{"x":50.3599700927734,"y":30.5444984436035}]},{"points":[{"x":50.3599586486816,"y":30.5445518493652},{"x":50.3599700927734,"y":30.5444984436035},{"x":50.3607330322266,"y":30.5448513031006},{"x":50.3614501953125,"y":30.5451908111572},{"x":50.3623199462891,"y":30.545581817627},{"x":50.3631896972656,"y":30.5459308624268},{"x":50.36376953125,"y":30.5461769104004},{"x":50.3642082214355,"y":30.5463104248047},{"x":50.3646583557129,"y":30.5464019775391},{"x":50.3656768798828,"y":30.5465908050537},{"x":50.3666648864746,"y":30.5467891693115},{"x":50.3674812316895,"y":30.5469436645508},{"x":50.3682594299316,"y":30.5471477508545},{"x":50.3688278198242,"y":30.5472927093506},{"x":50.369499206543,"y":30.5474758148193},{"x":50.3701210021973,"y":30.5476360321045},{"x":50.3708763122559,"y":30.5477695465088},{"x":50.3716659545898,"y":30.5479106903076},{"x":50.3718414306641,"y":30.5474224090576},{"x":50.3722267150879,"y":30.5463752746582},{"x":50.3723258972168,"y":30.546085357666},{"x":50.3724517822266,"y":30.5456733703613},{"x":50.3725395202637,"y":30.5453777313232}]},{"points":[{"x":50.3725852966309,"y":30.54541015625},{"x":50.3725395202637,"y":30.5453777313232},{"x":50.3726081848145,"y":30.5450820922852},{"x":50.3726692199707,"y":30.544734954834},{"x":50.372917175293,"y":30.543420791626},{"x":50.3732414245605,"y":30.5416870117188},{"x":50.3733024597168,"y":30.5413875579834},{"x":50.3733787536621,"y":30.5412158966064},{"x":50.3735008239746,"y":30.5410804748535},{"x":50.3736343383789,"y":30.5410385131836},{"x":50.3737678527832,"y":30.5410861968994},{"x":50.3741569519043,"y":30.541482925415},{"x":50.3742866516113,"y":30.5415954589844},{"x":50.3744354248047,"y":30.5416450500488},{"x":50.374626159668,"y":30.5416603088379},{"x":50.3748016357422,"y":30.5416278839111},{"x":50.3749618530273,"y":30.5415210723877},{"x":50.375114440918,"y":30.541316986084},{"x":50.3753929138184,"y":30.5408344268799},{"x":50.3759574890137,"y":30.5396595001221},{"x":50.3766784667969,"y":30.538179397583},{"x":50.3769721984863,"y":30.5376472473145},{"x":50.3772392272949,"y":30.5372085571289}]},{"points":[{"x":50.377269744873,"y":30.5372772216797},{"x":50.3772392272949,"y":30.5372085571289},{"x":50.3779602050781,"y":30.5360870361328},{"x":50.3782348632812,"y":30.5356636047363},{"x":50.3784332275391,"y":30.5353832244873},{"x":50.3786087036133,"y":30.5351486206055},{"x":50.3789329528809,"y":30.5348262786865},{"x":50.3791885375977,"y":30.5345630645752},{"x":50.3795051574707,"y":30.534252166748},{"x":50.3798065185547,"y":30.5339946746826},{"x":50.3802452087402,"y":30.5336894989014},{"x":50.3808784484863,"y":30.5332374572754}]},{"points":[{"x":50.3808975219727,"y":30.5333194732666},{"x":50.3808784484863,"y":30.5332374572754},{"x":50.381404876709,"y":30.5328731536865},{"x":50.3816833496094,"y":30.5326862335205},{"x":50.3824005126953,"y":30.5323429107666},{"x":50.3836402893066,"y":30.5317687988281},{"x":50.3843879699707,"y":30.5314197540283},{"x":50.3852043151855,"y":30.5310497283936}]},{"points":[{"x":50.3852195739746,"y":30.531135559082},{"x":50.3852043151855,"y":30.5310497283936},{"x":50.3856239318848,"y":30.5308609008789},{"x":50.3860740661621,"y":30.5306739807129},{"x":50.3871688842773,"y":30.5302982330322},{"x":50.3879165649414,"y":30.5300350189209},{"x":50.3893737792969,"y":30.529504776001},{"x":50.3896865844727,"y":30.5293979644775},{"x":50.3899002075195,"y":30.5293712615967},{"x":50.3901100158691,"y":30.5293865203857},{"x":50.3903160095215,"y":30.5294342041016},{"x":50.3907241821289,"y":30.5296382904053}]},{"points":[{"x":50.3907127380371,"y":30.5297183990479},{"x":50.3907241821289,"y":30.5296382904053},{"x":50.3913993835449,"y":30.5299987792969},{"x":50.3925437927246,"y":30.5305824279785},{"x":50.3929290771484,"y":30.5307750701904}]},{"points":[{"x":50.3929214477539,"y":30.5308666229248},{"x":50.3929290771484,"y":30.5307750701904},{"x":50.393367767334,"y":30.53098487854},{"x":50.3936424255371,"y":30.5311183929443},{"x":50.3944702148438,"y":30.5313453674316},{"x":50.3949089050293,"y":30.5314311981201},{"x":50.3952865600586,"y":30.5314407348633},{"x":50.3956565856934,"y":30.5314197540283},{"x":50.3958129882812,"y":30.5314083099365}]},{"points":[{"x":50.3958168029785,"y":30.5314846038818},{"x":50.3958129882812,"y":30.5314083099365},{"x":50.3960380554199,"y":30.5313930511475},{"x":50.3962631225586,"y":30.5313663482666},{"x":50.3967895507812,"y":30.5312366485596},{"x":50.3972015380859,"y":30.5310821533203},{"x":50.3975868225098,"y":30.5309047698975},{"x":50.398193359375,"y":30.5305557250977},{"x":50.3988418579102,"y":30.5300521850586},{"x":50.3993682861328,"y":30.5296020507812},{"x":50.399787902832,"y":30.5292587280273},{"x":50.4002075195312,"y":30.5288715362549}]},{"points":[{"x":50.4002380371094,"y":30.5289421081543},{"x":50.4002075195312,"y":30.5288715362549},{"x":50.4008865356445,"y":30.5282974243164},{"x":50.4014358520508,"y":30.5278091430664},{"x":50.4020805358887,"y":30.5272560119629},{"x":50.4022560119629,"y":30.5271282196045},{"x":50.4023933410645,"y":30.5269565582275},{"x":50.4031448364258,"y":30.5259857177734},{"x":50.4033622741699,"y":30.5256748199463},{"x":50.4035034179688,"y":30.5254859924316},{"x":50.4039649963379,"y":30.5249614715576},{"x":50.4043846130371,"y":30.5244617462158},{"x":50.4046173095703,"y":30.5240173339844},{"x":50.4047737121582,"y":30.5236682891846},{"x":50.4048957824707,"y":30.5234642028809},{"x":50.4055252075195,"y":30.5225467681885},{"x":50.405834197998,"y":30.5221118927002}]},{"points":[{"x":50.4058647155762,"y":30.5221710205078},{"x":50.405834197998,"y":30.5221118927002},{"x":50.4063835144043,"y":30.5213298797607},{"x":50.4065895080566,"y":30.5210399627686},{"x":50.4068145751953,"y":30.5206851959229},{"x":50.4069519042969,"y":30.5205459594727},{"x":50.4070892333984,"y":30.5204658508301},{"x":50.4072456359863,"y":30.520471572876},{"x":50.4074745178223,"y":30.5205669403076},{"x":50.4076232910156,"y":30.5207328796387},{"x":50.4078025817871,"y":30.5210494995117}]},{"points":[{"x":50.4077644348145,"y":30.5210933685303},{"x":50.4078025817871,"y":30.5210494995117},{"x":50.4080352783203,"y":30.5214786529541},{"x":50.4081916809082,"y":30.5217800140381},{"x":50.4084854125977,"y":30.522102355957},{"x":50.4091110229492,"y":30.5232391357422},{"x":50.4093742370605,"y":30.5238132476807},{"x":50.4094848632812,"y":30.5242156982422},{"x":50.4095268249512,"y":30.5245056152344},{"x":50.4095153808594,"y":30.5247993469238},{"x":50.4094352722168,"y":30.5251064300537},{"x":50.4092788696289,"y":30.5254650115967},{"x":50.4091491699219,"y":30.5257701873779},{"x":50.4090995788574,"y":30.526086807251},{"x":50.4090881347656,"y":30.5263824462891},{"x":50.4091529846191,"y":30.526741027832},{"x":50.4092597961426,"y":30.5270042419434},{"x":50.4094047546387,"y":30.527193069458},{"x":50.4096069335938,"y":30.5273475646973},{"x":50.4097938537598,"y":30.5273971557617},{"x":50.4099731445312,"y":30.5273475646973},{"x":50.4101600646973,"y":30.5272560119629},{"x":50.410343170166,"y":30.5271606445312},{"x":50.4107704162598,"y":30.5268650054932},{"x":50.4114608764648,"y":30.5264263153076},{"x":50.412109375,"y":30.5260238647461},{"x":50.4124755859375,"y":30.5257930755615},{"x":50.4128532409668,"y":30.5255508422852}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4125556945801,"y":30.5239505767822,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Лыбедская"},{"lang_id":"c_en","value":" Lybidska "},{"lang_id":"c_uk","value":" ст. м. Либідська"}]},{"city_id":0,"location":{"x":50.4077606201172,"y":30.5201015472412,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автовокзал"},{"lang_id":"c_en","value":" Autovokzal"},{"lang_id":"c_uk","value":" Автовокзал"}]},{"city_id":0,"location":{"x":50.404945373535156,"y":30.522768020629883,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Науки"},{"lang_id":"c_en","value":" Nauky Ave"},{"lang_id":"c_uk","value":" пр. Науки"}]},{"city_id":0,"location":{"x":50.3993339538574,"y":30.5295429229736,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Кинотеатр Салют"},{"lang_id":"c_en","value":" Kinoteatr Salut"},{"lang_id":"c_uk","value":" Кінотеатр Салют"}]},{"city_id":0,"location":{"x":50.3956451416016,"y":30.5313396453857,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Павла Грабовского"},{"lang_id":"c_en","value":" Pavla Hrabovskoho St"},{"lang_id":"c_uk","value":" вул. Павла Грабовського"}]},{"city_id":0,"location":{"x":50.3929405212402,"y":30.530689239502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Гидрометеорологическая"},{"lang_id":"c_en","value":" Hidrometeolohochna"},{"lang_id":"c_uk","value":" Гідрометеологічна"}]},{"city_id":0,"location":{"x":50.3901062011719,"y":30.5293006896973,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лысогорская"},{"lang_id":"c_en","value":" Lysohorska St"},{"lang_id":"c_uk","value":" вул. Лисогорська"}]},{"city_id":0,"location":{"x":50.3856010437012,"y":30.5307807922363,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Институт физики"},{"lang_id":"c_en","value":" Instytut phizyky"},{"lang_id":"c_uk","value":" Інститут фізики"}]},{"city_id":0,"location":{"x":50.3788871765137,"y":30.5347290039062,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Багриновая гора"},{"lang_id":"c_en","value":" Bahrinova hora"},{"lang_id":"c_uk","value":" Багрінова гора"}]},{"city_id":0,"location":{"x":50.3769378662109,"y":30.5375881195068,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Маршальская"},{"lang_id":"c_en","value":" Marshalska St"},{"lang_id":"c_uk","value":" вул. Маршальська"}]},{"city_id":0,"location":{"x":50.37255859375,"y":30.5450611114502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Китаевская"},{"lang_id":"c_en","value":" Kytaevska St"},{"lang_id":"c_uk","value":" вул. Китаєвська"}]},{"city_id":0,"location":{"x":50.3599853515625,"y":30.5444393157959,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод ЖБК"},{"lang_id":"c_en","value":" zavod ZBK"},{"lang_id":"c_uk","value":" завод ЗБК"}]},{"city_id":0,"location":{"x":50.3580551147461,"y":30.5435218811035,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Краснознаменная"},{"lang_id":"c_en","value":" Chervonoznamenna St"},{"lang_id":"c_uk","value":" вул. Червонознаменна"}]},{"city_id":0,"location":{"x":50.3523254394531,"y":30.5405883789062,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Славутич"},{"lang_id":"c_en","value":" zavod Slavutych"},{"lang_id":"c_uk","value":" завод Славутич"}]},{"city_id":0,"location":{"x":50.3492012023926,"y":30.5381851196289,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" АТП-1007"},{"lang_id":"c_en","value":" ATP-1007"},{"lang_id":"c_uk","value":" АТП-1007"}]},{"city_id":0,"location":{"x":50.3460540771484,"y":30.5349769592285,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" с. Пирогов"},{"lang_id":"c_en","value":" Pirihov"},{"lang_id":"c_uk","value":" с. Пірогов"}]}],"reverseRelations":[{"points":[{"x":50.4125556945801,"y":30.5239505767822},{"x":50.4125900268555,"y":30.5240383148193},{"x":50.4122848510742,"y":30.5244407653809},{"x":50.4118232727051,"y":30.5249767303467},{"x":50.4116363525391,"y":30.5251750946045},{"x":50.4110527038574,"y":30.5258731842041},{"x":50.4109268188477,"y":30.5259056091309},{"x":50.4108047485352,"y":30.5258827209473},{"x":50.4106597900391,"y":30.5258255004883},{"x":50.4105796813965,"y":30.525728225708},{"x":50.4102058410645,"y":30.5250301361084},{"x":50.40966796875,"y":30.524097442627},{"x":50.409423828125,"y":30.5235500335693},{"x":50.4091835021973,"y":30.5230236053467},{"x":50.4089088439941,"y":30.5224990844727},{"x":50.4085235595703,"y":30.5217742919922},{"x":50.4081649780273,"y":30.5210876464844},{"x":50.4079170227051,"y":30.5206203460693},{"x":50.4077110290527,"y":30.5201435089111}]},{"points":[{"x":50.4077606201172,"y":30.5201015472412},{"x":50.4077110290527,"y":30.5201435089111},{"x":50.407398223877,"y":30.5194301605225},{"x":50.4072227478027,"y":30.519021987915},{"x":50.4070167541504,"y":30.5186786651611},{"x":50.4068603515625,"y":30.518367767334},{"x":50.4066123962402,"y":30.5180568695068},{"x":50.4063262939453,"y":30.5177936553955},{"x":50.4057922363281,"y":30.5174407958984},{"x":50.4051055908203,"y":30.5170059204102},{"x":50.4047164916992,"y":30.5167579650879},{"x":50.4043655395508,"y":30.516544342041},{"x":50.4039115905762,"y":30.5162868499756},{"x":50.4038238525391,"y":30.5163345336914},{"x":50.4037780761719,"y":30.5164699554443},{"x":50.4037818908691,"y":30.516695022583},{"x":50.4040489196777,"y":30.5168876647949},{"x":50.4045944213867,"y":30.517204284668},{"x":50.4049949645996,"y":30.5174446105957},{"x":50.4053077697754,"y":30.5176486968994},{"x":50.4053840637207,"y":30.5177879333496},{"x":50.4054183959961,"y":30.5180568695068},{"x":50.4054489135742,"y":30.5185985565186},{"x":50.4054527282715,"y":30.5190486907959},{"x":50.4054756164551,"y":30.519344329834},{"x":50.4055213928223,"y":30.5197315216064},{"x":50.4057464599609,"y":30.5201644897461},{"x":50.4059867858887,"y":30.5206260681152},{"x":50.4060096740723,"y":30.5209045410156},{"x":50.4060096740723,"y":30.5211906433105},{"x":50.4059410095215,"y":30.521656036377},{"x":50.4055252075195,"y":30.5222568511963},{"x":50.4051322937012,"y":30.5227451324463},{"x":50.4050064086914,"y":30.5229110717773}]},{"points":[{"x":50.404945373535156,"y":30.522768020629883},{"x":50.4050064086914,"y":30.5229110717773},{"x":50.4044189453125,"y":30.5237216949463},{"x":50.404182434082,"y":30.5240497589111},{"x":50.4040298461914,"y":30.5242481231689},{"x":50.4038619995117,"y":30.5245685577393},{"x":50.403392791748,"y":30.5253467559814},{"x":50.4031257629395,"y":30.5257225036621},{"x":50.4027137756348,"y":30.5263290405273},{"x":50.4022521972656,"y":30.5269718170166},{"x":50.4021110534668,"y":30.5271606445312},{"x":50.4020805358887,"y":30.5272560119629},{"x":50.4014358520508,"y":30.5278091430664},{"x":50.4008865356445,"y":30.5282974243164},{"x":50.4002075195312,"y":30.5288715362549},{"x":50.399787902832,"y":30.5292587280273},{"x":50.3993682861328,"y":30.5296020507812}]},{"points":[{"x":50.3993339538574,"y":30.5295429229736},{"x":50.3993682861328,"y":30.5296020507812},{"x":50.3988418579102,"y":30.5300521850586},{"x":50.398193359375,"y":30.5305557250977},{"x":50.3975868225098,"y":30.5309047698975},{"x":50.3972015380859,"y":30.5310821533203},{"x":50.3967895507812,"y":30.5312366485596},{"x":50.3962631225586,"y":30.5313663482666},{"x":50.3960380554199,"y":30.5313930511475},{"x":50.3958129882812,"y":30.5314083099365},{"x":50.3956565856934,"y":30.5314197540283}]},{"points":[{"x":50.3956451416016,"y":30.5313396453857},{"x":50.3956565856934,"y":30.5314197540283},{"x":50.3952865600586,"y":30.5314407348633},{"x":50.3949089050293,"y":30.5314311981201},{"x":50.3944702148438,"y":30.5313453674316},{"x":50.3936424255371,"y":30.5311183929443},{"x":50.393367767334,"y":30.53098487854},{"x":50.3929290771484,"y":30.5307750701904}]},{"points":[{"x":50.3929405212402,"y":30.530689239502},{"x":50.3929290771484,"y":30.5307750701904},{"x":50.3925437927246,"y":30.5305824279785},{"x":50.3913993835449,"y":30.5299987792969},{"x":50.3907241821289,"y":30.5296382904053},{"x":50.3903160095215,"y":30.5294342041016},{"x":50.3901100158691,"y":30.5293865203857}]},{"points":[{"x":50.3901062011719,"y":30.5293006896973},{"x":50.3901100158691,"y":30.5293865203857},{"x":50.3899002075195,"y":30.5293712615967},{"x":50.3896865844727,"y":30.5293979644775},{"x":50.3893737792969,"y":30.529504776001},{"x":50.3879165649414,"y":30.5300350189209},{"x":50.3871688842773,"y":30.5302982330322},{"x":50.3860740661621,"y":30.5306739807129},{"x":50.3856239318848,"y":30.5308609008789}]},{"points":[{"x":50.3856010437012,"y":30.5307807922363},{"x":50.3856239318848,"y":30.5308609008789},{"x":50.3852043151855,"y":30.5310497283936},{"x":50.3843879699707,"y":30.5314197540283},{"x":50.3836402893066,"y":30.5317687988281},{"x":50.3824005126953,"y":30.5323429107666},{"x":50.3816833496094,"y":30.5326862335205},{"x":50.381404876709,"y":30.5328731536865},{"x":50.3808784484863,"y":30.5332374572754},{"x":50.3802452087402,"y":30.5336894989014},{"x":50.3798065185547,"y":30.5339946746826},{"x":50.3795051574707,"y":30.534252166748},{"x":50.3791885375977,"y":30.5345630645752},{"x":50.3789329528809,"y":30.5348262786865}]},{"points":[{"x":50.3788871765137,"y":30.5347290039062},{"x":50.3789329528809,"y":30.5348262786865},{"x":50.3786087036133,"y":30.5351486206055},{"x":50.3784332275391,"y":30.5353832244873},{"x":50.3782348632812,"y":30.5356636047363},{"x":50.3779602050781,"y":30.5360870361328},{"x":50.3772392272949,"y":30.5372085571289},{"x":50.3769721984863,"y":30.5376472473145}]},{"points":[{"x":50.3769378662109,"y":30.5375881195068},{"x":50.3769721984863,"y":30.5376472473145},{"x":50.3766784667969,"y":30.538179397583},{"x":50.3759574890137,"y":30.5396595001221},{"x":50.3753929138184,"y":30.5408344268799},{"x":50.375114440918,"y":30.541316986084},{"x":50.3749618530273,"y":30.5415210723877},{"x":50.3748016357422,"y":30.5416278839111},{"x":50.374626159668,"y":30.5416603088379},{"x":50.3744354248047,"y":30.5416450500488},{"x":50.3742866516113,"y":30.5415954589844},{"x":50.3741569519043,"y":30.541482925415},{"x":50.3737678527832,"y":30.5410861968994},{"x":50.3736343383789,"y":30.5410385131836},{"x":50.3735008239746,"y":30.5410804748535},{"x":50.3733787536621,"y":30.5412158966064},{"x":50.3733024597168,"y":30.5413875579834},{"x":50.3732414245605,"y":30.5416870117188},{"x":50.372917175293,"y":30.543420791626},{"x":50.3726692199707,"y":30.544734954834},{"x":50.3726081848145,"y":30.5450820922852}]},{"points":[{"x":50.37255859375,"y":30.5450611114502},{"x":50.3726081848145,"y":30.5450820922852},{"x":50.3725395202637,"y":30.5453777313232},{"x":50.3724517822266,"y":30.5456733703613},{"x":50.3723258972168,"y":30.546085357666},{"x":50.3722267150879,"y":30.5463752746582},{"x":50.3718414306641,"y":30.5474224090576},{"x":50.3716659545898,"y":30.5479106903076},{"x":50.3708763122559,"y":30.5477695465088},{"x":50.3701210021973,"y":30.5476360321045},{"x":50.369499206543,"y":30.5474758148193},{"x":50.3688278198242,"y":30.5472927093506},{"x":50.3682594299316,"y":30.5471477508545},{"x":50.3674812316895,"y":30.5469436645508},{"x":50.3666648864746,"y":30.5467891693115},{"x":50.3656768798828,"y":30.5465908050537},{"x":50.3646583557129,"y":30.5464019775391},{"x":50.3642082214355,"y":30.5463104248047},{"x":50.36376953125,"y":30.5461769104004},{"x":50.3631896972656,"y":30.5459308624268},{"x":50.3623199462891,"y":30.545581817627},{"x":50.3614501953125,"y":30.5451908111572},{"x":50.3607330322266,"y":30.5448513031006},{"x":50.3599700927734,"y":30.5444984436035}]},{"points":[{"x":50.3599853515625,"y":30.5444393157959},{"x":50.3599700927734,"y":30.5444984436035},{"x":50.3592796325684,"y":30.5441646575928},{"x":50.3587913513184,"y":30.5439357757568},{"x":50.3585968017578,"y":30.5438385009766},{"x":50.3580513000488,"y":30.5435962677002}]},{"points":[{"x":50.3580551147461,"y":30.5435218811035},{"x":50.3580513000488,"y":30.5435962677002},{"x":50.3573417663574,"y":30.5432796478271},{"x":50.356861114502,"y":30.5430450439453},{"x":50.3562431335449,"y":30.5426959991455},{"x":50.3555717468262,"y":30.5422821044922},{"x":50.3551216125488,"y":30.5420417785645},{"x":50.3545532226562,"y":30.5417137145996},{"x":50.3541488647461,"y":30.541482925415},{"x":50.3537635803223,"y":30.5412464141846},{"x":50.3533210754395,"y":30.5410747528076},{"x":50.3526153564453,"y":30.5407810211182},{"x":50.3523216247559,"y":30.540657043457}]},{"points":[{"x":50.3523254394531,"y":30.5405883789062},{"x":50.3523216247559,"y":30.540657043457},{"x":50.3517570495605,"y":30.5404376983643},{"x":50.35107421875,"y":30.5401477813721},{"x":50.3508071899414,"y":30.5399971008301},{"x":50.3504905700684,"y":30.5397777557373},{"x":50.3501663208008,"y":30.5394134521484},{"x":50.3491744995117,"y":30.5382480621338}]},{"points":[{"x":50.3492012023926,"y":30.5381851196289},{"x":50.3491744995117,"y":30.5382480621338},{"x":50.3487396240234,"y":30.5377826690674},{"x":50.3484992980957,"y":30.537525177002},{"x":50.3477668762207,"y":30.5367412567139},{"x":50.3475227355957,"y":30.5364513397217},{"x":50.3471298217773,"y":30.5359535217285},{"x":50.3465919494629,"y":30.5353088378906},{"x":50.3462524414062,"y":30.5349178314209},{"x":50.3460121154785,"y":30.5347518920898},{"x":50.3459243774414,"y":30.5347232818604},{"x":50.3458976745605,"y":30.5348682403564},{"x":50.3460540771484,"y":30.5349769592285}]}]}
16	2	c_route_bus	56	{"cityID":2,"routeID":256,"routeType":"c_route_bus","number":"56","timeStart":24240,"timeFinish":76560,"intervalMin":1080,"intervalMax":1080,"cost":3.0,"directStations":[{"city_id":0,"location":{"x":50.4643402099609,"y":30.355375289917,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Академгородок"},{"lang_id":"c_en","value":" Akademmistechko"},{"lang_id":"c_uk","value":" ст. м. Академмістечко"}]},{"city_id":0,"location":{"x":50.4549980163574,"y":30.356840133667,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Победы"},{"lang_id":"c_en","value":" Peremohy Ave"},{"lang_id":"c_uk","value":" пр. Перемоги"}]},{"city_id":0,"location":{"x":50.4519691467285,"y":30.3572959899902,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Верховинная"},{"lang_id":"c_en","value":" Verkhovynna St"},{"lang_id":"c_uk","value":" вул. Верховинна"}]},{"city_id":0,"location":{"x":50.4480628967285,"y":30.3576183319092,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Святошинское кладбище"},{"lang_id":"c_en","value":" Svyatoshynske kladovyshe"},{"lang_id":"c_uk","value":" Святошинське кладовище"}]},{"city_id":0,"location":{"x":50.4435043334961,"y":30.3582611083984,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Янтарная"},{"lang_id":"c_en","value":" Yantarna St"},{"lang_id":"c_uk","value":" вул. Янтарна"}]},{"city_id":0,"location":{"x":50.4363899230957,"y":30.3593997955322,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жмеринская"},{"lang_id":"c_en","value":" Zhmerynska St"},{"lang_id":"c_uk","value":" вул. Жмеринська"}]},{"city_id":0,"location":{"x":50.431510925293,"y":30.3612594604492,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Электронмаш"},{"lang_id":"c_en","value":" zavod Elektronmash"},{"lang_id":"c_uk","value":" завод Електронмаш"}]},{"city_id":0,"location":{"x":50.425048828125,"y":30.3662338256836,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Леся Курбаса"},{"lang_id":"c_en","value":" Lesya Kurbasa Ave"},{"lang_id":"c_uk","value":" пр. Леся Курбаса"}]},{"city_id":0,"location":{"x":50.4186058044434,"y":30.3732929229736,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Литвиненко-Вольгемут"},{"lang_id":"c_en","value":" Lytvynenka-Volhemut St"},{"lang_id":"c_uk","value":" вул. Литвиненка-Вольгемут"}]},{"city_id":0,"location":{"x":50.41355895996094,"y":30.381372451782227,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" автосалон Тойота"},{"lang_id":"c_en","value":" Toyota autosalon"},{"lang_id":"c_uk","value":" автосалон Тойота"}]},{"city_id":0,"location":{"x":50.40768814086914,"y":30.390634536743164,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Южная Борщаговка"},{"lang_id":"c_en","value":" Pivdenna Borshahivka"},{"lang_id":"c_uk","value":" Південна Борщагівка"}]},{"city_id":0,"location":{"x":50.4022827148438,"y":30.4044437408447,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Совхоз Совки"},{"lang_id":"c_en","value":" Rodhosp Sovki"},{"lang_id":"c_uk","value":" Радгосп Совкі"}]},{"city_id":0,"location":{"x":50.3955001831055,"y":30.4239063262939,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Путепровод"},{"lang_id":"c_en","value":" Shlyahoprovid"},{"lang_id":"c_uk","value":" Шляхопровід"}]},{"city_id":0,"location":{"x":50.3925399780273,"y":30.4281272888184,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ватутина"},{"lang_id":"c_en","value":" Vatutina St"},{"lang_id":"c_uk","value":" вул. Ватутіна"}]},{"city_id":0,"location":{"x":50.3897285461426,"y":30.4313831329346,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Жуляны-2"},{"lang_id":"c_en","value":" Zhulyany-2"},{"lang_id":"c_uk","value":" село Жуляни-2"}]},{"city_id":0,"location":{"x":50.385311126709,"y":30.437370300293,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Жуляны-1"},{"lang_id":"c_en","value":" Zhulyany-1"},{"lang_id":"c_uk","value":" село Жуляни-1"}]},{"city_id":0,"location":{"x":50.3793411254883,"y":30.4454555511475,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лятошинского"},{"lang_id":"c_en","value":" Lyatoshynskoho St"},{"lang_id":"c_uk","value":" вул. Лятошинського"}]},{"city_id":0,"location":{"x":50.3743362426758,"y":30.4522399902344,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Массив Теремки-1"},{"lang_id":"c_en","value":" Masyv Teremky-1"},{"lang_id":"c_uk","value":" Масив Теремки-1"}]},{"city_id":0,"location":{"x":50.369873046875,"y":30.4581851959229,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Одесская"},{"lang_id":"c_en","value":" plosha Odeska"},{"lang_id":"c_uk","value":" площа Одеська"}]},{"city_id":0,"location":{"x":50.3721122741699,"y":30.4616985321045,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Одесская"},{"lang_id":"c_en","value":" plosha Odeska"},{"lang_id":"c_uk","value":" площа Одеська"}]},{"city_id":0,"location":{"x":50.3742790222168,"y":30.465057373046875,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ледовый стадион"},{"lang_id":"c_en","value":" Lodovyi stadion"},{"lang_id":"c_uk","value":" Льодовий стадіон"}]},{"city_id":0,"location":{"x":50.3785514831543,"y":30.471622467041016,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автостанция Южная"},{"lang_id":"c_en","value":" Autostantsia Pivdena"},{"lang_id":"c_uk","value":" Автостанція Південна"}]},{"city_id":0,"location":{"x":50.3808708190918,"y":30.476343154907227,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Выставочный центр"},{"lang_id":"c_en","value":" Vystavkovyi tsentr"},{"lang_id":"c_uk","value":" ст. м. Виставковий центр"}]}],"directRelations":[{"points":[{"x":50.4643402099609,"y":30.355375289917},{"x":50.46433639526367,"y":30.355451583862305},{"x":50.46345138549805,"y":30.355573654174805},{"x":50.462181091308594,"y":30.355772018432617},{"x":50.46086883544922,"y":30.355993270874023},{"x":50.459529876708984,"y":30.3562068939209},{"x":50.45815658569336,"y":30.356443405151367},{"x":50.45680236816406,"y":30.356647491455078},{"x":50.456111907958984,"y":30.356754302978516},{"x":50.45549392700195,"y":30.35684585571289},{"x":50.454994201660156,"y":30.356937408447266}]},{"points":[{"x":50.4549980163574,"y":30.356840133667},{"x":50.454994201660156,"y":30.356937408447266},{"x":50.454158782958984,"y":30.357070922851562},{"x":50.45301818847656,"y":30.35722541809082},{"x":50.452423095703125,"y":30.357311248779297},{"x":50.45196533203125,"y":30.35736083984375}]},{"points":[{"x":50.4519691467285,"y":30.3572959899902},{"x":50.45196533203125,"y":30.35736083984375},{"x":50.45130157470703,"y":30.357402801513672},{"x":50.45051956176758,"y":30.357479095458984},{"x":50.44955825805664,"y":30.357547760009766},{"x":50.4489631652832,"y":30.35759735107422},{"x":50.44843673706055,"y":30.3576602935791},{"x":50.448055267333984,"y":30.357704162597656}]},{"points":[{"x":50.4480628967285,"y":30.3576183319092},{"x":50.448055267333984,"y":30.357704162597656},{"x":50.44725799560547,"y":30.35779571533203},{"x":50.44643783569336,"y":30.357885360717773},{"x":50.44602584838867,"y":30.35792350769043},{"x":50.44523239135742,"y":30.35805320739746},{"x":50.444496154785156,"y":30.35818099975586},{"x":50.443504333496094,"y":30.35833740234375}]},{"points":[{"x":50.4435043334961,"y":30.3582611083984},{"x":50.443504333496094,"y":30.35833740234375},{"x":50.442623138427734,"y":30.35845947265625},{"x":50.44173812866211,"y":30.35861587524414},{"x":50.44053268432617,"y":30.358793258666992},{"x":50.43918991088867,"y":30.359012603759766},{"x":50.43776321411133,"y":30.359243392944336},{"x":50.43638229370117,"y":30.359479904174805}]},{"points":[{"x":50.4363899230957,"y":30.3593997955322},{"x":50.43638229370117,"y":30.359479904174805},{"x":50.435726165771484,"y":30.35956573486328},{"x":50.434818267822266,"y":30.3597469329834},{"x":50.43443298339844,"y":30.35982894897461},{"x":50.43400955200195,"y":30.35993003845215},{"x":50.433650970458984,"y":30.360042572021484},{"x":50.433204650878906,"y":30.36020278930664},{"x":50.4325065612793,"y":30.360610961914062},{"x":50.43153762817383,"y":30.361351013183594}]},{"points":[{"x":50.431510925293,"y":30.3612594604492},{"x":50.43153762817383,"y":30.361351013183594},{"x":50.43064498901367,"y":30.362043380737305},{"x":50.4296875,"y":30.362773895263672},{"x":50.42873001098633,"y":30.363496780395508},{"x":50.42763900756836,"y":30.36434555053711},{"x":50.4267463684082,"y":30.365020751953125},{"x":50.425838470458984,"y":30.365718841552734},{"x":50.42506790161133,"y":30.36631965637207}]},{"points":[{"x":50.425048828125,"y":30.3662338256836},{"x":50.42506790161133,"y":30.36631965637207},{"x":50.42448806762695,"y":30.366775512695312},{"x":50.42375183105469,"y":30.367338180541992},{"x":50.422733306884766,"y":30.36808967590332},{"x":50.42228698730469,"y":30.368453979492188},{"x":50.42150115966797,"y":30.369152069091797},{"x":50.42118453979492,"y":30.36947250366211},{"x":50.42070007324219,"y":30.370073318481445},{"x":50.41991424560547,"y":30.371301651000977},{"x":50.41887283325195,"y":30.372943878173828},{"x":50.41864013671875,"y":30.373340606689453}]},{"points":[{"x":50.4186058044434,"y":30.3732929229736},{"x":50.41864013671875,"y":30.373340606689453},{"x":50.41769790649414,"y":30.37489128112793},{"x":50.416725158691406,"y":30.376474380493164},{"x":50.41557693481445,"y":30.37830924987793},{"x":50.4145393371582,"y":30.379955291748047},{"x":50.41358947753906,"y":30.38142967224121}]},{"points":[{"x":50.41355895996094,"y":30.381372451782227},{"x":50.41358947753906,"y":30.38142967224121},{"x":50.41240310668945,"y":30.383291244506836},{"x":50.4113655090332,"y":30.384906768798828},{"x":50.410919189453125,"y":30.385549545288086},{"x":50.410457611083984,"y":30.38633918762207},{"x":50.40946960449219,"y":30.38803482055664},{"x":50.40843200683594,"y":30.389692306518555},{"x":50.40776824951172,"y":30.390764236450195}]},{"points":[{"x":50.40768814086914,"y":30.390634536743164},{"x":50.40776824951172,"y":30.390764236450195},{"x":50.4073600769043,"y":30.391403198242188},{"x":50.40690231323242,"y":30.39214324951172},{"x":50.406761169433594,"y":30.39239501953125},{"x":50.40630340576172,"y":30.393247604370117},{"x":50.40615463256836,"y":30.39352798461914},{"x":50.40579605102539,"y":30.39435386657715},{"x":50.40556716918945,"y":30.394975662231445},{"x":50.404998779296875,"y":30.396617889404297},{"x":50.404518127441406,"y":30.398033142089844},{"x":50.40379333496094,"y":30.400217056274414},{"x":50.403236389160156,"y":30.401830673217773},{"x":50.40232849121094,"y":30.40448760986328}]},{"points":[{"x":50.4022827148438,"y":30.4044437408447},{"x":50.40232849121094,"y":30.40448760986328},{"x":50.401695251464844,"y":30.406417846679688},{"x":50.401390075683594,"y":30.407474517822266},{"x":50.40085220336914,"y":30.409732818603516},{"x":50.40034866333008,"y":30.411449432373047},{"x":50.39973068237305,"y":30.41329574584961},{"x":50.399017333984375,"y":30.41539764404297},{"x":50.39846420288086,"y":30.417034149169922},{"x":50.397979736328125,"y":30.418428421020508},{"x":50.397335052490234,"y":30.420198440551758},{"x":50.396942138671875,"y":30.421142578125},{"x":50.396278381347656,"y":30.422592163085938},{"x":50.3958854675293,"y":30.423315048217773},{"x":50.39554214477539,"y":30.423965454101562}]},{"points":[{"x":50.3955001831055,"y":30.4239063262939},{"x":50.39554214477539,"y":30.423965454101562},{"x":50.39536666870117,"y":30.424264907836914},{"x":50.39496994018555,"y":30.424877166748047},{"x":50.39443588256836,"y":30.42571449279785},{"x":50.394264221191406,"y":30.425987243652344},{"x":50.393768310546875,"y":30.426647186279297},{"x":50.392906188964844,"y":30.42777442932129},{"x":50.3925666809082,"y":30.428203582763672}]},{"points":[{"x":50.3925399780273,"y":30.4281272888184},{"x":50.3925666809082,"y":30.428203582763672},{"x":50.39229202270508,"y":30.428449630737305},{"x":50.391876220703125,"y":30.42877197265625},{"x":50.39155197143555,"y":30.4290714263916},{"x":50.39120101928711,"y":30.429479598999023},{"x":50.39027404785156,"y":30.430734634399414},{"x":50.3897590637207,"y":30.431447982788086}]},{"points":[{"x":50.3897285461426,"y":30.4313831329346},{"x":50.3897590637207,"y":30.431447982788086},{"x":50.38905715942383,"y":30.43238639831543},{"x":50.38770294189453,"y":30.434221267700195},{"x":50.386383056640625,"y":30.4360294342041},{"x":50.38534927368164,"y":30.437440872192383}]},{"points":[{"x":50.385311126709,"y":30.437370300293},{"x":50.38534927368164,"y":30.437440872192383},{"x":50.384342193603516,"y":30.438796997070312},{"x":50.38368606567383,"y":30.439672470092773},{"x":50.38323211669922,"y":30.44029426574707},{"x":50.38225555419922,"y":30.441614151000977},{"x":50.381378173828125,"y":30.442821502685547},{"x":50.380470275878906,"y":30.44403839111328},{"x":50.37937927246094,"y":30.445518493652344}]},{"points":[{"x":50.3793411254883,"y":30.4454555511475},{"x":50.37937927246094,"y":30.445518493652344},{"x":50.378475189208984,"y":30.44674301147461},{"x":50.37778854370117,"y":30.447654724121094},{"x":50.37731170654297,"y":30.448287963867188},{"x":50.376304626464844,"y":30.449670791625977},{"x":50.375247955322266,"y":30.451108932495117},{"x":50.374366760253906,"y":30.452289581298828}]},{"points":[{"x":50.3743362426758,"y":30.4522399902344},{"x":50.374366760253906,"y":30.452289581298828},{"x":50.373573303222656,"y":30.453388214111328},{"x":50.37330627441406,"y":30.453807830810547},{"x":50.37277603149414,"y":30.45471954345703},{"x":50.372154235839844,"y":30.455625534057617},{"x":50.37124252319336,"y":30.45684814453125},{"x":50.370548248291016,"y":30.45779800415039},{"x":50.370208740234375,"y":30.45825958251953},{"x":50.36963653564453,"y":30.459020614624023},{"x":50.36948776245117,"y":30.459075927734375},{"x":50.369327545166016,"y":30.45905303955078},{"x":50.369144439697266,"y":30.458904266357422},{"x":50.36906433105469,"y":30.45874786376953},{"x":50.369022369384766,"y":30.45856475830078},{"x":50.36901092529297,"y":30.458362579345703},{"x":50.36904525756836,"y":30.458173751831055},{"x":50.3691291809082,"y":30.45798683166504},{"x":50.36925506591797,"y":30.457847595214844},{"x":50.369407653808594,"y":30.45779800415039},{"x":50.36958312988281,"y":30.45785140991211},{"x":50.36979293823242,"y":30.457963943481445},{"x":50.369911193847656,"y":30.458141326904297}]},{"points":[{"x":50.369873046875,"y":30.4581851959229},{"x":50.369911193847656,"y":30.458141326904297},{"x":50.37017822265625,"y":30.458576202392578},{"x":50.37114715576172,"y":30.460094451904297},{"x":50.371681213378906,"y":30.460926055908203},{"x":50.37214660644531,"y":30.461645126342773}]},{"points":[{"x":50.3721122741699,"y":30.4616985321045},{"x":50.37214660644531,"y":30.461645126342773},{"x":50.37300109863281,"y":30.462932586669922},{"x":50.37376022338867,"y":30.46406364440918},{"x":50.374351501464844,"y":30.464948654174805}]},{"points":[{"x":50.3742790222168,"y":30.465057373046875},{"x":50.374351501464844,"y":30.464948654174805},{"x":50.37507629394531,"y":30.466054916381836},{"x":50.3758659362793,"y":30.46724510192871},{"x":50.376434326171875,"y":30.468135833740234},{"x":50.37727737426758,"y":30.469402313232422},{"x":50.37798309326172,"y":30.470491409301758},{"x":50.37831497192383,"y":30.47101593017578},{"x":50.37847900390625,"y":30.471294403076172},{"x":50.37860107421875,"y":30.4715518951416}]},{"points":[{"x":50.3785514831543,"y":30.471622467041016},{"x":50.37860107421875,"y":30.4715518951416},{"x":50.37910461425781,"y":30.47255516052246},{"x":50.379573822021484,"y":30.473554611206055},{"x":50.37981033325195,"y":30.474111557006836},{"x":50.380149841308594,"y":30.47495460510254},{"x":50.380645751953125,"y":30.47623062133789},{"x":50.38096237182617,"y":30.477035522460938},{"x":50.381011962890625,"y":30.477148056030273},{"x":50.381195068359375,"y":30.477216720581055},{"x":50.38179397583008,"y":30.4775333404541},{"x":50.38252639770508,"y":30.477909088134766},{"x":50.382598876953125,"y":30.47802734375},{"x":50.382652282714844,"y":30.47821044921875},{"x":50.382667541503906,"y":30.478361129760742},{"x":50.382606506347656,"y":30.47853660583496},{"x":50.38248062133789,"y":30.47869300842285},{"x":50.38191604614258,"y":30.47926139831543},{"x":50.38164520263672,"y":30.478532791137695},{"x":50.38132095336914,"y":30.477689743041992},{"x":50.381195068359375,"y":30.477216720581055},{"x":50.38106155395508,"y":30.476831436157227},{"x":50.3808708190918,"y":30.476343154907227}]}],"reverseStations":[{"city_id":0,"location":{"x":50.380916595458984,"y":30.47629165649414,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Выставочный центр"},{"lang_id":"c_en","value":" Vystavkovyi tsentr"},{"lang_id":"c_uk","value":" ст. м. Виставковий центр"}]},{"city_id":0,"location":{"x":50.3783645629883,"y":30.4706401824951,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Автостанция Южная"},{"lang_id":"c_en","value":" Autostantsia Pivdena"},{"lang_id":"c_uk","value":" Автостанція Південна"}]},{"city_id":0,"location":{"x":50.3739204406738,"y":30.4638233184814,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Ледовый стадион"},{"lang_id":"c_en","value":" Lodovyi stadion"},{"lang_id":"c_uk","value":" Льодовий стадіон"}]},{"city_id":0,"location":{"x":50.3716888427734,"y":30.4579219818115,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Одесская"},{"lang_id":"c_en","value":" plosha Odeska"},{"lang_id":"c_uk","value":" площа Одеська"}]},{"city_id":0,"location":{"x":50.3751640319824,"y":30.4520683288574,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Массив Теремки-1"},{"lang_id":"c_en","value":" Masyv Teremky-1"},{"lang_id":"c_uk","value":" Масив Теремки-1"}]},{"city_id":0,"location":{"x":50.379638671875,"y":30.4460067749023,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Лятошинского"},{"lang_id":"c_en","value":" Lyatoshynskoho St"},{"lang_id":"c_uk","value":" вул. Лятошинського"}]},{"city_id":0,"location":{"x":50.3859748840332,"y":30.4374237060547,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Жуляны-1"},{"lang_id":"c_en","value":" Zhulyany-1"},{"lang_id":"c_uk","value":" село Жуляни-1"}]},{"city_id":0,"location":{"x":50.3901176452637,"y":30.4318180084229,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" село Жуляны-2"},{"lang_id":"c_en","value":" Zhulyany-2"},{"lang_id":"c_uk","value":" село Жуляни-2"}]},{"city_id":0,"location":{"x":50.3926773071289,"y":30.4283313751221,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Ватутина"},{"lang_id":"c_en","value":" Vatutina St"},{"lang_id":"c_uk","value":" вул. Ватутіна"}]},{"city_id":0,"location":{"x":50.3956260681152,"y":30.4241256713867,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Путепровод"},{"lang_id":"c_en","value":" Shlyahoprovid"},{"lang_id":"c_uk","value":" Шляхопровід"}]},{"city_id":0,"location":{"x":50.4030532836914,"y":30.4036712646484,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Совхоз Совки"},{"lang_id":"c_en","value":" Rodhosp Sovki"},{"lang_id":"c_uk","value":" Радгосп Совкі"}]},{"city_id":0,"location":{"x":50.40802001953125,"y":30.39121437072754,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Южная Борщаговка"},{"lang_id":"c_en","value":" Pivdenna Borshahivka"},{"lang_id":"c_uk","value":" Південна Борщагівка"}]},{"city_id":0,"location":{"x":50.413856506347656,"y":30.38189125061035,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" автосалон Тойота"},{"lang_id":"c_en","value":" Toyota autosalon"},{"lang_id":"c_uk","value":" автосалон Тойота"}]},{"city_id":0,"location":{"x":50.4189834594727,"y":30.3737106323242,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Литвиненко-Вольгемут"},{"lang_id":"c_en","value":" Lytvynenka-Volhemut St"},{"lang_id":"c_uk","value":" вул. Литвиненка-Вольгемут"}]},{"city_id":0,"location":{"x":50.4262390136719,"y":30.3659496307373,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Леся Курбаса"},{"lang_id":"c_en","value":" Lesya Kurbasa Ave"},{"lang_id":"c_uk","value":" пр. Леся Курбаса"}]},{"city_id":0,"location":{"x":50.4308395385742,"y":30.3625583648682,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ПО Электронмаш"},{"lang_id":"c_en","value":" Elektronmash"},{"lang_id":"c_uk","value":" ПО Електронмаш"}]},{"city_id":0,"location":{"x":50.436408996582,"y":30.3601131439209,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Жмеринская"},{"lang_id":"c_en","value":" Zhmerynska St"},{"lang_id":"c_uk","value":" вул. Жмеринська"}]},{"city_id":0,"location":{"x":50.4433746337891,"y":30.3589382171631,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Янтарная"},{"lang_id":"c_en","value":" Yantarna St"},{"lang_id":"c_uk","value":" вул. Янтарна"}]},{"city_id":0,"location":{"x":50.4481658935547,"y":30.3582134246826,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Святошинское кладбище"},{"lang_id":"c_en","value":" Svyatoshynske kladovyshe"},{"lang_id":"c_uk","value":" Святошинське кладовище"}]},{"city_id":0,"location":{"x":50.4520072937012,"y":30.3577098846436,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Верховинная"},{"lang_id":"c_en","value":" Verkhovynna St"},{"lang_id":"c_uk","value":" вул. Верховинна"}]},{"city_id":0,"location":{"x":50.4557838439941,"y":30.3571033477783,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пр. Победы"},{"lang_id":"c_en","value":" Peremohy Ave"},{"lang_id":"c_uk","value":" пр. Перемоги"}]},{"city_id":0,"location":{"x":50.46340560913086,"y":30.355772018432617,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Академгородок"},{"lang_id":"c_en","value":" Akademmistechko"},{"lang_id":"c_uk","value":" ст. м. Академмістечко"}]}],"reverseRelations":[{"points":[{"x":50.380916595458984,"y":30.47629165649414},{"x":50.3808708190918,"y":30.476343154907227},{"x":50.38019943237305,"y":30.474626541137695},{"x":50.37994384765625,"y":30.4740047454834},{"x":50.37974548339844,"y":30.47353744506836},{"x":50.379615783691406,"y":30.47325325012207},{"x":50.37908935546875,"y":30.472143173217773},{"x":50.37871551513672,"y":30.471364974975586},{"x":50.378543853759766,"y":30.471054077148438},{"x":50.37833023071289,"y":30.470693588256836}]},{"points":[{"x":50.3783645629883,"y":30.4706401824951},{"x":50.37833023071289,"y":30.470693588256836},{"x":50.37785339355469,"y":30.46994972229004},{"x":50.37757873535156,"y":30.46953010559082},{"x":50.37724685668945,"y":30.46901512145996},{"x":50.37659454345703,"y":30.46804428100586},{"x":50.376102447509766,"y":30.46727752685547},{"x":50.37542724609375,"y":30.46626853942871},{"x":50.37485885620117,"y":30.465404510498047},{"x":50.37422561645508,"y":30.464433670043945},{"x":50.37387466430664,"y":30.463918685913086}]},{"points":[{"x":50.3739204406738,"y":30.4638233184814},{"x":50.37387466430664,"y":30.463918685913086},{"x":50.37339782714844,"y":30.46319580078125},{"x":50.372745513916016,"y":30.462202072143555},{"x":50.372257232666016,"y":30.461483001708984},{"x":50.37187957763672,"y":30.460908889770508},{"x":50.371788024902344,"y":30.460630416870117},{"x":50.371673583984375,"y":30.460250854492188},{"x":50.37161636352539,"y":30.459896087646484},{"x":50.371604919433594,"y":30.45949363708496},{"x":50.37164306640625,"y":30.457910537719727}]},{"points":[{"x":50.3716888427734,"y":30.4579219818115},{"x":50.37164306640625,"y":30.457910537719727},{"x":50.371665954589844,"y":30.457380294799805},{"x":50.3716926574707,"y":30.457111358642578},{"x":50.37180709838867,"y":30.456768035888672},{"x":50.37189865112305,"y":30.45659637451172},{"x":50.3724250793457,"y":30.455841064453125},{"x":50.372806549072266,"y":30.455303192138672},{"x":50.37297058105469,"y":30.4550724029541},{"x":50.373165130615234,"y":30.45461654663086},{"x":50.373504638671875,"y":30.454193115234375},{"x":50.37403869628906,"y":30.4534854888916},{"x":50.374881744384766,"y":30.452363967895508},{"x":50.3751335144043,"y":30.452011108398438}]},{"points":[{"x":50.3751640319824,"y":30.4520683288574},{"x":50.3751335144043,"y":30.452011108398438},{"x":50.375892639160156,"y":30.45099639892578},{"x":50.37688064575195,"y":30.449665069580078},{"x":50.377471923828125,"y":30.448871612548828},{"x":50.37812805175781,"y":30.447965621948242},{"x":50.37888717651367,"y":30.446924209594727},{"x":50.37960433959961,"y":30.445959091186523}]},{"points":[{"x":50.379638671875,"y":30.4460067749023},{"x":50.37960433959961,"y":30.445959091186523},{"x":50.38042449951172,"y":30.44485855102539},{"x":50.38119125366211,"y":30.443819046020508},{"x":50.381858825683594,"y":30.442922592163086},{"x":50.38237762451172,"y":30.442235946655273},{"x":50.3830680847168,"y":30.441303253173828},{"x":50.383758544921875,"y":30.44034194946289},{"x":50.38439178466797,"y":30.439483642578125},{"x":50.38532257080078,"y":30.438228607177734},{"x":50.38595199584961,"y":30.437376022338867}]},{"points":[{"x":50.3859748840332,"y":30.4374237060547},{"x":50.38595199584961,"y":30.437376022338867},{"x":50.386905670166016,"y":30.436073303222656},{"x":50.38786315917969,"y":30.43477439880371},{"x":50.388668060302734,"y":30.433685302734375},{"x":50.389530181884766,"y":30.432531356811523},{"x":50.39009475708008,"y":30.43177032470703}]},{"points":[{"x":50.3901176452637,"y":30.4318180084229},{"x":50.39009475708008,"y":30.43177032470703},{"x":50.390533447265625,"y":30.431169509887695},{"x":50.39104080200195,"y":30.430482864379883},{"x":50.391746520996094,"y":30.42951774597168},{"x":50.392642974853516,"y":30.42828941345215}]},{"points":[{"x":50.3926773071289,"y":30.4283313751221},{"x":50.392642974853516,"y":30.42828941345215},{"x":50.39288330078125,"y":30.428014755249023},{"x":50.39342498779297,"y":30.42728042602539},{"x":50.39392852783203,"y":30.426652908325195},{"x":50.394405364990234,"y":30.425949096679688},{"x":50.395084381103516,"y":30.42491912841797},{"x":50.395591735839844,"y":30.42409324645996}]},{"points":[{"x":50.3956260681152,"y":30.4241256713867},{"x":50.395591735839844,"y":30.42409324645996},{"x":50.39590072631836,"y":30.423551559448242},{"x":50.3962516784668,"y":30.422805786132812},{"x":50.39686584472656,"y":30.421497344970703},{"x":50.39736557006836,"y":30.42032241821289},{"x":50.39791488647461,"y":30.418842315673828},{"x":50.398345947265625,"y":30.4176025390625},{"x":50.398929595947266,"y":30.415864944458008},{"x":50.399391174316406,"y":30.414539337158203},{"x":50.399879455566406,"y":30.413070678710938},{"x":50.400447845458984,"y":30.411357879638672},{"x":50.40093231201172,"y":30.40982437133789},{"x":50.40122985839844,"y":30.408924102783203},{"x":50.40174102783203,"y":30.407421112060547},{"x":50.40229797363281,"y":30.405763626098633},{"x":50.40281295776367,"y":30.404207229614258},{"x":50.403011322021484,"y":30.403629302978516}]},{"points":[{"x":50.4030532836914,"y":30.4036712646484},{"x":50.403011322021484,"y":30.403629302978516},{"x":50.4036865234375,"y":30.401546478271484},{"x":50.404273986816406,"y":30.399829864501953},{"x":50.40496826171875,"y":30.397823333740234},{"x":50.40568923950195,"y":30.395763397216797},{"x":50.406044006347656,"y":30.394733428955078},{"x":50.40645217895508,"y":30.393768310546875},{"x":50.407073974609375,"y":30.392560958862305},{"x":50.40798568725586,"y":30.39116096496582}]},{"points":[{"x":50.40802001953125,"y":30.39121437072754},{"x":50.40798568725586,"y":30.39116096496582},{"x":50.40877914428711,"y":30.389890670776367},{"x":50.40946960449219,"y":30.388784408569336},{"x":50.40978240966797,"y":30.388301849365234},{"x":50.41048812866211,"y":30.387149810791016},{"x":50.411434173583984,"y":30.38559913635254},{"x":50.411956787109375,"y":30.384750366210938},{"x":50.41256332397461,"y":30.38380241394043},{"x":50.4132194519043,"y":30.382835388183594},{"x":50.413818359375,"y":30.38184356689453}]},{"points":[{"x":50.413856506347656,"y":30.38189125061035},{"x":50.413818359375,"y":30.38184356689453},{"x":50.41474151611328,"y":30.38036346435547},{"x":50.415794372558594,"y":30.378662109375},{"x":50.41668701171875,"y":30.377246856689453},{"x":50.417564392089844,"y":30.375856399536133},{"x":50.418216705322266,"y":30.374832153320312},{"x":50.418949127197266,"y":30.3736515045166}]},{"points":[{"x":50.4189834594727,"y":30.3737106323242},{"x":50.418949127197266,"y":30.3736515045166},{"x":50.41960144042969,"y":30.37261199951172},{"x":50.42039108276367,"y":30.371366500854492},{"x":50.421119689941406,"y":30.370271682739258},{"x":50.421260833740234,"y":30.370073318481445},{"x":50.421669006347656,"y":30.369596481323242},{"x":50.42219543457031,"y":30.369043350219727},{"x":50.422428131103516,"y":30.368803024291992},{"x":50.42304229736328,"y":30.368261337280273},{"x":50.423553466796875,"y":30.367820739746094},{"x":50.424495697021484,"y":30.367101669311523},{"x":50.42528533935547,"y":30.366500854492188},{"x":50.425575256347656,"y":30.36629295349121},{"x":50.426231384277344,"y":30.365873336791992}]},{"points":[{"x":50.4262390136719,"y":30.3659496307373},{"x":50.426231384277344,"y":30.365873336791992},{"x":50.42669677734375,"y":30.36557388305664},{"x":50.42716979980469,"y":30.365224838256836},{"x":50.42808151245117,"y":30.364543914794922},{"x":50.429046630859375,"y":30.363819122314453},{"x":50.42969512939453,"y":30.36334228515625},{"x":50.43050003051758,"y":30.362730026245117},{"x":50.430824279785156,"y":30.362478256225586}]},{"points":[{"x":50.4308395385742,"y":30.3625583648682},{"x":50.430824279785156,"y":30.362478256225586},{"x":50.43148422241211,"y":30.361974716186523},{"x":50.43202209472656,"y":30.361560821533203},{"x":50.43251419067383,"y":30.361169815063477},{"x":50.432735443115234,"y":30.361034393310547},{"x":50.43306350708008,"y":30.360841751098633},{"x":50.433414459228516,"y":30.360702514648438},{"x":50.43403625488281,"y":30.360483169555664},{"x":50.43446731567383,"y":30.360370635986328},{"x":50.43522644042969,"y":30.3602294921875},{"x":50.435752868652344,"y":30.360139846801758},{"x":50.4364013671875,"y":30.360027313232422}]},{"points":[{"x":50.436408996582,"y":30.3601131439209},{"x":50.4364013671875,"y":30.360027313232422},{"x":50.4372673034668,"y":30.35990333557129},{"x":50.43830108642578,"y":30.359737396240234},{"x":50.43941879272461,"y":30.359560012817383},{"x":50.44052505493164,"y":30.35936164855957},{"x":50.44136428833008,"y":30.359210968017578},{"x":50.44203186035156,"y":30.359098434448242},{"x":50.44282150268555,"y":30.358964920043945},{"x":50.44337463378906,"y":30.358861923217773}]},{"points":[{"x":50.4433746337891,"y":30.3589382171631},{"x":50.44337463378906,"y":30.358861923217773},{"x":50.443912506103516,"y":30.358787536621094},{"x":50.44514846801758,"y":30.358583450317383},{"x":50.44612503051758,"y":30.35843849182129},{"x":50.4472770690918,"y":30.358266830444336},{"x":50.44816589355469,"y":30.358139038085938}]},{"points":[{"x":50.4481658935547,"y":30.3582134246826},{"x":50.44816589355469,"y":30.358139038085938},{"x":50.44910430908203,"y":30.357994079589844},{"x":50.45017623901367,"y":30.35784339904785},{"x":50.45100021362305,"y":30.357736587524414},{"x":50.452003479003906,"y":30.35763931274414}]},{"points":[{"x":50.4520072937012,"y":30.3577098846436},{"x":50.452003479003906,"y":30.35763931274414},{"x":50.452518463134766,"y":30.35756492614746},{"x":50.45304489135742,"y":30.357479095458984},{"x":50.45320129394531,"y":30.357446670532227},{"x":50.45534133911133,"y":30.357112884521484},{"x":50.455780029296875,"y":30.357038497924805}]},{"points":[{"x":50.4557838439941,"y":30.3571033477783},{"x":50.455780029296875,"y":30.357038497924805},{"x":50.45681381225586,"y":30.35685157775879},{"x":50.45819854736328,"y":30.35662078857422},{"x":50.45956039428711,"y":30.356399536132812},{"x":50.46089553833008,"y":30.35618019104004},{"x":50.46254348754883,"y":30.355911254882812},{"x":50.46340560913086,"y":30.355772018432617}]}]}
17	2	c_route_bus	55	{"cityID":2,"routeID":255,"routeType":"c_route_bus","number":"55","timeStart":24000,"timeFinish":76620,"intervalMin":360,"intervalMax":660,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.43844223022461,"y":30.526012420654297,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Мечникова"},{"lang_id":"c_en","value":" Mechnikova St"},{"lang_id":"c_uk","value":" вул. Мечнікова"}]},{"city_id":0,"location":{"x":50.4371223449707,"y":30.5322132110596,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Кловская"},{"lang_id":"c_en","value":" Klovska"},{"lang_id":"c_uk","value":" ст. м. Кловська"}]},{"city_id":0,"location":{"x":50.4389419555664,"y":30.5380229949951,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" спуск Кловский"},{"lang_id":"c_en","value":" Klovskyi descent"},{"lang_id":"c_uk","value":" узвіз Кловський"}]},{"city_id":0,"location":{"x":50.4445610046387,"y":30.5389080047607,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Крепостной"},{"lang_id":"c_en","value":" Krepostnyi Ln"},{"lang_id":"c_uk","value":" пров. Крепостний"}]},{"city_id":0,"location":{"x":50.4434814453125,"y":30.545768737793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Арсенальная"},{"lang_id":"c_en","value":" plosha Arsenalna"},{"lang_id":"c_uk","value":" площа Арсенальна"}]},{"city_id":0,"location":{"x":50.4391212463379,"y":30.5445919036865,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Арсенал"},{"lang_id":"c_en","value":" zavod Arsenal"},{"lang_id":"c_uk","value":" завод Арсенал"}]},{"city_id":0,"location":{"x":50.4361991882324,"y":30.5447616577148,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" кинотеатр Зоряный"},{"lang_id":"c_en","value":" kinoteatr Zoryanyi"},{"lang_id":"c_uk","value":" кінотеатр Зоряний"}]},{"city_id":0,"location":{"x":50.4323425292969,"y":30.544771194458,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Панаса Мирного"},{"lang_id":"c_en","value":" Panasa Myrnoho St"},{"lang_id":"c_uk","value":" вул. Панаса Мирного"}]},{"city_id":0,"location":{"x":50.4310264587402,"y":30.5431041717529,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Кутузова"},{"lang_id":"c_en","value":" Kutuzova St"},{"lang_id":"c_uk","value":" вул. Кутузова"}]},{"city_id":0,"location":{"x":50.4276161193848,"y":30.5506248474121,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Водоканал"},{"lang_id":"c_en","value":" Vodokanal"},{"lang_id":"c_uk","value":" Водоканал"}]},{"city_id":0,"location":{"x":50.4264335632324,"y":30.5558071136475,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Редутный"},{"lang_id":"c_en","value":" Redutnyi Ln"},{"lang_id":"c_uk","value":" пров. Редутний"}]},{"city_id":0,"location":{"x":50.4238967895508,"y":30.5651321411133,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" мост им. Патона"},{"lang_id":"c_en","value":" most Patona"},{"lang_id":"c_uk","value":" мост ім. Патона"}]},{"city_id":0,"location":{"x":50.431224822998,"y":30.595027923584,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Русанкова"},{"lang_id":"c_en","value":" Rusanivka"},{"lang_id":"c_uk","value":" Русанівка"}]},{"city_id":0,"location":{"x":50.433406829834,"y":30.6001720428467,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульвар А. Давыдова"},{"lang_id":"c_en","value":" Davydoba Blvd"},{"lang_id":"c_uk","value":" бульвар О. Давидова"}]},{"city_id":0,"location":{"x":50.4354782104492,"y":30.6050643920898,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Березняки"},{"lang_id":"c_en","value":" Bereznyaky"},{"lang_id":"c_uk","value":" Березняки"}]},{"city_id":0,"location":{"x":50.4392509460449,"y":30.6158466339111,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Тампере"},{"lang_id":"c_en","value":" Tampere St"},{"lang_id":"c_uk","value":" вул. Тампере"}]},{"city_id":0,"location":{"x":50.4403839111328,"y":30.6195106506348,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Вулкан"},{"lang_id":"c_en","value":" zavod Vulkan"},{"lang_id":"c_uk","value":" завод Вулкан"}]},{"city_id":0,"location":{"x":50.4417610168457,"y":30.6241779327393,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" универмаг Дарницкий"},{"lang_id":"c_en","value":" univermah Darnytskyi"},{"lang_id":"c_uk","value":" універмаг Дарницький"}]},{"city_id":0,"location":{"x":50.4437141418457,"y":30.6275978088379,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Ленинградская"},{"lang_id":"c_en","value":" Leninhradska square"},{"lang_id":"c_uk","value":" площа Ленінградська"}]}],"directRelations":[{"points":[{"x":50.43844223022461,"y":30.526012420654297},{"x":50.4384765625,"y":30.526065826416},{"x":50.4383125305176,"y":30.5263557434082},{"x":50.4381980895996,"y":30.526554107666},{"x":50.4380416870117,"y":30.5269622802734},{"x":50.4376258850098,"y":30.5282325744629},{"x":50.4374618530273,"y":30.5287914276123},{"x":50.4374008178711,"y":30.5290966033936},{"x":50.4372673034668,"y":30.5299282073975},{"x":50.4370651245117,"y":30.5312099456787},{"x":50.4370231628418,"y":30.5315437316895},{"x":50.4370384216309,"y":30.5317363739014},{"x":50.4371566772461,"y":30.5321865081787}]},{"points":[{"x":50.4371223449707,"y":30.5322132110596},{"x":50.4371566772461,"y":30.5321865081787},{"x":50.437572479248,"y":30.5338287353516},{"x":50.4381370544434,"y":30.5360221862793},{"x":50.4384269714355,"y":30.5371589660645},{"x":50.4386215209961,"y":30.5378513336182},{"x":50.4389495849609,"y":30.5379276275635}]},{"points":[{"x":50.4389419555664,"y":30.5380229949951},{"x":50.4389495849609,"y":30.5379276275635},{"x":50.440128326416,"y":30.5381736755371},{"x":50.441478729248,"y":30.5384426116943},{"x":50.4422912597656,"y":30.5386028289795},{"x":50.4433059692383,"y":30.5387687683105},{"x":50.4434356689453,"y":30.5387630462646},{"x":50.4435539245605,"y":30.5387096405029},{"x":50.4436531066895,"y":30.5385818481445},{"x":50.4439849853516,"y":30.538013458252},{"x":50.4445915222168,"y":30.53883934021}]},{"points":[{"x":50.4445610046387,"y":30.5389080047607},{"x":50.4445915222168,"y":30.53883934021},{"x":50.4452590942383,"y":30.5397510528564},{"x":50.4448432922363,"y":30.5405292510986},{"x":50.4443244934082,"y":30.5414772033691},{"x":50.4442558288574,"y":30.5416278839111},{"x":50.4441680908203,"y":30.5419025421143},{"x":50.4439849853516,"y":30.5426635742188},{"x":50.4439277648926,"y":30.5430126190186},{"x":50.4438743591309,"y":30.5436668395996},{"x":50.4438095092773,"y":30.5445194244385},{"x":50.4437675476074,"y":30.5450286865234},{"x":50.4437217712402,"y":30.5453090667725},{"x":50.4436378479004,"y":30.545597076416},{"x":50.4435157775879,"y":30.5458183288574}]},{"points":[{"x":50.4434814453125,"y":30.545768737793},{"x":50.4435157775879,"y":30.5458183288574},{"x":50.4433364868164,"y":30.5461235046387},{"x":50.4431571960449,"y":30.5463962554932},{"x":50.4427452087402,"y":30.5470352172852},{"x":50.4424095153809,"y":30.5475444793701},{"x":50.4419212341309,"y":30.5483226776123},{"x":50.4414939880371,"y":30.5488910675049},{"x":50.4409828186035,"y":30.5495300292969},{"x":50.4405746459961,"y":30.5500183105469},{"x":50.4404945373535,"y":30.5500984191895},{"x":50.4404373168945,"y":30.549861907959},{"x":50.4403266906738,"y":30.5496101379395},{"x":50.4402046203613,"y":30.5492782592773},{"x":50.4399795532227,"y":30.548376083374},{"x":50.4397125244141,"y":30.5471591949463},{"x":50.4394226074219,"y":30.5457534790039},{"x":50.4392051696777,"y":30.5446853637695},{"x":50.4391250610352,"y":30.5446853637695}]},{"points":[{"x":50.4391212463379,"y":30.5445919036865},{"x":50.4391250610352,"y":30.5446853637695},{"x":50.4383697509766,"y":30.5447082519531},{"x":50.4367713928223,"y":30.5447940826416},{"x":50.4365005493164,"y":30.5448150634766},{"x":50.4362030029297,"y":30.5448360443115}]},{"points":[{"x":50.4361991882324,"y":30.5447616577148},{"x":50.4362030029297,"y":30.5448360443115},{"x":50.435905456543,"y":30.5448627471924},{"x":50.4355239868164,"y":30.544942855835},{"x":50.4349784851074,"y":30.5449962615967},{"x":50.434009552002,"y":30.5450019836426},{"x":50.4334564208984,"y":30.5450191497803},{"x":50.4330177307129,"y":30.5449924468994},{"x":50.4325065612793,"y":30.5449485778809},{"x":50.4323196411133,"y":30.5448474884033}]},{"points":[{"x":50.4323425292969,"y":30.544771194458},{"x":50.4323196411133,"y":30.5448474884033},{"x":50.4321746826172,"y":30.5447292327881},{"x":50.4320411682129,"y":30.5445995330811},{"x":50.4318008422852,"y":30.544261932373},{"x":50.4309997558594,"y":30.5431518554688}]},{"points":[{"x":50.4310264587402,"y":30.5431041717529},{"x":50.4309997558594,"y":30.5431518554688},{"x":50.4302597045898,"y":30.5421009063721},{"x":50.4298362731934,"y":30.5415363311768},{"x":50.4297103881836,"y":30.5417575836182},{"x":50.4292335510254,"y":30.5426197052002},{"x":50.4291191101074,"y":30.5428886413574},{"x":50.4289512634277,"y":30.5434417724609},{"x":50.4288940429688,"y":30.5436782836914},{"x":50.4288597106934,"y":30.5439929962158},{"x":50.4288635253906,"y":30.5443420410156},{"x":50.4289054870605,"y":30.5446376800537},{"x":50.429069519043,"y":30.545389175415},{"x":50.4295501708984,"y":30.5469436645508},{"x":50.4297027587891,"y":30.5474700927734},{"x":50.4297523498535,"y":30.5477924346924},{"x":50.429759979248,"y":30.548189163208},{"x":50.4297561645508,"y":30.5485153198242},{"x":50.4297142028809,"y":30.5488052368164},{"x":50.4296340942383,"y":30.5490798950195},{"x":50.4295196533203,"y":30.5491924285889},{"x":50.4288215637207,"y":30.5497493743896},{"x":50.4280014038086,"y":30.5503559112549},{"x":50.4276351928711,"y":30.5506935119629}]},{"points":[{"x":50.4276161193848,"y":30.5506248474121},{"x":50.4276351928711,"y":30.5506935119629},{"x":50.4273529052734,"y":30.5509834289551},{"x":50.42724609375,"y":30.5511341094971},{"x":50.4271202087402,"y":30.5514392852783},{"x":50.4270210266113,"y":30.5518264770508},{"x":50.4269142150879,"y":30.5523891448975},{"x":50.426700592041,"y":30.5539665222168},{"x":50.4265823364258,"y":30.554931640625},{"x":50.4264755249023,"y":30.5558109283447}]},{"points":[{"x":50.4264335632324,"y":30.5558071136475},{"x":50.4264755249023,"y":30.5558109283447},{"x":50.4263496398926,"y":30.5570125579834},{"x":50.4262809753418,"y":30.5574588775635},{"x":50.4259071350098,"y":30.5592079162598},{"x":50.4257774353027,"y":30.5597820281982},{"x":50.4254989624023,"y":30.5602378845215},{"x":50.4251976013184,"y":30.560661315918},{"x":50.4246940612793,"y":30.5613632202148},{"x":50.4245758056641,"y":30.5615730285645},{"x":50.4245185852051,"y":30.5618095397949},{"x":50.4244766235352,"y":30.561975479126},{"x":50.4244651794434,"y":30.5623397827148},{"x":50.424446105957,"y":30.562629699707},{"x":50.4244041442871,"y":30.5630168914795},{"x":50.4242362976074,"y":30.5637836456299},{"x":50.4239387512207,"y":30.5651569366455}]},{"points":[{"x":50.4238967895508,"y":30.5651321411133},{"x":50.4239387512207,"y":30.5651569366455},{"x":50.4237251281738,"y":30.5661106109619},{"x":50.423583984375,"y":30.5667877197266},{"x":50.4235458374023,"y":30.5671997070312},{"x":50.4235191345215,"y":30.5676784515381},{"x":50.4235305786133,"y":30.5681171417236},{"x":50.4235649108887,"y":30.568826675415},{"x":50.4235916137695,"y":30.5692977905273},{"x":50.4236526489258,"y":30.5697326660156},{"x":50.4237632751465,"y":30.5702857971191},{"x":50.4241485595703,"y":30.571647644043},{"x":50.4245071411133,"y":30.5728702545166},{"x":50.4249801635742,"y":30.5745277404785},{"x":50.4254112243652,"y":30.5759983062744},{"x":50.4258041381836,"y":30.5773601531982},{"x":50.4263381958008,"y":30.5791530609131},{"x":50.4267349243164,"y":30.5804996490479},{"x":50.427131652832,"y":30.5818176269531},{"x":50.4278144836426,"y":30.584098815918},{"x":50.428279876709,"y":30.5856704711914},{"x":50.4287796020508,"y":30.5873489379883},{"x":50.4292602539062,"y":30.5889854431152},{"x":50.4298095703125,"y":30.5908298492432},{"x":50.4300651550293,"y":30.5916576385498},{"x":50.430419921875,"y":30.5928688049316},{"x":50.4305686950684,"y":30.593318939209},{"x":50.4310531616211,"y":30.5944671630859},{"x":50.4312629699707,"y":30.5949726104736}]},{"points":[{"x":50.431224822998,"y":30.595027923584},{"x":50.4312629699707,"y":30.5949726104736},{"x":50.4315452575684,"y":30.5956420898438},{"x":50.431884765625,"y":30.5964679718018},{"x":50.4323539733887,"y":30.5975742340088},{"x":50.4328956604004,"y":30.5988388061523},{"x":50.4334411621094,"y":30.6001319885254}]},{"points":[{"x":50.433406829834,"y":30.6001720428467},{"x":50.4334411621094,"y":30.6001319885254},{"x":50.4338798522949,"y":30.6011943817139},{"x":50.4344673156738,"y":30.6025676727295},{"x":50.4350090026855,"y":30.6038398742676},{"x":50.4355125427246,"y":30.6050186157227}]},{"points":[{"x":50.4354782104492,"y":30.6050643920898},{"x":50.4355125427246,"y":30.6050186157227},{"x":50.4360427856445,"y":30.6062850952148},{"x":50.4365501403809,"y":30.6074771881104},{"x":50.4369049072266,"y":30.6083946228027},{"x":50.437141418457,"y":30.6090316772461},{"x":50.4375038146973,"y":30.6100406646729},{"x":50.4378776550293,"y":30.6112365722656},{"x":50.4380569458008,"y":30.611837387085},{"x":50.438404083252,"y":30.612979888916},{"x":50.4388580322266,"y":30.6144237518311},{"x":50.4392929077148,"y":30.6158027648926}]},{"points":[{"x":50.4392509460449,"y":30.6158466339111},{"x":50.4392929077148,"y":30.6158027648926},{"x":50.4397583007812,"y":30.6173477172852},{"x":50.4404220581055,"y":30.6194705963135}]},{"points":[{"x":50.4403839111328,"y":30.6195106506348},{"x":50.4404220581055,"y":30.6194705963135},{"x":50.4409866333008,"y":30.62131690979},{"x":50.4414978027344,"y":30.6230335235596},{"x":50.4416999816895,"y":30.6237030029297},{"x":50.4418067932129,"y":30.6241436004639}]},{"points":[{"x":50.4417610168457,"y":30.6241779327393},{"x":50.4418067932129,"y":30.6241436004639},{"x":50.4418411254883,"y":30.6244983673096},{"x":50.4418754577637,"y":30.6250457763672},{"x":50.4418640136719,"y":30.625431060791},{"x":50.4418258666992,"y":30.6257419586182},{"x":50.4418258666992,"y":30.6260051727295},{"x":50.4418487548828,"y":30.6262512207031},{"x":50.4419364929199,"y":30.6265316009521},{"x":50.442066192627,"y":30.6266708374023},{"x":50.4422340393066,"y":30.6267185211182},{"x":50.4423866271973,"y":30.6267032623291},{"x":50.4425239562988,"y":30.6266269683838},{"x":50.4429359436035,"y":30.6262836456299},{"x":50.4430885314941,"y":30.6261558532715},{"x":50.4432563781738,"y":30.6259784698486},{"x":50.4433631896973,"y":30.6258869171143},{"x":50.4434814453125,"y":30.6258926391602},{"x":50.4440612792969,"y":30.626256942749},{"x":50.4437141418457,"y":30.6275978088379}]}],"reverseStations":[{"city_id":0,"location":{"x":50.4436798095703,"y":30.6275691986084,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Ленинградская"},{"lang_id":"c_en","value":" Leninhradska square"},{"lang_id":"c_uk","value":" площа Ленінградська"}]},{"city_id":0,"location":{"x":50.4417457580566,"y":30.6232986450195,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" универмаг Дарницкий"},{"lang_id":"c_en","value":" univermah Darnytskyi"},{"lang_id":"c_uk","value":" універмаг Дарницький"}]},{"city_id":0,"location":{"x":50.4406394958496,"y":30.6196403503418,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" завод Вулкан"},{"lang_id":"c_en","value":" zavod Vulkan"},{"lang_id":"c_uk","value":" завод Вулкан"}]},{"city_id":0,"location":{"x":50.4394760131836,"y":30.6158580780029,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Тампере"},{"lang_id":"c_en","value":" Tampere St"},{"lang_id":"c_uk","value":" вул. Тампере"}]},{"city_id":0,"location":{"x":50.4360008239746,"y":30.6057415008545,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Березняки"},{"lang_id":"c_en","value":" Bereznyaky"},{"lang_id":"c_uk","value":" Березняки"}]},{"city_id":0,"location":{"x":50.4339218139648,"y":30.6008262634277,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" бульвар А. Давыдова"},{"lang_id":"c_en","value":" Davydoba Blvd"},{"lang_id":"c_uk","value":" бульвар О. Давидова"}]},{"city_id":0,"location":{"x":50.4319038391113,"y":30.596004486084,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Русанкова"},{"lang_id":"c_en","value":" Rusanivka"},{"lang_id":"c_uk","value":" Русанівка"}]},{"city_id":0,"location":{"x":50.4241065979004,"y":30.5652389526367,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" мост им. Патона"},{"lang_id":"c_en","value":" most Patona"},{"lang_id":"c_uk","value":" мост ім. Патона"}]},{"city_id":0,"location":{"x":50.4259605407715,"y":30.5592231750488,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Старонаводницкая"},{"lang_id":"c_en","value":" Staronavodnytska St"},{"lang_id":"c_uk","value":" вул. Старонаводницька"}]},{"city_id":0,"location":{"x":50.426628112793,"y":30.5549373626709,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Редутный"},{"lang_id":"c_en","value":" Redutnyi Ln"},{"lang_id":"c_uk","value":" пров. Редутний"}]},{"city_id":0,"location":{"x":50.4280281066895,"y":30.5504417419434,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Водоканал"},{"lang_id":"c_en","value":" Vodokanal"},{"lang_id":"c_uk","value":" Водоканал"}]},{"city_id":0,"location":{"x":50.430046081543,"y":30.5423049926758,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Кутузова"},{"lang_id":"c_en","value":" Kutuzova St"},{"lang_id":"c_uk","value":" вул. Кутузова"}]},{"city_id":0,"location":{"x":50.4330177307129,"y":30.5450611114502,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Панаса Мирного"},{"lang_id":"c_en","value":" Panasa Myrnoho St"},{"lang_id":"c_uk","value":" вул. Панаса Мирного"}]},{"city_id":0,"location":{"x":50.4361686706543,"y":30.545560836792,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Суворова"},{"lang_id":"c_en","value":" Suvorova St"},{"lang_id":"c_uk","value":" вул. Суворова"}]},{"city_id":0,"location":{"x":50.4399375915527,"y":30.5494918823242,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Славы"},{"lang_id":"c_en","value":" plosha Slavy"},{"lang_id":"c_uk","value":" площа Слави"}]},{"city_id":0,"location":{"x":50.4410133361816,"y":30.5495891571045,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Славы"},{"lang_id":"c_en","value":" plosha Slavy"},{"lang_id":"c_uk","value":" площа Слави"}]},{"city_id":0,"location":{"x":50.4438667297363,"y":30.5445251464844,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" площадь Арсенальная"},{"lang_id":"c_en","value":" plosha Arsenalna"},{"lang_id":"c_uk","value":" площа Арсенальна"}]},{"city_id":0,"location":{"x":50.4446258544922,"y":30.5387802124023,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" пер. Крепостной"},{"lang_id":"c_en","value":" Krepostnyi Ln"},{"lang_id":"c_uk","value":" пров. Крепостний"}]},{"city_id":0,"location":{"x":50.4384689331055,"y":30.5371265411377,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" спуск Кловский"},{"lang_id":"c_en","value":" Klovskyi descent"},{"lang_id":"c_uk","value":" узвіз Кловський"}]},{"city_id":0,"location":{"x":50.4371223449707,"y":30.5312156677246,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Кловская"},{"lang_id":"c_en","value":" Klovska"},{"lang_id":"c_uk","value":" ст. м. Кловська"}]},{"city_id":0,"location":{"x":50.4383125305176,"y":30.5263557434082,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Мечникова"},{"lang_id":"c_en","value":" Mechnikova St"},{"lang_id":"c_uk","value":" вул. Мечнікова"}]}],"reverseRelations":[{"points":[{"x":50.4436798095703,"y":30.6275691986084},{"x":50.4437141418457,"y":30.6275978088379},{"x":50.4434814453125,"y":30.628568649292},{"x":50.443431854248,"y":30.6288318634033},{"x":50.4431457519531,"y":30.6286067962646},{"x":50.4424629211426,"y":30.6281929016113},{"x":50.4417686462402,"y":30.6278018951416},{"x":50.4418716430664,"y":30.6272773742676},{"x":50.4422149658203,"y":30.6269111633301},{"x":50.4423866271973,"y":30.6267032623291},{"x":50.4425239562988,"y":30.6266269683838},{"x":50.4428825378418,"y":30.6263008117676},{"x":50.4430122375488,"y":30.6261119842529},{"x":50.4430618286133,"y":30.6259574890137},{"x":50.4430503845215,"y":30.6258010864258},{"x":50.4430084228516,"y":30.6256618499756},{"x":50.4428749084473,"y":30.625431060791},{"x":50.442813873291,"y":30.6253395080566},{"x":50.442813873291,"y":30.6253051757812},{"x":50.4424934387207,"y":30.6250152587891},{"x":50.442440032959,"y":30.6249599456787},{"x":50.4423484802246,"y":30.6248359680176},{"x":50.4420623779297,"y":30.6243534088135},{"x":50.4419097900391,"y":30.6240692138672},{"x":50.441707611084,"y":30.6233329772949}]},{"points":[{"x":50.4417457580566,"y":30.6232986450195},{"x":50.441707611084,"y":30.6233329772949},{"x":50.4415702819824,"y":30.6228771209717},{"x":50.441276550293,"y":30.6218967437744},{"x":50.4409027099609,"y":30.6206569671631},{"x":50.4405975341797,"y":30.6196804046631}]},{"points":[{"x":50.4406394958496,"y":30.6196403503418},{"x":50.4405975341797,"y":30.6196804046631},{"x":50.4403190612793,"y":30.6187419891357},{"x":50.4399108886719,"y":30.6174335479736},{"x":50.4394378662109,"y":30.6159038543701}]},{"points":[{"x":50.4394760131836,"y":30.6158580780029},{"x":50.4394378662109,"y":30.6159038543701},{"x":50.439022064209,"y":30.614574432373},{"x":50.4386138916016,"y":30.6132640838623},{"x":50.4382629394531,"y":30.6121120452881},{"x":50.437858581543,"y":30.6108131408691},{"x":50.4375839233398,"y":30.6099166870117},{"x":50.4373435974121,"y":30.6092624664307},{"x":50.4368934631348,"y":30.6080226898193},{"x":50.4365272521973,"y":30.6071109771729},{"x":50.4362716674805,"y":30.6065063476562},{"x":50.4359703063965,"y":30.6057815551758}]},{"points":[{"x":50.4360008239746,"y":30.6057415008545},{"x":50.4359703063965,"y":30.6057815551758},{"x":50.4356842041016,"y":30.6051006317139},{"x":50.4352645874023,"y":30.6041507720947},{"x":50.4347953796387,"y":30.6030445098877},{"x":50.4343490600586,"y":30.6019725799561},{"x":50.4338798522949,"y":30.6008720397949}]},{"points":[{"x":50.4339218139648,"y":30.6008262634277},{"x":50.4338798522949,"y":30.6008720397949},{"x":50.4334144592285,"y":30.5997562408447},{"x":50.4328956604004,"y":30.5985126495361},{"x":50.4323577880859,"y":30.5972633361816},{"x":50.4318580627441,"y":30.596061706543}]},{"points":[{"x":50.4319038391113,"y":30.596004486084},{"x":50.4318580627441,"y":30.596061706543},{"x":50.4312744140625,"y":30.5946922302246},{"x":50.4308166503906,"y":30.5935878753662},{"x":50.4306564331055,"y":30.5932025909424},{"x":50.4305267333984,"y":30.5928363800049},{"x":50.4303359985352,"y":30.5921726226807},{"x":50.4301528930664,"y":30.5915813446045},{"x":50.4298782348633,"y":30.5906543731689},{"x":50.429313659668,"y":30.5887393951416},{"x":50.4290084838867,"y":30.5876808166504},{"x":50.4285163879395,"y":30.5860290527344},{"x":50.4280471801758,"y":30.5844631195068},{"x":50.4275665283203,"y":30.5828533172607},{"x":50.4270858764648,"y":30.5812549591064},{"x":50.426685333252,"y":30.5798988342285},{"x":50.4263229370117,"y":30.5786972045898},{"x":50.4259376525879,"y":30.5773983001709},{"x":50.4255142211914,"y":30.5759811401367},{"x":50.4251441955566,"y":30.5746841430664},{"x":50.4248008728027,"y":30.5734386444092},{"x":50.4245071411133,"y":30.5724315643311},{"x":50.4242248535156,"y":30.5714912414551},{"x":50.4240875244141,"y":30.5709991455078},{"x":50.4239234924316,"y":30.5704250335693},{"x":50.4238204956055,"y":30.5699996948242},{"x":50.4237632751465,"y":30.5696792602539},{"x":50.4237365722656,"y":30.5693454742432},{"x":50.4236907958984,"y":30.5684719085693},{"x":50.4236793518066,"y":30.5680751800537},{"x":50.4236793518066,"y":30.5676078796387},{"x":50.4237098693848,"y":30.567066192627},{"x":50.4237747192383,"y":30.5665454864502},{"x":50.4239349365234,"y":30.5657997131348},{"x":50.4240684509277,"y":30.565221786499}]},{"points":[{"x":50.4241065979004,"y":30.5652389526367},{"x":50.4240684509277,"y":30.565221786499},{"x":50.4242935180664,"y":30.5642127990723},{"x":50.4244346618652,"y":30.5635623931885},{"x":50.4245223999023,"y":30.5631446838379},{"x":50.4246025085449,"y":30.5628337860107},{"x":50.4247589111328,"y":30.5622329711914},{"x":50.4248428344727,"y":30.5619316101074},{"x":50.4249649047852,"y":30.5615997314453},{"x":50.4251556396484,"y":30.5612144470215},{"x":50.4253768920898,"y":30.5607948303223},{"x":50.4255676269531,"y":30.5603923797607},{"x":50.4256744384766,"y":30.5601024627686},{"x":50.4257774353027,"y":30.5597820281982},{"x":50.4259071350098,"y":30.5592079162598}]},{"points":[{"x":50.4259605407715,"y":30.5592231750488},{"x":50.4259071350098,"y":30.5592079162598},{"x":50.4262809753418,"y":30.5574588775635},{"x":50.4263496398926,"y":30.5570125579834},{"x":50.4264755249023,"y":30.5558109283447},{"x":50.4265823364258,"y":30.554931640625}]},{"points":[{"x":50.426628112793,"y":30.5549373626709},{"x":50.4265823364258,"y":30.554931640625},{"x":50.426700592041,"y":30.5539665222168},{"x":50.4269142150879,"y":30.5523891448975},{"x":50.4270210266113,"y":30.5518264770508},{"x":50.4271202087402,"y":30.5514392852783},{"x":50.42724609375,"y":30.5511341094971},{"x":50.4273529052734,"y":30.5509834289551},{"x":50.4276351928711,"y":30.5506935119629},{"x":50.4280014038086,"y":30.5503559112549}]},{"points":[{"x":50.4280281066895,"y":30.5504417419434},{"x":50.4280014038086,"y":30.5503559112549},{"x":50.4288215637207,"y":30.5497493743896},{"x":50.4295196533203,"y":30.5491924285889},{"x":50.4296340942383,"y":30.5490798950195},{"x":50.4297142028809,"y":30.5488052368164},{"x":50.4297561645508,"y":30.5485153198242},{"x":50.429759979248,"y":30.548189163208},{"x":50.4297523498535,"y":30.5477924346924},{"x":50.4297027587891,"y":30.5474700927734},{"x":50.4295501708984,"y":30.5469436645508},{"x":50.429069519043,"y":30.545389175415},{"x":50.4289054870605,"y":30.5446376800537},{"x":50.4288635253906,"y":30.5443420410156},{"x":50.4288597106934,"y":30.5439929962158},{"x":50.4288940429688,"y":30.5436782836914},{"x":50.4289512634277,"y":30.5434417724609},{"x":50.4291191101074,"y":30.5428886413574},{"x":50.4292335510254,"y":30.5426197052002},{"x":50.4297103881836,"y":30.5417575836182},{"x":50.4300765991211,"y":30.5422458648682}]},{"points":[{"x":50.430046081543,"y":30.5423049926758},{"x":50.4300765991211,"y":30.5422458648682},{"x":50.4310874938965,"y":30.5436191558838},{"x":50.4318389892578,"y":30.5446586608887},{"x":50.4319725036621,"y":30.5448093414307},{"x":50.4321327209473,"y":30.544921875},{"x":50.432258605957,"y":30.5449810028076},{"x":50.4325065612793,"y":30.5449485778809},{"x":50.4330177307129,"y":30.5449924468994}]},{"points":[{"x":50.4330177307129,"y":30.5450611114502},{"x":50.4330177307129,"y":30.5449924468994},{"x":50.4334564208984,"y":30.5450191497803},{"x":50.434009552002,"y":30.5450019836426},{"x":50.4349784851074,"y":30.5449962615967},{"x":50.4355239868164,"y":30.544942855835},{"x":50.4357604980469,"y":30.5451145172119},{"x":50.4360237121582,"y":30.5453357696533},{"x":50.4361877441406,"y":30.5454902648926}]},{"points":[{"x":50.4361686706543,"y":30.545560836792},{"x":50.4361877441406,"y":30.5454902648926},{"x":50.4373931884766,"y":30.5466442108154},{"x":50.4380378723145,"y":30.5471973419189},{"x":50.4383277893066,"y":30.5474853515625},{"x":50.4392013549805,"y":30.5484199523926},{"x":50.4397010803223,"y":30.5490684509277},{"x":50.4399681091309,"y":30.5494232177734}]},{"points":[{"x":50.4399375915527,"y":30.5494918823242},{"x":50.4399681091309,"y":30.5494232177734},{"x":50.4404945373535,"y":30.5500984191895},{"x":50.4405746459961,"y":30.5500183105469},{"x":50.4409828186035,"y":30.5495300292969}]},{"points":[{"x":50.4410133361816,"y":30.5495891571045},{"x":50.4409828186035,"y":30.5495300292969},{"x":50.4414939880371,"y":30.5488910675049},{"x":50.4419212341309,"y":30.5483226776123},{"x":50.4424095153809,"y":30.5475444793701},{"x":50.4427452087402,"y":30.5470352172852},{"x":50.4431571960449,"y":30.5463962554932},{"x":50.4433364868164,"y":30.5461235046387},{"x":50.4435157775879,"y":30.5458183288574},{"x":50.4436378479004,"y":30.545597076416},{"x":50.4437217712402,"y":30.5453090667725},{"x":50.4437675476074,"y":30.5450286865234},{"x":50.4438095092773,"y":30.5445194244385}]},{"points":[{"x":50.4438667297363,"y":30.5445251464844},{"x":50.4438095092773,"y":30.5445194244385},{"x":50.4438743591309,"y":30.5436668395996},{"x":50.4439277648926,"y":30.5430126190186},{"x":50.4439849853516,"y":30.5426635742188},{"x":50.4441680908203,"y":30.5419025421143},{"x":50.4442558288574,"y":30.5416278839111},{"x":50.4443244934082,"y":30.5414772033691},{"x":50.4448432922363,"y":30.5405292510986},{"x":50.4452590942383,"y":30.5397510528564},{"x":50.4445915222168,"y":30.53883934021}]},{"points":[{"x":50.4446258544922,"y":30.5387802124023},{"x":50.4445915222168,"y":30.53883934021},{"x":50.4439849853516,"y":30.538013458252},{"x":50.4436531066895,"y":30.5385818481445},{"x":50.4435539245605,"y":30.5387096405029},{"x":50.4434356689453,"y":30.5387630462646},{"x":50.4433059692383,"y":30.5387687683105},{"x":50.4422912597656,"y":30.5386028289795},{"x":50.441478729248,"y":30.5384426116943},{"x":50.440128326416,"y":30.5381736755371},{"x":50.4389495849609,"y":30.5379276275635},{"x":50.4386215209961,"y":30.5378513336182},{"x":50.4384269714355,"y":30.5371589660645}]},{"points":[{"x":50.4384689331055,"y":30.5371265411377},{"x":50.4384269714355,"y":30.5371589660645},{"x":50.4381370544434,"y":30.5360221862793},{"x":50.437572479248,"y":30.5338287353516},{"x":50.4371566772461,"y":30.5321865081787},{"x":50.4370384216309,"y":30.5317363739014},{"x":50.4370231628418,"y":30.5315437316895},{"x":50.4370651245117,"y":30.5312099456787}]},{"points":[{"x":50.4371223449707,"y":30.5312156677246},{"x":50.4370651245117,"y":30.5312099456787},{"x":50.4372673034668,"y":30.5299282073975},{"x":50.4374008178711,"y":30.5290966033936},{"x":50.4374618530273,"y":30.5287914276123},{"x":50.4376258850098,"y":30.5282325744629},{"x":50.4380416870117,"y":30.5269622802734},{"x":50.4381980895996,"y":30.526554107666},{"x":50.4383125305176,"y":30.5263557434082}]}]}
18	2	c_route_bus	30	{"cityID":2,"routeID":422,"routeType":"c_route_bus","number":"30","timeStart":22500,"timeFinish":74160,"intervalMin":1200,"intervalMax":1200,"cost":1.5,"directStations":[{"city_id":0,"location":{"x":50.5529518127441,"y":30.3357582092285,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Пуща-Водица"},{"lang_id":"c_en","value":" Pushya-Vodytsya"},{"lang_id":"c_uk","value":" Пуща-Водиця"}]},{"city_id":0,"location":{"x":50.5409317016602,"y":30.3536643981934,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 7-ая линия"},{"lang_id":"c_en","value":" Soma liniya"},{"lang_id":"c_uk","value":" 7-ма лінія"}]},{"city_id":0,"location":{"x":50.537113189697266,"y":30.35633659362793,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Юнкерова"},{"lang_id":"c_en","value":" Unkerova St"},{"lang_id":"c_uk","value":" вул. Юнкерова"}]},{"city_id":0,"location":{"x":50.534725189209,"y":30.3554458618164,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Школа интернат"},{"lang_id":"c_en","value":" Shkola internat"},{"lang_id":"c_uk","value":" Школа інтернат"}]},{"city_id":0,"location":{"x":50.532432556152344,"y":30.358524322509766,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Госпиталь"},{"lang_id":"c_en","value":" Shpital"},{"lang_id":"c_uk","value":" Шпіталь"}]},{"city_id":0,"location":{"x":50.53095626831055,"y":30.360504150390625,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 3-я линия"},{"lang_id":"c_en","value":" Tretya liniya"},{"lang_id":"c_uk","value":" 3-я лінія"}]},{"city_id":0,"location":{"x":50.5293731689453,"y":30.3625640869141,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 2-я линия"},{"lang_id":"c_en","value":" Druha liniya"},{"lang_id":"c_uk","value":" 2-га лінія"}]},{"city_id":0,"location":{"x":50.527717590332,"y":30.3647880554199,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 1-я линия"},{"lang_id":"c_en","value":" Persha liniya"},{"lang_id":"c_uk","value":" 1-ша лінія"}]},{"city_id":0,"location":{"x":50.5263290405273,"y":30.3664989471436,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Городская"},{"lang_id":"c_en","value":" Horodska St"},{"lang_id":"c_uk","value":" вул. Городська"}]},{"city_id":0,"location":{"x":50.5162582397461,"y":30.3617515563965,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" дорога на Гостомель"},{"lang_id":"c_en","value":" doroha na Hostomel"},{"lang_id":"c_uk","value":" дорога на Гостомель"}]},{"city_id":0,"location":{"x":50.4997138977051,"y":30.3647518157959,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Синеозерная"},{"lang_id":"c_en","value":" Synoozerna St"},{"lang_id":"c_uk","value":" вул. Синьоозерна"}]},{"city_id":0,"location":{"x":50.4735488891602,"y":30.357349395752,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Генерала Наумова"},{"lang_id":"c_en","value":" Henerala Naumova St"},{"lang_id":"c_uk","value":" вул. Генерала Наумова"}]},{"city_id":0,"location":{"x":50.47056579589844,"y":30.35614776611328,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Нефтяник"},{"lang_id":"c_en","value":" Neftyanyk"},{"lang_id":"c_uk","value":" Нефтяник"}]},{"city_id":0,"location":{"x":50.46579360961914,"y":30.35540199279785,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Академгородок"},{"lang_id":"c_en","value":" Akademmistechko"},{"lang_id":"c_uk","value":" ст. м. Академмістечко"}]}],"directRelations":[{"points":[{"x":50.5529518127441,"y":30.3357582092285},{"x":50.5529899597168,"y":30.335693359375},{"x":50.55361557006836,"y":30.33692741394043},{"x":50.553199768066406,"y":30.337539672851562},{"x":50.55293655395508,"y":30.337919235229492},{"x":50.55206298828125,"y":30.33897590637207},{"x":50.551170349121094,"y":30.340194702148438},{"x":50.550514221191406,"y":30.3410587310791},{"x":50.54935836791992,"y":30.34257698059082},{"x":50.54889678955078,"y":30.343172073364258},{"x":50.548274993896484,"y":30.34398651123047},{"x":50.54733657836914,"y":30.345279693603516},{"x":50.546207427978516,"y":30.346813201904297},{"x":50.54548263549805,"y":30.3477840423584},{"x":50.544193267822266,"y":30.349485397338867},{"x":50.54379653930664,"y":30.349985122680664},{"x":50.54261016845703,"y":30.351566314697266},{"x":50.54117965698242,"y":30.35350799560547},{"x":50.540977478027344,"y":30.353755950927734}]},{"points":[{"x":50.5409317016602,"y":30.3536643981934},{"x":50.540977478027344,"y":30.353755950927734},{"x":50.540130615234375,"y":30.354877471923828},{"x":50.53944778442383,"y":30.355783462524414},{"x":50.53789520263672,"y":30.357891082763672},{"x":50.53706741333008,"y":30.356399536132812}]},{"points":[{"x":50.537113189697266,"y":30.35633659362793},{"x":50.53706741333008,"y":30.356399536132812},{"x":50.536869049072266,"y":30.3560791015625},{"x":50.536659240722656,"y":30.355798721313477},{"x":50.53618621826172,"y":30.35496711730957},{"x":50.53595733642578,"y":30.354570388793945},{"x":50.53589630126953,"y":30.354415893554688},{"x":50.53590774536133,"y":30.354270935058594},{"x":50.5357551574707,"y":30.354040145874023},{"x":50.53547286987305,"y":30.35456085205078},{"x":50.5350341796875,"y":30.355161666870117},{"x":50.534767150878906,"y":30.35553741455078}]},{"points":[{"x":50.534725189209,"y":30.3554458618164},{"x":50.534767150878906,"y":30.35553741455078},{"x":50.53441619873047,"y":30.356019973754883},{"x":50.5341911315918,"y":30.35633087158203},{"x":50.53377151489258,"y":30.35689926147461},{"x":50.532859802246094,"y":30.358083724975586},{"x":50.532466888427734,"y":30.35859489440918}]},{"points":[{"x":50.532432556152344,"y":30.358524322509766},{"x":50.532466888427734,"y":30.35859489440918},{"x":50.53170394897461,"y":30.359619140625},{"x":50.5309944152832,"y":30.36056900024414}]},{"points":[{"x":50.53095626831055,"y":30.360504150390625},{"x":50.5309944152832,"y":30.36056900024414},{"x":50.53053665161133,"y":30.361169815063477},{"x":50.52973937988281,"y":30.36220359802246},{"x":50.52952575683594,"y":30.362478256225586},{"x":50.52940368652344,"y":30.362632751464844}]},{"points":[{"x":50.5293731689453,"y":30.3625640869141},{"x":50.52940368652344,"y":30.362632751464844},{"x":50.528663635253906,"y":30.3636417388916},{"x":50.52793884277344,"y":30.364612579345703},{"x":50.52775573730469,"y":30.36485481262207}]},{"points":[{"x":50.527717590332,"y":30.3647880554199},{"x":50.52775573730469,"y":30.36485481262207},{"x":50.527069091796875,"y":30.365755081176758},{"x":50.526344299316406,"y":30.366729736328125},{"x":50.52629470825195,"y":30.366561889648438}]},{"points":[{"x":50.5263290405273,"y":30.3664989471436},{"x":50.52629470825195,"y":30.366561889648438},{"x":50.52587890625,"y":30.365787506103516},{"x":50.52507781982422,"y":30.36431884765625},{"x":50.524436950683594,"y":30.36311149597168},{"x":50.524112701416016,"y":30.362611770629883},{"x":50.52381134033203,"y":30.362215042114258},{"x":50.52348709106445,"y":30.361974716186523},{"x":50.523193359375,"y":30.361865997314453},{"x":50.52288055419922,"y":30.361845016479492},{"x":50.522029876708984,"y":30.361839294433594},{"x":50.52055358886719,"y":30.36182403564453},{"x":50.51959228515625,"y":30.361812591552734},{"x":50.51823806762695,"y":30.36180305480957},{"x":50.5173454284668,"y":30.361785888671875},{"x":50.51671600341797,"y":30.36180305480957},{"x":50.51625061035156,"y":30.36185073852539}]},{"points":[{"x":50.5162582397461,"y":30.3617515563965},{"x":50.51625061035156,"y":30.36185073852539},{"x":50.5159912109375,"y":30.361845016479492},{"x":50.51579284667969,"y":30.361833572387695},{"x":50.51571273803711,"y":30.36182975769043},{"x":50.515419006347656,"y":30.361831665039062},{"x":50.514949798583984,"y":30.36191177368164},{"x":50.51396942138672,"y":30.362110137939453},{"x":50.51316833496094,"y":30.362272262573242},{"x":50.51218795776367,"y":30.362464904785156},{"x":50.51126480102539,"y":30.362642288208008},{"x":50.51047897338867,"y":30.362808227539062},{"x":50.509620666503906,"y":30.36296844482422},{"x":50.50876998901367,"y":30.363130569458008},{"x":50.50782012939453,"y":30.36332893371582},{"x":50.506927490234375,"y":30.36350440979004},{"x":50.50593185424805,"y":30.36368751525879},{"x":50.50477981567383,"y":30.36391258239746},{"x":50.503868103027344,"y":30.364084243774414},{"x":50.50290298461914,"y":30.364267349243164},{"x":50.5018310546875,"y":30.364477157592773},{"x":50.500789642333984,"y":30.364669799804688},{"x":50.50018310546875,"y":30.364782333374023},{"x":50.49971008300781,"y":30.364830017089844}]},{"points":[{"x":50.4997138977051,"y":30.3647518157959},{"x":50.49971008300781,"y":30.364830017089844},{"x":50.49917221069336,"y":30.364877700805664},{"x":50.49845504760742,"y":30.36496353149414},{"x":50.49754333496094,"y":30.365081787109375},{"x":50.496883392333984,"y":30.36517333984375},{"x":50.49610900878906,"y":30.36530303955078},{"x":50.49513244628906,"y":30.365463256835938},{"x":50.49413299560547,"y":30.365549087524414},{"x":50.49338150024414,"y":30.365516662597656},{"x":50.49281692504883,"y":30.365463256835938},{"x":50.491939544677734,"y":30.365259170532227},{"x":50.49152374267578,"y":30.36517906188965},{"x":50.49070358276367,"y":30.3648738861084},{"x":50.48972702026367,"y":30.364444732666016},{"x":50.48885726928711,"y":30.364063262939453},{"x":50.48757553100586,"y":30.36353302001953},{"x":50.4863166809082,"y":30.363018035888672},{"x":50.484989166259766,"y":30.362438201904297},{"x":50.48387908935547,"y":30.361955642700195},{"x":50.48228073120117,"y":30.36127281188965},{"x":50.48078155517578,"y":30.36060905456543},{"x":50.479888916015625,"y":30.360206604003906},{"x":50.47844314575195,"y":30.359535217285156},{"x":50.47747039794922,"y":30.359100341796875},{"x":50.476932525634766,"y":30.358861923217773},{"x":50.47598648071289,"y":30.358476638793945},{"x":50.47477722167969,"y":30.35795021057129},{"x":50.473533630371094,"y":30.35742950439453}]},{"points":[{"x":50.4735488891602,"y":30.357349395752},{"x":50.473533630371094,"y":30.35742950439453},{"x":50.472591400146484,"y":30.357032775878906},{"x":50.471431732177734,"y":30.356571197509766},{"x":50.47099685668945,"y":30.356395721435547},{"x":50.470558166503906,"y":30.356243133544922}]},{"points":[{"x":50.47056579589844,"y":30.35614776611328},{"x":50.470558166503906,"y":30.356243133544922},{"x":50.46950912475586,"y":30.355934143066406},{"x":50.46883773803711,"y":30.355772018432617},{"x":50.46847915649414,"y":30.35569190979004},{"x":50.46847915649414,"y":30.35569190979004},{"x":50.46772003173828,"y":30.355546951293945},{"x":50.467254638671875,"y":30.355487823486328},{"x":50.46670150756836,"y":30.35543441772461},{"x":50.46622085571289,"y":30.35541343688965},{"x":50.46579360961914,"y":30.35540199279785}]}],"reverseStations":[{"city_id":0,"location":{"x":50.46602249145508,"y":30.355770111083984,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ст. м. Академгородок"},{"lang_id":"c_en","value":" Akademmistechko"},{"lang_id":"c_uk","value":" ст. м. Академмістечко"}]},{"city_id":0,"location":{"x":50.47116470336914,"y":30.356840133666992,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Нефтяник"},{"lang_id":"c_en","value":" Neftyanyk"},{"lang_id":"c_uk","value":" Нефтяник"}]},{"city_id":0,"location":{"x":50.4736251831055,"y":30.3577461242676,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Генерала Наумова"},{"lang_id":"c_en","value":" Henerala Naumova St"},{"lang_id":"c_uk","value":" вул. Генерала Наумова"}]},{"city_id":0,"location":{"x":50.4994468688965,"y":30.3651714324951,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Лесорассадник"},{"lang_id":"c_en","value":" Lisorozsadnyk"},{"lang_id":"c_uk","value":" Лісорозсадник"}]},{"city_id":0,"location":{"x":50.5162506103516,"y":30.3619117736816,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" дорога на Гостомель"},{"lang_id":"c_en","value":" doroha na Hostomel"},{"lang_id":"c_uk","value":" дорога на Гостомель"}]},{"city_id":0,"location":{"x":50.5262756347656,"y":30.3666229248047,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" ул. Городская"},{"lang_id":"c_en","value":" Horodska St"},{"lang_id":"c_uk","value":" вул. Городська"}]},{"city_id":0,"location":{"x":50.5425910949707,"y":30.35675048828125,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Радиологический центр"},{"lang_id":"c_en","value":" Radiolohochnyi tsentr"},{"lang_id":"c_uk","value":" Радіологічний центр"}]},{"city_id":0,"location":{"x":50.549495697021484,"y":30.359773635864258,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" санаторий Лесная поляна"},{"lang_id":"c_en","value":" sanatoriy Lisna polyana"},{"lang_id":"c_uk","value":" санаторій Лісна поляна"}]},{"city_id":0,"location":{"x":50.542930603027344,"y":30.357059478759766,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Радиологический центр"},{"lang_id":"c_en","value":" Radiolohochnyi tsentr"},{"lang_id":"c_uk","value":" Радіологічний центр"}]},{"city_id":0,"location":{"x":50.54120635986328,"y":30.353557586669922,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" 7-ая линия"},{"lang_id":"c_en","value":" Soma liniya"},{"lang_id":"c_uk","value":" 7-ма лінія"}]},{"city_id":0,"location":{"x":50.543830871582,"y":30.3500328063965,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Детский сад"},{"lang_id":"c_en","value":" Dytyachyi sadok"},{"lang_id":"c_uk","value":" Дитячий садок"}]},{"city_id":0,"location":{"x":50.5529899597168,"y":30.335693359375,"z":0.0,"m":0.0,"dimension":2,"haveMeasure":false,"type":1,"srid":0},"name_key":0,"names":[{"lang_id":"c_ru","value":" Пуща-Водица"},{"lang_id":"c_en","value":" Pushya-Vodytsya"},{"lang_id":"c_uk","value":" Пуща-Водиця"}]}],"reverseRelations":[{"points":[{"x":50.46602249145508,"y":30.355770111083984},{"x":50.46599197387695,"y":30.355606079101562},{"x":50.46644973754883,"y":30.35561752319336},{"x":50.46678924560547,"y":30.35561752319336},{"x":50.46761703491211,"y":30.355724334716797},{"x":50.468223571777344,"y":30.355810165405273},{"x":50.468223571777344,"y":30.355810165405273},{"x":50.46882247924805,"y":30.355937957763672},{"x":50.469608306884766,"y":30.35613250732422},{"x":50.47011184692383,"y":30.356292724609375},{"x":50.47117614746094,"y":30.356678009033203}]},{"points":[{"x":50.47116470336914,"y":30.356840133666992},{"x":50.47117614746094,"y":30.356678009033203},{"x":50.47193145751953,"y":30.356979370117188},{"x":50.47308349609375,"y":30.357446670532227},{"x":50.473636627197266,"y":30.357677459716797}]},{"points":[{"x":50.4736251831055,"y":30.3577461242676},{"x":50.473636627197266,"y":30.357677459716797},{"x":50.47404479980469,"y":30.35782241821289},{"x":50.47446823120117,"y":30.35797119140625},{"x":50.47553634643555,"y":30.35840606689453},{"x":50.476661682128906,"y":30.35887908935547},{"x":50.476890563964844,"y":30.358985900878906},{"x":50.477291107177734,"y":30.359149932861328},{"x":50.4775505065918,"y":30.359254837036133},{"x":50.47797775268555,"y":30.359468460083008},{"x":50.47822570800781,"y":30.35959815979004},{"x":50.47888946533203,"y":30.359994888305664},{"x":50.4792366027832,"y":30.36020851135254},{"x":50.47987365722656,"y":30.360519409179688},{"x":50.48112487792969,"y":30.361047744750977},{"x":50.482566833496094,"y":30.361671447753906},{"x":50.48402404785156,"y":30.362287521362305},{"x":50.485374450683594,"y":30.362876892089844},{"x":50.48655700683594,"y":30.363391876220703},{"x":50.48786926269531,"y":30.363956451416016},{"x":50.48902130126953,"y":30.364465713500977},{"x":50.49021911621094,"y":30.364959716796875},{"x":50.491268157958984,"y":30.365365982055664},{"x":50.49191665649414,"y":30.365543365478516},{"x":50.49287796020508,"y":30.365720748901367},{"x":50.4931526184082,"y":30.365768432617188},{"x":50.49419021606445,"y":30.365812301635742},{"x":50.494659423828125,"y":30.36579132080078},{"x":50.495452880859375,"y":30.365673065185547},{"x":50.496131896972656,"y":30.365501403808594},{"x":50.49638748168945,"y":30.365447998046875},{"x":50.49702835083008,"y":30.36537742614746},{"x":50.498165130615234,"y":30.365253448486328},{"x":50.49944305419922,"y":30.365108489990234}]},{"points":[{"x":50.4994468688965,"y":30.3651714324951},{"x":50.49944305419922,"y":30.365108489990234},{"x":50.50020980834961,"y":30.365028381347656},{"x":50.50156021118164,"y":30.364770889282227},{"x":50.50290298461914,"y":30.364524841308594},{"x":50.50384521484375,"y":30.36433219909668},{"x":50.504638671875,"y":30.364187240600586},{"x":50.50568389892578,"y":30.363988876342773},{"x":50.50697326660156,"y":30.363725662231445},{"x":50.50848388671875,"y":30.36343002319336},{"x":50.50965118408203,"y":30.36319351196289},{"x":50.511112213134766,"y":30.362899780273438},{"x":50.51255798339844,"y":30.36260414123535},{"x":50.51438903808594,"y":30.36224937438965},{"x":50.51544189453125,"y":30.362035751342773},{"x":50.51566696166992,"y":30.361989974975586},{"x":50.51576232910156,"y":30.361957550048828},{"x":50.516143798828125,"y":30.36187171936035},{"x":50.51625061035156,"y":30.36185073852539}]},{"points":[{"x":50.5162506103516,"y":30.3619117736816},{"x":50.51625061035156,"y":30.36185073852539},{"x":50.51671600341797,"y":30.36180305480957},{"x":50.5173454284668,"y":30.361785888671875},{"x":50.51823806762695,"y":30.36180305480957},{"x":50.51959228515625,"y":30.361812591552734},{"x":50.52055358886719,"y":30.36182403564453},{"x":50.522029876708984,"y":30.361839294433594},{"x":50.52288055419922,"y":30.361845016479492},{"x":50.523193359375,"y":30.361865997314453},{"x":50.52348709106445,"y":30.361974716186523},{"x":50.52381134033203,"y":30.362215042114258},{"x":50.524112701416016,"y":30.362611770629883},{"x":50.524436950683594,"y":30.36311149597168},{"x":50.52507781982422,"y":30.36431884765625},{"x":50.52587890625,"y":30.365787506103516},{"x":50.52629470825195,"y":30.366561889648438}]},{"points":[{"x":50.5262756347656,"y":30.3666229248047},{"x":50.52629470825195,"y":30.366561889648438},{"x":50.526344299316406,"y":30.366729736328125},{"x":50.52643966674805,"y":30.366960525512695},{"x":50.52680587768555,"y":30.3676700592041},{"x":50.52737045288086,"y":30.368711471557617},{"x":50.52858352661133,"y":30.367074966430664},{"x":50.528968811035156,"y":30.366554260253906},{"x":50.52980422973633,"y":30.36546516418457},{"x":50.53054428100586,"y":30.364473342895508},{"x":50.531455993652344,"y":30.36321258544922},{"x":50.532100677490234,"y":30.36233901977539},{"x":50.53268814086914,"y":30.361513137817383},{"x":50.53365707397461,"y":30.360214233398438},{"x":50.53409194946289,"y":30.359601974487305},{"x":50.5348014831543,"y":30.358654022216797},{"x":50.535186767578125,"y":30.35812759399414},{"x":50.53528594970703,"y":30.358142852783203},{"x":50.535423278808594,"y":30.358036041259766},{"x":50.53584671020508,"y":30.35745620727539},{"x":50.536617279052734,"y":30.35641098022461},{"x":50.536869049072266,"y":30.3560791015625},{"x":50.53694534301758,"y":30.356035232543945},{"x":50.53712463378906,"y":30.35590171813965},{"x":50.53738784790039,"y":30.355594635009766},{"x":50.53852081298828,"y":30.35407257080078},{"x":50.539371490478516,"y":30.352962493896484},{"x":50.539955139160156,"y":30.352161407470703},{"x":50.54009246826172,"y":30.35196304321289},{"x":50.5406608581543,"y":30.353015899658203},{"x":50.541015625,"y":30.353679656982422},{"x":50.54138946533203,"y":30.354366302490234},{"x":50.541969299316406,"y":30.35542869567871},{"x":50.54265213012695,"y":30.3566837310791}]},{"points":[{"x":50.5425910949707,"y":30.35675048828125},{"x":50.54265213012695,"y":30.3566837310791},{"x":50.54289627075195,"y":30.357118606567383},{"x":50.54363250732422,"y":30.35848617553711},{"x":50.544429779052734,"y":30.359994888305664},{"x":50.54460906982422,"y":30.36033821105957},{"x":50.544795989990234,"y":30.360504150390625},{"x":50.54553985595703,"y":30.360424041748047},{"x":50.54690933227539,"y":30.36020278930664},{"x":50.54800033569336,"y":30.359989166259766},{"x":50.54949951171875,"y":30.359683990478516}]},{"points":[{"x":50.549495697021484,"y":30.359773635864258},{"x":50.54949951171875,"y":30.359683990478516},{"x":50.54800033569336,"y":30.359989166259766},{"x":50.54690933227539,"y":30.36020278930664},{"x":50.54553985595703,"y":30.360424041748047},{"x":50.544795989990234,"y":30.360504150390625},{"x":50.54460906982422,"y":30.36033821105957},{"x":50.544429779052734,"y":30.359994888305664},{"x":50.54363250732422,"y":30.35848617553711},{"x":50.54289627075195,"y":30.357118606567383}]},{"points":[{"x":50.542930603027344,"y":30.357059478759766},{"x":50.54289627075195,"y":30.357118606567383},{"x":50.54265213012695,"y":30.3566837310791},{"x":50.541969299316406,"y":30.35542869567871},{"x":50.54138946533203,"y":30.354366302490234},{"x":50.541015625,"y":30.353679656982422},{"x":50.54117965698242,"y":30.35350799560547}]},{"points":[{"x":50.54120635986328,"y":30.353557586669922},{"x":50.54117965698242,"y":30.35350799560547},{"x":50.54261016845703,"y":30.351566314697266},{"x":50.54379653930664,"y":30.349985122680664}]},{"points":[{"x":50.543830871582,"y":30.3500328063965},{"x":50.54379653930664,"y":30.349985122680664},{"x":50.544193267822266,"y":30.349485397338867},{"x":50.54548263549805,"y":30.3477840423584},{"x":50.546207427978516,"y":30.346813201904297},{"x":50.54733657836914,"y":30.345279693603516},{"x":50.548274993896484,"y":30.34398651123047},{"x":50.54889678955078,"y":30.343172073364258},{"x":50.54935836791992,"y":30.34257698059082},{"x":50.550514221191406,"y":30.3410587310791},{"x":50.551170349121094,"y":30.340194702148438},{"x":50.55206298828125,"y":30.33897590637207},{"x":50.55293655395508,"y":30.337919235229492},{"x":50.553199768066406,"y":30.337539672851562},{"x":50.55361557006836,"y":30.33692741394043},{"x":50.5529899597168,"y":30.335693359375}]}]}
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY languages (id, name) FROM stdin;
c_en	English
c_ru	Русский
c_uk	Українська
\.


--
-- Data for Name: route_relations; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY route_relations (id, direct_route_id, station_a_id, station_b_id, position_index, distance, ev_time, geom) FROM stdin;
1	1	\N	\N	0	0	00:00:00	\N
2	2	\N	\N	0	0	00:00:00	\N
3	3	\N	1	0	0	00:00:00	\N
4	3	1	2	1	964.697903796407331	00:01:17.175832	0102000020E6100000040000007EB33F293F034940000000DC042B42400CA2E1FB430249400500002C3D2A42400CA2E1FB430249400500002C3D2A42400CA2E1FB430249400500002C3D2A4240
5	3	2	3	2	1562.80202721257888	00:02:05.024162	0102000020E6100000040000000CA2E1FB430249400500002C3D2A42400FD0045427014940010000CCAD2842400FD0045427014940010000CCAD2842400FD0045427014940010000CCAD284240
6	3	3	4	3	1642.10690547141644	00:02:11.368552	0102000020E6100000040000000FD0045427014940010000CCAD2842401B20A8964B00494002000072EB2642401B20A8964B00494002000072EB2642401B20A8964B00494002000072EB264240
7	3	4	5	4	3786.9768150445384	00:05:02.958145	0102000020E6100000040000001B20A8964B00494002000072EB2642402816A34023004940050000F08F2242402816A34023004940050000F08F2242402816A34023004940050000F08F224240
8	3	5	6	5	2502.97608581568602	00:03:20.238087	0102000020E6100000040000002816A34023004940050000F08F22424043976CBC7C004940020000E0B11F424043976CBC7C004940020000E0B11F424043976CBC7C004940020000E0B11F4240
9	3	6	7	6	1547.899970322336	00:02:03.831998	0102000020E61000000400000043976CBC7C004940020000E0B11F4240E2C2EBD99700494003000040EA1D4240E2C2EBD99700494003000040EA1D4240E2C2EBD99700494003000040EA1D4240
10	3	7	8	7	1084.24161958873697	00:01:26.73933	0102000020E610000004000000E2C2EBD99700494003000040EA1D424010D40F0819FF4840FAFFFF2B981D424010D40F0819FF4840FAFFFF2B981D424010D40F0819FF4840FAFFFF2B981D4240
11	4	\N	8	0	0	00:00:00	\N
12	4	8	7	1	1084.24161958872423	00:01:26.73933	0102000020E61000000400000010D40F0819FF4840FAFFFF2B981D4240E2C2EBD99700494003000040EA1D4240E2C2EBD99700494003000040EA1D4240E2C2EBD99700494003000040EA1D4240
13	4	7	6	2	1547.89997032247766	00:02:03.831998	0102000020E610000004000000E2C2EBD99700494003000040EA1D424043976CBC7C004940020000E0B11F424043976CBC7C004940020000E0B11F424043976CBC7C004940020000E0B11F4240
14	4	6	5	3	2502.9760858154641	00:03:20.238087	0102000020E61000000400000043976CBC7C004940020000E0B11F42402816A34023004940050000F08F2242402816A34023004940050000F08F2242402816A34023004940050000F08F224240
15	4	5	4	4	3786.97681504448519	00:05:02.958145	0102000020E6100000040000002816A34023004940050000F08F2242401B20A8964B00494002000072EB2642401B20A8964B00494002000072EB2642401B20A8964B00494002000072EB264240
16	4	4	3	5	1642.10690547099739	00:02:11.368552	0102000020E6100000040000001B20A8964B00494002000072EB2642400FD0045427014940010000CCAD2842400FD0045427014940010000CCAD2842400FD0045427014940010000CCAD284240
17	4	3	2	6	1562.80202721251658	00:02:05.024162	0102000020E6100000040000000FD0045427014940010000CCAD2842400CA2E1FB430249400500002C3D2A42400CA2E1FB430249400500002C3D2A42400CA2E1FB430249400500002C3D2A4240
18	4	2	1	7	964.697903796676542	00:01:17.175832	0102000020E6100000040000000CA2E1FB430249400500002C3D2A42407EB33F293F034940000000DC042B42407EB33F293F034940000000DC042B42407EB33F293F034940000000DC042B4240
19	5	\N	9	0	0	00:00:00	\N
20	5	9	10	1	854.40639771077042	00:01:09.905978	0102000020E6100000040000008765A2D18B04494006000070251C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240
21	5	10	11	2	1293.55106316396541	00:01:45.835996	0102000020E610000004000000F11BF98E6C034940FBFFFFDF871C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C4240
22	5	11	12	3	927.769131150337103	00:01:15.908383	0102000020E6100000040000007F0551FAA6014940FAFFFFBFF21C4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240
23	5	12	13	4	1137.26704917355619	00:01:33.049122	0102000020E610000004000000B370F7149F004940FEFFFF4F9E1D424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E4240
24	5	13	14	5	2868.96378180913143	00:03:54.7334	0102000020E61000000400000033F23344E1FF4840FCFFFF6FC81E4240E45F93B48EFE4840FEFFFF97E8214240E45F93B48EFE4840FEFFFF97E8214240E45F93B48EFE4840FEFFFF97E8214240
25	5	14	15	6	906.512662272981061	00:01:14.169218	0102000020E610000004000000E45F93B48EFE4840FEFFFF97E821424054E913D64EFD4840FEFFFFFBA221424054E913D64EFD4840FEFFFFFBA221424054E913D64EFD4840FEFFFFFBA2214240
26	6	\N	15	0	0	00:00:00	\N
27	6	15	14	1	906.512662273003002	00:01:14.169218	0102000020E61000000400000054E913D64EFD4840FEFFFFFBA2214240E45F93B48EFE4840FEFFFF97E8214240E45F93B48EFE4840FEFFFF97E8214240E45F93B48EFE4840FEFFFF97E8214240
28	6	14	13	2	2868.96378180915917	00:03:54.7334	0102000020E610000004000000E45F93B48EFE4840FEFFFF97E821424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E4240
29	6	13	12	3	1137.26704917324469	00:01:33.049122	0102000020E61000000400000033F23344E1FF4840FCFFFF6FC81E4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240
30	6	12	11	4	927.769131150104045	00:01:15.908383	0102000020E610000004000000B370F7149F004940FEFFFF4F9E1D42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C4240
31	6	11	10	5	1293.5510631640243	00:01:45.835996	0102000020E6100000040000007F0551FAA6014940FAFFFFBFF21C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240
32	6	10	9	6	854.406397710846591	00:01:09.905978	0102000020E610000004000000F11BF98E6C034940FBFFFFDF871C42408765A2D18B04494006000070251C42408765A2D18B04494006000070251C42408765A2D18B04494006000070251C4240
33	7	\N	16	0	0	00:00:00	\N
34	7	16	17	1	2700.54788689421957	00:03:40.953918	0102000020E610000004000000EE1ACCEEBCFD4840FAFFFF7740174240B939B2B4AFFE4840FAFFFFCB431A4240B939B2B4AFFE4840FAFFFFCB431A4240B939B2B4AFFE4840FAFFFFCB431A4240
35	7	17	18	2	1600.89223124044634	00:02:10.982092	0102000020E610000004000000B939B2B4AFFE4840FAFFFFCB431A4240D65C270F14FF484001000090141C4240D65C270F14FF484001000090141C4240D65C270F14FF484001000090141C4240
36	7	18	19	3	1501.34846177088752	00:02:02.837601	0102000020E610000004000000D65C270F14FF484001000090141C42406B1168B4F1FE4840FEFFFF1FCE1D42406B1168B4F1FE4840FEFFFF1FCE1D42406B1168B4F1FE4840FEFFFF1FCE1D4240
37	7	19	20	4	1511.48191785973813	00:02:03.666702	0102000020E6100000040000006B1168B4F1FE4840FEFFFF1FCE1D4240943444717FFD4840FEFFFF97181F4240943444717FFD4840FEFFFF97181F4240943444717FFD4840FEFFFF97181F4240
38	7	20	21	5	1987.13961139174739	00:02:42.58415	0102000020E610000004000000943444717FFD4840FEFFFF97181F4240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240
39	7	21	22	6	2262.62757091444109	00:03:05.124074	0102000020E610000004000000912644E35EFD4840FBFFFF97612142406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F5234240
40	7	22	23	7	2310.4008153231066	00:03:09.032794	0102000020E6100000040000006464C05BEBFC4840FFFFFFD3F52342402EF3E35B70FC4840F9FFFF6B972642402EF3E35B70FC4840F9FFFF6B972642402EF3E35B70FC4840F9FFFF6B97264240
41	7	23	24	8	2258.5990462284467	00:03:04.794467	0102000020E6100000040000002EF3E35B70FC4840F9FFFF6B97264240089446E4ADFB48400600004C1E294240089446E4ADFB48400600004C1E294240089446E4ADFB48400600004C1E294240
42	7	24	25	9	2441.71351381456952	00:03:19.77656	0102000020E610000004000000089446E4ADFB48400600004C1E294240597D9B0F1EFB484002000074E42B4240597D9B0F1EFB484002000074E42B4240597D9B0F1EFB484002000074E42B4240
43	7	25	26	10	1930.65255454697035	00:02:37.962482	0102000020E610000004000000597D9B0F1EFB484002000074E42B42407924E5EAAFFA484000000070162E42407924E5EAAFFA484000000070162E42407924E5EAAFFA484000000070162E4240
44	7	26	27	11	2138.17029511797773	00:02:54.941206	0102000020E6100000040000007924E5EAAFFA484000000070162E4240B9B61CE2EFF94840FEFFFF4379304240B9B61CE2EFF94840FEFFFF4379304240B9B61CE2EFF94840FEFFFF4379304240
45	7	27	28	12	2320.00312697125355	00:03:09.818438	0102000020E610000004000000B9B61CE2EFF94840FEFFFF43793042408B13F6862BF94840FDFFFF6B123342408B13F6862BF94840FDFFFF6B123342408B13F6862BF94840FDFFFF6B12334240
46	8	\N	28	0	0	00:00:00	\N
47	8	28	27	1	2320.00312697108302	00:03:09.818438	0102000020E6100000040000008B13F6862BF94840FDFFFF6B12334240B9B61CE2EFF94840FEFFFF4379304240B9B61CE2EFF94840FEFFFF4379304240B9B61CE2EFF94840FEFFFF4379304240
48	8	27	26	2	2138.17029511778037	00:02:54.941206	0102000020E610000004000000B9B61CE2EFF94840FEFFFF43793042407924E5EAAFFA484000000070162E42407924E5EAAFFA484000000070162E42407924E5EAAFFA484000000070162E4240
49	8	26	25	3	1930.65255454715066	00:02:37.962482	0102000020E6100000040000007924E5EAAFFA484000000070162E4240597D9B0F1EFB484002000074E42B4240597D9B0F1EFB484002000074E42B4240597D9B0F1EFB484002000074E42B4240
50	8	25	24	4	2441.71351381437444	00:03:19.77656	0102000020E610000004000000597D9B0F1EFB484002000074E42B4240089446E4ADFB48400600004C1E294240089446E4ADFB48400600004C1E294240089446E4ADFB48400600004C1E294240
51	8	24	23	5	2258.59904622827935	00:03:04.794467	0102000020E610000004000000089446E4ADFB48400600004C1E2942402EF3E35B70FC4840F9FFFF6B972642402EF3E35B70FC4840F9FFFF6B972642402EF3E35B70FC4840F9FFFF6B97264240
52	8	23	22	6	2310.4008153231207	00:03:09.032794	0102000020E6100000040000002EF3E35B70FC4840F9FFFF6B972642406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F5234240
53	8	22	21	7	2262.62757091442154	00:03:05.124074	0102000020E6100000040000006464C05BEBFC4840FFFFFFD3F5234240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240
54	8	21	20	8	1987.13961139161643	00:02:42.58415	0102000020E610000004000000912644E35EFD4840FBFFFF9761214240943444717FFD4840FEFFFF97181F4240943444717FFD4840FEFFFF97181F4240943444717FFD4840FEFFFF97181F4240
55	8	20	19	9	1511.48191785965287	00:02:03.666702	0102000020E610000004000000943444717FFD4840FEFFFF97181F42406B1168B4F1FE4840FEFFFF1FCE1D42406B1168B4F1FE4840FEFFFF1FCE1D42406B1168B4F1FE4840FEFFFF1FCE1D4240
56	8	19	18	10	1501.34846177101963	00:02:02.837601	0102000020E6100000040000006B1168B4F1FE4840FEFFFF1FCE1D4240D65C270F14FF484001000090141C4240D65C270F14FF484001000090141C4240D65C270F14FF484001000090141C4240
57	8	18	17	11	1600.89223124072032	00:02:10.982092	0102000020E610000004000000D65C270F14FF484001000090141C4240B939B2B4AFFE4840FAFFFFCB431A4240B939B2B4AFFE4840FAFFFFCB431A4240B939B2B4AFFE4840FAFFFFCB431A4240
58	8	17	16	12	2700.54788689444467	00:03:40.953918	0102000020E610000004000000B939B2B4AFFE4840FAFFFFCB431A4240EE1ACCEEBCFD4840FAFFFF7740174240EE1ACCEEBCFD4840FAFFFF7740174240EE1ACCEEBCFD4840FAFFFF7740174240
59	9	\N	10	0	0	00:00:00	\N
60	9	10	11	1	1293.55106316396541	00:01:33.135677	0102000020E610000004000000F11BF98E6C034940FBFFFFDF871C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C4240
61	9	11	12	2	927.769131150337103	00:01:06.799377	0102000020E6100000040000007F0551FAA6014940FAFFFFBFF21C4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240
62	9	12	13	3	1137.26704917355619	00:01:21.883228	0102000020E610000004000000B370F7149F004940FEFFFF4F9E1D424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E4240
63	9	13	21	4	2860.93742095668267	00:03:25.987494	0102000020E61000000400000033F23344E1FF4840FCFFFF6FC81E4240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240
64	9	21	22	5	2262.62757091444109	00:02:42.909185	0102000020E610000004000000912644E35EFD4840FBFFFF97612142406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F52342406464C05BEBFC4840FFFFFFD3F5234240
65	10	\N	22	0	0	00:00:00	\N
66	10	22	21	1	2262.62757091442154	00:02:42.909185	0102000020E6100000040000006464C05BEBFC4840FFFFFFD3F5234240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240912644E35EFD4840FBFFFF9761214240
67	10	21	13	2	2860.93742095662856	00:03:25.987494	0102000020E610000004000000912644E35EFD4840FBFFFF976121424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E424033F23344E1FF4840FCFFFF6FC81E4240
68	10	13	12	3	1137.26704917324469	00:01:21.883228	0102000020E61000000400000033F23344E1FF4840FCFFFF6FC81E4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240B370F7149F004940FEFFFF4F9E1D4240
69	10	12	11	4	927.769131150104045	00:01:06.799377	0102000020E610000004000000B370F7149F004940FEFFFF4F9E1D42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C42407F0551FAA6014940FAFFFFBFF21C4240
70	10	11	10	5	1293.5510631640243	00:01:33.135677	0102000020E6100000040000007F0551FAA6014940FAFFFFBFF21C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240F11BF98E6C034940FBFFFFDF871C4240
460	41	\N	184	0	0	00:00:00	\N
461	41	184	185	1	1374.67409733489922	00:01:38.976535	0102000020E610000012000000000000006C34494000000080F4843E40000000006B34494000000020EF843E40000000E06E344940000000C0E6843E40000000A07134494000000000DE843E40000000207434494000000060C5843E40000000E070344940000000A0B0843E40000000407334494000000060AB843E4000000060A13449400000000058843E40000000E0CD344940000000E007843E4000000080DB344940000000A0EF833E4000000000F3344940000000E061843E4000000020F7344940000000A071843E4000000040FF344940000000C09A843E40000000600B3549400000000084843E4000000000143549400000006072843E40000000203B3549400000002020843E40000000806435494000000040C9833E40000000806A354940000000A0BC833E40
462	41	185	186	2	285.173037305905495	00:00:20.532459	0102000020E610000005000000040000606B354940000000E0C0833E40000000806A354940000000A0BC833E400000004076354940000000C0A4833E40000000A087354940000000A0FC833E40000000208F354940000000E021843E40
463	41	186	187	3	961.838542334805311	00:01:09.252375	0102000020E61000000C000000FDFFFFBF8D3549400000006024843E40000000208F354940000000E021843E40000000208F354940000000E021843E4000000040933549400000004035843E40000000009A354940000000E055843E4000000020B9354940000000E02D843E4000000060DB3549400000008001843E4000000080FA354940000000E0DA833E40000000C00C3649400000006052843E40000000C0113649400000002059843E40000000202836494000000000E5843E400000008032364940000000A0D8843E40
464	41	187	188	4	244.475067244410297	00:00:17.602205	0102000020E610000005000000FAFFFFBF3236494000000080DC843E400000008032364940000000A0D8843E40000000005236494000000000B1843E40000000A06B3649400000004090843E400000002074364940000000C085843E40
465	41	188	189	5	353.828169775532501	00:00:25.475628	0102000020E610000008000000010000C074364940000000408A843E400000002074364940000000C085843E4000000080903649400000008062843E4000000020AA364940000000A043843E40000000C0C33649400000000024843E4000000020CA364940000000401D843E4000000060CE364940000000E01A843E4000000000D7364940000000801A843E40
466	41	189	190	6	310.18485920522653	00:00:22.33331	0102000020E610000006000000FFFFFFDFD6364940000000601F843E4000000000D7364940000000801A843E4000000080F43649400000002019843E4000000080073749400000000018843E4000000000233749400000000018843E40000000403E3749400000006018843E40
467	41	190	191	7	326.165696849997232	00:00:23.48393	0102000020E610000006000000FEFFFF1F3E374940000000001D843E40000000403E3749400000006018843E40000000A04B3749400000006018843E40000000A0643749400000000018843E40000000808B3749400000006017843E4000000020AB3749400000004016843E40
468	41	191	192	8	169.889749253328773	00:00:12.232062	0102000020E61000000700000004000000AB374940000000401B843E4000000020AB3749400000004016843E4000000020C4374940000000E015843E4000000080C7374940000000A016843E4000000020CC374940000000C019843E4000000000CC3749400000008000843E4000000000CC37494000000020F4833E40
469	41	192	193	9	863.23840795363185	00:01:02.153165	0102000020E610000007000000FDFFFFBFCD37494000000020F4833E4000000000CC37494000000020F4833E4000000020CC374940000000C077833E40000000A0CC37494000000080FA823E4000000000CD3749400000008071823E40000000C0CD3749400000000062823E40000000E0D537494000000060FB813E40
470	41	193	194	10	676.056497122263409	00:00:48.676068	0102000020E610000008000000040000C0D737494000000060FD813E40000000E0D537494000000060FB813E40000000E0DC374940000000C0A8813E4000000040E0374940000000C083813E40000000A0E33749400000006075813E4000000020033849400000000020813E40000000802E38494000000040AB803E400000004034384940000000C09B803E40
471	41	194	195	11	422.063428878946183	00:00:30.388567	0102000020E610000005000000FDFFFF5F35384940000000A09F803E400000004034384940000000C09B803E40000000205E384940000000402B803E40000000407738494000000020E87F3E40000000A08238494000000040D07F3E40
472	41	195	196	12	1201.74813300248661	00:01:26.525866	0102000020E610000011000000040000608338494000000060D47F3E40000000A08238494000000040D07F3E4000000020A0384940000000A0917F3E40000000C0C438494000000040447F3E40000000A0CB384940000000E0357F3E4000000000B8384940000000A0DD7E3E4000000020AF384940000000E0B47E3E4000000060A238494000000060777E3E40000000E08D384940000000A0167E3E40000000808338494000000080E67D3E400000008080384940000000A0AE7D3E40000000A07E384940000000C08B7D3E40000000A07C384940000000407A7D3E40000000807A384940000000006F7D3E40000000C077384940000000806C7D3E400000008074384940000000E06C7D3E40000000C06F384940000000E0797D3E40
473	42	\N	197	0	0	00:00:00	\N
538	45	261	262	18	896.723231667889422	00:01:04.564073	0102000020E610000006000000FCFFFF3F583A494000000000E76F3E4000000080593A494000000000E86F3E40000000404F3A4940000000A067703E4000000020453A4940000000E0E5703E40000000603A3A4940000000E06B713E40000000802F3A494000000020F1713E40
474	42	197	198	1	669.956285790616221	00:00:48.236853	0102000020E61000000E000000FFFFFF3F6F384940000000A0777D3E40000000C06F384940000000E0797D3E40000000406B38494000000020867D3E40000000C06738494000000080907D3E400000000067384940000000A0997D3E40000000006738494000000080A37D3E40000000406E384940000000C0B57D3E40000000007D38494000000040D87D3E40000000808338494000000080E67D3E40000000E08D384940000000A0167E3E4000000060A238494000000060777E3E4000000020AF384940000000E0B47E3E4000000080A8384940000000C0C37E3E40000000C09E384940000000C0D67E3E40
475	42	198	199	2	429.917923535123862	00:00:30.95409	0102000020E610000007000000070000009E384940F9FFFF5FD27E3E40000000C09E384940000000C0D67E3E40000000A080384940000000C0157F3E400000002067384940000000204A7F3E40000000205B384940000000A0637F3E400000004055384940000000C0727F3E40000000C045384940000000609A7F3E40
476	42	199	200	3	377.574851138108556	00:00:27.185389	0102000020E6100000050000000500008044384940F4FFFFDF957F3E40000000C045384940000000609A7F3E400000004029384940000000A0E57F3E40000000400D384940000000C02E803E4000000060003849400000002050803E40
477	42	200	201	4	405.854830523182329	00:00:29.221548	0102000020E610000005000000FAFFFF1FFF3749400D0000E04A803E4000000060003849400000002050803E4000000000DD374940000000A0AC803E4000000000BD37494000000080FE803E4000000060B5374940000000A012813E40
478	42	201	202	5	1125.48407696849199	00:01:21.034854	0102000020E61000000C000000FCFFFF3FB4374940080000C00E813E4000000060B5374940000000A012813E4000000060A6374940000000003A813E4000000060A43749400000000042813E40000000609F3749400000004078813E400000004091374940000000C01D823E400000002090374940000000A02D823E40000000008F374940000000603D823E40000000E08D37494000000000B5823E40000000608C374940000000C05E833E40000000608C3749400000004076833E400000006077374940000000E074833E40
479	42	202	203	6	365.564153191036382	00:00:26.320619	0102000020E61000000700000004000060773749400000006070833E400000006077374940000000E074833E400000006063374940000000C072833E40000000204C3749400000002073833E40000000402A3749400000008072833E40000000C006374940000000A070833E4000000000FD3649400000006070833E40
480	42	203	204	7	236.549147412148614	00:00:17.031539	0102000020E610000007000000FDFFFF5FFD364940FAFFFFBF6A833E4000000000FD3649400000006070833E40000000A0E6364940000000406F833E4000000020D93649400000006071833E4000000080C8364940000000A075833E4000000000C43649400000002078833E4000000060B3364940000000C08B833E40
481	42	204	205	8	380.194880484634609	00:00:27.374031	0102000020E610000006000000FAFFFFBFB23649400800002087833E4000000060B3364940000000C08B833E400000000099364940000000C0AC833E40000000207436494000000040DC833E400000002058364940000000C0FE833E40000000C04C364940000000800D843E40
482	42	205	206	9	886.575905940064786	00:01:03.833465	0102000020E61000000C000000050000204C364940F5FFFFFF06843E40000000C04C364940000000800D843E40000000E027364940000000A03C843E40000000C0113649400000002059843E400000002012364940000000604B843E40000000A0073649400000008006843E4000000000FF35494000000020D4833E4000000080FA354940000000E0DA833E4000000060DB3549400000008001843E4000000020B9354940000000E02D843E40000000009A354940000000E055843E4000000040933549400000004035843E40
483	42	206	207	10	345.375061468388935	00:00:24.867004	0102000020E610000007000000FCFFFF3F94354940FAFFFFBF32843E4000000040933549400000004035843E40000000208F354940000000E021843E40000000A087354940000000A0FC833E400000004076354940000000C0A4833E40000000806A354940000000A0BC833E40000000806435494000000040C9833E40
484	42	207	208	11	1178.20981754155946	00:01:24.831107	0102000020E61000000E0000000000008061354940000000E0BC833E40000000806435494000000040C9833E40000000203B3549400000002020843E4000000000143549400000006072843E40000000600B3549400000000084843E400000000007354940000000A083843E40000000E0003549400000002080843E4000000000FC344940000000C079843E4000000020F7344940000000A071843E4000000000F3344940000000E061843E4000000080DB344940000000A0EF833E40000000E0CD344940000000E007843E4000000060A13449400000000058843E40000000407334494000000060AB843E40
520	45	\N	244	0	0	00:00:00	\N
521	45	244	245	1	1134.64669753933435	00:01:21.694562	0102000020E610000017000000FAFFFF1FCB344940000000C0CD683E4000000080CC344940000000A0D1683E4000000080C6344940000000E0E2683E4000000020C434494000000080EE683E4000000080C4344940000000E0F5683E4000000060C634494000000020FB683E4000000020B23449400000000039693E4000000040983449400000008089693E40000000408834494000000000BF693E40000000807834494000000000F3693E400000002071344940000000E00A6A3E40000000406C344940000000E01D6A3E40000000E075344940000000A0326A3E400000008084344940000000C04F6A3E40000000608E34494000000000676A3E40000000E096344940000000807E6A3E40000000C09934494000000040856A3E40000000409D34494000000040866A3E4000000000AB344940000000C0826A3E4000000000B2344940000000A0866A3E4000000000BD344940000000A0A66A3E4000000060C8344940000000E0D16A3E4000000060D1344940000000A0EC6A3E40
522	45	245	246	2	702.012053188890832	00:00:50.544868	0102000020E61000000A000000FCFFFF3FD034494000000020F16A3E4000000060D1344940000000A0EC6A3E40000000E0DC344940000000000E6B3E4000000000E2344940000000A0216B3E4000000020E7344940000000A0406B3E4000000060F8344940000000A0B36B3E40000000C00335494000000060FC6B3E40000000000F35494000000080386C3E40000000200B354940000000A0486C3E40000000E00535494000000020716C3E40
523	45	246	247	3	627.741082201676136	00:00:45.197358	0102000020E6100000070000000000006004354940000000406F6C3E40000000E00535494000000020716C3E40000000C0F834494000000060D66C3E4000000020E9344940000000804C6D3E40000000C0DA34494000000020B96D3E4000000080D734494000000060C46D3E4000000020D734494000000040D66D3E40
524	45	247	248	4	770.88903995651026	00:00:55.504011	0102000020E61000000D000000070000A0D534494000000080DB6D3E4000000020D734494000000040D66D3E40000000E0DA34494000000000DF6D3E40000000C0E0344940000000C0E06D3E4000000020E234494000000000EA6D3E4000000000EC344940000000A0F76D3E400000008011354940000000C02C6E3E40000000C03A35494000000020676E3E40000000E05E354940000000C09A6E3E40000000E08035494000000040CB6E3E40000000209535494000000020E86E3E400000006097354940000000A0EB6E3E40000000609A35494000000040F76E3E40
525	45	248	249	5	627.287650619393162	00:00:45.164711	0102000020E610000007000000FCFFFFFF98354940000000C0FA6E3E40000000609A35494000000040F76E3E40000000A0B335494000000060536F3E40000000E0C7354940000000206E6F3E4000000040EF354940000000809D6F3E40000000A0FC354940000000A0326F3E400000004000364940000000E0176F3E40
526	45	249	250	6	854.542372679696086	00:01:01.527051	0102000020E610000009000000020000E00136494000000060196F3E400000004000364940000000E0176F3E40000000400E364940000000E0AF6E3E40000000001D364940000000E0416E3E40000000802536494000000040046E3E40000000802C36494000000040CA6D3E40000000E03436494000000000906D3E40000000A03D364940000000804E6D3E40000000404C36494000000080606D3E40
527	45	250	251	7	626.487942380154777	00:00:45.107132	0102000020E610000008000000FBFFFF7F4B36494000000020666D3E40000000404C36494000000080606D3E40000000807A364940000000009D6D3E40000000809B36494000000080C76D3E4000000060C3364940000000E0FB6D3E4000000040CE364940000000A0096E3E4000000020DF364940000000C01F6E3E40000000E0E4364940000000C0F26D3E40
528	45	251	252	8	580.19075044534236	00:00:41.773734	0102000020E61000000900000003000040E636494000000040F56D3E40000000E0E4364940000000C0F26D3E40000000C0F7364940000000A0626D3E4000000080FF36494000000080276D3E40000000000537494000000080006D3E400000004008374940000000C0EA6C3E40000000200D374940000000C0D06C3E40000000A00F37494000000040C76C3E400000004016374940000000C0AB6C3E40
529	45	252	253	9	1543.11424954106246	00:01:51.104226	0102000020E6100000120000000400006017374940000000A0AF6C3E400000004016374940000000C0AB6C3E40000000801A374940000000A09B6C3E400000006021374940000000C0856C3E40000000A02C37494000000040676C3E40000000C03637494000000060506C3E400000000043374940000000403B6C3E40000000404E374940000000C0296C3E40000000004537494000000060DD6B3E40000000E038374940000000C0776B3E40000000C02B374940000000E00A6B3E40000000401C37494000000020896A3E400000000011374940000000E0296A3E40000000601E37494000000000196A3E40000000C03037494000000020036A3E40000000404C374940000000C0E1693E40000000206A374940000000C0BA693E40000000207837494000000040AA693E40
530	45	253	254	10	507.621642040808581	00:00:36.548758	0102000020E61000000E000000FCFFFF9F7837494000000080AF693E40000000207837494000000040AA693E40000000C07F37494000000060A0693E400000004087374940000000809C693E40000000808F3749400000008095693E400000006097374940000000408B693E40000000009F374940000000A07E693E4000000060A63749400000000073693E40000000E0BB3749400000004058693E40000000A0CB374940000000A044693E4000000080D3374940000000003A693E4000000060F03749400000008016693E40000000A0FC3749400000002007693E40000000C002384940000000E001693E40
531	45	254	255	11	161.144093610205346	00:00:11.602375	0102000020E610000005000000FBFFFF7F033849400000008008693E40000000C002384940000000E001693E40000000600A38494000000060F8683E40000000800F38494000000020EE683E4000000060163849400000006027693E40
532	45	255	256	12	949.238733225453416	00:01:08.345189	0102000020E610000008000000060000E0143849400000002029693E4000000060163849400000006027693E40000000E0243849400000000099693E40000000C02D38494000000060E0693E40000000403C384940000000E0516A3E40000000C04E384940000000C0E36A3E400000004068384940000000C0C36A3E40000000207E384940000000A0A76A3E40
533	45	256	257	13	1223.59076219769486	00:01:28.098535	0102000020E61000000B000000FFFFFFDF7E38494000000040AC6A3E40000000207E384940000000A0A76A3E400000008090384940000000E0906A3E4000000080A9384940000000A0726A3E4000000020D3384940000000C0416A3E40000000E0F2384940000000C01B6A3E4000000040F9384940000000C0146A3E40000000000439494000000000686A3E40000000A01A39494000000060156B3E40000000802D394940000000E0A66B3E400000002033394940000000E0D36B3E40
534	45	257	258	14	598.081076674503493	00:00:43.061838	0102000020E61000000B000000FDFFFFBF3139494000000060D56B3E400000002033394940000000E0D36B3E40000000603639494000000060F66B3E40000000203939494000000080196C3E40000000803A39494000000040336C3E40000000C03B394940000000C05D6C3E40000000C03B394940000000208B6C3E40000000803B39494000000080AC6C3E40000000403939494000000060D06C3E40000000E03639494000000080F36C3E400000002032394940000000A02F6D3E40
535	45	258	259	15	759.46303995246501	00:00:54.681339	0102000020E610000008000000060000E030394940000000402E6D3E400000002032394940000000A02F6D3E40000000402A39494000000000926D3E40000000201E394940000000C02C6E3E40000000001439494000000020AF6E3E40000000801939494000000020B46E3E400000008028394940000000A0BE6E3E400000000033394940000000A0C56E3E40
536	45	259	260	16	458.705375830771004	00:00:33.026787	0102000020E610000007000000030000A03239494000000040CB6E3E400000000033394940000000A0C56E3E40000000A058394940000000C0E06E3E40000000607239494000000060F36E3E40000000209A394940000000E00F6F3E4000000020AB394940000000801D6F3E4000000000C0394940000000202E6F3E40
537	45	260	261	17	622.342712096278547	00:00:44.808675	0102000020E610000007000000FBFFFF7FBF39494000000020346F3E4000000000C0394940000000202E6F3E4000000020E5394940000000004C6F3E40000000C0093A4940000000E0696F3E40000000003F3A494000000000946F3E40000000605E3A494000000000AD6F3E4000000080593A494000000000E86F3E40
539	46	\N	263	0	0	00:00:00	\N
540	46	263	264	1	597.229694335093768	00:00:43.000538	0102000020E6100000070000000500008090394940090000E0976F3E40000000C08E39494000000040976F3E40000000209A394940000000E00F6F3E40000000607239494000000060F36E3E40000000A058394940000000C0E06E3E400000000033394940000000A0C56E3E400000008028394940000000A0BE6E3E40
541	46	264	265	2	819.111632829836253	00:00:58.976038	0102000020E61000000700000001000020293949400B0000C0B96E3E400000008028394940000000A0BE6E3E40000000801939494000000020B46E3E40000000C01E394940000000C06D6E3E40000000A02939494000000040E36D3E400000008034394940000000A0556D3E40000000203C39494000000040F66C3E40
555	47	\N	279	0	0	00:00:00	\N
556	47	279	280	1	862.452102122820065	00:01:02.096551	0102000020E610000015000000000000A067414940000000408F943E40FBFFFFDF67414940000000008A943E40060000406D4149400000006090943E40FBFFFFDF734149400000008099943E40FBFFFF7F7B414940000000E0A7943E40FEFFFF7F8A414940000000A0C2943E40FEFFFF7F9641494000000080D9943E40FCFFFFFF9C414940000000C0E6943E4000000060A0414940000000A0EF943E40000000A0A341494000000040FC943E4005000080AC4149400000006011953E40010000C0B4414940000000A022953E40FFFFFF3FCF4149400000002054953E40FCFFFF9FE8414940000000607E953E40FAFFFF1FF74149400000008095953E40FDFFFF5F0142494000000080A1953E40F9FFFF5F0642494000000000A5953E40050000800C42494000000020A7953E400500002020424940000000C0AD953E40000000A03B424940000000A0B6953E40040000604342494000000000B8953E40
557	47	280	281	2	360.965615996453096	00:00:25.989524	0102000020E610000009000000FBFFFF7F43424940000000E0BC953E40040000604342494000000000B8953E40010000205542494000000040BE953E40FCFFFF9F6442494000000080C1953E40F9FFFF5F6A424940000000A0C4953E40030000A08242494000000080D5953E40070000A099424940000000E0E2953E40FCFFFF3FAC424940000000E0EE953E4007000000B642494000000040F6953E40
558	47	281	282	3	479.077900332607271	00:00:34.493609	0102000020E610000010000000070000A0B542494000000020FB953E4007000000B642494000000040F6953E40070000A0C9424940000000C006963E40FEFFFF7FD6424940000000000D963E4000000060E0424940000000800F963E4000000060E8424940000000C00D963E40FBFFFF7FEF4249400000008009963E40FAFFFFBFF64249400000004003963E4002000080FD42494000000020FA953E40F9FFFF5F0643494000000040EB953E400300004012434940000000A0D7953E40F9FFFF5F1A43494000000000CC953E40000000A01F43494000000080C7953E40020000802943494000000080C1953E40FDFFFFBF3943494000000080B5953E40FAFFFF1F4343494000000080AE953E40
559	47	282	283	4	356.644927066440289	00:00:25.678435	0102000020E61000000C000000FBFFFFDF4343494000000060B3953E40FAFFFF1F4343494000000080AE953E40030000404A43494000000040AA953E400100002051434940000000E0A8953E40FFFFFFDF5643494000000040AA953E40020000806143494000000040AF953E40000000A06B434940000000A0B6953E40FAFFFFBF72434940000000E0BC953E40FCFFFF9F78434940000000C0C6953E40030000408243494000000020DA953E400100002095434940000000A0FD953E40FDFFFF5FA14349400000002014963E40
560	47	283	284	5	855.053585987105748	00:01:01.563858	0102000020E61000000F000000010000C0A04349400000000019963E40FDFFFF5FA14349400000002014963E40000000A0AB434940000000A025963E4001000020B9434940000000A038963E40FDFFFF5FC94349400000006052963E40040000C0DB434940000000806E963E40070000A0D94349400000002089963E40FCFFFF9FD843494000000020AF963E40FCFFFF3FD843494000000000E1963E40FCFFFF3FD8434940000000C002973E40070000A0D9434940000000202A973E4002000080DD434940000000605B973E4000000060E0434940000000607A973E40040000C0E34349400000008097973E40FDFFFFBFED43494000000020D6973E40
589	48	312	313	4	317.521390483260689	00:00:22.86154	0102000020E610000006000000040000C0373B494005000080F4A03E4004000060373B49400B000000F1A03E40FCFFFFFF543B4940F9FFFF9FC9A03E4003000040663B4940F9FFFF5FB2A03E40FCFFFF9F843B4940F8FFFF3F89A03E40FBFFFF7F8B3B4940F7FFFF1F80A03E40
542	46	265	266	3	531.613223211690638	00:00:38.276152	0102000020E61000000B000000070000A03D394940010000C0F86C3E40000000203C39494000000040F66C3E40000000C03E39494000000060D16C3E40000000604039494000000060B16C3E400000002041394940000000C0976C3E400000002041394940000000A0696C3E40000000804039494000000020456C3E40000000203F394940000000A0216C3E40000000403D394940000000E0006C3E40000000603A394940000000C0DD6B3E40000000803739494000000000C26B3E40
543	46	266	267	4	830.92620517798116	00:00:59.826687	0102000020E6100000090000000100002039394940090000E0BF6B3E40000000803739494000000000C26B3E400000002033394940000000809F6B3E40000000802E394940000000C07C6B3E40000000202539494000000020376B3E40000000A01939494000000040E06A3E40000000A00A394940000000C06E6A3E4000000000FE384940000000600E6A3E4000000060F9384940000000C0E7693E40
544	46	267	268	5	327.342906287324581	00:00:23.568689	0102000020E610000004000000FFFFFFDFFA38494007000060E6693E4000000060F9384940000000C0E7693E40000000C0EC384940000000A084693E40000000E0E1384940000000202E693E40
545	46	268	269	6	714.931427127735901	00:00:51.475063	0102000020E610000012000000040000C0E33849400D0000402B693E40000000E0E1384940000000202E693E4000000020DC3849400000000005693E4000000020D838494000000000EB683E4000000060CE38494000000040C4683E4000000060C538494000000080A8683E40000000C0B7384940000000008B683E4000000020B23849400000006080683E4000000000A8384940000000E074683E40000000209D384940000000E068683E40000000A0963849400000000065683E40000000A08C3849400000008062683E400000006082384940000000C060683E4000000080773849400000000064683E40000000206D3849400000008068683E400000006064384940000000E06F683E40000000C04C384940000000008C683E40000000A03F384940000000E09B683E40
546	46	269	270	7	1046.84604836492372	00:01:15.372915	0102000020E61000001A000000FFFFFF3F3F384940FFFFFFDF96683E40000000A03F384940000000E09B683E40000000C02138494000000020C1683E40000000200D384940000000C0D9683E4000000000FF37494000000080E9683E4000000000EB374940000000A004693E40000000C0C83749400000004030693E4000000020B53749400000002048693E40000000A09C374940000000C066693E40000000E095374940000000406B693E40000000808B3749400000008076693E400000008088374940000000407D693E4000000040883749400000000087693E40000000E0883749400000008090693E40000000208C3749400000008095693E40000000808F3749400000008095693E400000006097374940000000408B693E40000000E09D3749400000004085693E40000000A0A3374940000000C080693E4000000020AC3749400000008075693E4000000060B9374940000000A064693E4000000040C1374940000000E05C693E4000000040C6374940000000805B693E40000000C0CA3749400000006060693E4000000020D23749400000002076693E40000000E0D737494000000020A1693E40
547	46	270	271	8	757.429805063263757	00:00:54.534946	0102000020E610000008000000FEFFFF7FD6374940FAFFFF1FA3693E40000000E0D737494000000020A1693E4000000060E537494000000000066A3E40000000C0EB37494000000080376A3E4000000060FA37494000000080AA6A3E40000000200738494000000020106B3E40000000200C384940000000A03A6B3E40000000E000384940000000C0486B3E40
548	46	271	272	9	702.573099396799421	00:00:50.585263	0102000020E610000009000000FCFFFF3F00384940F9FFFF5F426B3E40000000E000384940000000C0486B3E4000000080E6374940000000C0696B3E4000000000CB374940000000408C6B3E4000000040AD37494000000080B16B3E40000000208D374940000000A0DA6B3E400000004064374940000000E00D6C3E40000000404E374940000000C0296C3E400000000043374940000000403B6C3E40
549	46	272	273	10	291.299671671270005	00:00:20.973576	0102000020E610000008000000FEFFFF1F42374940F5FFFFFF366C3E400000000043374940000000403B6C3E40000000C03637494000000060506C3E40000000A02C37494000000040676C3E400000006021374940000000C0856C3E40000000801A374940000000A09B6C3E400000004016374940000000C0AB6C3E40000000A00F37494000000040C76C3E40
550	46	273	274	11	670.853179112685893	00:00:48.301429	0102000020E61000000A000000030000400E374940F2FFFFFFC36C3E40000000A00F37494000000040C76C3E40000000200D374940000000C0D06C3E400000004008374940000000C0EA6C3E40000000000537494000000080006D3E4000000080FF36494000000080276D3E40000000C0F7364940000000A0626D3E40000000E0E4364940000000C0F26D3E4000000020DF364940000000C01F6E3E4000000040CE364940000000A0096E3E40
551	46	274	275	12	1380.79946405356554	00:01:39.417561	0102000020E61000000E000000030000A0CE364940FCFFFF9F046E3E4000000040CE364940000000A0096E3E4000000060C3364940000000E0FB6D3E40000000809B36494000000080C76D3E40000000807A364940000000009D6D3E40000000404C36494000000080606D3E40000000A03D364940000000804E6D3E40000000E03436494000000000906D3E40000000802C36494000000040CA6D3E40000000802536494000000040046E3E40000000001D364940000000E0416E3E40000000400E364940000000E0AF6E3E400000004000364940000000E0176F3E40000000A0FC354940000000A0326F3E40
552	46	275	276	13	608.475203930009798	00:00:43.810215	0102000020E610000008000000FAFFFF1FFB354940F9FFFFFF316F3E40000000A0FC354940000000A0326F3E4000000040EF354940000000809D6F3E40000000E0C7354940000000206E6F3E40000000A0B335494000000060536F3E40000000609A35494000000040F76E3E400000006097354940000000A0EB6E3E40000000209535494000000020E86E3E40
553	46	276	277	14	2037.36579783335628	00:02:26.690337	0102000020E610000015000000FDFFFF5F953549400D0000E0E26E3E40000000209535494000000020E86E3E40000000E08035494000000040CB6E3E40000000E05E354940000000C09A6E3E40000000C03A35494000000020676E3E400000008011354940000000C02C6E3E4000000000EC344940000000A0F76D3E4000000020E234494000000000EA6D3E40000000C0E0344940000000C0E06D3E40000000C0DA34494000000020B96D3E4000000020E9344940000000804C6D3E40000000C0F834494000000060D66C3E40000000E00535494000000020716C3E40000000200B354940000000A0486C3E40000000000F35494000000080386C3E40000000C00335494000000060FC6B3E4000000060F8344940000000A0B36B3E4000000020E7344940000000A0406B3E4000000000E2344940000000A0216B3E40000000E0DC344940000000000E6B3E4000000060D1344940000000A0EC6A3E40
554	46	277	278	15	1132.04525771848944	00:01:21.507259	0102000020E610000014000000FEFFFF7FD234494000000060E86A3E4000000060D1344940000000A0EC6A3E4000000060C8344940000000E0D16A3E4000000000BD344940000000A0A66A3E4000000000B2344940000000A0866A3E4000000000AB344940000000C0826A3E40000000409D34494000000040866A3E40000000C09934494000000040856A3E40000000E096344940000000807E6A3E40000000608E34494000000000676A3E400000008084344940000000C04F6A3E40000000E075344940000000A0326A3E40000000406C344940000000E01D6A3E400000002071344940000000E00A6A3E40000000807834494000000000F3693E40000000408834494000000000BF693E4000000040983449400000008089693E4000000020B23449400000000039693E4000000060C634494000000020FB683E40000000C0D234494000000040D4683E40
561	47	284	285	6	710.597942129984858	00:00:51.163052	0102000020E61000000F00000005000080EC434940000000E0D8973E40FDFFFFBFED43494000000020D6973E4000000000F4434940000000C0FB973E40FCFFFF9F044449400000006063983E40030000400E444940000000609C983E40FEFFFF7F1244494000000000BC983E40FCFFFF9F1444494000000040D4983E40FDFFFF5F15444940000000A0E8983E40FCFFFF9F1444494000000000FD983E40FDFFFFBF11444940000000600F993E40060000E00C4449400000004028993E400000006008444940000000A03A993E40000000A003444940000000604A993E40FFFFFF3FFF434940000000C056993E40FDFFFF5FF94349400000008060993E40
562	47	285	286	7	359.832188134022658	00:00:25.907918	0102000020E610000008000000FCFFFF9FF8434940000000005C993E40FDFFFF5FF94349400000008060993E40FCFFFFFFEC4349400000004074993E40FAFFFF1FD3434940000000C09D993E40FDFFFFBFB543494000000060CB993E4005000080AC43494000000080D9993E4006000040A543494000000060E3993E40040000C09F43494000000000EB993E40
563	47	286	287	8	495.199879558153441	00:00:35.654391	0102000020E610000013000000FBFFFF7F9F434940000000C0E5993E40040000C09F43494000000000EB993E40FAFFFFBF9A434940000000C0F1993E40000000609443494000000020F8993E40FBFFFF7F8B434940000000C0FE993E40010000208143494000000020059A3E40010000207943494000000020079A3E40010000207143494000000040089A3E40FAFFFF1F6B434940000000E0079A3E40050000806043494000000060059A3E40040000C057434940000000E0019A3E40FCFFFF3F4C43494000000080F9993E40FFFFFFDF42434940000000A0EF993E40F9FFFF5F3A43494000000060E5993E400000000034434940000000A0DB993E40FCFFFFFF3043494000000000D7993E40FEFFFF1F2A43494000000020CB993E40030000402243494000000040BA993E400500008014434940000000C09D993E40
564	47	287	288	9	311.8828456427633	00:00:22.455565	0102000020E610000009000000070000A015434940000000C098993E400500008014434940000000C09D993E40000000A003434940000000A07B993E40010000C0F4424940000000A05C993E4000000060EC424940000000604A993E40040000C0E34249400000008039993E4003000040DA424940000000E026993E4000000000D84249400000000022993E40FDFFFFBFD14249400000004015993E40
565	47	288	289	10	361.727937724444587	00:00:26.044412	0102000020E610000008000000030000A0D2424940000000C010993E40FDFFFFBFD14249400000004015993E4000000060C442494000000080F9983E4004000060B742494000000020DF983E40FAFFFF1FAB42494000000040C6983E40FDFFFFBF9D424940000000C0AA983E400200008091424940000000E091983E40030000A08A424940000000A0B4983E40
566	47	289	290	11	799.260594702188428	00:00:57.546763	0102000020E610000006000000FDFFFF5F8942494000000020B2983E40030000A08A424940000000A0B4983E400000006078424940000000E00C993E40FDFFFFBF59424940000000209E993E40020000803D424940000000A0239A3E40070000002E424940000000606C9A3E40
567	47	290	291	12	355.637784477223704	00:00:25.60592	0102000020E610000005000000010000C02C424940000000006A9A3E40070000002E424940000000606C9A3E40020000802542494000000040959A3E40050000201442494000000040EF9A3E40030000A0FA41494000000020BB9A3E40
568	47	291	292	13	463.390043058626986	00:00:33.364083	0102000020E610000007000000FBFFFF7FFB414940000000E0B59A3E40030000A0FA41494000000020BB9A3E4000000000E841494000000080949A3E40030000A0D6414940000000606C9A3E4006000040C941494000000040499A3E40FAFFFFBFB6414940000000C00A9A3E40FCFFFF9FA841494000000020D9993E40
569	47	292	293	14	880.167737507813854	00:01:03.372077	0102000020E61000000F000000F9FFFFFFA9414940000000A0D5993E40FCFFFF9FA841494000000020D9993E40040000009B41494000000000A9993E40FDFFFF5F95414940000000E093993E40FCFFFFFF8C414940000000406F993E40040000C083414940000000C043993E400500002078414940000000C004993E40000000607041494000000040D9983E40FAFFFF1F6741494000000020A3983E40F9FFFF5F5A41494000000080B7983E40FFFFFF3F53414940000000C0C3983E40050000204041494000000060E3983E40FEFFFF1F2E414940000000A001993E40000000A023414940000000E013993E40030000401A4149400000000023993E40
570	47	293	294	15	670.773739364638573	00:00:48.295709	0102000020E610000014000000FDFFFFBF19414940000000801E993E40030000401A4149400000000023993E40000000A0074149400000000043993E4000000060FC404940000000A055993E40FEFFFF1FE2404940000000A081993E40F9FFFF5FCA40494000000000A9993E40000000A0C3404940000000C0B3993E4002000080BD404940000000C0BD993E4004000060B740494000000080BF993E40FCFFFF9FB040494000000020BF993E40000000A0AB404940000000A0BB993E40000000A0A7404940000000A0BB993E40000000A0A340494000000080BF993E40010000C0A040494000000080C5993E40030000409E404940000000C0D2993E40000000609C40494000000020E0993E40F9FFFFFF9940494000000080EC993E40FDFFFFBF95404940000000C0FD993E40030000A09240494000000060059A3E40040000C07F40494000000020259A3E40
571	47	294	295	16	744.290064245928193	00:00:53.588885	0102000020E61000000A000000FFFFFFDF7E404940000000C01F9A3E40040000C07F40494000000020259A3E40FFFFFF3F67404940000000E04D9A3E40040000C053404940000000806E9A3E40FDFFFF5F35404940000000A0A29A3E40000000001440494000000020DA9A3E40FCFFFF9FF83F494000000020089B3E40FBFFFF7FEB3F4940000000A01C9B3E40FCFFFFFFD83F4940000000803C9B3E4004000060CB3F494000000000539B3E40
572	47	295	296	17	486.389277098953755	00:00:35.020028	0102000020E61000000F000000FFFFFFDFCA3F4940000000C04D9B3E4004000060CB3F494000000000539B3E40FBFFFF7FAF3F4940000000C0809B3E4000000000A03F4940000000C0999B3E40FBFFFFDF973F494000000000A59B3E40F9FFFFFF913F494000000080A99B3E40FEFFFF1F8A3F494000000000AB9B3E4005000020803F4940000000C0A79B3E40FFFFFFDF763F4940000000E0A39B3E40060000E06C3F494000000000A09B3E4005000080683F4940000000809C9B3E40000000A0633F494000000060999B3E40FCFFFFFF583F4940000000609A9B3E40FCFFFF9F4C3F4940000000009F9B3E40070000003E3F494000000080A89B3E40
573	47	296	297	18	552.213774128965724	00:00:39.759392	0102000020E61000000C000000020000E03D3F4940000000E0A39B3E40070000003E3F494000000080A89B3E40000000A02F3F494000000000B89B3E40FEFFFF1F1E3F494000000080C99B3E4001000020053F4940000000C0E19B3E40FAFFFFBFEE3E494000000020F69B3E4000000000D83E4940000000400A9C3E40FCFFFFFFC43E4940000000C0199C3E4001000020B93E494000000020229C3E40FFFFFFDFAE3E4940000000C0289C3E4002000080A53E494000000080309C3E4006000040993E4940000000803D9C3E40
574	47	297	298	19	354.120444808315597	00:00:25.496672	0102000020E610000009000000FCFFFFFF983E4940000000E0369C3E4006000040993E4940000000803D9C3E40FDFFFFBF893E4940000000E04F9C3E40050000807C3E494000000000609C3E40020000E06D3E494000000000749C3E40FAFFFF1F633E494000000000819C3E40FDFFFF5F553E494000000000939C3E40FCFFFFFF4C3E4940000000209D9C3E40FBFFFF7F3B3E4940000000E0B69C3E40
575	47	298	299	20	1032.22731837483707	00:01:14.320367	0102000020E61000000D000000FAFFFF1F3B3E4940000000A0B19C3E40FBFFFF7F3B3E4940000000E0B69C3E40000000A0273E4940000000A0D29C3E40060000E0103E4940000000E0F19C3E4001000020F53D4940000000E0179D3E40FFFFFFDFDA3D4940000000C03B9D3E4004000060BF3D494000000000609D3E40FBFFFF7FA33D4940000000E0859D3E4000000060883D494000000020AB9D3E40F9FFFFFF693D494000000060D59D3E40FAFFFF1F4B3D494000000080FE9D3E4003000040323D4940000000A0219E3E40FCFFFFFF283D4940000000A02D9E3E40
576	47	299	300	21	361.505198455698405	00:00:26.028374	0102000020E61000000600000000000060283D4940000000A0279E3E40FCFFFFFF283D4940000000A02D9E3E40010000C01C3D4940000000203E9E3E40040000C00F3D4940000000604F9E3E40FEFFFF1FFA3C4940000000A06D9E3E40030000A0CA3C4940000000E0AD9E3E40
577	47	300	301	22	572.328774719819876	00:00:41.207672	0102000020E61000000B000000F9FFFFFFC93C494000000040A89E3E40030000A0CA3C4940000000E0AD9E3E40020000E0B13C4940000000A0CF9E3E40030000409A3C4940000000A0EF9E3E4004000000933C494000000080F99E3E40040000C0873C4940000000600A9F3E40040000607F3C4940000000C0129F3E4000000000743C4940000000001B9F3E40020000805D3C4940000000E0399F3E40FCFFFF9F3C3C494000000040699F3E40030000A0323C494000000000789F3E40
578	47	301	302	23	585.093863672435646	00:00:42.126758	0102000020E610000009000000F9FFFFFF313C4940000000E0739F3E40030000A0323C494000000000789F3E40010000C0243C4940000000808D9F3E40FDFFFFBF013C494000000080C49F3E40FDFFFFBFE93B494000000020EA9F3E40FEFFFF1FDA3B4940000000E004A03E40070000A0D13B49400000008016A03E4001000020BD3B4940000000A033A03E40FBFFFF7F9F3B4940000000005BA03E40
579	47	302	303	24	362.427253757182882	00:00:26.094762	0102000020E610000007000000FFFFFFDF9E3B49400000004055A03E40FBFFFF7F9F3B4940000000005BA03E40FBFFFFDF7B3B4940000000208BA03E40FDFFFFBF693B494000000020A3A03E4005000080603B4940000000E0ACA03E40FFFFFFDF4E3B494000000060B0A03E40FCFFFF9F3C3B494000000020CBA03E40
580	47	303	304	25	477.706185304693918	00:00:34.394845	0102000020E61000000A000000FBFFFFDF3B3B494000000000C5A03E40FCFFFF9F3C3B494000000020CBA03E40040000C02B3B4940000000C0E3A03E40030000A0163B49400000000002A13E4000000000FC3A49400000008025A13E4004000060E73A49400000006042A13E40FCFFFF3FE03A4940000000E04CA13E4006000040D93A4940000000E053A13E40010000C0CC3A49400000006063A13E4004000060BF3A49400000000076A13E40
581	47	304	305	26	503.750794412142341	00:00:36.270057	0102000020E610000008000000FFFFFFDFBE3A4940000000A070A13E4004000060BF3A49400000000076A13E4003000040A63A4940000000A09AA13E40FBFFFFDF8B3A4940000000E0BFA13E40FCFFFF9F643A4940000000E0F3A13E40070000004E3A49400000002012A23E40FDFFFF5F453A4940000000000AA23E40FDFFFF5F393A4940000000A0FCA13E40
582	47	305	306	27	492.749826019624493	00:00:35.477987	0102000020E61000000A000000020000E0393A4940000000A0F7A13E40FDFFFF5F393A4940000000A0FCA13E40010000C0143A494000000000CFA13E40FFFFFF3FFB39494000000060AFA13E40060000E0E8394940000000A094A13E40FAFFFFBFE23949400000006089A13E40000000A0DB394940000000807FA13E4004000060CF394940000000406EA13E40FDFFFFBFC1394940000000605CA13E40F9FFFF5FB6394940000000404EA13E40
583	47	306	307	28	459.851386239489273	00:00:33.1093	0102000020E610000006000000FFFFFFDFB6394940000000E048A13E40F9FFFF5FB6394940000000404EA13E40FCFFFF9F98394940000000C02AA13E40FBFFFFDF773949400000006003A13E40070000005E39494000000080E4A03E40000000A037394940000000C0B6A03E40
584	47	307	308	29	520.886503459279083	00:00:37.503828	0102000020E610000006000000000000603839494000000060B1A03E40000000A037394940000000C0B6A03E40070000A0193949400000004093A03E40020000E0013949400000008077A03E4000000060D83849400000004046A03E40FBFFFFDFCB384940000000A0AAA03E40
585	48	\N	309	0	0	00:00:00	\N
586	48	309	310	1	395.526446517078853	00:00:28.477904	0102000020E610000005000000050000204C3949400D0000E0E2A03E40FCFFFF9F4C394940F5FFFF9FDEA03E400400006077394940F9FFFF5F12A13E4006000040A1394940FCFFFF9F44A13E4006000040B93949400C00008062A13E40
587	48	310	311	2	1237.45059163522978	00:01:29.096443	0102000020E610000014000000060000E0B83949400800002067A13E4006000040B93949400C00008062A13E40FCFFFF3FC83949400500002074A13E40FBFFFF7FCF394940010000C080A13E40040000C0D3394940FEFFFF7F8EA13E40000000A0D73949400D000040A3A13E40000000A0DB39494000000060C0A13E4003000040EA3949400700006026A23E4000000000F0394940F7FFFF1F50A23E40FBFFFF7FF33949400B00006061A23E4004000060F7394940FCFFFF9F6CA23E40FCFFFF3FFC3949400E0000A073A23E40F9FFFFFF013A4940090000E077A23E40FEFFFF7F0A3A49400B00000079A23E40F9FFFFFF293A4940090000804FA23E40FCFFFF9F4C3A4940FAFFFF1F23A23E40FBFFFFDF673A49400000000000A23E40000000A08F3A4940F6FFFFBFC7A13E40000000A0AF3A4940F4FFFFDF9DA13E40040000C0BF3A4940030000A08AA13E40
588	48	311	312	3	443.289064207555668	00:00:31.916813	0102000020E61000000C00000000000000C03A4940FEFFFF1F8EA13E40040000C0BF3A4940030000A08AA13E4007000000CE3A49400A0000A078A13E40FCFFFF9FDC3A49400000006060A13E40030000A0E23A4940000000A057A13E40FBFFFF7FEF3A4940F8FFFFDF48A13E40F9FFFF5FFE3A49400400006033A13E40FAFFFFBF0A3B49400C00008022A13E4004000060133B4940F5FFFF9F16A13E40FFFFFFDF1E3B4940040000600BA13E40FDFFFFBF2D3B494006000040FDA03E4004000060373B49400B000000F1A03E40
590	48	313	314	5	645.439624662231381	00:00:46.471653	0102000020E61000000D000000FBFFFFDF8B3B4940F2FFFF5F84A03E40FBFFFF7F8B3B4940F7FFFF1F80A03E4004000060A33B4940F7FFFF7F60A03E40FCFFFF9FC03B4940010000C038A03E40FDFFFFBFD53B4940FCFFFF9F1CA03E40040000C0DF3B4940FAFFFF1F13A03E40FEFFFF1FE63B4940050000200CA03E40FCFFFF9FEC3B4940F2FFFF5F04A03E4001000020F53B4940F5FFFFFFF69F3E40020000E0093C4940F5FFFF3FD69F3E40060000E0243C4940F3FFFF1FAD9F3E40FEFFFF7F2E3C4940F7FFFF1FA09F3E4002000080353C4940060000E0949F3E40
591	48	314	315	6	540.723527581022154	00:00:38.932094	0102000020E610000009000000FEFFFF1F363C494002000080999F3E4002000080353C4940060000E0949F3E40FEFFFF7F523C4940090000E0679F3E40FEFFFF1F6E3C4940020000E0419F3E40FFFFFFDF7E3C49400A000040289F3E4005000080843C49400E0000001C9F3E4005000080883C49400C000080129F3E40FAFFFF1F973C494009000080FF9E3E40040000C0BF3C49400B000060C99E3E40
592	48	315	316	7	520.324468203673973	00:00:37.463362	0102000020E610000008000000FCFFFF3FC03C4940070000A0CD9E3E40040000C0BF3C49400B000060C99E3E4007000000DE3C49400A0000A0A09E3E40F9FFFF5FEE3C4940FAFFFFBF8A9E3E40F9FFFF5F0E3D4940FDFFFF5F5D9E3E40FCFFFF3F243D4940090000E03F9E3E40040000C0373D4940FFFFFFDF269E3E40FDFFFFBF493D4940070000600E9E3E40
593	48	316	317	8	1031.8013564791861	00:01:14.289698	0102000020E61000000B000000F9FFFF5F4A3D49400C000020129E3E40FDFFFFBF493D4940070000600E9E3E40FBFFFFDF6F3D4940F9FFFF9FD99D3E4002000080893D4940F7FFFF1FB89D3E4002000080993D4940FBFFFF7FA39D3E40020000E0BD3D4940F8FFFFDF709D3E40FCFFFF9FE83D4940FEFFFF1F369D3E40070000A0113E4940F5FFFF3FFE9C3E40FAFFFF1F3B3E4940F5FFFF9FC69C3E40FCFFFFFF503E494002000080A99C3E40FDFFFF5F5D3E49400A000040989C3E40
594	48	317	318	9	293.358972334827911	00:00:21.121846	0102000020E610000008000000FDFFFFBF5D3E4940040000C09B9C3E40FDFFFF5F5D3E49400A000040989C3E4005000020743E49400A000040789C3E40FAFFFF1F833E4940FAFFFF1F639C3E40040000008B3E49400B000000599C3E40F9FFFF5F963E4940F2FFFF5F4C9C3E40000000A09F3E49400C000020429C3E40FCFFFFFFAC3E4940F4FFFF7F359C3E40
595	48	318	319	10	656.677586800270774	00:00:47.280786	0102000020E61000000F00000002000080AD3E4940F9FFFF9F399C3E40FCFFFFFFAC3E4940F4FFFF7F359C3E4002000080B93E4940FCFFFF9F2C9C3E4003000040CA3E4940010000C0209C3E40000000A0E33E4940F2FFFF5F0C9C3E4004000000F73E4940060000E0FC9B3E4000000000083F4940F2FFFF5FEC9B3E4001000020253F4940FEFFFF1FCE9B3E40FDFFFF5F393F49400B000060B99B3E4004000060433F49400A000040B09B3E40FCFFFF9F543F4940F8FFFF3FA99B3E40FBFFFFDF5F3F494007000060A69B3E40020000E0653F4940FCFFFFFFA49B3E40060000E06C3F494000000000A09B3E40FFFFFFDF763F4940FBFFFFDFA39B3E40
596	48	319	320	11	443.900347110846894	00:00:31.960825	0102000020E61000000B000000FAFFFF1F773F4940F7FFFF7FA89B3E40FFFFFFDF763F4940FBFFFFDFA39B3E4005000020803F4940F6FFFFBFA79B3E40FEFFFF1F8A3F494004000000AB9B3E40F9FFFFFF913F494002000080A99B3E40FBFFFFDF973F4940FCFFFFFFA49B3E4000000000A03F49400B0000C0999B3E40FBFFFF7FAF3F4940010000C0809B3E4004000060CB3F494004000000539B3E40FCFFFFFFD83F4940050000803C9B3E40FBFFFF7FEB3F4940FCFFFF9F1C9B3E40
597	48	320	321	12	431.02754346838941	00:00:31.033983	0102000020E610000006000000FCFFFF3FEC3F494000000060209B3E40FBFFFF7FEB3F4940FCFFFF9F1C9B3E40FCFFFF9FF83F4940F7FFFF1F089B3E4000000000144049400C000020DA9A3E40FDFFFF5F35404940030000A0A29A3E40040000C053404940FEFFFF7F6E9A3E40
598	48	321	322	13	502.248237954039666	00:00:36.161873	0102000020E61000000F000000FCFFFF9F54404940FAFFFF1F739A3E40040000C053404940FEFFFF7F6E9A3E40FFFFFF3F67404940F4FFFFDF4D9A3E40040000C07F404940F3FFFF1F259A3E40030000A092404940FDFFFF5F059A3E40010000C098404940F7FFFF7F009A3E40060000E0A0404940F6FFFFBFFF993E40040000C0A7404940FDFFFF5F059A3E40FCFFFF9FAC404940F3FFFF1F059A3E4005000020B0404940F7FFFF7F009A3E40FBFFFFDFB3404940FCFFFF3FF4993E40FEFFFF1FB6404940F6FFFFBFDF993E40060000E0B84049400B0000C0D1993E4002000080BD404940FDFFFFBFBD993E40000000A0C3404940040000C0B3993E40
599	48	322	323	14	285.347866034525055	00:00:20.545046	0102000020E610000006000000FCFFFF9FC440494001000020B9993E40000000A0C3404940040000C0B3993E40F9FFFF5FCA4049400B000000A9993E40FEFFFF1FE2404940F9FFFF9F81993E4000000060FC404940070000A055993E40000000A0074149400400000043993E40
600	48	323	324	15	345.611995243526735	00:00:24.884064	0102000020E6100000080000000000000008414940FFFFFF3F47993E40000000A0074149400400000043993E40030000401A4149400400000023993E40000000A023414940FBFFFFDF13993E40FEFFFF1F2E414940F9FFFF9F01993E40050000204041494004000060E3983E40FFFFFF3F53414940040000C0C3983E40F9FFFF5F5A41494009000080B7983E40
601	48	324	325	16	154.852665780928959	00:00:11.149392	0102000020E610000004000000FBFFFF7F5B4149400E000000BC983E40F9FFFF5F5A41494009000080B7983E40FAFFFF1F67414940FAFFFF1FA3983E400000006070414940F8FFFF3FD9983E40
602	48	325	326	17	378.88805180520751	00:00:27.27994	0102000020E610000007000000FFFFFF3F6F4149400D000040DB983E400000006070414940F8FFFF3FD9983E400500002078414940F3FFFFBF04993E40040000C083414940040000C043993E40FCFFFFFF8C414940FFFFFF3F6F993E40FDFFFF5F95414940FBFFFFDF93993E40040000009B4149400B000000A9993E40
603	48	326	327	18	551.745439966081904	00:00:39.725672	0102000020E610000008000000020000E09941494005000080AC993E40040000009B4149400B000000A9993E40FCFFFF9FA841494001000020D9993E40FAFFFFBFB6414940FAFFFFBF0A9A3E4006000040C9414940F8FFFF3F499A3E40030000A0D6414940F2FFFF5F6C9A3E4000000000E841494005000080949A3E40030000A0FA414940FAFFFF1FBB9A3E40
604	48	327	328	19	359.776233959102456	00:00:25.903889	0102000020E610000005000000070000A0F9414940F7FFFF7FC09A3E40030000A0FA414940FAFFFF1FBB9A3E400500002014424940FFFFFF3FEF9A3E40020000802542494006000040959A3E40070000002E424940F2FFFF5F6C9A3E40
605	48	328	329	20	917.838957426225761	00:01:06.084405	0102000020E610000008000000FBFFFF7F2F424940FFFFFF3F6F9A3E40070000002E424940F2FFFF5F6C9A3E40020000803D4249400E0000A0239A3E40FDFFFFBF59424940FEFFFF1F9E993E400000006078424940060000E00C993E40030000A08A424940FCFFFF9FB4983E400200008091424940020000E091983E40FDFFFFBF9D424940FAFFFFBFAA983E40
606	48	329	330	21	273.457130566335309	00:00:19.688913	0102000020E610000007000000010000209D42494000000000B0983E40FDFFFFBF9D424940FAFFFFBFAA983E40FAFFFF1FAB424940F5FFFF3FC6983E4004000060B742494008000020DF983E4000000060C442494002000080F9983E40FDFFFFBFD14249400600004015993E4000000000D8424940F9FFFFFF21993E40
607	48	330	331	22	410.562262451452284	00:00:29.560483	0102000020E61000000B000000FAFFFF1FD7424940FEFFFF7F26993E4000000000D8424940F9FFFFFF21993E4003000040DA424940FFFFFFDF26993E40040000C0E34249400200008039993E4000000060EC424940F9FFFF5F4A993E40010000C0F4424940FCFFFF9F5C993E40000000A0034349400E0000A07B993E400500008014434940FDFFFFBF9D993E40030000402243494003000040BA993E40FEFFFF1F2A434940FAFFFF1FCB993E40FCFFFFFF30434940F5FFFFFFD6993E40
608	48	331	332	23	449.332027992549172	00:00:32.351906	0102000020E61000001300000005000080304349400D000040DB993E40FCFFFFFF30434940F5FFFFFFD6993E4000000000344349400E0000A0DB993E40F9FFFF5F3A434940FDFFFF5FE5993E40FFFFFFDF42434940000000A0EF993E40FCFFFF3F4C43494002000080F9993E40040000C057434940020000E0019A3E400500008060434940FDFFFF5F059A3E40FAFFFF1F6B434940090000E0079A3E4001000020714349400A000040089A3E40010000207943494008000020079A3E400100002081434940F3FFFF1F059A3E40FBFFFF7F8B434940080000C0FE993E400000006094434940F7FFFF1FF8993E40FAFFFFBF9A4349400B0000C0F1993E40040000C09F43494004000000EB993E4006000040A543494004000060E3993E4005000080AC43494002000080D9993E40FDFFFFBFB543494004000060CB993E40
609	48	332	333	24	277.380679598288111	00:00:19.971409	0102000020E61000000500000003000040B6434940010000C0D0993E40FDFFFFBFB543494004000060CB993E40FAFFFF1FD3434940FDFFFFBF9D993E40FCFFFFFFEC434940FCFFFF3F74993E40FDFFFF5FF9434940F7FFFF7F60993E40
610	48	333	334	25	720.487883370486429	00:00:51.875128	0102000020E610000013000000020000E0F9434940F4FFFF7F65993E40FDFFFF5FF9434940F7FFFF7F60993E40FFFFFF3FFF434940080000C056993E40FDFFFFBF01444940070000A055993E40FAFFFF1F0B444940F5FFFF9F4E993E40070000A015444940060000404D993E40000000A01B444940060000404D993E400500002020444940FFFFFF3F47993E40FFFFFF3F23444940FCFFFFFF3C993E40FCFFFF9F244449400B0000C031993E40FCFFFFFF24444940F8FFFF3F21993E40FFFFFFDF22444940FBFFFFDF13993E40FBFFFF7F1F444940FEFFFF7FFE983E4006000040194449400D000040DB983E40020000E01544494000000000C8983E40FEFFFF7F124449400E000000BC983E40030000400E444940F2FFFF5F9C983E40FCFFFF9F044449400400006063983E4000000000F4434940040000C0FB973E40
611	48	334	335	26	920.023786752234969	00:01:06.241713	0102000020E61000001000000002000080F5434940F7FFFF7FF8973E4000000000F4434940040000C0FB973E40FDFFFFBFED434940FEFFFF1FD6973E40040000C0E34349400900008097973E4000000060E0434940F9FFFF5F7A973E4002000080DD434940040000605B973E40070000A0D94349400C0000202A973E40FCFFFF3FD8434940FAFFFFBF02973E40FCFFFF3FD84349400B000000E1963E40FCFFFF9FD843494008000020AF963E40070000A0D94349400100002089963E40040000C0DB434940FEFFFF7F6E963E40FDFFFF5FC9434940F9FFFF5F52963E4001000020B94349400A0000A038963E40000000A0AB434940070000A025963E40FDFFFF5FA14349400500002014963E40
612	48	335	336	27	389.485416655696042	00:00:28.04295	0102000020E61000000D000000020000E0A1434940FDFFFF5F0D963E40FDFFFF5FA14349400500002014963E400100002095434940070000A0FD953E4003000040824349400C000020DA953E40FCFFFF9F78434940080000C0C6953E40FAFFFFBF72434940060000E0BC953E40000000A06B434940F5FFFF9FB6953E400200008061434940FFFFFF3FAF953E40FFFFFFDF5643494003000040AA953E400100002051434940F8FFFFDFA8953E40030000404A43494003000040AA953E40FAFFFF1F43434940FEFFFF7FAE953E40FDFFFFBF39434940F4FFFF7FB5953E40
613	48	336	337	28	480.930108451728074	00:00:34.626968	0102000020E61000001000000002000080394349400A000040B0953E40FDFFFFBF39434940F4FFFF7FB5953E40020000802943494002000080C1953E40000000A01F43494009000080C7953E40F9FFFF5F1A4349400E000000CC953E400300004012434940000000A0D7953E40F9FFFF5F064349400D000040EB953E4002000080FD4249400C000020FA953E40FAFFFFBFF64249400D00004003963E40FBFFFF7FEF4249400200008009963E4000000060E8424940FDFFFFBF0D963E4000000060E0424940090000800F963E40FEFFFF7FD6424940FCFFFFFF0C963E40070000A0C9424940080000C006963E4007000000B6424940F5FFFF3FF6953E40FCFFFF3FAC424940FFFFFFDFEE953E40
614	48	337	338	29	355.881674807622289	00:00:25.623481	0102000020E610000009000000010000C0AC424940F7FFFF1FE8953E40FCFFFF3FAC424940FFFFFFDFEE953E40070000A0994249400D0000E0E2953E40030000A082424940F4FFFF7FD5953E40F9FFFF5F6A424940FCFFFF9FC4953E40FCFFFF9F6442494002000080C1953E400100002055424940F5FFFF3FBE953E40040000604342494000000000B8953E40000000A03B424940F5FFFF9FB6953E40
615	48	338	339	30	2167.08591176340269	00:02:36.030186	0102000020E610000023000000FBFFFFDF3B4249400B000000B1953E40000000A03B424940F5FFFF9FB6953E400500002020424940FDFFFFBFAD953E40050000800C42494008000020A7953E40F9FFFF5F06424940FCFFFFFFA4953E40FDFFFF5F0142494002000080A1953E40FAFFFF1FF7414940F4FFFF7F95953E40FCFFFF9FE8414940070000607E953E40FFFFFF3FCF4149400500002054953E40010000C0B4414940030000A022953E4005000080AC4149400B00006011953E40000000A0A3414940FCFFFF3FFC943E4000000060A0414940000000A0EF943E40FCFFFFFF9C414940080000C0E6943E40FEFFFF7F9641494002000080D9943E40FEFFFF7F8A414940030000A0C2943E40FBFFFF7F7B414940090000E0A7943E40000000007441494005000020CC943E400200008061414940FCFFFFFF24953E40040000C05B4149400300004042953E400500008054414940FCFFFF3F7C953E40FCFFFFFF4C41494008000020CF953E40FAFFFFBF46414940F2FFFF5F0C963E40FFFFFF3F37414940FDFFFF5FED953E40040000C02F41494000000000E0953E40040000002B41494006000040DD953E40000000A023414940FAFFFFBFDA953E40000000A01B41494000000060D8953E400400000013414940FBFFFFDFE3953E40F9FFFFFF0941494000000060C0953E40FBFFFF7F03414940080000C0A6953E4004000060EB404940060000405D953E40FAFFFF1FCF404940040000000B953E40060000E0B8404940F9FFFF5FCA943E4003000040B2404940F5FFFFFFB6943E40
616	49	\N	196	0	0	00:00:00	\N
617	49	196	340	1	1061.33401825162014	00:01:16.416049	0102000020E610000018000000FFFFFF3F6F384940000000A0777D3E40000000C06F384940000000A0797D3E40000000C06B384940000000E0847D3E400000000069384940000000808C7D3E40000000A067384940000000C0927D3E400000000067384940000000C09B7D3E40000000006738494000000040A47D3E40000000A06A38494000000080AC7D3E40000000007238494000000000BE7D3E40000000607C384940000000A0D67D3E400000000084384940000000C0E87D3E40000000008938494000000040017E3E400000000093384940000000802E7E3E40000000209C384940000000605A7E3E4000000060A538494000000080867E3E40000000C0AC38494000000060A97E3E4000000020AF384940000000A0B47E3E4000000040B5384940000000A0D07E3E4000000060BF38494000000000FF7E3E4000000080CB384940000000C0357F3E40000000A0D6384940000000001E7F3E4000000080E6384940000000E0FB7E3E4000000000F938494000000040D47E3E4000000060FD38494000000000CB7E3E40
675	53	395	396	17	790.805235300526419	00:00:56.937977	0102000020E610000008000000FCFFFFFFF438494000000000006A3E40FEFFFF1FF638494000000040FE693E4006000040F9384940000000C0146A3E40000000000439494000000000686A3E40030000A01A39494000000060156B3E40020000802D394940000000E0A66B3E40FAFFFF1F33394940000000809F6B3E40030000A03A39494000000000966B3E40
618	49	340	341	2	690.997659092485037	00:00:49.751831	0102000020E61000000E000000F9FFFF5FFE384940000000C0CF7E3E4000000060FD38494000000000CB7E3E40000000C008394940000000A0B37E3E40000000801139494000000080A17E3E40000000A013394940000000809E7E3E40000000401A394940000000E0977E3E40000000202339494000000080907E3E40000000202C394940000000C0897E3E40000000C03D39494000000060BA7D3E40000000E03E39494000000060A77D3E400000004045394940000000A0AC7D3E40000000C050394940000000E0B77D3E40000000A05739494000000020C97D3E40000000C05939494000000040D47D3E40
619	49	341	342	3	891.865635271237579	00:01:04.214326	0102000020E61000000B000000FCFFFF3F5839494000000000D77D3E40000000C05939494000000040D47D3E40000000A05E394940000000E0EA7D3E400000008067394940000000401F7E3E40000000A069394940000000802A7E3E40000000C07439494000000080517E3E40000000A083394940000000E0847E3E40000000209439494000000000C27E3E4000000040A5394940000000C0107F3E4000000060B6394940000000805F7F3E4000000000CA39494000000020B87F3E40
620	49	342	343	4	340.541160861276865	00:00:24.518964	0102000020E61000000600000005000080C8394940000000A0BB7F3E4000000000CA39494000000020B87F3E40000000C0D0394940000000E0D97F3E40000000E0E1394940000000002A803E4000000000E83949400000000049803E4000000060F03949400000000071803E40
621	49	343	344	5	463.135366001832438	00:00:33.345746	0102000020E61000000A00000004000000EF3949400000004074803E4000000060F03949400000000071803E40000000E0FA39494000000060A3803E40000000600C3A4940000000A0F5803E40000000C0163A49400000008026813E40000000E0183A4940000000C02F813E40000000C0223A49400000006061813E40000000A0253A49400000006062813E40000000E0273A49400000000062813E40000000C0293A4940000000005F813E40
622	50	\N	345	0	0	00:00:00	\N
623	50	345	346	1	245.377797539808938	00:00:17.667201	0102000020E610000004000000FCFFFF3F183A49400000004022813E40000000C0163A49400000008026813E40000000600C3A4940000000A0F5803E40000000E0FA39494000000060A3803E40
624	50	346	347	2	372.248752312688111	00:00:26.80191	0102000020E610000006000000FCFFFF9FFC394940000000209F803E40000000E0FA39494000000060A3803E4000000060F03949400000000071803E4000000000E83949400000000049803E40000000E0E1394940000000002A803E40000000C0D0394940000000E0D97F3E40
625	50	347	348	3	1203.54786501297326	00:01:26.655446	0102000020E610000012000000FEFFFF1FD239494000000060D77F3E40000000C0D0394940000000E0D97F3E4000000000CA39494000000020B87F3E4000000060B6394940000000805F7F3E4000000040A5394940000000C0107F3E40000000209439494000000000C27E3E40000000A083394940000000E0847E3E40000000C07439494000000080517E3E40000000A069394940000000802A7E3E400000008067394940000000401F7E3E40000000A05E394940000000E0EA7D3E40000000C05939494000000040D47D3E40000000A05739494000000020C97D3E40000000C050394940000000E0B77D3E400000004045394940000000A0AC7D3E40000000E03E39494000000060A77D3E40000000A035394940000000A0A17D3E40000000E030394940000000E0E07D3E40
626	50	348	349	4	570.019695049798202	00:00:41.041418	0102000020E61000000B000000040000602F39494000000060E07D3E40000000E030394940000000E0E07D3E40000000E02939494000000080397E3E40000000C024394940000000C0797E3E40000000A021394940000000407B7E3E40000000601C394940000000E07B7E3E40000000601739494000000020797E3E40000000E01139494000000060727E3E400000006009394940000000E0537E3E40000000E0F938494000000000167E3E4000000060EA38494000000000377E3E40
627	50	349	196	5	906.761862587564906	00:01:05.286854	0102000020E61000001100000002000080E9384940000000E0307E3E4000000060EA38494000000000377E3E4000000080D338494000000020677E3E4000000020AF384940000000A0B47E3E40000000C0AC38494000000060A97E3E4000000060A538494000000080867E3E40000000209C384940000000605A7E3E400000000093384940000000802E7E3E40000000008938494000000040017E3E400000000084384940000000C0E87D3E400000000081384940000000A0B67D3E40000000407E38494000000000897D3E40000000A07B38494000000080737D3E400000004079384940000000806D7D3E40000000C075384940000000C06B7D3E40000000A073384940000000006F7D3E40000000C06F384940000000A0797D3E40
628	51	\N	350	0	0	00:00:00	\N
629	51	350	351	1	837.093454956931737	00:01:00.270729	0102000020E610000009000000000000607430494000000040BC783E40000000C07530494000000060B8783E4000000060883049400000002001793E40000000C092304940000000E02E793E40000000609C3049400000006058793E4000000060A83049400000000098793E40000000A0C0304940000000A0117A3E40000000C0CB304940000000A04C7A3E40000000E0D5304940000000E0837A3E40
630	51	351	352	2	455.973336654392597	00:00:32.83008	0102000020E610000006000000000000E0D430494000000000867A3E40000000E0D5304940000000E0837A3E4000000020E130494000000060C07A3E4000000000F030494000000020037B3E400000002005314940000000006D7B3E40000000E008314940000000E07E7B3E40
631	51	352	353	3	392.761963041756417	00:00:28.278861	0102000020E610000005000000FBFFFFDF07314940000000E0807B3E40000000E008314940000000E07E7B3E40000000E01A314940000000A0DA7B3E40000000202A314940000000A0277C3E400000004033314940000000C0577C3E40
632	51	353	354	4	643.054110397603836	00:00:46.299896	0102000020E61000000A0000000000000032314940000000605B7C3E400000004033314940000000C0577C3E40000000A036314940000000A0677C3E40000000001D314940000000A09A7C3E40000000C018314940000000E0A57C3E40000000C01331494000000080C47C3E40000000400631494000000000637D3E400000008004314940000000E07A7D3E400000000005314940000000C08A7D3E40000000A005314940000000C0B77D3E40
633	51	354	355	5	507.173463236822329	00:00:36.516489	0102000020E610000005000000000000600431494000000020B87D3E40000000A005314940000000C0B77D3E400000002007314940000000A0EF7D3E40000000800C314940000000009F7E3E40000000000E31494000000020E07E3E40
634	51	355	356	6	570.820188514127608	00:00:41.099054	0102000020E610000005000000000000600C314940000000C0E07E3E40000000000E31494000000020E07E3E40000000C012314940000000A08B7F3E40000000401431494000000000C67F3E400000004016314940000000602D803E40
635	51	356	357	7	519.130873795450611	00:00:37.377423	0102000020E610000009000000000000C014314940000000C02D803E400000004016314940000000602D803E40000000001731494000000020A8803E40000000E017314940000000E00A813E400000000019314940000000C016813E40000000401B314940000000C01C813E40000000C025314940000000202A813E40000000002D3149400000004038813E400000006033314940000000804A813E40
636	51	357	358	8	546.51650778575754	00:00:39.349189	0102000020E61000000A0000000000008032314940000000C04E813E400000006033314940000000804A813E40000000404D3149400000006081813E40000000A06831494000000060C1813E40000000806E31494000000000D4813E40000000607631494000000020F1813E40000000207C3149400000006010823E40000000C07F314940000000202B823E400000004080314940000000E04C823E400000000081314940000000E060823E40
637	51	358	359	9	1025.60409025062336	00:01:13.843494	0102000020E610000016000000000000807F3149400000006062823E400000000081314940000000E060823E400000006082314940000000C07E823E400000004085314940000000209E823E40000000008D31494000000080B8823E40000000C09431494000000060CF823E40000000E09F31494000000000F7823E4000000000A3314940000000400D833E40000000A0A33149400000000023833E4000000080A2314940000000E033833E40000000409E314940000000004A833E4000000040913149400000008067833E4000000080843149400000006083833E400000004081314940000000C091833E40000000207F31494000000060A4833E40000000007F314940000000E0B4833E40000000E081314940000000C0CB833E40000000E088314940000000C0EC833E40000000808D314940000000E015843E40000000C091314940000000203B843E4000000020993149400000008080843E40000000209C3149400000004096843E40
638	51	359	360	10	1097.86345436210672	00:01:19.046169	0102000020E610000013000000000000809A314940000000C099843E40000000209C3149400000004096843E40000000E0A531494000000040CA843E40000000E0AE31494000000080EE843E40000000E0B63149400000000012853E4000000020BC314940000000A031853E4000000080C03149400000008056853E4000000040C3314940000000007F853E4000000060C33149400000008095853E4000000040C031494000000080DD853E40000000C0C031494000000060FB853E4000000040C3314940000000401E863E4000000000C7314940000000E03C863E4000000080D8314940000000C082863E40000000A0E031494000000000A7863E40000000E0E431494000000060BA863E4000000020E831494000000020D6863E40000000A0EA31494000000040ED863E4000000040F131494000000020DC863E40
639	51	360	361	11	531.512203224487166	00:00:38.268879	0102000020E610000006000000000000C0F231494000000040DF863E4000000040F131494000000020DC863E40000000A005324940000000009A863E40000000C029324940000000E029863E40000000C03F32494000000020E3853E400000002047324940000000A0CC853E40
640	51	361	362	12	361.554686697046236	00:00:26.031937	0102000020E610000005000000000000A048324940000000E0CF853E400000002047324940000000A0CC853E40000000C057324940000000E096853E40000000807C3249400000008021853E4000000000803249400000002014853E40
641	51	362	363	13	356.006133274508898	00:00:25.632442	0102000020E610000006000000000000A0813249400000004017853E4000000000803249400000002014853E40000000408E32494000000060E0843E40000000609532494000000080CE843E4000000060A432494000000080AE843E4000000020C4324940000000C06C843E40
642	51	363	364	14	984.113396843428177	00:01:10.856165	0102000020E61000000F00000000000020C53249400000006072843E4000000020C4324940000000C06C843E4000000020D7324940000000003F843E40000000E0DD3249400000008034843E4000000060043349400000004003843E40000000400C33494000000020FA833E400000008001334940000000009D833E40000000E0F1324940000000E02D833E40000000E0EC324940000000C011833E4000000000E132494000000060DD823E40000000E0DB32494000000000C9823E4000000080D732494000000060AF823E40000000E0DB324940000000E092823E4000000000DD324940000000C089823E4000000000D3324940000000807E823E40
643	52	\N	365	0	0	00:00:00	\N
644	52	365	366	1	1300.92452091349423	00:01:33.666566	0102000020E610000013000000000000E0DD324940000000E025823E4000000000DF3249400000006023823E4000000020E8324940000000A05B823E4000000000EF324940000000A081823E4000000000F832494000000040A0823E4000000000F332494000000080B3823E4000000000DD324940000000C089823E40000000E0DB324940000000E092823E4000000080D732494000000060AF823E40000000E0DB32494000000000C9823E4000000000E132494000000060DD823E40000000E0EC324940000000C011833E40000000E0F1324940000000E02D833E400000008001334940000000009D833E40000000400C33494000000020FA833E4000000060043349400000004003843E40000000E0DD3249400000008034843E4000000020D7324940000000003F843E4000000020C4324940000000C06C843E40
645	52	366	367	2	384.985004284865852	00:00:27.71892	0102000020E61000000700000000000020C33249400000006066843E4000000020C4324940000000C06C843E4000000060A432494000000080AE843E40000000609532494000000080CE843E40000000408E32494000000060E0843E4000000000803249400000002014853E40000000807C3249400000008021853E40
646	52	367	368	3	380.431400416597569	00:00:27.391061	0102000020E610000005000000000000407B324940000000001E853E40000000807C3249400000008021853E40000000C057324940000000E096853E400000002047324940000000A0CC853E40000000C03F32494000000020E3853E40
647	52	368	369	4	487.762132004004627	00:00:35.118874	0102000020E610000005000000000000803E324940000000A0DF853E40000000C03F32494000000020E3853E40000000C029324940000000E029863E40000000A005324940000000009A863E4000000040F131494000000020DC863E40
762	59	\N	478	0	0	00:00:00	\N
648	52	369	370	5	1100.67234394170782	00:01:19.248409	0102000020E61000001300000000000080F031494000000020D6863E4000000040F131494000000020DC863E40000000A0EA31494000000040ED863E4000000020E831494000000020D6863E40000000E0E431494000000060BA863E40000000A0E031494000000000A7863E4000000080D8314940000000C082863E4000000000C7314940000000E03C863E4000000040C3314940000000401E863E40000000C0C031494000000060FB853E4000000040C031494000000080DD853E4000000060C33149400000008095853E4000000040C3314940000000007F853E4000000080C03149400000008056853E4000000020BC314940000000A031853E40000000E0B63149400000000012853E40000000E0AE31494000000080EE843E40000000E0A531494000000040CA843E40000000209C3149400000004096843E40
649	52	370	371	6	1026.21064895898598	00:01:13.887167	0102000020E610000016000000000000A09D3149400000002094843E40000000209C3149400000004096843E4000000020993149400000008080843E40000000C091314940000000203B843E40000000808D314940000000E015843E40000000E088314940000000C0EC833E40000000E081314940000000C0CB833E40000000007F314940000000E0B4833E40000000207F31494000000060A4833E400000004081314940000000C091833E4000000080843149400000006083833E4000000040913149400000008067833E40000000409E314940000000004A833E4000000080A2314940000000E033833E40000000A0A33149400000000023833E4000000000A3314940000000400D833E40000000E09F31494000000000F7823E40000000C09431494000000060CF823E40000000008D31494000000080B8823E400000004085314940000000209E823E400000006082314940000000C07E823E400000000081314940000000E060823E40
650	52	371	372	7	613.090108534948968	00:00:44.142488	0102000020E61000000C0000000000000083314940000000E05F823E400000000081314940000000E060823E400000004080314940000000E04C823E40000000C07F314940000000202B823E40000000207C3149400000006010823E40000000607631494000000020F1813E40000000806E31494000000000D4813E40000000A06831494000000060C1813E40000000404D3149400000006081813E400000006033314940000000804A813E40000000002D3149400000004038813E40000000C025314940000000202A813E40
651	52	372	373	8	453.386559211281792	00:00:32.643832	0102000020E61000000700000000000060263149400000004026813E40000000C025314940000000202A813E40000000401B314940000000C01C813E400000000019314940000000C016813E40000000E017314940000000E00A813E40000000001731494000000020A8803E400000004016314940000000602D803E40
652	52	373	374	9	681.287791624998363	00:00:49.052721	0102000020E610000006000000000000E017314940000000602D803E400000004016314940000000602D803E40000000401431494000000000C67F3E40000000C012314940000000A08B7F3E40000000000E31494000000020E07E3E40000000800C314940000000009F7E3E40
653	52	374	375	10	542.64172393397439	00:00:39.070204	0102000020E610000007000000000000600E314940000000609E7E3E40000000800C314940000000009F7E3E400000002007314940000000A0EF7D3E40000000A005314940000000C0B77D3E400000000005314940000000C08A7D3E400000008004314940000000E07A7D3E40000000400631494000000000637D3E40
654	52	375	376	11	582.669323821952162	00:00:41.952191	0102000020E610000008000000000000E00731494000000000647D3E40000000400631494000000000637D3E40000000C01331494000000080C47C3E40000000C018314940000000E0A57C3E40000000001D314940000000A09A7C3E40000000A036314940000000A0677C3E400000004033314940000000C0577C3E40000000202A314940000000A0277C3E40
655	52	376	377	12	342.183771063433312	00:00:24.637232	0102000020E610000005000000000000A02B314940F2FFFFFF237C3E40000000202A314940000000A0277C3E40000000E01A314940000000A0DA7B3E40000000E008314940000000E07E7B3E400000002005314940000000006D7B3E40
656	52	377	378	13	684.64600772322342	00:00:49.294513	0102000020E610000008000000FAFFFF1F07314940F8FFFF3F697B3E400000002005314940000000006D7B3E4000000000F030494000000020037B3E40000000A0E9304940000000A0DE7A3E40000000E0DB30494000000060917A3E4000000000CC304940000000C0377A3E4000000000C7304940000000E0137A3E4000000060C0304940000000C0F0793E40
657	52	378	379	14	676.037714296989179	00:00:48.674715	0102000020E610000007000000000000E0C130494000000040EE793E4000000060C0304940000000C0F0793E4000000020A83049400000008078793E40000000809F304940000000004E793E40000000208B30494000000080F7783E40000000007930494000000040AD783E40000000E06C3049400000006081783E40
658	53	\N	380	0	0	00:00:00	\N
659	53	380	381	1	551.450072738501376	00:00:39.704405	0102000020E61000000B00000004000000B734494000000080AE683E40FDFFFFBFB534494000000060B2683E4001000020A5344940000000007E683E40030000409E3449400000004069683E400600004099344940000000205A683E40F9FFFF5F96344940000000C04B683E400200008091344940000000A02F683E400000006090344940000000C01F683E40000000608C34494000000000CB673E40030000A08A344940000000A0AA673E4001000020893449400000004081673E40
660	53	381	382	2	543.699674915923083	00:00:39.146377	0102000020E61000000A000000FFFFFFDF8A344940000000E080673E4001000020893449400000004081673E40FEFFFF1F863449400000002025673E400500008084344940000000600B673E40070000A081344940000000A0E9663E40FAFFFF1F7F344940000000C0D8663E40040000607B344940000000A0C9663E40060000407134494000000020B1663E40FDFFFFBF61344940000000608A663E40020000E06D3449400000008058663E40
661	53	382	383	3	436.665099947092699	00:00:31.439887	0102000020E610000007000000040000006F344940000000605C663E40020000E06D3449400000008058663E40FBFFFF7F7F344940000000E018663E40060000409134494000000060E8653E40FBFFFF7FA734494000000080B2653E40FDFFFFBFAD344940000000E0A5653E40040000C0BF3449400000000089653E40
662	53	383	384	4	315.375660621334987	00:00:22.707048	0102000020E61000000A000000FCFFFF3FC0344940000000408D653E40040000C0BF3449400000000089653E40F9FFFF5FC6344940000000207E653E40F9FFFFFFD1344940000000006F653E40020000E0DD3449400000004060653E40FAFFFFBFEE344940000000604F653E40FAFFFF1FFF344940000000403F653E40030000A00A3549400000004032653E4004000000133549400000000027653E4007000000163549400000000022653E40
663	53	384	385	5	850.686064857980796	00:01:01.249397	0102000020E610000016000000FEFFFF7F163549400000000027653E4007000000163549400000000022653E40020000E01D354940000000C014653E400100002025354940000000E004653E40030000402A354940000000E0F8643E40000000A02F354940000000C0E8643E40020000803535494000000060D4643E40000000A03B35494000000060BA643E40FCFFFF3F4035494000000060A1643E40070000A045354940000000607A643E40070000A04D354940000000A039643E40FCFFFF9F503549400000002022643E40FCFFFF3F5835494000000040EA633E40030000A06235494000000040F7633E400500002068354940000000E0FC633E40060000406D354940000000A0F9633E40020000E071354940000000A0F2633E40010000C07435494000000000E7633E40FEFFFF1F7A35494000000020BB633E40FEFFFF7F7A35494000000000A6633E4000000000783549400000000093633E400100002075354940000000608D633E40
664	53	385	386	6	882.872829116844855	00:01:03.566844	0102000020E61000000B00000007000000763549400000008088633E400100002075354940000000608D633E40FBFFFF7F633549400000004071633E40FEFFFF1F763549400000002020633E40FCFFFFFF8035494000000000F1623E400000000094354940000000609E623E40070000A0A53549400000000051623E4006000040AD354940000000A02F623E4004000060B7354940000000E008623E4001000020C535494000000080D4613E4005000080CC354940000000A0BB613E40
665	53	386	387	7	490.193178966253925	00:00:35.293909	0102000020E610000005000000070000A0CD35494000000020BF613E4005000080CC354940000000A0BB613E40F9FFFF5FEA354940000000805A613E40040000600736494000000020FE603E40030000A01A364940000000A0C0603E40
666	53	387	388	8	663.40579793390998	00:00:47.765217	0102000020E61000000D000000040000C01B36494000000060C3603E40030000A01A364940000000A0C0603E40040000C0273649400000002098603E40FCFFFF3F443649400000004046603E40F9FFFFFF493649400000000035603E40F9FFFF5F6636494000000000FC5F3E40070000A07136494000000080E55F3E40000000007836494000000020DD5F3E40010000208136494000000060D55F3E40070000008636494000000000D45F3E40030000A08A36494000000020D65F3E40FFFFFFDF9A36494000000060FB5F3E40070000009E3649400000000015603E40
667	53	388	389	9	618.168261137823151	00:00:44.508115	0102000020E610000004000000060000E09C3649400000006016603E40070000009E3649400000000015603E40FEFFFF1FB6364940000000E0D3603E40FAFFFFBFCA364940000000A076613E40
668	53	389	390	10	785.559564829438614	00:00:56.560289	0102000020E61000001300000006000040C93649400000002078613E40FAFFFFBFCA364940000000A076613E40040000C0DF364940000000201A623E40020000E0E53649400000004049623E40FBFFFFDFE7364940000000005E623E4000000000E8364940000000E06D623E40030000A0E6364940000000E081623E40060000E0E4364940000000C092623E40060000E0E4364940000000E0A2623E40F9FFFF5FE6364940000000A0AF623E40070000A0E936494000000060BF623E40FDFFFF5FED36494000000000CB623E40FFFFFFDFEE36494000000000CC623E40F9FFFFFFF1364940000000E0CE623E4003000040F6364940000000C0D8623E40020000E0F936494000000060E5623E4001000020FD36494000000020FA623E4005000080003749400000000012633E400500002004374940000000E02E633E40
669	53	390	391	11	582.048957636022465	00:00:41.907525	0102000020E610000006000000FAFFFFBF023749400000004030633E400500002004374940000000E02E633E40FDFFFF5F0D374940000000A078633E40030000401637494000000040BE633E4005000080203749400000004011643E40FEFFFF1F2E374940000000607B643E40
670	53	391	392	12	1360.72098694528972	00:01:37.971911	0102000020E61000000B000000010000C02C374940000000207D643E40FEFFFF1F2E374940000000607B643E40FAFFFFBF3A37494000000060E1643E400600004045374940000000A033653E40FFFFFFDF4E374940000000A07F653E40FCFFFFFF5837494000000020D1653E40030000A066374940000000003C663E40FAFFFF1F7737494000000000BC663E40FBFFFF7F833749400000008019673E40FFFFFF3F8F374940000000A06F673E4003000040923749400000008087673E40
671	53	392	254	13	1422.97523347798892	00:01:42.454217	0102000020E61000001C000000060000E090374940000000E088673E4003000040923749400000008087673E4005000080A0374940000000C0F1673E40F9FFFF5FAE374940000000605F683E40FFFFFFDFBA374940000000E0C3683E40FAFFFFBFC23749400000002001693E40FEFFFF1FC2374940000000200E693E40FCFFFF3FC0374940000000401E693E40FDFFFFBFBD374940000000602C693E40000000A0B7374940000000203B693E4007000000AE3749400000000045693E40FDFFFFBF9D374940000000205B693E40020000E095374940000000406B693E40FBFFFF7F8B3749400000008076693E400500008088374940000000407D693E40FCFFFF3F883749400000000087693E40060000E0883749400000008090693E40050000208C3749400000008095693E40FBFFFF7F8F3749400000008095693E400400006097374940000000408B693E40040000009F374940000000A07E693E40F9FFFF5FA63749400000000073693E40FBFFFFDFBB3749400000004058693E40000000A0CB374940000000A044693E40FBFFFF7FD3374940000000003A693E4000000060F03749400000008016693E40FCFFFF9FFC3749400000002007693E4004000000033849400000002002693E40
672	53	254	393	14	268.424177936135663	00:00:19.326541	0102000020E610000007000000FBFFFF7F033849400000008008693E4004000000033849400000002002693E40F9FFFF5F0A38494000000060F8683E40FBFFFF7F0F38494000000020EE683E40FBFFFFDF1338494000000000E6683E40FCFFFF9F2438494000000040D1683E40050000204838494000000000A5683E40
673	53	393	394	15	555.512965365113587	00:00:39.996934	0102000020E610000010000000050000804838494000000040AA683E40050000204838494000000000A5683E40020000E059384940000000E08E683E40FEFFFF1F66384940000000C080683E40FBFFFF7F6B384940000000807B683E40010000C074384940000000A076683E40070000007E3849400000006073683E40F9FFFF5F8A3849400000006073683E40F9FFFFFF913849400000004076683E40040000C09B384940000000407C683E40FAFFFFBFA63849400000002088683E40F9FFFFFFB13849400000006099683E40FCFFFF9FBC38494000000080AF683E40FCFFFF9FC838494000000040D1683E40060000E0D038494000000040F0683E40000000A0D338494000000020FB683E40
674	53	394	395	16	457.573162051536428	00:00:32.945268	0102000020E61000000500000003000040D238494000000000FE683E40000000A0D338494000000020FB683E40FFFFFFDFD6384940000000000C693E40FAFFFFBFE23849400000006066693E40FEFFFF1FF638494000000040FE693E40
676	53	396	397	18	398.317603885222354	00:00:28.678867	0102000020E610000006000000040000003B394940000000409A6B3E40030000A03A39494000000000966B3E40030000A05E394940000000C0686B3E40040000C08739494000000040346B3E40FFFFFF3F9739494000000000216B3E40FEFFFF7FA6394940000000000E6B3E40
677	53	397	398	19	429.749494866056239	00:00:30.941964	0102000020E61000000A000000FFFFFFDFA639494000000040126B3E40FEFFFF7FA6394940000000000E6B3E40000000A0BF39494000000060EE6A3E40FBFFFF7FCB39494000000060E16A3E40FCFFFF3FD439494000000060DB6A3E40FCFFFFFFDC394940000000E0D76A3E40FEFFFF7FEA394940000000C0D66A3E4004000060033A494000000040DA6A3E4004000000233A4940000000E0DD6A3E40070000A02D3A494000000080DD6A3E40
678	53	398	399	20	501.934218917899216	00:00:36.139264	0102000020E61000000B000000020000802D3A494000000060E16A3E40070000A02D3A494000000080DD6A3E40FCFFFF3F4C3A494000000020DD6A3E40FEFFFF7F5A3A4940000000E0DD6A3E4001000020613A4940000000A0DF6A3E40040000C0673A4940000000C0E36A3E40010000C06C3A494000000000E86A3E4006000040853A494000000020246B3E40FAFFFFBF8E3A494000000020436B3E40040000C0973A494000000040676B3E40FFFFFFDF9E3A494000000040866B3E40
679	53	399	400	21	1084.26141373992778	00:01:18.066822	0102000020E61000000E000000060000E09C3A4940000000E08A6B3E40FFFFFFDF9E3A494000000040866B3E4003000040A23A494000000020976B3E4005000020A83A4940000000E0B86B3E40020000E0A93A494000000080C66B3E40040000C0AB3A4940000000C0D46B3E40000000A0AF3A494000000080FB6B3E40060000E0B83A4940000000803D6C3E40FDFFFFBFC53A494000000060996C3E40FFFFFF3FD33A494000000060FA6C3E40030000A0E23A4940000000406B6D3E4000000000E83A494000000020896D3E40FDFFFF5FF13A4940000000C0C86D3E40030000A0F63A4940000000E0EC6D3E40
680	53	400	401	22	836.45404007812283	00:01:00.224691	0102000020E61000000A000000FDFFFF5FF53A4940000000E0EE6D3E40030000A0F63A4940000000E0EC6D3E40FDFFFF5F093B4940000000E06B6E3E40F9FFFF5F0E3B4940000000A08E6E3E40040000C0133B4940000000C0BC6E3E40FFFFFFDF163B494000000080E06E3E4005000080183B4940000000E0F36E3E40020000E01D3B4940000000405A6F3E4004000060233B494000000000B66F3E40060000E0243B494000000040CF6F3E40
681	53	401	402	23	620.298818315913195	00:00:44.661515	0102000020E61000000500000004000060233B4940000000C0CF6F3E40060000E0243B494000000040CF6F3E40010000C02C3B4940000000A05D703E4000000000343B4940000000C0E5703E4005000080383B4940000000A038713E40
682	53	402	403	24	1007.05301565050536	00:01:12.507817	0102000020E61000000800000004000000373B4940000000E039713E4005000080383B4940000000A038713E40F9FFFFFF393B4940000000C054713E40000000003C3B4940000000A0B7713E40060000E03C3B494000000020F5713E40FFFFFF3F3F3B49400000006087723E4006000040413B4940000000403A733E4006000040413B49400000000087733E40
683	53	403	404	25	455.381816627178921	00:00:32.787491	0102000020E610000005000000040000C03F3B4940000000C086733E4006000040413B49400000000087733E40F9FFFF5F423B4940000000A00E743E40FFFFFF3F433B49400000008052743E4000000000443B4940000000C090743E40
684	53	404	405	26	560.129814244469912	00:00:40.329347	0102000020E610000006000000030000A0423B49400000004091743E4000000000443B4940000000C090743E4001000020453B49400000000024753E40070000A0453B49400000000076753E40FCFFFFFF443B4940000000C09F753E40000000A0433B494000000060D8753E40
685	53	405	406	27	559.761566399966682	00:00:40.302833	0102000020E61000000500000003000040423B494000000080D7753E40000000A0433B494000000060D8753E4005000020403B49400000008035763E40010000C0383B494000000080BB763E4000000000343B4940000000A01E773E40
686	53	406	407	28	971.863857867128331	00:01:09.974198	0102000020E610000009000000030000A0323B4940000000201E773E4000000000343B4940000000A01E773E40FDFFFFBF313B49400000002055773E40070000002E3B4940000000A0A4773E40F9FFFF5F2A3B49400000004031783E40FFFFFFDF263B494000000080B7783E40FBFFFF7F233B49400000008037793E40FFFFFFDF223B4940000000804C793E4002000080293B4940000000E04E793E40
687	53	407	408	29	290.252931588942033	00:00:20.898211	0102000020E610000006000000FDFFFF5F293B4940000000A053793E4002000080293B4940000000E04E793E40040000C0573B4940000000E05B793E40FDFFFFBF653B49400000002061793E40F9FFFFFF693B49400000008068793E40FAFFFFBF623B49400000006099793E40
688	53	408	409	30	663.758798464387382	00:00:47.790633	0102000020E61000000C00000002000080613B49400000004097793E40FAFFFFBF623B49400000006099793E40FFFFFF3F4F3B4940000000001F7A3E40FAFFFF1F3F3B4940000000A08C7A3E40FCFFFFFF3C3B4940000000A0977A3E40FEFFFF1F2E3B4940000000C0D57A3E4005000020283B494000000060F07A3E4002000080253B494000000040EE7A3E40FEFFFF7F223B4940000000E0ED7A3E40040000C01F3B4940000000C0F27A3E40FFFFFFDF1E3B494000000080F97A3E40FFFFFF3F1F3B494000000080FF7A3E40
689	54	\N	410	0	0	00:00:00	\N
690	54	410	411	1	896.682573380848908	00:01:04.561145	0102000020E61000000B000000070000001E3B49400B000000017B3E40FFFFFF3F1F3B494009000080FF7A3E4005000020203B4940FEFFFF1F067B3E40F9FFFFFF213B4940040000000B7B3E40070000A01D3B4940FCFFFFFF1C7B3E40030000A0163B4940F6FFFF5F177B3E40FFFFFF3F173B4940030000A0027B3E40000000A0173B4940FAFFFF1FF37A3E40FDFFFFBF1D3B4940F6FFFF5F177A3E40F9FFFFFF213B49400C00008072793E40FBFFFF7F233B49400900008037793E40
691	54	411	412	2	825.465312130852794	00:00:59.433502	0102000020E61000000600000002000080253B49400800002037793E40FBFFFF7F233B49400900008037793E40FFFFFFDF263B494009000080B7783E40F9FFFF5F2A3B4940F8FFFF3F31783E40070000002E3B4940FCFFFF9FA4773E40FDFFFFBF313B4940F3FFFF1F55773E40
692	54	412	413	3	748.970128939853794	00:00:53.925849	0102000020E610000007000000FFFFFF3F333B49400700000056773E40FDFFFFBF313B4940F3FFFF1F55773E4000000000343B4940F5FFFF9F1E773E40010000C0383B4940FBFFFF7FBB763E4005000020403B4940F4FFFF7F35763E40000000A0433B494000000060D8753E40FCFFFFFF443B4940F6FFFFBF9F753E40
693	54	413	414	4	570.375079496515809	00:00:41.067006	0102000020E610000006000000FEFFFF7F463B49400B000000A1753E40FCFFFFFF443B4940F6FFFFBF9F753E40070000A0453B49400700000076753E4001000020453B4940F2FFFFFF23753E4000000000443B4940010000C090743E40FFFFFF3F433B49400C00008052743E40
694	54	414	415	5	350.159485367406944	00:00:25.211483	0102000020E610000004000000060000E0443B4940F9FFFFFF51743E40FFFFFF3F433B49400C00008052743E40F9FFFF5F423B4940F5FFFF9F0E743E4006000040413B4940F5FFFFFF86733E40
695	54	415	416	6	1008.56983128507886	00:01:12.617028	0102000020E61000000A000000FAFFFFBF423B49400700006086733E4006000040413B4940F5FFFFFF86733E4006000040413B4940030000403A733E4002000080453B4940F2FFFF5FFC723E4000000000443B49400D000040B3723E40020000E0413B49400D0000E022723E4001000020413B4940F8FFFF3FF1713E40000000003C3B4940000000A0B7713E40F9FFFFFF393B4940F3FFFFBF54713E4005000080383B49400A0000A038713E40
696	54	416	417	7	664.358903002246734	00:00:47.833841	0102000020E610000006000000030000403A3B49400900008037713E4005000080383B49400A0000A038713E4000000000343B4940FDFFFFBFE5703E40010000C02C3B4940070000A05D703E40060000E0243B4940FFFFFF3FCF6F3E4004000060233B494007000000B66F3E40
697	54	417	418	8	856.793875121012093	00:01:01.689159	0102000020E61000000A000000FCFFFFFF243B4940F3FFFFBFB46F3E4004000060233B494007000000B66F3E40020000E01D3B4940030000405A6F3E4005000080183B4940FBFFFFDFF36E3E40FFFFFFDF163B4940F7FFFF7FE06E3E40040000C0133B4940F3FFFFBFBC6E3E40F9FFFF5F0E3B4940F5FFFF9F8E6E3E40FDFFFF5F093B4940FBFFFFDF6B6E3E40030000A0F63A4940060000E0EC6D3E40FDFFFF5FF13A4940010000C0C86D3E40
698	54	418	419	9	1021.87786066701301	00:01:13.575206	0102000020E61000001500000004000000F33A494007000060C66D3E40FDFFFF5FF13A4940010000C0C86D3E4000000000E83A494001000020896D3E40FDFFFF5FE53A494002000080696D3E40010000C0E43A4940FDFFFF5F556D3E40FBFFFFDFE33A4940040000003B6D3E40FAFFFFBFE23A4940000000A01F6D3E40FAFFFFBFDE3A4940FDFFFF5FF56C3E40FFFFFFDFD23A4940060000E0A46C3E40FCFFFFFFC83A4940F2FFFF5F646C3E40040000C0C73A4940FDFFFFBF5D6C3E40FCFFFF9FC03A4940FFFFFFDF466C3E40060000E0BC3A4940F7FFFF1F386C3E40FEFFFF1FBA3A4940F9FFFFFF296C3E40FFFFFF3FB73A4940F6FFFF5F176C3E40FAFFFFBFB23A494008000020F76B3E40FAFFFF1FAF3A4940040000C0E36B3E40020000E0A93A4940FEFFFF7FC66B3E4005000020A83A4940F8FFFFDFB86B3E4003000040A23A494008000020976B3E40FFFFFFDF9E3A4940F5FFFF3F866B3E40
699	54	419	420	10	536.357441630501967	00:00:38.617736	0102000020E61000000C000000FCFFFF9FA03A4940F8FFFF3F816B3E40FFFFFFDF9E3A4940F5FFFF3F866B3E40040000C0973A4940FFFFFF3F676B3E40FAFFFFBF8E3A4940FAFFFF1F436B3E4006000040853A494005000020246B3E40010000C06C3A494000000000E86A3E40040000C0673A4940040000C0E36A3E4001000020613A4940000000A0DF6A3E40FEFFFF7F5A3A4940F4FFFFDFDD6A3E40FCFFFF3F4C3A4940F3FFFF1FDD6A3E40070000A02D3A4940F4FFFF7FDD6A3E4004000000233A4940F4FFFFDFDD6A3E40
700	54	420	421	11	454.26463715665011	00:00:32.707054	0102000020E61000000A000000FFFFFFDF223A4940F8FFFF3FD96A3E4004000000233A4940F4FFFFDFDD6A3E4004000060033A494003000040DA6A3E40FEFFFF7FEA394940080000C0D66A3E40FCFFFFFFDC394940090000E0D76A3E40FCFFFF3FD439494004000060DB6A3E40FBFFFF7FCB3949400B000060E16A3E40000000A0BF39494007000060EE6A3E40FEFFFF7FA6394940070000000E6B3E40FFFFFF3F973949400B000000216B3E40
701	54	421	422	12	344.580168241575961	00:00:24.809772	0102000020E610000005000000FAFFFFBF963949400E0000001C6B3E40FFFFFF3F973949400B000000216B3E40040000C087394940FCFFFF3F346B3E40030000A05E394940010000C0686B3E40030000A03A39494007000000966B3E40
702	54	422	267	13	799.419133743080238	00:00:57.558178	0102000020E610000009000000FEFFFF1F3A394940020000E0916B3E40030000A03A39494007000000966B3E40FAFFFF1F33394940090000809F6B3E40FEFFFF7F2E394940F3FFFFBF7C6B3E40010000202539494008000020376B3E40070000A0193949400A000040E06A3E40030000A00A394940080000C06E6A3E4007000000FE384940070000600E6A3E40FDFFFF5FF9384940F6FFFFBFE7693E40
703	54	267	268	14	327.342906283661023	00:00:23.568689	0102000020E610000004000000FFFFFFDFFA38494007000060E6693E40FDFFFF5FF9384940F6FFFFBFE7693E40010000C0EC384940FCFFFF9F84693E40020000E0E1384940FEFFFF1F2E693E40
704	54	268	269	15	714.931427125345749	00:00:51.475063	0102000020E610000012000000040000C0E33849400D0000402B693E40020000E0E1384940FEFFFF1F2E693E4005000020DC384940FCFFFFFF04693E4005000020D838494004000000EB683E40F9FFFF5FCE384940FCFFFF3FC4683E40FDFFFF5FC5384940F7FFFF7FA8683E40040000C0B7384940040000008B683E40FEFFFF1FB23849400000006080683E4000000000A8384940060000E074683E40010000209D384940F8FFFFDF68683E40030000A096384940FCFFFFFF64683E40FCFFFF9F8C3849400C00008062683E40F9FFFF5F82384940010000C060683E40FBFFFF7F77384940F2FFFFFF63683E40010000206D384940F7FFFF7F68683E400000006064384940090000E06F683E40010000C04C3849400E0000008C683E40000000A03F384940FBFFFFDF9B683E40
705	54	269	423	16	331.46065050792879	00:00:23.865167	0102000020E610000008000000FFFFFF3F3F384940FFFFFFDF96683E40000000A03F384940FBFFFFDF9B683E40FDFFFFBF2138494001000020C1683E40010000200D3849400B0000C0D9683E4004000000FF37494002000080E9683E40FDFFFFBFF9374940030000A0EA683E40FEFFFF7FF6374940F3FFFF1FED683E4000000000E4374940FBFFFFDF03693E40
706	54	423	424	17	1272.42071635476805	00:01:31.614292	0102000020E61000000F000000000000A0E3374940F5FFFF9FFE683E4000000000E4374940FBFFFFDF03693E40FCFFFFFFDC374940F3FFFFBF0C693E4005000080D8374940FDFFFFBF0D693E40FCFFFF9FD43749400E0000000C693E40FBFFFFDFCF374940FCFFFF3F04693E40000000A0CB374940F9FFFF5FFA683E40FDFFFFBFC9374940F4FFFF7FF5683E40FFFFFF3FBF37494009000080A7683E4004000000AB374940FEFFFF1F0E683E40FBFFFFDF9F37494002000080B9673E400300004092374940FAFFFFBF52673E40010000C088374940F9FFFF5F0A673E40FFFFFFDF7A374940FEFFFF1F9E663E40FEFFFF1F72374940F8FFFFDF58663E40
707	54	424	425	18	615.51644591980596	00:00:44.317184	0102000020E610000005000000FCFFFF3F743749400700006056663E40FEFFFF1F72374940F8FFFFDF58663E40FEFFFF1F66374940F6FFFFBFF7653E400400000057374940000000A07F653E400300004046374940030000A0FA643E40
708	54	425	426	19	598.032296491286161	00:00:43.058325	0102000020E610000006000000040000C047374940F8FFFFDFF8643E400300004046374940030000A0FA643E400500008038374940080000C08E643E40FDFFFFBF2D3749400B00000039643E40010000202137494004000000D3633E40FFFFFF3F1B37494006000040A5633E40
709	54	426	427	20	992.467116747312389	00:01:11.457632	0102000020E61000001B000000060000E01C374940FBFFFF7FA3633E40FFFFFF3F1B37494006000040A5633E40050000800C374940090000E02F633E40000000A00337494007000060E6623E40FEFFFF1F02374940F4FFFFDFD5623E40FDFFFFBF01374940010000C0C0623E40F9FFFFFF01374940F8FFFF3FB9623E40FBFFFFDF0337494007000060AE623E40010000C004374940040000609B623E40FCFFFF3F04374940FCFFFF3F8C623E40F9FFFF5F023749400A0000A080623E4000000000003749400E0000A073623E4004000000FF364940FEFFFF7F6E623E40F9FFFF5FFE364940F3FFFF1F6D623E4002000080F9364940FEFFFF1F66623E40020000E0F1364940F9FFFF9F69623E4004000060EB364940F9FFFFFF71623E40030000A0E6364940020000E081623E40FAFFFF1FE3364940F3FFFFBF8C623E4004000000DF364940FFFFFF3F97623E40020000E0D9364940080000C09E623E40FFFFFF3FD33649400D000040A3623E4005000080CC364940F2FFFF5FA4623E40070000A0C53649400D0000E0A2623E40FBFFFF7FB33649400600004095623E40FAFFFFBF923649400B00006079623E40FBFFFFDF7F364940F8FFFFDF68623E40
710	54	427	428	21	904.922687766259742	00:01:05.154434	0102000020E61000000C000000FCFFFF3F803649400D00004063623E40FBFFFFDF7F364940F8FFFFDF68623E40000000A0673649400600004055623E40040000004F364940080000203F623E4005000020303649400400000023623E40FCFFFF3F283649400000006018623E40FCFFFF3F203649400800002007623E40FAFFFFBF12364940FCFFFF9FDC613E40FFFFFFDFFA354940FAFFFFBF92613E40F9FFFF5FEA3549400C0000805A613E4005000080CC3549400E0000A0BB613E4001000020C535494005000080D4613E40
711	54	428	429	22	615.456094093489128	00:00:44.312839	0102000020E610000008000000FBFFFFDFC33549400B000000D1613E4001000020C535494005000080D4613E4004000060B7354940F8FFFFDF08623E4006000040AD354940000000A02F623E40070000A0A53549400B00000051623E400000000094354940070000609E623E40FCFFFFFF803549400B000000F1623E40FEFFFF1F76354940F7FFFF1F20633E40
712	54	429	430	23	931.062180335599237	00:01:07.036477	0102000020E61000000E000000060000E074354940060000401D633E40FEFFFF1F76354940F7FFFF1F20633E40FBFFFF7F63354940F8FFFF3F71633E40050000205835494007000060A6633E400000006054354940FBFFFF7FBB633E40000000A04F354940FAFFFF1FDB633E400000006044354940040000C033643E40FEFFFF7F3A3549400C00008082643E40FFFFFF3F33354940FCFFFF3FA4643E40040000002B354940FBFFFFDFC3643E40070000A02135494000000000E0643E40F9FFFF5F16354940F3FFFF1FFD643E40FCFFFF9F103549400200008009653E4004000060073549400900008017653E40
713	54	430	431	24	468.027076532614103	00:00:33.69795	0102000020E61000000A000000FFFFFFDF063549400300004012653E4004000060073549400900008017653E40030000A0F6344940010000C028653E4006000040E5344940F8FFFFDF38653E40FCFFFF9FD8344940F5FFFFFF46653E40FDFFFF5FC9344940F7FFFF7F58653E40070000A0B9344940080000C06E653E40FFFFFF3FAF344940FFFFFFDF7E653E4003000040A6344940F7FFFF7F90653E40FCFFFF9F90344940FAFFFFBFC2653E40
714	54	431	432	25	480.682790094774646	00:00:34.609161	0102000020E610000008000000FBFFFFDF8F344940FEFFFF1FBE653E40FCFFFF9F90344940FAFFFFBFC2653E40FFFFFF3F83344940060000E0E4653E40FDFFFF5F75344940060000400D663E40060000E068344940F7FFFF7F38663E40070000005E344940F8FFFF3F61663E40060000E0543449400B00000089663E40FFFFFFDF4A344940FCFFFF9FBC663E40
715	54	432	433	26	1073.94286180240829	00:01:17.323886	0102000020E61000000F000000020000E049344940020000E0B9663E40FFFFFFDF4A344940FCFFFF9FBC663E4004000060433449400B000060E9663E40060000E03C3449400700000016673E4005000080343449400600004055673E40000000602C34494002000080A1673E40FFFFFFDF2A3449400A000040B0673E40000000603434494002000080B9673E40FAFFFF1F37344940FCFFFF3F9C673E40060000403D3449400400006063673E40FEFFFF1F463449400E0000A01B673E40F9FFFF5F4E3449400A000040E8663E400500008058344940FAFFFF1FB3663E40FDFFFFBF61344940F9FFFF5F8A663E40060000407134494001000020B1663E40
716	54	433	434	27	446.730752629084122	00:00:32.164614	0102000020E610000009000000050000207034494007000060B6663E40060000407134494001000020B1663E40040000607B344940F9FFFF9FC9663E40FAFFFF1F7F344940010000C0D8663E40070000A081344940F9FFFF9FE9663E400500008084344940040000600B673E40FEFFFF1F86344940F3FFFF1F25673E400100002089344940F8FFFF3F81673E40030000A08A344940030000A0AA673E40
717	54	434	435	28	509.575906151999448	00:00:36.689465	0102000020E61000000B0000000100002089344940040000C0AB673E40030000A08A344940030000A0AA673E40000000608C34494004000000CB673E400000006090344940F6FFFFBF1F683E400200008091344940000000A02F683E40F9FFFF5F96344940040000C04B683E4006000040993449400C0000205A683E40030000409E344940F8FFFF3F69683E4001000020A5344940070000007E683E40FDFFFFBFB5344940F9FFFF5FB2683E40FFFFFFDFBA3449400C000080C2683E40
718	55	\N	436	0	0	00:00:00	\N
719	55	436	437	1	1524.09937158800676	00:01:49.735155	0102000020E61000000F000000040000C09B3B494000000040FAA43E40FCFFFFFF9C3B4940000000C0F7A43E4001000020A13B4940000000A015A53E40000000A0AB3B4940000000401CA53E40FBFFFF7FB33B4940000000C01FA53E40F9FFFF5FBA3B4940000000C01FA53E4005000020D03B494000000040BCA53E40070000A0E53B4940000000E05BA63E4006000040F93B494000000060EDA63E40010000200D3C4940000000407DA73E40FBFFFF7F133C4940000000E0A4A73E40FCFFFFFF183C494000000020BBA73E40F9FFFF5F323C4940000000A013A83E40FBFFFFDF373C4940000000E02AA83E4006000040393C4940000000A032A83E40
720	55	437	438	2	972.145160894918604	00:01:09.994452	0102000020E61000000F000000040000C0373C49400000002036A83E4006000040393C4940000000A032A83E40FEFFFF1F3E3C49400000004051A83E40030000A0423C4940000000C07CA83E4000000060443C4940000000209EA83E40FDFFFF5F453C494000000040CCA83E40030000A0463C494000000020F1A83E4000000060483C4940000000A00CA93E40040000004B3C49400000004026A93E4004000000533C49400000004061A93E40040000605B3C4940000000609CA93E4005000020643C494000000080D9A93E40010000C06C3C4940000000E019AA3E40010000C0583C4940000000E033AA3E40000000605C3C49400000000050AA3E40
721	55	438	439	3	600.628547496192482	00:00:43.245255	0102000020E610000006000000FAFFFF1F5B3C49400000002052AA3E40000000605C3C49400000000050AA3E4002000080713C494000000060E5AA3E4005000020783C4940000000E013AB3E4004000060873C4940000000C085AB3E40040000C08B3C494000000060A5AB3E40
722	55	439	440	4	573.214218943155743	00:00:41.271424	0102000020E61000000A000000030000408A3C4940000000C0A6AB3E40040000C08B3C494000000060A5AB3E4007000000963C494000000000F1AB3E40040000009F3C494000000040E4AB3E40FDFFFFBFA93C494000000080D5AB3E40FAFFFF1FBF3C4940000000A0B7AB3E4000000000E03C4940000000A08AAB3E4005000080F43C4940000000206EAB3E40F9FFFF5F063D4940000000805AAB3E40FCFFFF3F0C3D4940000000E053AB3E40
723	55	440	441	5	413.397980304169209	00:00:29.764655	0102000020E610000007000000000000600C3D4940000000A057AB3E40FCFFFF3F0C3D4940000000E053AB3E40FFFFFFDF123D4940000000A050AB3E40000000A01B3D4940000000E04EAB3E40FDFFFFBF3D3D4940000000804EAB3E40FAFFFFBF6A3D4940000000404FAB3E4004000060973D4940000000A04FAB3E40
724	55	441	442	6	437.805569553907787	00:00:31.522001	0102000020E610000006000000FFFFFF3F973D49400000002054AB3E4004000060973D4940000000A04FAB3E40FBFFFFDFBF3D49400000004050AB3E40FDFFFF5FE93D4940000000A050AB3E40FEFFFF1F163E4940000000A050AB3E40FAFFFFBF2A3E49400000004050AB3E40
725	56	\N	443	0	0	00:00:00	\N
726	56	443	444	1	437.805569567110922	00:00:31.522001	0102000020E610000006000000FFFFFFDF2A3E4940040000C04BAB3E40FAFFFFBF2A3E49400A00004050AB3E40FEFFFF1F163E49400A0000A050AB3E40FDFFFF5FE93D49400A0000A050AB3E40FBFFFFDFBF3D49400A00004050AB3E4004000060973D4940000000A04FAB3E40
727	56	444	445	2	436.043273123656945	00:00:31.395116	0102000020E610000008000000FAFFFF1F973D4940030000A04AAB3E4004000060973D4940000000A04FAB3E40FAFFFFBF6A3D4940FFFFFF3F4FAB3E40FDFFFFBF3D3D4940FEFFFF7F4EAB3E40000000A01B3D4940FFFFFFDF4EAB3E40FFFFFFDF123D49400A0000A050AB3E40FCFFFF3F0C3D4940FBFFFFDF53AB3E40F9FFFF5F063D49400C0000805AAB3E40
728	56	445	446	3	619.95281017918353	00:00:44.636602	0102000020E61000000B000000FDFFFFBF053D4940070000A055AB3E40F9FFFF5F063D49400C0000805AAB3E4005000080F43C4940FEFFFF1F6EAB3E4000000000E03C4940030000A08AAB3E40FAFFFF1FBF3C4940000000A0B7AB3E40FDFFFFBFA93C4940F4FFFF7FD5AB3E40040000009F3C4940FCFFFF3FE4AB3E4007000000963C49400B000000F1AB3E4005000020803C4940070000A00DAC3E40FDFFFFBF793C4940F6FFFFBF17AC3E40FAFFFFBF723C494005000020E4AB3E40
729	56	446	447	4	1455.65688802184286	00:01:44.807296	0102000020E61000000900000005000020743C494002000080E1AB3E40FAFFFFBF723C494005000020E4AB3E40010000C0643C49400A00004080AB3E40FCFFFF9F503C4940FDFFFF5FEDAA3E40000000003C3C4940FAFFFF1F5BAA3E4005000020283C4940020000E0C9A93E4002000080193C4940F6FFFF5F5FA93E40070000A00D3C4940030000400AA93E40000000A0FF3B4940FCFFFFFFA4A83E40
730	56	447	448	5	1991.86377285587491	00:02:23.414192	0102000020E610000011000000FCFFFFFF003C4940F9FFFF5FA2A83E40000000A0FF3B4940FCFFFFFFA4A83E40FBFFFF7FF33B4940030000A04AA83E40FBFFFF7FE33B4940FAFFFF1FD3A73E4003000040D23B4940FBFFFF7F53A73E40FCFFFF3FC43B4940F5FFFF3FEEA63E4000000060B43B49400E0000A07BA63E40F9FFFF5FA23B4940F8FFFF3FF9A53E40FAFFFF1FC33B494007000000CEA53E4005000020D03B4940FCFFFF3FBCA53E40F9FFFF5FBA3B4940F6FFFFBF1FA53E40FAFFFFBFAA3B4940F3FFFFBFB4A43E40000000A0A73B4940F7FFFF1FB0A43E40FFFFFF3FA33B4940FDFFFF5FADA43E40040000009F3B4940090000E0AFA43E4000000060983B49400B000000D9A43E40FCFFFFFF9C3B4940F6FFFFBFF7A43E40
731	57	\N	449	0	0	00:00:00	\N
759	58	474	475	13	369.704296862140723	00:00:26.618709	0102000020E61000000400000005000080843549400E0000A0B37B3E40FFFFFF3F83354940F8FFFFDFB07B3E40FAFFFF1FA7354940F3FFFFBF147B3E40FCFFFFFFB035494002000080E97A3E40
732	57	449	450	1	451.767776858997536	00:00:32.52728	0102000020E610000007000000FDFFFF5F3D3749400000008015783E40FEFFFF1F3E3749400000006011783E40030000A04E374940000000E033783E40060000403137494000000080C7783E40F9FFFFFF2937494000000080CD783E40F9FFFF5F26374940000000A0D5783E40FDFFFF5F1937494000000020F3783E40
733	57	450	451	2	509.929037777635472	00:00:36.714891	0102000020E61000000A0000000000006018374940000000E0EE783E40FDFFFF5F1937494000000020F3783E40FFFFFFDF12374940000000A003793E40F9FFFF5F023749400000004029793E40070000A0E5364940000000A069793E40FFFFFFDFCA36494000000060A5793E4000000060C436494000000000B3793E40060000E0C036494000000000B9793E40FDFFFFBFB536494000000040C9793E4005000020AC364940000000E0D5793E40
734	57	451	452	3	692.012378795483983	00:00:49.824891	0102000020E61000000C00000004000000AB36494000000080CE793E4005000020AC364940000000E0D5793E40FBFFFFDF9736494000000020EF793E40020000807D36494000000040107A3E40000000A06F364940000000C0207A3E40050000806C364940000000E0107A3E40060000406936494000000020017A3E40020000E06536494000000020F5793E40FDFFFFBF6136494000000000EB793E40050000804C364940000000C0BF793E40020000E02D3649400000002081793E40FCFFFFFF18364940000000E0C1793E40
735	57	452	453	4	962.563056536953013	00:01:09.30454	0102000020E61000000B000000040000C01736494000000040BE793E40FCFFFFFF18364940000000E0C1793E40050000200436494000000040037A3E40020000E0DD354940000000E06F7A3E40070000A0D9354940000000207C7A3E4000000000D4354940000000E0827A3E40FDFFFF5FC5354940000000A09E7A3E4005000020C035494000000080A87A3E40FCFFFFFFB035494000000080E97A3E40FAFFFF1FA7354940000000C0147B3E40FFFFFF3F83354940000000E0B07B3E40
736	57	453	454	5	421.643285793683731	00:00:30.358317	0102000020E61000000B000000F9FFFFFF8135494000000060AE7B3E40FFFFFF3F83354940000000E0B07B3E40040000607F354940000000C0C17B3E40FDFFFFBF89354940000000A0D47B3E40010000C08C35494000000060E87B3E40FBFFFFDF93354940000000000E7C3E40FCFFFF3F98354940000000602E7C3E40010000C098354940000000E0457C3E400400000097354940000000E05E7C3E40020000809135494000000040807C3E40070000A08D354940000000C0977C3E40
737	57	454	455	6	582.632029285220938	00:00:41.949506	0102000020E61000000D000000050000208C35494000000060957C3E40070000A08D354940000000C0977C3E40F9FFFFFF8935494000000080B17C3E40FFFFFF3F7F354940000000E0067D3E40010000207D354940000000E0187D3E40FCFFFFFF7C35494000000000227D3E40FEFFFF7F7E354940000000802D7D3E40050000808035494000000080387D3E40060000E084354940000000804C7D3E40FDFFFFBF89354940000000206B7D3E40FEFFFF7F8E354940000000008A7D3E40060000E09035494000000000A47D3E400000000098354940000000A0E27D3E40
738	57	455	456	7	1004.9636782087083	00:01:12.357385	0102000020E61000000A000000F9FFFF5F9635494000000080E37D3E400000000098354940000000A0E27D3E40FBFFFFDF9F35494000000040287E3E4003000040A6354940000000004B7E3E40FEFFFF7FAA354940000000E0607E3E40030000A0BE354940000000A0CF7E3E40FCFFFF9FC8354940000000C0057F3E40FCFFFF3FD035494000000000B97F3E40070000A0D135494000000020C17F3E40020000E0E9354940000000A019803E40
739	57	456	457	8	1189.33264585663528	00:01:25.631951	0102000020E61000000D000000010000C0E8354940000000601E803E40020000E0E9354940000000A019803E40070000A0D135494000000020C17F3E40FCFFFF3FD035494000000000B97F3E40FCFFFF9FC8354940000000C0057F3E40030000A0BE354940000000A0CF7E3E40FEFFFF7FAA354940000000E0607E3E4003000040A6354940000000004B7E3E40FBFFFFDF9F35494000000040287E3E400000000098354940000000A0E27D3E40060000E09035494000000000A47D3E400600004089354940000000A0957D3E40060000408135494000000000837D3E40
740	57	457	458	9	411.284626280890052	00:00:29.612493	0102000020E610000008000000F9FFFF5F82354940000000207F7D3E40060000408135494000000000837D3E40FFFFFF3F7335494000000080657D3E40070000006E354940000000007C7D3E40FEFFFF1F66354940000000009E7D3E40030000405A35494000000080D97D3E40010000C05035494000000040C97D3E40060000403D35494000000020A07D3E40
741	57	458	459	10	302.492495357574455	00:00:21.77946	0102000020E61000000B000000FEFFFF7F3E354940000000409B7D3E40060000403D35494000000020A07D3E40FBFFFF7F2B354940000000807A7D3E40FAFFFFBF2235494000000060697D3E40000000601C354940000000E0607D3E40070000001635494000000080597D3E40F9FFFF5F0E35494000000020587D3E400500002008354940000000205F7D3E40FFFFFF3FFF344940000000606A7D3E40010000C0F8344940000000C0787D3E40070000A0F5344940000000A0827D3E40
742	57	459	460	11	825.185335763784792	00:00:59.413344	0102000020E61000000C00000005000020F434494000000020807D3E40070000A0F5344940000000A0827D3E4007000000EE344940000000609E7D3E4004000060EB344940000000E0A77D3E40030000A0EA344940000000A0AF7D3E40060000E0E8344940000000A0D07D3E4005000020E4344940000000801A7E3E40FCFFFFFFDC34494000000060857E3E4005000080D4344940000000A0FE7E3E40F9FFFFFFD1344940000000E0287F3E40040000C0CF344940000000604C7F3E40FFFFFFDFCE344940000000A05E7F3E40
743	57	460	461	12	1133.09565350068874	00:01:21.582887	0102000020E610000015000000FDFFFFBFCD344940000000A05E7F3E40FFFFFFDFCE344940000000A05E7F3E40FFFFFF3FCB34494000000040B07F3E40FCFFFFFFC834494000000060D97F3E4006000040C934494000000060F97F3E40FEFFFF7FCA344940000000401D803E40030000A0CA344940000000203B803E40060000E0C8344940000000A071803E40FFFFFFDFC634494000000020A3803E4005000080C4344940000000E0B1803E40070000A0BD344940000000A0D8803E4001000020B1344940000000A01A813E40000000A0AB344940000000402D813E4001000020A5344940000000A040813E40FEFFFF7F9E344940000000205C813E40FCFFFF9F983449400000000074813E40FFFFFFDF92344940000000C090813E40000000A08B34494000000040B2813E40FCFFFF3F8C34494000000060C2813E40FEFFFF1F8E344940000000E0D2813E400000006090344940000000C0E3813E40
744	57	461	462	13	765.832777065615346	00:00:55.13996	0102000020E61000000A000000FFFFFF3F8F34494000000000E6813E400000006090344940000000C0E3813E400400006097344940000000000F823E40FBFFFF7F9F344940000000E03E823E4002000080B134494000000040AE823E40FAFFFFBFB634494000000080D3823E40000000A0BF344940000000201E833E4005000080C83449400000000071833E40030000A0CA3449400000002086833E4001000020CD3449400000006097833E40
745	57	462	208	14	601.023732486857057	00:00:43.273709	0102000020E610000007000000FBFFFFDFCB344940000000A099833E4001000020CD3449400000006097833E40FAFFFF1FDB34494000000040EF833E40020000E0C9344940000000E00E843E40FCFFFF3FA8344940000000004B843E40FEFFFF1F7E344940000000A097843E40FAFFFF1F73344940000000A0AB843E40
746	58	\N	184	0	0	00:00:00	\N
747	58	184	463	1	796.572314789577149	00:00:57.353207	0102000020E61000000E000000000000006C34494005000080F4843E40040000006B344940090000E0EF843E40FDFFFFBF71344940F5FFFFFFDE843E40040000C07334494004000000CB843E40FBFFFFDF73344940FCFFFFFFC4843E40060000E0703449400A000040B0843E40FAFFFF1F733449400E0000A0AB843E40FEFFFF1F7E344940000000A097843E40FCFFFF3FA8344940040000004B843E40020000E0C9344940FFFFFFDF0E843E40FAFFFF1FDB344940FFFFFF3FEF833E4001000020CD344940F6FFFF5F97833E40030000A0CA344940FEFFFF1F86833E4005000080C83449400B00000071833E40
748	58	463	464	2	729.171149971673003	00:00:52.500323	0102000020E610000009000000020000E0C9344940080000C06E833E4005000080C83449400B00000071833E40000000A0BF344940FEFFFF1F1E833E40FAFFFFBFB6344940FBFFFF7FD3823E4002000080B1344940F5FFFF3FAE823E40FBFFFF7F9F344940FFFFFFDF3E823E400400006097344940F5FFFFFF0E823E400000006090344940040000C0E3813E40FEFFFF1F8E3449400D0000E0D2813E40
749	58	464	465	3	460.43641347780806	00:00:33.151422	0102000020E61000000B000000FBFFFF7F8F344940090000E0CF813E40FEFFFF1F8E3449400D0000E0D2813E40FCFFFF3F8C344940F9FFFF5FC2813E40000000A08B34494003000040B2813E40FFFFFFDF92344940010000C090813E40FCFFFF9F98344940F2FFFFFF73813E40FEFFFF7F9E344940050000205C813E4001000020A53449400A0000A040813E40000000A0AB344940060000402D813E4001000020B1344940030000A01A813E40070000A0BD3449400A0000A0D8803E40
750	58	465	466	4	744.095447305395055	00:00:53.574872	0102000020E61000000D000000FAFFFF1FBF34494004000000DB803E40070000A0BD3449400A0000A0D8803E4005000080C4344940020000E0B1803E40FFFFFFDFC6344940FAFFFF1FA3803E40060000E0C8344940F9FFFF9F71803E40030000A0CA344940FAFFFF1F3B803E40FEFFFF7FCA344940060000401D803E4006000040C93449400B000060F97F3E40FCFFFFFFC83449400B000060D97F3E40FFFFFF3FCB3449400A000040B07F3E40FFFFFFDFCE344940F5FFFF9F5E7F3E40040000C0CF344940F2FFFF5F4C7F3E40F9FFFFFFD1344940F8FFFFDF287F3E40
751	58	466	467	5	732.21593401204359	00:00:52.719547	0102000020E61000000A000000000000A0D3344940F8FFFF3F297F3E40F9FFFFFFD1344940F8FFFFDF287F3E4005000080D4344940F5FFFF9FFE7E3E40FCFFFFFFDC344940FDFFFF5F857E3E4005000020E43449400C0000801A7E3E40060000E0E83449400A0000A0D07D3E40030000A0EA344940000000A0AF7D3E4004000060EB344940090000E0A77D3E4007000000EE344940070000609E7D3E40070000A0F5344940030000A0827D3E40
752	58	467	468	6	300.971902727209169	00:00:21.669977	0102000020E61000000B000000FFFFFFDFF6344940FEFFFF7F867D3E40070000A0F5344940030000A0827D3E40010000C0F8344940010000C0787D3E40FFFFFF3FFF344940F9FFFF5F6A7D3E400500002008354940080000205F7D3E40F9FFFF5F0E354940F7FFFF1F587D3E40070000001635494002000080597D3E40000000601C354940F8FFFFDF607D3E40FAFFFFBF223549400B000060697D3E40FBFFFF7F2B3549400C0000807A7D3E40060000403D354940F7FFFF1FA07D3E40
753	58	468	469	7	307.77892284339373	00:00:22.160082	0102000020E610000006000000010000C03C354940FDFFFFBFA57D3E40060000403D354940F7FFFF1FA07D3E40010000C050354940F8FFFF3FC97D3E40030000405A35494002000080D97D3E40FEFFFF1F66354940070000009E7D3E40070000006E3549400E0000007C7D3E40
754	58	469	470	8	293.974078589301484	00:00:21.166134	0102000020E610000007000000FFFFFF3F6F354940090000E07F7D3E40070000006E3549400E0000007C7D3E40FFFFFF3F73354940F4FFFF7F657D3E40060000408135494004000000837D3E400600004089354940070000A0957D3E40060000E090354940F2FFFFFFA37D3E400000000098354940030000A0E27D3E40
755	58	470	471	9	1004.96367820379317	00:01:12.357385	0102000020E61000000A000000F9FFFF5F96354940FBFFFF7FE37D3E400000000098354940030000A0E27D3E40FBFFFFDF9F3549400A000040287E3E4003000040A6354940040000004B7E3E40FEFFFF7FAA354940F8FFFFDF607E3E40030000A0BE354940000000A0CF7E3E40FCFFFF9FC8354940FDFFFFBF057F3E40FCFFFF3FD03549400B000000B97F3E40070000A0D135494001000020C17F3E40020000E0E9354940F9FFFF9F19803E40
756	58	471	472	10	1215.8194577605193	00:01:27.539001	0102000020E61000000C000000010000C0E8354940070000601E803E40020000E0E9354940F9FFFF9F19803E40070000A0D135494001000020C17F3E40FCFFFF3FD03549400B000000B97F3E40FCFFFF9FC8354940FDFFFFBF057F3E40030000A0BE354940000000A0CF7E3E40FEFFFF7FAA354940F8FFFFDF607E3E40FBFFFFDF9F3549400A000040287E3E400000000098354940030000A0E27D3E40060000E090354940F2FFFFFFA37D3E40FEFFFF7F8E354940F9FFFFFF897D3E40FDFFFFBF89354940FAFFFF1F6B7D3E40
757	58	472	473	11	416.540059877662372	00:00:29.990884	0102000020E61000000B000000FFFFFF3F8B35494001000020697D3E40FDFFFFBF89354940FAFFFF1F6B7D3E40060000E084354940050000804C7D3E400500008080354940F7FFFF7F387D3E40FEFFFF7F7E354940F4FFFF7F2D7D3E40FCFFFFFF7C354940F9FFFFFF217D3E40010000207D354940F8FFFFDF187D3E40FFFFFF3F7F354940FFFFFFDF067D3E40F9FFFFFF8935494002000080B17C3E40070000A08D354940F6FFFFBF977C3E4002000080913549400A000040807C3E40
758	58	473	474	12	379.301662610825474	00:00:27.30972	0102000020E61000000A000000FAFFFFBF92354940F9FFFFFF817C3E4002000080913549400A000040807C3E400400000097354940FFFFFFDF5E7C3E40010000C098354940F4FFFFDF457C3E40FCFFFF3F98354940070000602E7C3E40FBFFFFDF93354940070000000E7C3E40010000C08C35494000000060E87B3E40FDFFFFBF89354940FCFFFF9FD47B3E40040000607F3549400B0000C0C17B3E40FFFFFF3F83354940F8FFFFDFB07B3E40
760	58	475	476	14	599.525607093737221	00:00:43.165844	0102000020E61000000900000004000000B3354940FCFFFF9FEC7A3E40FCFFFFFFB035494002000080E97A3E4005000020C0354940F7FFFF7FA87A3E40FDFFFF5FC5354940F5FFFF9F9E7A3E4000000000D43549400D0000E0827A3E40070000A0D9354940050000207C7A3E40020000E0DD354940090000E06F7A3E4005000020043649400D000040037A3E40FCFFFFFF18364940020000E0C1793E40
761	58	476	477	15	1529.75689224928465	00:01:50.142496	0102000020E61000000F000000030000401A36494007000000C6793E40FCFFFFFF18364940020000E0C1793E40020000E02D3649400100002081793E40000000A03B364940FDFFFFBF4D793E40FEFFFF7F463649400900008027793E40FDFFFF5F61364940F5FFFF3FD6783E40040000006B36494002000080B9783E40FBFFFFDF87364940F9FFFFFF69783E40FBFFFF7F933649400B00000049783E40030000A0B2364940F2FFFF5F04783E40FCFFFF3FCC364940040000C0CB773E4006000040F13649400200008079773E40FDFFFF5F15374940F8FFFF3FC1773E400000000038374940FDFFFFBF05783E40FEFFFF1F3E3749400B00006011783E40
763	59	478	479	1	883.06312119159179	00:01:03.580545	0102000020E61000000D000000030000A0F63F494000000060605D3E40000000E0F63F494000000060655D3E4000000000E43F4940000000E0685D3E4000000040C73F4940000000806F5D3E40000000C0A23F494000000060795D3E40000000A09A3F4940000000807C5D3E40000000609D3F4940000000E0DD5D3E40000000609F3F494000000020285E3E40000000809F3F4940000000E0495E3E40000000C09E3F494000000040645E3E40000000609B3F4940000000A0915E3E40000000E0943F4940000000A0B95E3E40000000008F3F494000000060DB5E3E40
764	59	479	480	2	1042.90759583774752	00:01:15.089347	0102000020E61000000A000000020000808D3F494000000040D95E3E40000000008F3F494000000060DB5E3E4000000040843F4940000000C01C5F3E4000000080813F4940000000402F5F3E40000000E07C3F4940000000A0485F3E4000000080723F4940000000A07C5F3E40000000E0653F494000000040BD5F3E40000000805B3F494000000060F25F3E4000000060303F4940000000E0CE603E4000000060203F49400000000020613E40
765	59	480	481	3	1314.58785547211346	00:01:34.650326	0102000020E610000008000000000000401E3F4940000000001D613E4000000060203F49400000000020613E4000000040053F4940000000E0AA613E4000000080E73E49400000002043623E4000000060D53E4940000000409F623E4000000060BF3E4940000000600F633E4000000020A53E49400000002097633E40000000E0913E4940000000C0F9633E40
766	59	481	482	4	409.158495390713767	00:00:29.459412	0102000020E61000000400000000000060903E4940000000E0F7633E40000000E0913E4940000000C0F9633E40000000406C3E494000000020BA643E40000000A0653E494000000020DB643E40
767	59	482	483	5	425.32186974561921	00:00:30.623175	0102000020E61000000F00000000000060643E4940000000A0D8643E40000000A0653E494000000020DB643E40000000805D3E4940000000A002653E4000000020573E4940000000E012653E4000000000473E4940000000002E653E40000000C0413E4940000000C036653E4000000020403E49400000004038653E40000000C03C3E4940000000203C653E40000000203B3E4940000000204A653E40000000203B3E4940000000E057653E40000000003D3E49400000008063653E40000000403D3E4940000000606E653E40000000403C3E4940000000607C653E4000000040353E49400000002098653E40000000202E3E494000000040B2653E40
768	59	483	484	6	903.255475059872197	00:01:05.034394	0102000020E610000008000000060000E02C3E494000000000AF653E40000000202E3E494000000040B2653E4000000020153E4940000000400E663E40000000C0F53D4940000000A081663E4000000060DE3D494000000040DA663E40000000A0C13D49400000008046673E4000000080BF3D4940000000A04F673E4000000060AD3D4940000000C091673E40
769	59	484	485	7	226.720906803498963	00:00:16.323905	0102000020E610000006000000FCFFFF3FAC3D4940000000808E673E4000000060AD3D4940000000C091673E40000000009F3D4940000000E0C7673E4000000080983D494000000020E0673E4000000060843D4940000000C0DF673E40000000407F3D494000000080E0673E40
770	59	485	486	8	389.760679523135082	00:00:28.062769	0102000020E610000005000000000000A07F3D494000000080DB673E40000000407F3D494000000080E0673E40000000805A3D4940000000E0E0673E40000000202E3D4940000000E0E0673E4000000000FD3C494000000080E1673E40
771	59	486	487	9	486.976262963025476	00:00:35.062291	0102000020E61000000600000001000020FD3C4940000000E0DB673E4000000000FD3C494000000080E1673E40000000C0D03C494000000080E1673E4000000020A33C494000000040E2673E40000000C0783C4940000000E0E1673E40000000E0593C494000000040E2673E40
772	59	487	488	10	383.816527862140219	00:00:27.63479	0102000020E610000006000000F9FFFFFF593C4940000000A0DC673E40000000E0593C494000000040E2673E4000000060313C494000000040E2673E4000000040053C494000000040E3673E40000000A0E83B494000000040E3673E4000000000DA3B4940000000A0E3673E40
773	59	488	489	11	357.359954602480911	00:00:25.729917	0102000020E610000006000000F9FFFFFFD93B4940000000A0DD673E4000000000DA3B4940000000A0E3673E40000000C0AF3B4940000000A0E3673E40000000E08B3B494000000000E4673E40000000C0773B494000000000E4673E4000000060633B494000000000E4673E40
774	59	489	490	12	483.337946455543772	00:00:34.800332	0102000020E61000000A000000FBFFFF7F633B494000000020DF673E4000000060633B494000000000E4673E40000000A0393B494000000060E4673E4000000060193B4940000000C0E4673E40000000A0F83A494000000000E5673E4000000080DF3A494000000060E4673E4000000080D73A4940000000E0E2673E4000000040D13A4940000000C0DF673E40000000A0C93A494000000080D4673E40000000E0C53A4940000000C0CC673E40
775	60	\N	491	0	0	00:00:00	\N
776	60	491	492	1	479.331479704166327	00:00:34.511867	0102000020E610000008000000FBFFFF7FD73A4940000000E0E8673E4000000080D73A4940000000E0E2673E4000000080DF3A494000000060E4673E40000000A0F83A494000000000E5673E4000000060193B4940000000C0E4673E40000000A0393B494000000060E4673E4000000060633B494000000000E4673E40000000C0773B494000000000E4673E40
777	60	492	493	2	337.567029370215096	00:00:24.304826	0102000020E610000006000000040000C0773B494000000040E8673E40000000C0773B494000000000E4673E40000000E08B3B494000000000E4673E40000000C0AF3B4940000000A0E3673E4000000000DA3B4940000000A0E3673E40000000A0E83B494000000040E3673E40
778	60	493	494	3	221.410899793071565	00:00:15.941585	0102000020E610000004000000FCFFFF9FE83B494000000040E8673E40000000A0E83B494000000040E3673E4000000040053C494000000040E3673E4000000060313C494000000040E2673E40
779	60	494	495	4	217.165741721854857	00:00:15.635933	0102000020E610000004000000FDFFFF5F313C494000000020E7673E4000000060313C494000000040E2673E40000000E0593C494000000040E2673E40000000C0783C4940000000E0E1673E40
780	60	495	496	5	267.099855371837805	00:00:19.23119	0102000020E610000004000000010000C0783C494000000080E7673E40000000C0783C4940000000E0E1673E4000000020A33C494000000040E2673E40000000C0D03C494000000080E1673E40
781	60	496	497	6	535.31635948027656	00:00:38.542778	0102000020E610000007000000FCFFFF9FD03C494000000020E7673E40000000C0D03C494000000080E1673E4000000000FD3C494000000080E1673E40000000202E3D4940000000E0E0673E40000000805A3D4940000000E0E0673E40000000407F3D494000000080E0673E4000000060843D4940000000C0DF673E40
782	60	497	498	7	779.529063164792205	00:00:56.126093	0102000020E610000015000000000000A0843D494000000060E4673E4000000060843D4940000000C0DF673E4000000080983D494000000020E0673E40000000208B3D49400000006011683E4000000060863D4940000000E022683E4000000020863D4940000000802E683E4000000000873D49400000006039683E40000000C0893D49400000004042683E40000000A08D3D49400000006044683E40000000C08F3D49400000008041683E40000000E0923D4940000000A03C683E4000000020983D49400000008027683E40000000C0AC3D494000000080DB673E4000000040B53D494000000040BC673E40000000C0B93D494000000020AC673E4000000060BB3D4940000000609D673E4000000060BC3D4940000000608A673E4000000080BD3D49400000002079673E40000000C0BF3D4940000000E066673E4000000080C23D49400000000057673E4000000060CE3D4940000000C02A673E40
783	60	498	499	8	691.589236565056467	00:00:49.794425	0102000020E610000009000000FBFFFF7FCF3D4940000000E02C673E4000000060CE3D4940000000C02A673E4000000040DB3D494000000080F9663E40000000C0E53D494000000080D2663E40000000A0F03D494000000060AA663E4000000060013E4940000000E06B663E40000000A0153E4940000000801F663E4000000000223E494000000020F2653E4000000020313E4940000000A0BB653E40
784	60	499	500	9	474.922566174249937	00:00:34.194425	0102000020E61000000B00000003000040323E494000000020BD653E4000000020313E4940000000A0BB653E4000000040393E4940000000809D653E40000000403F3E49400000006088653E4000000020443E49400000002077653E4000000020483E4940000000806A653E40000000C04A3E49400000000061653E4000000080513E49400000002040653E40000000805D3E4940000000A002653E40000000A0653E494000000020DB643E40000000406C3E494000000020BA643E40
785	60	500	501	10	349.925193606988728	00:00:25.194614	0102000020E610000003000000020000806D3E494000000080BC643E40000000406C3E494000000020BA643E40000000E0913E4940000000C0F9633E40
786	60	501	502	11	1458.18037143452943	00:01:44.988987	0102000020E610000009000000FBFFFF7F933E494000000020FC633E40000000E0913E4940000000C0F9633E4000000020A53E49400000002097633E4000000060BF3E4940000000600F633E4000000060D53E4940000000409F623E4000000080E73E49400000002043623E4000000040053F4940000000E0AA613E4000000060203F49400000000020613E4000000060303F4940000000E0CE603E40
787	60	502	503	12	970.233231451108168	00:01:09.856793	0102000020E61000000A000000FDFFFFBF313F494000000080D1603E4000000060303F4940000000E0CE603E40000000805B3F494000000060F25F3E40000000E0653F494000000040BD5F3E4000000080723F4940000000A07C5F3E40000000E07C3F4940000000A0485F3E4000000080813F4940000000402F5F3E40000000C0863F494000000040165F3E4000000040913F4940000000C0DE5E3E4000000060993F494000000040B45E3E40
788	60	503	504	13	620.215857593295141	00:00:44.655542	0102000020E61000000C000000FAFFFFBF9A3F494000000020B65E3E4000000060993F494000000040B45E3E40000000609C3F494000000060A35E3E40000000A0AE3F4940000000A03F5E3E40000000E0B83F494000000000065E3E4000000060C53F494000000060C55D3E4000000080CA3F494000000020AE5D3E40000000E0CF3F4940000000E09B5D3E4000000020D43F494000000040915D3E4000000060DA3F4940000000C0855D3E4000000020E23F4940000000C07A5D3E40000000E0ED3F4940000000A0775D3E40
789	61	\N	436	0	0	00:00:00	\N
790	61	436	437	1	1524.09937158800676	00:01:49.735155	0102000020E61000000F000000040000C09B3B494000000040FAA43E40FCFFFFFF9C3B4940000000C0F7A43E4001000020A13B4940000000A015A53E40000000A0AB3B4940000000401CA53E40FBFFFF7FB33B4940000000C01FA53E40F9FFFF5FBA3B4940000000C01FA53E4005000020D03B494000000040BCA53E40070000A0E53B4940000000E05BA63E4006000040F93B494000000060EDA63E40010000200D3C4940000000407DA73E40FBFFFF7F133C4940000000E0A4A73E40FCFFFFFF183C494000000020BBA73E40F9FFFF5F323C4940000000A013A83E40FBFFFFDF373C4940000000E02AA83E4006000040393C4940000000A032A83E40
802	63	\N	449	0	0	00:00:00	\N
830	64	474	475	13	369.704296862140723	00:00:26.618709	0102000020E61000000400000005000080843549400E0000A0B37B3E40FFFFFF3F83354940F8FFFFDFB07B3E40FAFFFF1FA7354940F3FFFFBF147B3E40FCFFFFFFB035494002000080E97A3E40
791	61	437	438	2	972.145160894918604	00:01:09.994452	0102000020E61000000F000000040000C0373C49400000002036A83E4006000040393C4940000000A032A83E40FEFFFF1F3E3C49400000004051A83E40030000A0423C4940000000C07CA83E4000000060443C4940000000209EA83E40FDFFFF5F453C494000000040CCA83E40030000A0463C494000000020F1A83E4000000060483C4940000000A00CA93E40040000004B3C49400000004026A93E4004000000533C49400000004061A93E40040000605B3C4940000000609CA93E4005000020643C494000000080D9A93E40010000C06C3C4940000000E019AA3E40010000C0583C4940000000E033AA3E40000000605C3C49400000000050AA3E40
792	61	438	439	3	600.628547496192482	00:00:43.245255	0102000020E610000006000000FAFFFF1F5B3C49400000002052AA3E40000000605C3C49400000000050AA3E4002000080713C494000000060E5AA3E4005000020783C4940000000E013AB3E4004000060873C4940000000C085AB3E40040000C08B3C494000000060A5AB3E40
793	61	439	440	4	573.214218943155743	00:00:41.271424	0102000020E61000000A000000030000408A3C4940000000C0A6AB3E40040000C08B3C494000000060A5AB3E4007000000963C494000000000F1AB3E40040000009F3C494000000040E4AB3E40FDFFFFBFA93C494000000080D5AB3E40FAFFFF1FBF3C4940000000A0B7AB3E4000000000E03C4940000000A08AAB3E4005000080F43C4940000000206EAB3E40F9FFFF5F063D4940000000805AAB3E40FCFFFF3F0C3D4940000000E053AB3E40
794	61	440	441	5	413.397980304169209	00:00:29.764655	0102000020E610000007000000000000600C3D4940000000A057AB3E40FCFFFF3F0C3D4940000000E053AB3E40FFFFFFDF123D4940000000A050AB3E40000000A01B3D4940000000E04EAB3E40FDFFFFBF3D3D4940000000804EAB3E40FAFFFFBF6A3D4940000000404FAB3E4004000060973D4940000000A04FAB3E40
795	61	441	442	6	437.805569553907787	00:00:31.522001	0102000020E610000006000000FFFFFF3F973D49400000002054AB3E4004000060973D4940000000A04FAB3E40FBFFFFDFBF3D49400000004050AB3E40FDFFFF5FE93D4940000000A050AB3E40FEFFFF1F163E4940000000A050AB3E40FAFFFFBF2A3E49400000004050AB3E40
796	62	\N	442	0	0	00:00:00	\N
797	62	442	444	1	437.805569567110922	00:00:31.522001	0102000020E610000006000000FFFFFFDF2A3E4940040000C04BAB3E40FAFFFFBF2A3E49400A00004050AB3E40FEFFFF1F163E49400A0000A050AB3E40FDFFFF5FE93D49400A0000A050AB3E40FBFFFFDFBF3D49400A00004050AB3E4004000060973D4940000000A04FAB3E40
798	62	444	445	2	436.043273123656945	00:00:31.395116	0102000020E610000008000000FAFFFF1F973D4940030000A04AAB3E4004000060973D4940000000A04FAB3E40FAFFFFBF6A3D4940FFFFFF3F4FAB3E40FDFFFFBF3D3D4940FEFFFF7F4EAB3E40000000A01B3D4940FFFFFFDF4EAB3E40FFFFFFDF123D49400A0000A050AB3E40FCFFFF3F0C3D4940FBFFFFDF53AB3E40F9FFFF5F063D49400C0000805AAB3E40
799	62	445	446	3	619.95281017918353	00:00:44.636602	0102000020E61000000B000000FDFFFFBF053D4940070000A055AB3E40F9FFFF5F063D49400C0000805AAB3E4005000080F43C4940FEFFFF1F6EAB3E4000000000E03C4940030000A08AAB3E40FAFFFF1FBF3C4940000000A0B7AB3E40FDFFFFBFA93C4940F4FFFF7FD5AB3E40040000009F3C4940FCFFFF3FE4AB3E4007000000963C49400B000000F1AB3E4005000020803C4940070000A00DAC3E40FDFFFFBF793C4940F6FFFFBF17AC3E40FAFFFFBF723C494005000020E4AB3E40
800	62	446	447	4	1455.65688802184286	00:01:44.807296	0102000020E61000000900000005000020743C494002000080E1AB3E40FAFFFFBF723C494005000020E4AB3E40010000C0643C49400A00004080AB3E40FCFFFF9F503C4940FDFFFF5FEDAA3E40000000003C3C4940FAFFFF1F5BAA3E4005000020283C4940020000E0C9A93E4002000080193C4940F6FFFF5F5FA93E40070000A00D3C4940030000400AA93E40000000A0FF3B4940FCFFFFFFA4A83E40
801	62	447	436	5	1991.86377285587491	00:02:23.414192	0102000020E610000011000000FCFFFFFF003C4940F9FFFF5FA2A83E40000000A0FF3B4940FCFFFFFFA4A83E40FBFFFF7FF33B4940030000A04AA83E40FBFFFF7FE33B4940FAFFFF1FD3A73E4003000040D23B4940FBFFFF7F53A73E40FCFFFF3FC43B4940F5FFFF3FEEA63E4000000060B43B49400E0000A07BA63E40F9FFFF5FA23B4940F8FFFF3FF9A53E40FAFFFF1FC33B494007000000CEA53E4005000020D03B4940FCFFFF3FBCA53E40F9FFFF5FBA3B4940F6FFFFBF1FA53E40FAFFFFBFAA3B4940F3FFFFBFB4A43E40000000A0A73B4940F7FFFF1FB0A43E40FFFFFF3FA33B4940FDFFFF5FADA43E40040000009F3B4940090000E0AFA43E4000000060983B49400B000000D9A43E40FCFFFFFF9C3B4940F6FFFFBFF7A43E40
803	63	449	450	1	451.767776858997536	00:00:32.52728	0102000020E610000007000000FDFFFF5F3D3749400000008015783E40FEFFFF1F3E3749400000006011783E40030000A04E374940000000E033783E40060000403137494000000080C7783E40F9FFFFFF2937494000000080CD783E40F9FFFF5F26374940000000A0D5783E40FDFFFF5F1937494000000020F3783E40
804	63	450	451	2	509.929037777635472	00:00:36.714891	0102000020E61000000A0000000000006018374940000000E0EE783E40FDFFFF5F1937494000000020F3783E40FFFFFFDF12374940000000A003793E40F9FFFF5F023749400000004029793E40070000A0E5364940000000A069793E40FFFFFFDFCA36494000000060A5793E4000000060C436494000000000B3793E40060000E0C036494000000000B9793E40FDFFFFBFB536494000000040C9793E4005000020AC364940000000E0D5793E40
805	63	451	452	3	692.012378795483983	00:00:49.824891	0102000020E61000000C00000004000000AB36494000000080CE793E4005000020AC364940000000E0D5793E40FBFFFFDF9736494000000020EF793E40020000807D36494000000040107A3E40000000A06F364940000000C0207A3E40050000806C364940000000E0107A3E40060000406936494000000020017A3E40020000E06536494000000020F5793E40FDFFFFBF6136494000000000EB793E40050000804C364940000000C0BF793E40020000E02D3649400000002081793E40FCFFFFFF18364940000000E0C1793E40
806	63	452	453	4	962.563056536953013	00:01:09.30454	0102000020E61000000B000000040000C01736494000000040BE793E40FCFFFFFF18364940000000E0C1793E40050000200436494000000040037A3E40020000E0DD354940000000E06F7A3E40070000A0D9354940000000207C7A3E4000000000D4354940000000E0827A3E40FDFFFF5FC5354940000000A09E7A3E4005000020C035494000000080A87A3E40FCFFFFFFB035494000000080E97A3E40FAFFFF1FA7354940000000C0147B3E40FFFFFF3F83354940000000E0B07B3E40
807	63	453	454	5	421.643285793683731	00:00:30.358317	0102000020E61000000B000000F9FFFFFF8135494000000060AE7B3E40FFFFFF3F83354940000000E0B07B3E40040000607F354940000000C0C17B3E40FDFFFFBF89354940000000A0D47B3E40010000C08C35494000000060E87B3E40FBFFFFDF93354940000000000E7C3E40FCFFFF3F98354940000000602E7C3E40010000C098354940000000E0457C3E400400000097354940000000E05E7C3E40020000809135494000000040807C3E40070000A08D354940000000C0977C3E40
808	63	454	455	6	582.632029285220938	00:00:41.949506	0102000020E61000000D000000050000208C35494000000060957C3E40070000A08D354940000000C0977C3E40F9FFFFFF8935494000000080B17C3E40FFFFFF3F7F354940000000E0067D3E40010000207D354940000000E0187D3E40FCFFFFFF7C35494000000000227D3E40FEFFFF7F7E354940000000802D7D3E40050000808035494000000080387D3E40060000E084354940000000804C7D3E40FDFFFFBF89354940000000206B7D3E40FEFFFF7F8E354940000000008A7D3E40060000E09035494000000000A47D3E400000000098354940000000A0E27D3E40
809	63	455	456	7	1004.9636782087083	00:01:12.357385	0102000020E61000000A000000F9FFFF5F9635494000000080E37D3E400000000098354940000000A0E27D3E40FBFFFFDF9F35494000000040287E3E4003000040A6354940000000004B7E3E40FEFFFF7FAA354940000000E0607E3E40030000A0BE354940000000A0CF7E3E40FCFFFF9FC8354940000000C0057F3E40FCFFFF3FD035494000000000B97F3E40070000A0D135494000000020C17F3E40020000E0E9354940000000A019803E40
810	63	456	457	8	1189.33264585663528	00:01:25.631951	0102000020E61000000D000000010000C0E8354940000000601E803E40020000E0E9354940000000A019803E40070000A0D135494000000020C17F3E40FCFFFF3FD035494000000000B97F3E40FCFFFF9FC8354940000000C0057F3E40030000A0BE354940000000A0CF7E3E40FEFFFF7FAA354940000000E0607E3E4003000040A6354940000000004B7E3E40FBFFFFDF9F35494000000040287E3E400000000098354940000000A0E27D3E40060000E09035494000000000A47D3E400600004089354940000000A0957D3E40060000408135494000000000837D3E40
811	63	457	458	9	411.284626280890052	00:00:29.612493	0102000020E610000008000000F9FFFF5F82354940000000207F7D3E40060000408135494000000000837D3E40FFFFFF3F7335494000000080657D3E40070000006E354940000000007C7D3E40FEFFFF1F66354940000000009E7D3E40030000405A35494000000080D97D3E40010000C05035494000000040C97D3E40060000403D35494000000020A07D3E40
812	63	458	459	10	302.492495357574455	00:00:21.77946	0102000020E61000000B000000FEFFFF7F3E354940000000409B7D3E40060000403D35494000000020A07D3E40FBFFFF7F2B354940000000807A7D3E40FAFFFFBF2235494000000060697D3E40000000601C354940000000E0607D3E40070000001635494000000080597D3E40F9FFFF5F0E35494000000020587D3E400500002008354940000000205F7D3E40FFFFFF3FFF344940000000606A7D3E40010000C0F8344940000000C0787D3E40070000A0F5344940000000A0827D3E40
813	63	459	460	11	825.185335763784792	00:00:59.413344	0102000020E61000000C00000005000020F434494000000020807D3E40070000A0F5344940000000A0827D3E4007000000EE344940000000609E7D3E4004000060EB344940000000E0A77D3E40030000A0EA344940000000A0AF7D3E40060000E0E8344940000000A0D07D3E4005000020E4344940000000801A7E3E40FCFFFFFFDC34494000000060857E3E4005000080D4344940000000A0FE7E3E40F9FFFFFFD1344940000000E0287F3E40040000C0CF344940000000604C7F3E40FFFFFFDFCE344940000000A05E7F3E40
814	63	460	461	12	1133.09565350068874	00:01:21.582887	0102000020E610000015000000FDFFFFBFCD344940000000A05E7F3E40FFFFFFDFCE344940000000A05E7F3E40FFFFFF3FCB34494000000040B07F3E40FCFFFFFFC834494000000060D97F3E4006000040C934494000000060F97F3E40FEFFFF7FCA344940000000401D803E40030000A0CA344940000000203B803E40060000E0C8344940000000A071803E40FFFFFFDFC634494000000020A3803E4005000080C4344940000000E0B1803E40070000A0BD344940000000A0D8803E4001000020B1344940000000A01A813E40000000A0AB344940000000402D813E4001000020A5344940000000A040813E40FEFFFF7F9E344940000000205C813E40FCFFFF9F983449400000000074813E40FFFFFFDF92344940000000C090813E40000000A08B34494000000040B2813E40FCFFFF3F8C34494000000060C2813E40FEFFFF1F8E344940000000E0D2813E400000006090344940000000C0E3813E40
815	63	461	462	13	765.832777065615346	00:00:55.13996	0102000020E61000000A000000FFFFFF3F8F34494000000000E6813E400000006090344940000000C0E3813E400400006097344940000000000F823E40FBFFFF7F9F344940000000E03E823E4002000080B134494000000040AE823E40FAFFFFBFB634494000000080D3823E40000000A0BF344940000000201E833E4005000080C83449400000000071833E40030000A0CA3449400000002086833E4001000020CD3449400000006097833E40
816	63	462	208	14	601.023732486857057	00:00:43.273709	0102000020E610000007000000FBFFFFDFCB344940000000A099833E4001000020CD3449400000006097833E40FAFFFF1FDB34494000000040EF833E40020000E0C9344940000000E00E843E40FCFFFF3FA8344940000000004B843E40FEFFFF1F7E344940000000A097843E40FAFFFF1F73344940000000A0AB843E40
817	64	\N	184	0	0	00:00:00	\N
818	64	184	463	1	796.572314789577149	00:00:57.353207	0102000020E61000000E000000000000006C34494005000080F4843E40040000006B344940090000E0EF843E40FDFFFFBF71344940F5FFFFFFDE843E40040000C07334494004000000CB843E40FBFFFFDF73344940FCFFFFFFC4843E40060000E0703449400A000040B0843E40FAFFFF1F733449400E0000A0AB843E40FEFFFF1F7E344940000000A097843E40FCFFFF3FA8344940040000004B843E40020000E0C9344940FFFFFFDF0E843E40FAFFFF1FDB344940FFFFFF3FEF833E4001000020CD344940F6FFFF5F97833E40030000A0CA344940FEFFFF1F86833E4005000080C83449400B00000071833E40
819	64	463	464	2	729.171149971673003	00:00:52.500323	0102000020E610000009000000020000E0C9344940080000C06E833E4005000080C83449400B00000071833E40000000A0BF344940FEFFFF1F1E833E40FAFFFFBFB6344940FBFFFF7FD3823E4002000080B1344940F5FFFF3FAE823E40FBFFFF7F9F344940FFFFFFDF3E823E400400006097344940F5FFFFFF0E823E400000006090344940040000C0E3813E40FEFFFF1F8E3449400D0000E0D2813E40
820	64	464	465	3	460.43641347780806	00:00:33.151422	0102000020E61000000B000000FBFFFF7F8F344940090000E0CF813E40FEFFFF1F8E3449400D0000E0D2813E40FCFFFF3F8C344940F9FFFF5FC2813E40000000A08B34494003000040B2813E40FFFFFFDF92344940010000C090813E40FCFFFF9F98344940F2FFFFFF73813E40FEFFFF7F9E344940050000205C813E4001000020A53449400A0000A040813E40000000A0AB344940060000402D813E4001000020B1344940030000A01A813E40070000A0BD3449400A0000A0D8803E40
821	64	465	466	4	744.095447305395055	00:00:53.574872	0102000020E61000000D000000FAFFFF1FBF34494004000000DB803E40070000A0BD3449400A0000A0D8803E4005000080C4344940020000E0B1803E40FFFFFFDFC6344940FAFFFF1FA3803E40060000E0C8344940F9FFFF9F71803E40030000A0CA344940FAFFFF1F3B803E40FEFFFF7FCA344940060000401D803E4006000040C93449400B000060F97F3E40FCFFFFFFC83449400B000060D97F3E40FFFFFF3FCB3449400A000040B07F3E40FFFFFFDFCE344940F5FFFF9F5E7F3E40040000C0CF344940F2FFFF5F4C7F3E40F9FFFFFFD1344940F8FFFFDF287F3E40
822	64	466	467	5	732.21593401204359	00:00:52.719547	0102000020E61000000A000000000000A0D3344940F8FFFF3F297F3E40F9FFFFFFD1344940F8FFFFDF287F3E4005000080D4344940F5FFFF9FFE7E3E40FCFFFFFFDC344940FDFFFF5F857E3E4005000020E43449400C0000801A7E3E40060000E0E83449400A0000A0D07D3E40030000A0EA344940000000A0AF7D3E4004000060EB344940090000E0A77D3E4007000000EE344940070000609E7D3E40070000A0F5344940030000A0827D3E40
823	64	467	468	6	300.971902727209169	00:00:21.669977	0102000020E61000000B000000FFFFFFDFF6344940FEFFFF7F867D3E40070000A0F5344940030000A0827D3E40010000C0F8344940010000C0787D3E40FFFFFF3FFF344940F9FFFF5F6A7D3E400500002008354940080000205F7D3E40F9FFFF5F0E354940F7FFFF1F587D3E40070000001635494002000080597D3E40000000601C354940F8FFFFDF607D3E40FAFFFFBF223549400B000060697D3E40FBFFFF7F2B3549400C0000807A7D3E40060000403D354940F7FFFF1FA07D3E40
824	64	468	469	7	307.77892284339373	00:00:22.160082	0102000020E610000006000000010000C03C354940FDFFFFBFA57D3E40060000403D354940F7FFFF1FA07D3E40010000C050354940F8FFFF3FC97D3E40030000405A35494002000080D97D3E40FEFFFF1F66354940070000009E7D3E40070000006E3549400E0000007C7D3E40
825	64	469	455	8	293.974078589301484	00:00:21.166134	0102000020E610000007000000FFFFFF3F6F354940090000E07F7D3E40070000006E3549400E0000007C7D3E40FFFFFF3F73354940F4FFFF7F657D3E40060000408135494004000000837D3E400600004089354940070000A0957D3E40060000E090354940F2FFFFFFA37D3E400000000098354940030000A0E27D3E40
826	64	455	456	9	1004.96367820379317	00:01:12.357385	0102000020E61000000A000000F9FFFF5F96354940FBFFFF7FE37D3E400000000098354940030000A0E27D3E40FBFFFFDF9F3549400A000040287E3E4003000040A6354940040000004B7E3E40FEFFFF7FAA354940F8FFFFDF607E3E40030000A0BE354940000000A0CF7E3E40FCFFFF9FC8354940FDFFFFBF057F3E40FCFFFF3FD03549400B000000B97F3E40070000A0D135494001000020C17F3E40020000E0E9354940F9FFFF9F19803E40
827	64	456	472	10	1215.8194577605193	00:01:27.539001	0102000020E61000000C000000010000C0E8354940070000601E803E40020000E0E9354940F9FFFF9F19803E40070000A0D135494001000020C17F3E40FCFFFF3FD03549400B000000B97F3E40FCFFFF9FC8354940FDFFFFBF057F3E40030000A0BE354940000000A0CF7E3E40FEFFFF7FAA354940F8FFFFDF607E3E40FBFFFFDF9F3549400A000040287E3E400000000098354940030000A0E27D3E40060000E090354940F2FFFFFFA37D3E40FEFFFF7F8E354940F9FFFFFF897D3E40FDFFFFBF89354940FAFFFF1F6B7D3E40
828	64	472	473	11	416.540059877662372	00:00:29.990884	0102000020E61000000B000000FFFFFF3F8B35494001000020697D3E40FDFFFFBF89354940FAFFFF1F6B7D3E40060000E084354940050000804C7D3E400500008080354940F7FFFF7F387D3E40FEFFFF7F7E354940F4FFFF7F2D7D3E40FCFFFFFF7C354940F9FFFFFF217D3E40010000207D354940F8FFFFDF187D3E40FFFFFF3F7F354940FFFFFFDF067D3E40F9FFFFFF8935494002000080B17C3E40070000A08D354940F6FFFFBF977C3E4002000080913549400A000040807C3E40
829	64	473	474	12	379.301662610825474	00:00:27.30972	0102000020E61000000A000000FAFFFFBF92354940F9FFFFFF817C3E4002000080913549400A000040807C3E400400000097354940FFFFFFDF5E7C3E40010000C098354940F4FFFFDF457C3E40FCFFFF3F98354940070000602E7C3E40FBFFFFDF93354940070000000E7C3E40010000C08C35494000000060E87B3E40FDFFFFBF89354940FCFFFF9FD47B3E40040000607F3549400B0000C0C17B3E40FFFFFF3F83354940F8FFFFDFB07B3E40
831	64	475	476	14	599.525607093737221	00:00:43.165844	0102000020E61000000900000004000000B3354940FCFFFF9FEC7A3E40FCFFFFFFB035494002000080E97A3E4005000020C0354940F7FFFF7FA87A3E40FDFFFF5FC5354940F5FFFF9F9E7A3E4000000000D43549400D0000E0827A3E40070000A0D9354940050000207C7A3E40020000E0DD354940090000E06F7A3E4005000020043649400D000040037A3E40FCFFFFFF18364940020000E0C1793E40
832	64	476	449	15	1529.75689224928465	00:01:50.142496	0102000020E61000000F000000030000401A36494007000000C6793E40FCFFFFFF18364940020000E0C1793E40020000E02D3649400100002081793E40000000A03B364940FDFFFFBF4D793E40FEFFFF7F463649400900008027793E40FDFFFF5F61364940F5FFFF3FD6783E40040000006B36494002000080B9783E40FBFFFFDF87364940F9FFFFFF69783E40FBFFFF7F933649400B00000049783E40030000A0B2364940F2FFFF5F04783E40FCFFFF3FCC364940040000C0CB773E4006000040F13649400200008079773E40FDFFFF5F15374940F8FFFF3FC1773E400000000038374940FDFFFFBF05783E40FEFFFF1F3E3749400B00006011783E40
833	65	\N	478	0	0	00:00:00	\N
834	65	478	479	1	883.06312119159179	00:01:03.580545	0102000020E61000000D000000030000A0F63F494000000060605D3E40000000E0F63F494000000060655D3E4000000000E43F4940000000E0685D3E4000000040C73F4940000000806F5D3E40000000C0A23F494000000060795D3E40000000A09A3F4940000000807C5D3E40000000609D3F4940000000E0DD5D3E40000000609F3F494000000020285E3E40000000809F3F4940000000E0495E3E40000000C09E3F494000000040645E3E40000000609B3F4940000000A0915E3E40000000E0943F4940000000A0B95E3E40000000008F3F494000000060DB5E3E40
835	65	479	480	2	1042.90759583774752	00:01:15.089347	0102000020E61000000A000000020000808D3F494000000040D95E3E40000000008F3F494000000060DB5E3E4000000040843F4940000000C01C5F3E4000000080813F4940000000402F5F3E40000000E07C3F4940000000A0485F3E4000000080723F4940000000A07C5F3E40000000E0653F494000000040BD5F3E40000000805B3F494000000060F25F3E4000000060303F4940000000E0CE603E4000000060203F49400000000020613E40
836	65	480	481	3	1314.58785547211346	00:01:34.650326	0102000020E610000008000000000000401E3F4940000000001D613E4000000060203F49400000000020613E4000000040053F4940000000E0AA613E4000000080E73E49400000002043623E4000000060D53E4940000000409F623E4000000060BF3E4940000000600F633E4000000020A53E49400000002097633E40000000E0913E4940000000C0F9633E40
837	65	481	482	4	409.158495390713767	00:00:29.459412	0102000020E61000000400000000000060903E4940000000E0F7633E40000000E0913E4940000000C0F9633E40000000406C3E494000000020BA643E40000000A0653E494000000020DB643E40
838	65	482	483	5	425.32186974561921	00:00:30.623175	0102000020E61000000F00000000000060643E4940000000A0D8643E40000000A0653E494000000020DB643E40000000805D3E4940000000A002653E4000000020573E4940000000E012653E4000000000473E4940000000002E653E40000000C0413E4940000000C036653E4000000020403E49400000004038653E40000000C03C3E4940000000203C653E40000000203B3E4940000000204A653E40000000203B3E4940000000E057653E40000000003D3E49400000008063653E40000000403D3E4940000000606E653E40000000403C3E4940000000607C653E4000000040353E49400000002098653E40000000202E3E494000000040B2653E40
839	65	483	484	6	903.255475059872197	00:01:05.034394	0102000020E610000008000000060000E02C3E494000000000AF653E40000000202E3E494000000040B2653E4000000020153E4940000000400E663E40000000C0F53D4940000000A081663E4000000060DE3D494000000040DA663E40000000A0C13D49400000008046673E4000000080BF3D4940000000A04F673E4000000060AD3D4940000000C091673E40
840	65	484	485	7	226.720906803498963	00:00:16.323905	0102000020E610000006000000FCFFFF3FAC3D4940000000808E673E4000000060AD3D4940000000C091673E40000000009F3D4940000000E0C7673E4000000080983D494000000020E0673E4000000060843D4940000000C0DF673E40000000407F3D494000000080E0673E40
841	65	485	486	8	389.760679523135082	00:00:28.062769	0102000020E610000005000000000000A07F3D494000000080DB673E40000000407F3D494000000080E0673E40000000805A3D4940000000E0E0673E40000000202E3D4940000000E0E0673E4000000000FD3C494000000080E1673E40
842	65	486	487	9	486.976262963025476	00:00:35.062291	0102000020E61000000600000001000020FD3C4940000000E0DB673E4000000000FD3C494000000080E1673E40000000C0D03C494000000080E1673E4000000020A33C494000000040E2673E40000000C0783C4940000000E0E1673E40000000E0593C494000000040E2673E40
843	65	487	488	10	383.816527862140219	00:00:27.63479	0102000020E610000006000000F9FFFFFF593C4940000000A0DC673E40000000E0593C494000000040E2673E4000000060313C494000000040E2673E4000000040053C494000000040E3673E40000000A0E83B494000000040E3673E4000000000DA3B4940000000A0E3673E40
844	65	488	489	11	357.359954602480911	00:00:25.729917	0102000020E610000006000000F9FFFFFFD93B4940000000A0DD673E4000000000DA3B4940000000A0E3673E40000000C0AF3B4940000000A0E3673E40000000E08B3B494000000000E4673E40000000C0773B494000000000E4673E4000000060633B494000000000E4673E40
845	65	489	490	12	483.337946455543772	00:00:34.800332	0102000020E61000000A000000FBFFFF7F633B494000000020DF673E4000000060633B494000000000E4673E40000000A0393B494000000060E4673E4000000060193B4940000000C0E4673E40000000A0F83A494000000000E5673E4000000080DF3A494000000060E4673E4000000080D73A4940000000E0E2673E4000000040D13A4940000000C0DF673E40000000A0C93A494000000080D4673E40000000E0C53A4940000000C0CC673E40
846	66	\N	491	0	0	00:00:00	\N
847	66	491	492	1	479.331479700276077	00:00:34.511867	0102000020E610000008000000FBFFFF7FD73A4940F8FFFFDFE8673E4000000080D73A4940000000E0E2673E4000000080DF3A494000000060E4673E40000000A0F83A494000000000E5673E4000000060193B4940000000C0E4673E40000000A0393B494000000060E4673E4000000060633B494000000000E4673E40000000C0773B494000000000E4673E40
848	66	492	493	2	337.567029373044363	00:00:24.304826	0102000020E610000006000000040000C0773B49400A000040E8673E40000000C0773B494000000000E4673E40000000E08B3B494000000000E4673E40000000C0AF3B4940000000A0E3673E4000000000DA3B4940000000A0E3673E40000000A0E83B494000000040E3673E40
849	66	493	494	3	221.410899796254512	00:00:15.941585	0102000020E610000004000000FCFFFF9FE83B49400A000040E8673E40000000A0E83B494000000040E3673E4000000040053C494000000040E3673E4000000060313C494000000040E2673E40
850	66	494	495	4	217.165741725037805	00:00:15.635933	0102000020E610000004000000FDFFFF5F313C494008000020E7673E4000000060313C494000000040E2673E40000000E0593C494000000040E2673E40000000C0783C4940000000E0E1673E40
851	66	495	496	5	267.099855375374432	00:00:19.23119	0102000020E610000004000000010000C0783C494009000080E7673E40000000C0783C4940000000E0E1673E4000000020A33C494000000040E2673E40000000C0D03C494000000080E1673E40
852	66	496	497	6	535.316359483457177	00:00:38.542778	0102000020E610000007000000FCFFFF9FD03C494008000020E7673E40000000C0D03C494000000080E1673E4000000000FD3C494000000080E1673E40000000202E3D4940000000E0E0673E40000000805A3D4940000000E0E0673E40000000407F3D494000000080E0673E4000000060843D4940000000C0DF673E40
853	66	497	498	7	779.529063164792205	00:00:56.126093	0102000020E610000015000000000000A0843D494000000060E4673E4000000060843D4940000000C0DF673E4000000080983D494000000020E0673E40000000208B3D49400000006011683E4000000060863D4940000000E022683E4000000020863D4940000000802E683E4000000000873D49400000006039683E40000000C0893D49400000004042683E40000000A08D3D49400000006044683E40000000C08F3D49400000008041683E40000000E0923D4940000000A03C683E4000000020983D49400000008027683E40000000C0AC3D494000000080DB673E4000000040B53D494000000040BC673E40000000C0B93D494000000020AC673E4000000060BB3D4940000000609D673E4000000060BC3D4940000000608A673E4000000080BD3D49400000002079673E40000000C0BF3D4940000000E066673E4000000080C23D49400000000057673E4000000060CE3D4940000000C02A673E40
854	66	498	499	8	691.589236567406829	00:00:49.794425	0102000020E610000009000000FBFFFF7FCF3D4940060000E02C673E4000000060CE3D4940000000C02A673E4000000040DB3D494000000080F9663E40000000C0E53D494000000080D2663E40000000A0F03D494000000060AA663E4000000060013E4940000000E06B663E40000000A0153E4940000000801F663E4000000000223E494000000020F2653E4000000020313E4940000000A0BB653E40
855	66	499	500	9	474.922566171222002	00:00:34.194425	0102000020E61000000B00000003000040323E4940F3FFFF1FBD653E4000000020313E4940000000A0BB653E4000000040393E4940000000809D653E40000000403F3E49400000006088653E4000000020443E49400000002077653E4000000020483E4940000000806A653E40000000C04A3E49400000000061653E4000000080513E49400000002040653E40000000805D3E4940000000A002653E40000000A0653E494000000020DB643E40000000406C3E494000000020BA643E40
856	66	500	501	10	349.925193608297889	00:00:25.194614	0102000020E610000003000000020000806D3E494005000080BC643E40000000406C3E494000000020BA643E40000000E0913E4940000000C0F9633E40
857	66	501	502	11	1458.18037143567244	00:01:44.988987	0102000020E610000009000000FBFFFF7F933E494005000020FC633E40000000E0913E4940000000C0F9633E4000000020A53E49400000002097633E4000000060BF3E4940000000600F633E4000000060D53E4940000000409F623E4000000080E73E49400000002043623E4000000040053F4940000000E0AA613E4000000060203F49400000000020613E4000000060303F4940000000E0CE603E40
858	66	502	503	12	970.233231451108168	00:01:09.856793	0102000020E61000000A000000FDFFFFBF313F494002000080D1603E4000000060303F4940000000E0CE603E40000000805B3F494000000060F25F3E40000000E0653F494000000040BD5F3E4000000080723F4940000000A07C5F3E40000000E07C3F4940000000A0485F3E4000000080813F4940000000402F5F3E40000000C0863F494000000040165F3E4000000040913F4940000000C0DE5E3E4000000060993F494000000040B45E3E40
859	66	503	504	13	620.215857592856537	00:00:44.655542	0102000020E61000000C000000FAFFFFBF9A3F4940FEFFFF1FB65E3E4000000060993F494000000040B45E3E40000000609C3F494000000060A35E3E40000000A0AE3F4940000000A03F5E3E40000000E0B83F494000000000065E3E4000000060C53F494000000060C55D3E4000000080CA3F494000000020AE5D3E40000000E0CF3F4940000000E09B5D3E4000000020D43F494000000040915D3E4000000060DA3F4940000000C0855D3E4000000020E23F4940000000C07A5D3E40000000E0ED3F4940000000A0775D3E40
860	67	\N	505	0	0	00:00:00	\N
861	67	505	506	1	696.738014507952471	00:00:50.165137	0102000020E610000008000000FAFFFF1FFB31494000000080C6AA3E4000000060FC314940000000A0C1AA3E40F9FFFF5F0E324940000000E0F4AA3E40FCFFFF3F1432494000000020E0AA3E40030000A0323249400000004035AB3E40FEFFFF7F4E3249400000004083AB3E40F9FFFF5F6E324940000000E0DBAB3E40F9FFFF5F76324940000000C0F2AB3E40
862	67	506	507	2	747.385997646048963	00:00:53.811792	0102000020E610000007000000FDFFFF5F75324940000000A0F6AB3E40F9FFFF5F76324940000000C0F2AB3E400400000087324940000000C020AC3E4003000040AE324940000000808FAC3E40060000E0D432494000000080FCAC3E4002000080E5324940000000E02AAD3E4003000040FA3249400000006067AD3E40
863	67	507	508	3	513.007580515322161	00:00:36.936546	0102000020E61000000500000006000040F9324940000000806AAD3E4003000040FA3249400000006067AD3E40040000001733494000000080B7AD3E40FAFFFF1F373349400000000013AE3E400600004055334940000000E065AE3E40
864	67	508	509	4	733.133353508132814	00:00:52.785601	0102000020E61000001B0000000500002054334940000000E06AAE3E400600004055334940000000E065AE3E400500008058334940000000A074AE3E40000000A05B3349400000004087AE3E40FBFFFF7F5B3349400000008098AE3E40FFFFFFDF5A33494000000040ADAE3E40FCFFFF3F5833494000000040C6AE3E40FAFFFF1F5733494000000040DAAE3E40FFFFFF3F57334940000000A0EDAE3E4001000020593349400000004007AF3E40FBFFFF7F5B334940000000A01BAF3E40FAFFFFBF5E334940000000802CAF3E400400006063334940000000003BAF3E4000000060683349400000008046AF3E40070000006E334940000000004FAF3E4000000060743349400000000055AF3E40FFFFFFDF7A3349400000006056AF3E40020000E081334940000000A055AF3E4000000060883349400000008052AF3E40FDFFFFBF8D334940000000004EAF3E40060000E0903349400000000049AF3E40020000E095334940000000C037AF3E40030000A09A3349400000008025AF3E40070000A09D3349400000000015AF3E40000000A09F3349400000008004AF3E4001000020A133494000000020F0AE3E4001000020A1334940000000A0DAAE3E40
865	68	\N	510	0	0	00:00:00	\N
866	68	510	511	1	383.003988736473445	00:00:27.576287	0102000020E610000011000000FEFFFF7FA23349400B000060D9AE3E4001000020A1334940030000A0DAAE3E4005000080A0334940FAFFFFBFCAAE3E40030000409E334940FCFFFF9FB4AE3E40050000209C3349400B000000A1AE3E40020000E095334940040000C083AE3E40030000A092334940FDFFFFBF75AE3E400000006088334940F6FFFF5F6FAE3E40FBFFFFDF83334940070000006EAE3E400100002079334940070000A06DAE3E4004000000733349400100002071AE3E40010000C06C334940090000E077AE3E40000000A067334940F9FFFFFF79AE3E40030000A062334940030000A07AAE3E40FAFFFFBF5E334940F7FFFF7F78AE3E40030000A05A3349400300004072AE3E400600004055334940F4FFFFDF65AE3E40
867	68	511	512	2	354.251564756859921	00:00:25.506113	0102000020E610000004000000FEFFFF1F56334940F9FFFFFF61AE3E400600004055334940F4FFFFDF65AE3E40FAFFFF1F373349400400000013AE3E40040000001733494009000080B7AD3E40
868	68	512	513	3	951.978461854412558	00:01:08.542449	0102000020E610000009000000FBFFFF7F173349400E0000A0B3AD3E40040000001733494009000080B7AD3E4003000040FA324940F6FFFF5F67AD3E4002000080E53249400D0000E02AAD3E40060000E0D432494005000080FCAC3E4003000040AE324940090000808FAC3E400400000087324940010000C020AC3E40F9FFFF5F76324940FAFFFFBFF2AB3E40F9FFFF5F6E324940FBFFFFDFDBAB3E40
869	68	513	514	4	664.845623816647048	00:00:47.868885	0102000020E61000000A000000FBFFFF7F6F324940010000C0D8AB3E40F9FFFF5F6E324940FBFFFFDFDBAB3E40FEFFFF7F4E3249400D00004083AB3E40030000A0323249400600004035AB3E40FCFFFF3F14324940F7FFFF1FE0AA3E40020000E00532494007000000B6AA3E400500008000324940060000E0ACAA3E40060000E0FC314940FAFFFF1FABAA3E40FEFFFF1FFA3149400C000080BAAA3E4000000060FC314940F9FFFF9FC1AA3E40
870	69	\N	515	0	0	00:00:00	\N
871	69	515	516	1	713.064396883929135	00:00:51.340637	0102000020E61000000B00000000000000E043494000000040329C3E4000000000E043494000000080369C3E40010000C0D4434940000000C0339C3E40FAFFFF1FB7434940000000A02C9C3E40FCFFFF3F9843494000000000269C3E40000000008043494000000060209C3E40FCFFFF3F5C434940000000A0189C3E40FCFFFFFF38434940000000800F9C3E40000000A01B43494000000080089C3E40050000800043494000000080039C3E4005000080F042494000000000FF9B3E40
872	69	516	517	2	357.313426609407941	00:00:25.726567	0102000020E61000000900000000000060F042494000000060F99B3E4005000080F042494000000000FF9B3E40FDFFFFBFDD424940000000A0F89B3E4004000000D3424940000000C0F39B3E4001000020C542494000000060EC9B3E40FAFFFF1FB3424940000000A0DE9B3E400400000097424940000000C0C69B3E40030000A08642494000000060B39B3E40040000C08342494000000040B09B3E40
873	69	517	291	3	590.627969893143927	00:00:42.525214	0102000020E6100000080000000500002084424940000000E0A99B3E40040000C08342494000000040B09B3E40FBFFFFDF73424940000000209C9B3E40FFFFFFDF66424940000000408A9B3E40070000A04542494000000060539B3E40010000202542494000000020139B3E40050000201442494000000040EF9A3E40030000A0FA414940000000E0BA9A3E40
874	69	291	292	4	464.00969728897195	00:00:33.408698	0102000020E61000000A000000FBFFFF7FFB414940000000E0B59A3E40030000A0FA414940000000E0BA9A3E40FAFFFFBFEE41494000000080A19A3E40F9FFFF5FE641494000000000919A3E40FFFFFFDFDA414940000000E0759A3E40FFFFFFDFD2414940000000A0629A3E40FDFFFF5FC9414940000000004A9A3E4004000000BF41494000000080279A3E40FAFFFF1FB7414940000000C00C9A3E4005000080A841494000000060D8993E40
875	69	292	518	5	656.453974138518106	00:00:47.264686	0102000020E61000000B000000F9FFFFFFA9414940000000A0D5993E4005000080A841494000000060D8993E40FAFFFF1F9B41494000000060A9993E4003000040964149400000000097993E40FEFFFF7F8E414940000000A075993E40FDFFFF5F85414940000000804C993E40FAFFFFBF7E4149400000006029993E40040000607741494000000020FF983E40000000607041494000000080D8983E40FAFFFF1F6741494000000060A2983E40030000A05E414940000000C06F983E40
876	69	518	519	6	339.468975728943747	00:00:24.441766	0102000020E6100000050000000000006060414940000000A06D983E40030000A05E414940000000C06F983E40000000A04F4149400000002018983E40070000A04541494000000060DB973E40030000A03E41494000000040B3973E40
877	69	519	520	7	502.586419140658904	00:00:36.186222	0102000020E610000006000000FCFFFF3F40414940000000E0B0973E40030000A03E41494000000040B3973E40FCFFFF9F30414940000000405F973E40FEFFFF7F22414940000000C00D973E400400000017414940000000C0C7963E40FAFFFF1F0F414940000000609A963E40
878	69	520	521	8	408.997346351780379	00:00:29.447809	0102000020E61000000900000000000060104149400000004098963E40FAFFFF1F0F414940000000609A963E40020000E005414940000000A06A963E40FCFFFF3FFC404940000000403E963E40FBFFFF7FF3404940000000E01D963E40030000A0EA40494000000000FF953E40010000C0E440494000000020EF953E40FCFFFF9FD840494000000060CC953E40010000C0D4404940000000E0C3953E40
879	69	521	522	9	473.93197561690971	00:00:34.123102	0102000020E61000001400000007000000D640494000000040BD953E40010000C0D4404940000000E0C3953E4002000080CD40494000000000B2953E40020000E0C9404940000000E0A8953E4007000000BE404940000000207A953E40FFFFFFDFBA404940000000C06D953E40FBFFFFDFB74049400000006066953E4005000080B44049400000006066953E40020000E0B1404940000000606B953E4000000060B04049400000000072953E40FDFFFFBFAD404940000000E075953E40020000E0A9404940000000C078953E40010000C0A4404940000000C07A953E4002000080994049400000006078953E40020000E08D404940000000E074953E4000000060844049400000002074953E40FCFFFF3F7C4049400000002074953E40FCFFFFFF744049400000004077953E40F9FFFF5F6E404940000000807B953E400000000060404940000000408A953E40
880	69	522	523	10	225.94839402147565	00:00:16.268284	0102000020E610000007000000000000A05F404940000000C085953E400000000060404940000000408A953E400400006053404940000000E09C953E40FFFFFFDF4A404940000000A0A9953E40040000004340494000000040B7953E40070000A039404940000000C0CC953E40000000A02F404940000000A0EA953E40
881	69	523	524	11	397.426464924135018	00:00:28.614705	0102000020E610000008000000FEFFFF7F2E40494000000080E8953E40000000A02F404940000000A0EA953E40FAFFFF1F27404940000000400B963E40F9FFFF5F224049400000002021963E40020000801D404940000000A03F963E40FFFFFF3F17404940000000406B963E40020000E011404940000000009A963E40050000800C40494000000020C9963E40
882	69	524	525	12	471.422498049623869	00:00:33.94242	0102000020E61000000E000000FFFFFF3F0B404940000000C0C7963E40050000800C40494000000020C9963E40FCFFFFFF0840494000000020E8963E400500008000404940000000802F973E4003000040F23F4940000000A01F973E40010000C0E03F4940000000000C973E4004000060D33F494000000080FD963E40FDFFFFBFC93F494000000060F4963E40FEFFFF1FC23F4940000000A0EC963E4006000040BD3F4940000000C0E8963E40FEFFFF7FBA3F4940000000A0E6963E4004000000B33F4940000000E0E3963E40FCFFFF9FAC3F4940000000C0E2963E40FDFFFF5FA93F494000000020E2963E40
906	70	548	325	16	345.548149577024788	00:00:24.879467	0102000020E610000005000000FEFFFF1F4E414940F9FFFFFF19983E40000000A04F414940F7FFFF1F18983E40030000A05E414940F6FFFFBF6F983E40FAFFFF1F67414940F9FFFF5FA2983E400000006070414940F7FFFF7FD8983E40
883	69	525	526	13	937.7192237096599	00:01:07.515784	0102000020E61000000E000000070000A0A93F494000000020DC963E40FDFFFF5FA93F494000000020E2963E40FBFFFF7F973F4940000000C0E0963E40FBFFFF7F8F3F494000000020DB963E4005000020883F494000000080D0963E40FDFFFF5F813F494000000000BF963E4002000080793F4940000000C0A7963E40FBFFFF7F733F4940000000C08D963E40FEFFFF1F6E3F4940000000206E963E40FAFFFFBF6E3F494000000000F3953E40040000006F3F49400000000092953E40030000A06E3F4940000000005E953E40070000A06D3F4940000000C038953E40010000C06C3F4940000000A0F6943E40
884	69	526	527	14	957.511499239843261	00:01:08.940828	0102000020E610000008000000F9FFFF5F6E3F494000000040F6943E40010000C06C3F4940000000A0F6943E40060000E06C3F494000000000B8943E40060000406D3F4940000000E041943E40FDFFFF5F6D3F4940000000C0F0933E40FDFFFFBF6D3F494000000000B7933E40030000A06E3F49400000008025933E40030000A06E3F494000000020C5923E40
885	69	527	528	15	1584.74194592082904	00:01:54.10142	0102000020E61000000E00000005000020703F4940000000E0C4923E40030000A06E3F494000000020C5923E40FEFFFF7F6E3F4940000000C07D923E40FEFFFF7F6E3F49400000008018923E40FAFFFF1F6F3F494000000020A3913E40040000606F3F4940000000604D913E40000000A06F3F494000000020EE903E40FBFFFF7F6F3F4940000000808E903E40FFFFFFDF6E3F4940000000003F903E40020000E06D3F4940000000C005903E40000000006C3F4940000000E0C78F3E40F9FFFFFF693F4940000000008B8F3E40FAFFFF1F673F4940000000E0478F3E4006000040653F494000000040228F3E40
886	69	528	529	16	1694.86383465038261	00:02:02.030196	0102000020E610000010000000FFFFFFDF663F494000000080218F3E4006000040653F494000000040228F3E40030000A0623F4940000000A0EF8E3E40FAFFFFBF5E3F494000000080B28E3E40000000A05B3F4940000000E07F8E3E4003000040563F4940000000E02D8E3E40FDFFFFBF4D3F494000000000AF8D3E40FAFFFF1F473F494000000060488D3E4000000000403F494000000080DE8C3E40060000E0383F494000000080718C3E4005000020343F494000000000278C3E40010000C0303F494000000000F48B3E40020000E02D3F494000000020C88B3E40030000402A3F4940000000209B8B3E4007000000263F4940000000606C8B3E40070000A0213F494000000040458B3E40
887	69	529	530	17	2288.20263116541992	00:02:44.750589	0102000020E610000016000000FBFFFFDF233F4940000000E0428B3E40070000A0213F494000000040458B3E40030000A01A3F4940000000A0118B3E4004000060133F494000000020E18A3E40FDFFFF5F093F4940000000A09D8A3E40F9FFFF5FFE3E4940000000E0568A3E40060000E0F43E4940000000801A8A3E40FBFFFFDFE73E494000000020C6893E40040000C0DB3E49400000004075893E40FBFFFFDFCF3E49400000002027893E4000000000B43E4940000000806C883E4000000000A03E4940000000C0E9873E40FBFFFFDF9B3E494000000040CD873E40FEFFFF7F963E494000000000A1873E4006000040913E4940000000A06D873E40070000A0893E4940000000201D873E40FDFFFF5F853E494000000020E9863E40FAFFFF1F833E494000000080C4863E40F9FFFFFF813E494000000020A9863E40FBFFFF7F7F3E4940000000405E863E40FEFFFF7F7E3E4940000000803D863E40FEFFFF7F7E3E49400000006026863E40
888	69	530	531	18	1799.57289628666126	00:02:09.569249	0102000020E610000010000000FCFFFFFF803E49400000006026863E40FEFFFF7F7E3E49400000006026863E40FEFFFF1F7E3E494000000040F1853E40FAFFFFBF7E3E4940000000A0B2853E40000000A07F3E49400000008076853E40FCFFFFFF803E4940000000A02B853E40FEFFFF7F823E494000000060DF843E4005000020843E4940000000A091843E4002000080853E4940000000C052843E40FAFFFF1F873E4940000000C0FE833E4001000020893E494000000080A0833E40FAFFFFBF8A3E4940000000E04D833E40FCFFFF3F8C3E4940000000E0FF823E40030000408E3E494000000000A2823E40FBFFFFDF8F3E4940000000C04F823E4002000080913E4940000000A006823E40
912	71	\N	553	0	0	00:00:00	\N
966	73	431	432	23	480.682790094648965	00:00:34.609161	0102000020E610000008000000FBFFFFDF8F34494000000020BE653E40FCFFFF9F90344940000000C0C2653E40FFFFFF3F83344940000000E0E4653E40FDFFFF5F75344940000000400D663E40060000E0683449400000008038663E40070000005E3449400000004061663E40060000E0543449400000000089663E40FFFFFFDF4A344940000000A0BC663E40
889	69	531	532	19	2040.76336056405125	00:02:26.934962	0102000020E610000017000000FFFFFF3F933E4940000000A006823E4002000080913E4940000000A006823E40FFFFFF3F933E494000000040A7813E4002000080953E4940000000C049813E4004000000973E494000000040EC803E40FAFFFF1F9B3E494000000060B1803E40FAFFFFBF9E3E4940000000008A803E40FAFFFF1FA33E4940000000006A803E40020000E0AD3E4940000000A02E803E40FCFFFFFFB43E4940000000C004803E40020000E0ED3E494000000040617F3E40FBFFFFDF073F4940000000A0137F3E40040000000F3F494000000020107F3E40060000E0143F4940000000E0197F3E40FEFFFF1F163F4940000000802B7F3E4000000000143F4940000000803E7F3E40010000C00C3F4940000000E0527F3E40FAFFFFBF023F494000000020657F3E40020000E0ED3E494000000040617F3E4004000060DF3E494000000000637F3E40070000A0A13E494000000040607F3E4005000080743E4940000000E0607F3E40060000E05C3E4940000000A0607F3E40
890	70	\N	533	0	0	00:00:00	\N
891	70	533	534	1	1479.8392808002036	00:01:46.548428	0102000020E61000000C000000FDFFFFBF213E4940F8FFFF3FA97F3E4004000060233E4940020000E0A97F3E40FAFFFFBF1E3E4940F3FFFFBF34803E40FAFFFFBF1A3E494004000000BB803E40FCFFFFFF143E49400A00004058813E40F9FFFF5F123E4940080000C08E813E40020000E0193E4940000000A07F813E40FAFFFFBF2A3E49400200008051813E40FFFFFFDF423E49400100002009813E40060000E0603E4940F7FFFF1FB0803E40030000A07E3E49400A0000A058803E4006000040853E4940F5FFFF9F46803E40
892	70	534	535	2	875.546503436210742	00:01:03.039348	0102000020E61000000D000000FEFFFF7F863E49400D0000404B803E4006000040853E4940F5FFFF9F46803E40FDFFFF5F913E4940020000E029803E40FDFFFF5F913E4940040000C053803E4006000040913E4940080000C06E803E4001000020913E4940F3FFFF1F7D803E40FBFFFF7F933E494009000080B7803E40FAFFFF1F933E4940010000C0C8803E40F9FFFFFF913E4940FDFFFF5FED803E40FCFFFF3F903E4940FBFFFF7F43813E40FFFFFFDF8E3E49400B00006089813E40020000808D3E4940040000C0C3813E40FCFFFF3F8C3E4940060000E004823E40
893	70	535	536	3	453.581691688499575	00:00:32.657882	0102000020E610000007000000030000A08A3E4940060000E004823E40FCFFFF3F8C3E4940060000E004823E40040000008B3E4940F9FFFF5F42823E4002000080893E4940FAFFFF1F8B823E40060000E0883E4940F4FFFFDFAD823E40FBFFFFDF873E4940090000E0E7823E4004000000873E4940060000400D833E40
894	70	536	537	4	904.317837272512975	00:01:05.110884	0102000020E610000009000000FDFFFFBF853E4940060000400D833E4004000000873E4940060000400D833E4002000080853E49400C0000205A833E40000000A0833E4940F5FFFF9FB6833E40030000A0823E4940F5FFFF3FEE833E40060000E0803E4940F6FFFFBF3F843E40FEFFFF7F7E3E4940FEFFFF1FAE843E40FCFFFF9F7C3E4940F7FFFF7F08853E40050000207C3E4940F6FFFFBF1F853E40
895	70	537	538	5	981.984484546694716	00:01:10.702883	0102000020E61000000D000000030000A07A3E4940F6FFFF5F1F853E40050000207C3E4940F6FFFFBF1F853E40030000A07A3E49400800002047853E4006000040793E4940080000C086853E40FBFFFFDF773E4940F6FFFF5FC7853E4004000060773E4940060000E024863E40FBFFFFDF773E4940080000C04E863E4002000080793E4940F5FFFFFF86863E40040000C07B3E4940FDFFFFBFB5863E40FCFFFFFF7C3E4940F7FFFF7FD0863E4005000020803E49400500002004873E40040000C0833E49400300004032873E40FBFFFFDF873E4940FEFFFF1F5E873E40
896	70	538	539	6	1776.76998633672497	00:02:07.927439	0102000020E610000010000000070000A0853E49400B00000061873E40FBFFFFDF873E4940FEFFFF1F5E873E40040000008B3E4940090000E07F873E40070000A08D3E4940F7FFFF1F98873E4006000040913E4940F5FFFFFFAE873E4005000020983E4940FEFFFF7FDE873E40FCFFFF3FA43E4940070000A02D883E4004000060AF3E4940F7FFFF1F78883E40000000A0C33E49400E0000A0FB883E40FFFFFF3FD73E4940FBFFFF7F7B893E4002000080F93E4940070000005E8A3E4000000000043F49400D0000E0A28A3E4005000020143F49400D0000400B8B3E40FAFFFF1F173F49400B000060218B3E40030000A01A3F4940F9FFFF5F3A8B3E40020000801D3F4940090000E04F8B3E40
897	70	539	540	7	1699.48563398235024	00:02:02.362966	0102000020E61000000F000000000000A01B3F4940F9FFFFFF518B3E40020000801D3F4940090000E04F8B3E40020000E0213F4940F3FFFF1F758B3E4003000040263F4940FCFFFF3FA48B3E40040000002B3F4940090000E0D78B3E40FCFFFF9F303F4940010000C0288C3E40060000E0343F4940F7FFFF1F708C3E40040000C03B3F4940080000C0D68C3E4002000080413F4940070000A02D8D3E40020000E0493F494000000060B08D3E40FEFFFF1F523F4940050000802C8E3E40000000A0573F494003000040828E3E40FFFFFF3F5B3F49400C000080BA8E3E40030000A05E3F4940FBFFFFDFF38E3E40FDFFFF5F613F4940FEFFFF7F2E8F3E40
898	70	540	541	8	1571.93889440152202	00:01:53.1796	0102000020E61000000B000000000000A05F3F4940FFFFFF3F2F8F3E40FDFFFF5F613F4940FEFFFF7F2E8F3E40F9FFFF5F663F494003000040A28F3E40010000C0683F4940F6FFFF5FFF8F3E40F9FFFF5F6A3F49400E0000004C903E40040000606B3F4940FBFFFFDFC3903E40040000006B3F4940060000E01C913E40040000006B3F4940F8FFFF3F91913E40FEFFFF1F6A3F49400200008011923E40020000E0693F4940F4FFFF7F7D923E40070000A0693F49400B000060C9923E40
899	70	541	542	9	939.231209005383903	00:01:07.624647	0102000020E610000008000000FBFFFF7F673F49400B0000C0C9923E40070000A0693F49400B000060C9923E4001000020693F49400400000023933E40060000E0683F4940F9FFFFFF69933E40060000E0683F494005000020CC933E40060000E0683F4940FCFFFF9F14943E40FCFFFF9F683F49400700000076943E4005000020683F4940FFFFFF3FEF943E40
900	70	542	543	10	1140.7601829076591	00:01:22.134733	0102000020E610000014000000030000A0663F4940FFFFFFDFEE943E4005000020683F4940FFFFFF3FEF943E4004000060673F4940FFFFFFDF0E953E40FEFFFF1F663F49400D0000E03A953E4005000080643F4940F9FFFFFF71953E4000000000643F4940010000C098953E4000000000643F4940030000A0CA953E4005000020643F4940F9FFFF5F32963E40040000C0633F4940F7FFFF7F70963E40030000A0623F49400C000080E2963E40FAFFFFBF623F4940F9FFFF9FF1963E40030000A06A3F4940080000C0EE963E40FDFFFF5F713F494003000040EA963E4007000000763F4940FBFFFF7FE3963E40060000E08C3F49400B0000C0E1963E40FBFFFF7F973F4940010000C0E0963E40FDFFFF5FA93F49400C000020E2963E40FCFFFF9FAC3F4940FAFFFFBFE2963E4004000000B33F4940FBFFFFDFE3963E40FEFFFF7FBA3F4940F5FFFF9FE6963E40
901	70	543	544	11	373.020977358054097	00:00:26.85751	0102000020E61000000A000000F9FFFF5FBA3F4940FCFFFF9FEC963E40FEFFFF7FBA3F4940F5FFFF9FE6963E4006000040BD3F4940010000C0E8963E40FEFFFF1FC23F4940FCFFFF9FEC963E40FDFFFFBFC93F4940F2FFFF5FF4963E4004000060D33F4940F4FFFF7FFD963E40010000C0E03F49400E0000000C973E4003000040F23F4940000000A01F973E400500008000404940090000802F973E40FCFFFFFF08404940F7FFFF1FE8963E40
902	70	544	545	12	670.276993382668024	00:00:48.259944	0102000020E61000000E000000FAFFFFBF0A404940020000E0E9963E40FCFFFFFF08404940F7FFFF1FE8963E40050000800C40494001000020C9963E40020000E011404940F9FFFFFF99963E40FFFFFF3F174049400D0000406B963E40020000801D404940000000A03F963E40F9FFFF5F224049400100002021963E40FAFFFF1F274049400D0000400B963E40000000A02F404940030000A0EA953E40070000A039404940F3FFFFBFCC953E400400000043404940FFFFFF3FB7953E40FFFFFFDF4A404940F9FFFF9FA9953E400400006053404940060000E09C953E400000000060404940030000408A953E40
903	70	545	546	13	495.551478856481538	00:00:35.679706	0102000020E610000012000000010000C060404940FFFFFFDF8E953E400000000060404940030000408A953E40F9FFFF5F6E404940FBFFFF7F7B953E40FCFFFFFF74404940FFFFFF3F77953E40FCFFFF3F7C4049400500002074953E4000000060844049400500002074953E40020000E08D404940060000E074953E4002000080994049400000006078953E40010000C0A4404940FAFFFFBF7A953E40FEFFFF7FAE404940040000C083953E40FAFFFFBFB2404940FFFFFF3F87953E40030000A0B6404940F3FFFF1F8D953E4005000080C04049400E0000A09B953E40070000A0C94049400C000080AA953E4002000080CD404940F9FFFFFFB1953E40010000C0D4404940FBFFFFDFC3953E40FCFFFF9FD8404940F2FFFF5FCC953E40010000C0E440494008000020EF953E40
904	70	546	547	14	403.52052751597671	00:00:29.053478	0102000020E610000008000000000000A0E3404940F9FFFF5FF2953E40010000C0E440494008000020EF953E40030000A0EA404940F5FFFFFFFE953E40FBFFFF7FF3404940F4FFFFDF1D963E40FCFFFF3FFC404940F5FFFF3F3E963E40020000E005414940030000A06A963E40FAFFFF1F0F414940F9FFFF5F9A963E400400000017414940F6FFFFBFC7963E40
905	70	547	548	15	600.882934155638736	00:00:43.263571	0102000020E610000007000000FDFFFF5F154149400C000080CA963E400400000017414940F6FFFFBFC7963E40FEFFFF7F22414940FDFFFFBF0D973E40FCFFFF9F30414940FFFFFF3F5F973E40030000A03E4149400D000040B3973E40070000A04541494004000060DB973E40000000A04F414940F7FFFF1F18983E40
1068	80	\N	308	0	0	00:00:00	\N
907	70	325	326	17	381.822452076952288	00:00:27.491217	0102000020E610000008000000FFFFFF3F6F4149400D000040DB983E400000006070414940F7FFFF7FD8983E40040000607741494008000020FF983E40FAFFFFBF7E4149400B00006029993E40FDFFFF5F85414940050000804C993E40FEFFFF7F8E414940070000A075993E400300004096414940F5FFFFFF96993E40FAFFFF1F9B4149400B000060A9993E40
908	70	326	549	18	744.886509907867094	00:00:53.631829	0102000020E61000000D000000020000E09941494005000080AC993E40FAFFFF1F9B4149400B000060A9993E4005000080A841494000000060D8993E40FAFFFF1FB7414940F3FFFFBF0C9A3E4004000000BF41494009000080279A3E40FDFFFF5FC9414940F9FFFFFF499A3E40FFFFFFDFD2414940030000A0629A3E40FFFFFFDFDA414940F4FFFFDF759A3E40F9FFFF5FE64149400B000000919A3E40FAFFFFBFEE41494002000080A19A3E40030000A0FA4149400D0000E0BA9A3E400500002014424940FFFFFF3FEF9A3E400100002025424940FAFFFF1F139B3E40
909	70	549	550	19	404.454554202267559	00:00:29.120728	0102000020E610000007000000FCFFFF3F2442494000000060189B3E400100002025424940FAFFFF1F139B3E40070000A04542494004000060539B3E40FFFFFFDF66424940030000408A9B3E40FBFFFFDF73424940050000209C9B3E40040000C0834249400A000040B09B3E40030000A08642494004000060B39B3E40
910	70	550	551	20	471.518949321124637	00:00:33.949364	0102000020E61000000A0000000300004086424940FFFFFF3FB79B3E40030000A08642494004000060B39B3E400400000097424940080000C0C69B3E40FAFFFF1FB3424940F5FFFF9FDE9B3E4001000020C5424940F2FFFF5FEC9B3E4004000000D3424940040000C0F39B3E40FDFFFFBFDD4249400A0000A0F89B3E4005000080F0424940F5FFFFFFFE9B3E400500008000434940FBFFFF7F039C3E40000000A01B434940F7FFFF7F089C3E40
911	70	551	552	21	603.915267960335655	00:00:43.481899	0102000020E61000000A000000000000A01B434940FDFFFFBF0D9C3E40000000A01B434940F7FFFF7F089C3E40FCFFFFFF38434940090000800F9C3E40FCFFFF3F5C4349400A0000A0189C3E40000000008043494000000060209C3E40FCFFFF3F9843494007000000269C3E40FAFFFF1FB7434940FCFFFF9F2C9C3E40010000C0D4434940040000C0339C3E4000000000E0434940FEFFFF7F369C3E4002000080E5434940000000A0379C3E40
913	71	553	554	1	994.555094194504477	00:01:11.607967	0102000020E610000013000000030000A0CE344940000000A021863E40000000C0CF3449400000006027863E40000000C0C5344940000000C041863E40000000A0B6344940000000E064863E4000000080B0344940000000E071863E40000000609D344940000000A09F863E400000004099344940000000C0A1863E40000000409534494000000040A0863E400000008090344940000000809C863E40000000E08D3449400000002096863E40000000A0813449400000006068863E400000000070344940000000402B863E4000000000683449400000006007863E400000002060344940000000E0E4853E40000000205734494000000080C2853E40000000804A3449400000000093853E40000000C03E3449400000000066853E40000000A0363449400000006047853E40000000E02F3449400000002028853E40
914	71	554	555	2	1443.30234444778239	00:01:43.917769	0102000020E61000002200000002000080313449400000006025853E40000000E02F3449400000002028853E40000000A02534494000000060F9843E40000000E01F344940000000A0DE843E40000000201934494000000020C8843E400000000014344940000000C0B3843E40000000E00B344940000000609F843E400000008002344940000000208E843E4000000000F13349400000000077843E4000000080DA334940000000805A843E40000000C0CD334940000000404A843E4000000040C2334940000000403C843E4000000060B3334940000000602B843E4000000080B0334940000000802E843E4000000000AF3349400000006037843E4000000020AF3349400000002046843E40000000E0B7334940000000C052843E40000000C0C93349400000008067843E40000000E0D63349400000004077843E4000000020E1334940000000A084843E40000000A0E3334940000000C08D843E40000000C0E4334940000000609F843E40000000C0E5334940000000E0C2843E40000000E0E533494000000060E0843E40000000A0E6334940000000C0F3843E4000000020E8334940000000200D853E4000000080EF3349400000008029853E4000000060F7334940000000C047853E4000000020F8334940000000005A853E4000000020F8334940000000C06C853E40000000E0F5334940000000408B853E4000000040E8334940000000A0B2853E4000000060DB334940000000A0D2853E4000000040D733494000000080DD853E40
915	71	555	556	3	944.56954026699043	00:01:08.009007	0102000020E61000001100000000000040D533494000000020D4853E4000000040D733494000000080DD853E4000000000C4334940000000A012863E4000000040BC3349400000002028863E4000000040B73349400000002035863E40000000C0B1334940000000204A863E4000000060A2334940000000207D863E40000000A099334940000000C095863E40000000208C33494000000080BD863E40000000007D334940000000A0E7863E40000000607833494000000000F4863E40000000607733494000000040FA863E400000004062334940000000801E873E400000004050334940000000803E873E40000000003A3349400000002064873E40000000402C334940000000807D873E40000000801E3349400000000094873E40
916	71	556	557	4	427.625710067214868	00:00:30.789051	0102000020E61000000B000000FDFFFF5F1D3349400000002090873E40000000801E3349400000000094873E40000000400D33494000000080B1873E4000000000F832494000000080D2873E4000000020E432494000000060E9873E4000000080D732494000000000F5873E4000000000CA32494000000020FF873E40000000C0B8324940000000A007883E4000000060B13249400000006009883E4000000000AA324940000000600A883E40000000E0A4324940000000200B883E40
917	71	557	558	5	285.235752058816502	00:00:20.536974	0102000020E61000000800000005000080A4324940000000E005883E40000000E0A4324940000000200B883E40000000C098324940000000800C883E40000000608C324940000000E00B883E40000000007E3249400000004006883E40000000E06232494000000060F7873E40000000E059324940000000A0EE873E40000000804B324940000000E0E0873E40
918	71	558	559	6	321.377573438113586	00:00:23.139185	0102000020E610000007000000FBFFFFDF4B32494000000040DB873E40000000804B324940000000E0E0873E40000000E03E32494000000040D4873E40000000601932494000000000AE873E4000000040033249400000006096873E40000000E0F53149400000000089873E4000000020EF314940000000E085873E40
919	71	559	560	7	472.237684397046678	00:00:34.001113	0102000020E61000000900000004000000EF3149400000004080873E4000000020EF314940000000E085873E4000000040E8314940000000E084873E4000000040E1314940000000A086873E4000000000D7314940000000A08D873E4000000040A731494000000060B0873E40000000C08E314940000000A0C1873E40000000E06A31494000000040DA873E40000000205C31494000000080E6873E40
920	71	560	561	8	793.787544245979916	00:00:57.152703	0102000020E61000000E000000040000605B31494000000040E1873E40000000205C31494000000080E6873E40000000604E314940000000E0F2873E40000000A033314940000000200B883E40000000201B3149400000000022883E4000000080F2304940000000A047883E4000000000DB304940000000205E883E40000000E0D1304940000000606A883E40000000A0C03049400000004082883E40000000E0AB304940000000E09F883E40000000809D304940000000E0B3883E40000000A093304940000000C0C4883E40000000408930494000000020D9883E40000000E08030494000000060EA883E40
921	71	561	562	9	378.195717501518857	00:00:27.230092	0102000020E610000008000000040000607F30494000000000E4883E40000000E08030494000000060EA883E40000000407630494000000080FF883E400000008070304940000000E00E893E40000000006A3049400000004021893E400000000061304940000000003D893E4000000060493049400000008086893E40000000A04030494000000040A3893E40
922	71	562	563	10	1108.36286961949008	00:01:19.802127	0102000020E610000015000000FBFFFF7F3F304940000000609F893E40000000A04030494000000040A3893E40000000003730494000000020C6893E40000000601F30494000000020278A3E40000000E00C30494000000020748A3E40000000C003304940000000C0938A3E40000000C0FE2F494000000020A18A3E4000000080F92F494000000020A88A3E40000000C0F32F494000000040AA8A3E4000000080ED2F494000000040A98A3E40000000A0E82F494000000000A68A3E4000000060E42F4940000000A09E8A3E40000000A0D72F4940000000A0848A3E4000000040D32F494000000080818A3E40000000E0CE2F494000000040848A3E40000000E0CA2F4940000000208D8A3E4000000060C82F494000000060988A3E4000000060C62F494000000000AC8A3E40000000C0BB2F4940000000A01D8B3E40000000A0B32F4940000000C0738B3E40000000A0B12F4940000000808A8B3E40
923	71	563	564	11	716.503693857706594	00:00:51.588266	0102000020E61000000F00000000000000B02F494000000020898B3E40000000A0B12F4940000000808A8B3E4000000060AF2F4940000000E09D8B3E4000000080AC2F494000000040B18B3E4000000060A82F494000000040CC8B3E4000000020A52F494000000040DF8B3E4000000080982F4940000000E0238C3E40000000C0882F4940000000007B8C3E40000000A0832F494000000000958C3E40000000A0822F4940000000E09D8C3E40000000E0822F494000000040AC8C3E40000000E0822F4940000000C0BC8C3E40000000A0822F4940000000C0CE8C3E4000000020772F494000000060CE8C3E40000000A0762F4940000000A00D8D3E40
924	71	564	565	12	307.323267473008457	00:00:22.127275	0102000020E610000009000000000000E0742F4940000000E00C8D3E40000000A0762F4940000000A00D8D3E4000000020762F4940000000A0198D3E40000000A0732F494000000020248D3E40000000E06C2F4940000000002F8D3E40000000C0442F4940000000806B8D3E40000000E03B2F4940000000E0788D3E4000000080372F4940000000C0828D3E4000000040322F4940000000A08D8D3E40
925	71	565	566	13	553.370602384530343	00:00:39.842683	0102000020E61000000600000000000020312F4940000000A0888D3E4000000040322F4940000000A08D8D3E4000000040162F4940000000E0D38D3E40000000200C2F494000000020F18D3E4000000060F12E4940000000804C8E3E4000000040D82E4940000000C0A58E3E40
926	71	566	567	14	404.386989433510905	00:00:29.115863	0102000020E61000000D00000000000080D62E4940000000E0A18E3E4000000040D82E4940000000C0A58E3E4000000080CC2E494000000000D08E3E4000000080C22E494000000040F68E3E4000000000BB2E4940000000A0158F3E4000000080B62E4940000000A0298F3E40000000E0B32E494000000000318F3E4000000000B02E4940000000A0378F3E4000000060AA2E4940000000603F8F3E40000000A09D2E4940000000204C8F3E4000000020962E4940000000C0528F3E40000000408F2E4940000000A0558F3E40000000608B2E494000000040568F3E40
927	71	567	568	15	412.706550953382703	00:00:29.714872	0102000020E61000000D000000000000C08B2E4940000000404F8F3E40000000608B2E494000000040568F3E40000000E0802E4940000000805B8F3E40000000C0682E494000000060658F3E40000000A05A2E494000000080688F3E4000000020542E494000000040688F3E4000000080482E494000000080608F3E40000000A03E2E4940000000C0588F3E4000000020372E4940000000204C8F3E4000000000342E4940000000803B8F3E40000000A0302E494000000040288F3E40000000A0302E4940000000C0128F3E40000000A0322E494000000060FD8E3E40
928	72	\N	569	0	0	00:00:00	\N
929	72	569	570	1	356.644877440268374	00:00:25.678431	0102000020E61000000500000000000000342E4940000000E0FF8E3E40000000A0322E494000000060FD8E3E40000000A0482E494000000000B78E3E4000000040652E4940000000C0578E3E40000000A06A2E494000000080468E3E40
930	72	570	571	2	713.788104421287926	00:00:51.392744	0102000020E61000000E000000FBFFFFDF6B2E4940F9FFFF5F4A8E3E40000000A06A2E494000000080468E3E40000000C0712E4940000000A02E8E3E4000000080872E494000000020E58D3E40000000A08B2E494000000080B98D3E40000000008E2E4940000000A0888D3E40000000008E2E494000000020658D3E40000000408B2E494000000080258D3E4000000000892E494000000040FA8C3E40000000E0882E494000000000EE8C3E4000000060892E4940000000E0D78C3E40000000A08B2E4940000000C0C28C3E40000000E08E2E4940000000C0C28C3E4000000060942E494000000020C38C3E40
931	72	571	572	3	579.997042799489464	00:00:41.759787	0102000020E610000009000000FCFFFF9F942E4940000000A0C78C3E4000000060942E494000000020C38C3E40000000C0AC2E494000000080C48C3E40000000A0CB2E494000000080C58C3E40000000E0E22E494000000040C78C3E4000000060052F494000000020CA8C3E40000000A0202F494000000080CB8C3E40000000E03F2F4940000000E0CB8C3E4000000020582F494000000040CC8C3E40
932	72	572	573	4	668.705386926960387	00:00:48.146788	0102000020E61000000E00000005000020582F4940010000C0D08C3E4000000020582F494000000040CC8C3E4000000040782F494000000040CD8C3E40000000A0822F4940000000C0CE8C3E40000000E0822F4940000000C0BC8C3E40000000E0822F494000000040AC8C3E40000000A0822F4940000000E09D8C3E40000000A0832F494000000000958C3E40000000C0882F4940000000007B8C3E4000000080982F4940000000E0238C3E4000000020A52F494000000040DF8B3E4000000060A82F494000000040CC8B3E4000000080AC2F494000000040B18B3E4000000060AF2F4940000000E09D8B3E40
933	72	573	574	5	1195.29007681403891	00:01:26.060886	0102000020E610000017000000060000E0B02F494000000000A08B3E4000000060AF2F4940000000E09D8B3E40000000A0B12F4940000000808A8B3E40000000A0B32F4940000000C0738B3E40000000C0BB2F4940000000A01D8B3E4000000060C62F494000000000AC8A3E4000000060C82F494000000060988A3E40000000E0CA2F4940000000208D8A3E40000000E0CE2F494000000040848A3E4000000040D32F494000000080818A3E40000000A0D72F4940000000A0848A3E4000000060E42F4940000000A09E8A3E40000000A0E82F494000000000A68A3E4000000080ED2F494000000040A98A3E40000000C0F32F494000000040AA8A3E4000000080F92F494000000020A88A3E40000000C0FE2F494000000020A18A3E40000000C003304940000000C0938A3E40000000E00C30494000000020748A3E40000000601F30494000000020278A3E40000000003730494000000020C6893E40000000A04030494000000040A3893E4000000060493049400000008086893E40
934	72	574	575	6	577.197322121197431	00:00:41.558207	0102000020E61000000C000000F9FFFF5F4A304940040000008B893E4000000060493049400000008086893E400000000061304940000000003D893E40000000006A3049400000004021893E400000008070304940000000E00E893E40000000407630494000000080FF883E40000000E08030494000000060EA883E40000000408930494000000020D9883E40000000A093304940000000C0C4883E40000000809D304940000000E0B3883E40000000E0AB304940000000E09F883E40000000A0C03049400000004082883E40
935	72	575	576	7	490.995726976986703	00:00:35.351692	0102000020E61000000800000006000040C1304940000000A087883E40000000A0C03049400000004082883E40000000E0D1304940000000606A883E4000000000DB304940000000205E883E4000000080F2304940000000A047883E40000000201B3149400000000022883E40000000A033314940000000200B883E40000000604E314940000000E0F2873E40
936	72	576	577	8	583.320257128850812	00:00:41.999059	0102000020E61000000C000000FFFFFFDF4E314940F7FFFF7FF8873E40000000604E314940000000E0F2873E40000000205C31494000000080E6873E40000000E06A31494000000040DA873E40000000C08E314940000000A0C1873E4000000040A731494000000060B0873E4000000000D7314940000000A08D873E4000000040E1314940000000A086873E4000000040E8314940000000E084873E4000000020EF314940000000E085873E40000000E0F53149400000000089873E4000000040033249400000006096873E40
937	72	577	578	9	255.111849768921218	00:00:18.368053	0102000020E610000005000000FFFFFFDF023249400E0000A09B873E4000000040033249400000006096873E40000000601932494000000000AE873E40000000E03E32494000000040D4873E40000000804B324940000000E0E0873E40
938	72	578	579	10	301.501161580366045	00:00:21.708084	0102000020E610000009000000FFFFFF3F4B324940FFFFFFDFE6873E40000000804B324940000000E0E0873E40000000E059324940000000A0EE873E40000000E06232494000000060F7873E40000000007E3249400000004006883E40000000608C324940000000E00B883E40000000C098324940000000800C883E40000000E0A4324940000000200B883E4000000000AA324940000000600A883E40
939	72	579	580	11	528.061700381392939	00:00:38.020442	0102000020E61000000C000000FEFFFF1FAA324940F6FFFF5F0F883E4000000000AA324940000000600A883E4000000060B13249400000006009883E40000000C0B8324940000000A007883E4000000000CA32494000000020FF873E4000000080D732494000000000F5873E4000000020E432494000000060E9873E4000000000F832494000000080D2873E40000000400D33494000000080B1873E40000000801E3349400000000094873E40000000402C334940000000807D873E40000000003A3349400000002064873E40
940	72	580	581	12	940.839712614554514	00:01:07.740459	0102000020E610000011000000040000003B334940010000C068873E40000000003A3349400000002064873E400000004050334940000000803E873E400000004062334940000000801E873E40000000607733494000000040FA863E40000000207D334940000000E0F1863E40000000A081334940000000A0E6863E40000000409A33494000000000A7863E4000000060A1334940000000A092863E4000000000A63349400000004086863E4000000020B5334940000000E063863E40000000E0C23349400000002043863E4000000080CA3349400000000026863E40000000A0CF334940000000200F863E40000000A0D3334940000000C001863E4000000040E8334940000000A0C5853E4000000060F233494000000020A9853E40
941	72	581	582	13	329.62179928931414	00:00:23.73277	0102000020E61000000B00000004000060F3334940FCFFFFFFAC853E4000000060F233494000000020A9853E400000006004344940000000E075853E40000000200B344940000000E062853E400000008012344940000000A04B853E4000000000173449400000008042853E40000000801B344940000000403D853E40000000A020344940000000A03D853E400000002028344940000000E043853E40000000002D344940000000C04E853E40000000E0323449400000008063853E40
942	72	582	583	14	1142.92877913614484	00:01:22.290872	0102000020E61000001C000000070000A0313449400700006066853E40000000E0323449400000008063853E40000000803A344940000000A07F853E40000000A03F3449400000006093853E40000000404934494000000080A8853E40000000C05D34494000000000F3853E400000006066344940000000A018863E40000000006A3449400000000033863E40000000606B3449400000000046863E40000000006B3449400000004059863E400000006068344940000000606D863E400000004063344940000000E084863E40000000005F344940000000E098863E40000000605D344940000000A0AD863E40000000005D34494000000000C1863E40000000205F34494000000080D8863E40000000A062344940000000C0E9863E40000000606734494000000020F6863E40000000006E3449400000004000873E4000000020743449400000008003873E40000000007A3449400000004000873E40000000208034494000000040FA863E40000000208634494000000000F4863E400000002094344940000000A0E0863E40000000C0AA344940000000E0C3863E4000000000C034494000000080A9863E4000000000CC344940000000609A863E4000000060D8344940000000808A863E40
943	73	\N	584	0	0	00:00:00	\N
944	73	584	585	1	1016.61319245829077	00:01:13.19615	0102000020E610000007000000FDFFFFBF693C494000000020A6673E4005000020683C494000000020A6673E40FCFFFF3F683C49400000000009673E4005000080683C49400000006083663E40FCFFFF9F683C4940000000C0E3653E40FCFFFF9F683C4940000000E058653E4005000080643C4940000000E058653E40
945	73	585	586	2	728.344145351686279	00:00:52.440778	0102000020E61000000900000000000060643C4940000000A053653E4005000080643C4940000000E058653E40FEFFFF7F3E3C4940000000005B653E4005000080183C4940000000C05B653E40020000E0E93B4940000000205D653E40FDFFFFBFB53B4940000000E05E653E40000000A0873B4940000000405F653E40020000E0793B4940000000A05F653E40FAFFFFBF6E3B4940000000E05F653E40
946	73	586	587	3	543.47212697769487	00:00:39.129993	0102000020E610000007000000FAFFFFBF6E3B4940000000005A653E40FAFFFFBF6E3B4940000000E05F653E4002000080413B4940000000A060653E40040000000F3B4940000000A061653E4003000040F23A4940000000C062653E40FEFFFF1FCA3A49400000006061653E4005000080B83A4940000000A061653E40
947	73	587	588	4	372.60298448606045	00:00:26.827415	0102000020E610000007000000FCFFFF3FB83A4940000000005C653E4005000080B83A4940000000A061653E4001000020B13A49400000000062653E40FDFFFFBFA13A4940000000A061653E40FBFFFF7F9F3A49400000002024653E40070000A09D3A4940000000E0F1643E40FBFFFF7F9B3A494000000040B3643E40
948	73	588	589	5	1047.32829463316398	00:01:15.407637	0102000020E610000007000000010000209D3A494000000000B3643E40FBFFFF7F9B3A494000000040B3643E40FBFFFFDF973A4940000000A051643E40040000C0933A4940000000C0DA633E40FCFFFF3F903A49400000002075633E40050000808C3A49400000002007633E40F9FFFF5F863A4940000000E04D623E40
949	73	589	590	6	579.324654474702356	00:00:41.711375	0102000020E61000000500000005000020883A4940000000804D623E40F9FFFF5F863A4940000000E04D623E4003000040823A494000000000D0613E40FFFFFF3F7F3A4940000000E066613E40FBFFFF7F7B3A494000000000FC603E40
950	73	590	591	7	718.234155977384603	00:00:51.712859	0102000020E610000006000000010000207D3A4940000000A0FB603E40FBFFFF7F7B3A494000000000FC603E4005000080783A4940000000A0A0603E40000000A0733A4940000000E018603E40040000606F3A4940000000A09A5F3E40010000206D3A494000000040585F3E40
951	73	591	592	8	812.988518318374986	00:00:58.535173	0102000020E610000006000000FFFFFFDF6E3A4940000000E0575F3E40010000206D3A494000000040585F3E40070000A0693A4940000000C0EE5E3E40FEFFFF1F663A494000000000815E3E40020000E0613A494000000060005E3E40FDFFFFBF5D3A4940000000E07C5D3E40
952	73	592	593	9	1671.35765124036197	00:02:00.337751	0102000020E610000019000000FFFFFF3F5F3A4940000000807C5D3E40FDFFFFBF5D3A4940000000E07C5D3E40030000A05A3A4940000000C01F5D3E40FEFFFF1F563A494000000020995C3E40FFFFFFDF523A4940000000A03B5C3E40FAFFFF1F4F3A4940000000A0C95B3E40FBFFFF7F4B3A4940000000A04D5B3E40040000C0473A4940000000C0E25A3E4006000040493A494000000060D55A3E40000000004C3A494000000020C55A3E40F9FFFF5F4E3A494000000020BE5A3E40F9FFFF5F523A4940000000C0B75A3E40030000A0563A4940000000E0B15A3E40FCFFFF3F5C3A494000000060B05A3E4004000000633A4940000000A0B45A3E4000000000683A494000000020BF5A3E40050000206C3A494000000020D15A3E40020000E06D3A494000000040F45A3E40000000A06F3A4940000000A01A5B3E40070000A06D3A494000000000355B3E40030000406A3A494000000060445B3E40020000E0653A4940000000804C5B3E40020000E0613A494000000040545B3E40070000A04D3A4940000000405A5B3E40060000403D3A494000000040605B3E40
953	73	593	594	10	305.280956004089091	00:00:21.980229	0102000020E610000006000000FDFFFF5F3D3A4940000000E0595B3E40060000403D3A494000000040605B3E40020000E0213A494000000000695B3E4005000080FC39494000000020735B3E40FCFFFFFFE8394940000000C0785B3E40F9FFFFFFD9394940000000007C5B3E40
954	73	594	595	11	384.423049657204501	00:00:27.67846	0102000020E610000008000000FEFFFF1FDA394940000000C0775B3E40F9FFFFFFD9394940000000007C5B3E40FCFFFF3FC4394940000000C07E5B3E40030000A0AA394940000000C0835B3E40FAFFFF1F8B39494000000040885B3E40000000A077394940000000808B5B3E40F9FFFF5F66394940000000A08F5B3E40020000E05939494000000080925B3E40
955	73	595	596	12	452.1025440597341	00:00:32.551383	0102000020E610000008000000FEFFFF1F5A394940000000E08C5B3E40020000E05939494000000080925B3E40040000C03F39494000000080985B3E40060000E024394940000000609E5B3E400400006017394940000000E0A05B3E40FDFFFF5FFD38494000000060A95B3E4006000040E5384940000000C0B15B3E40010000C0C438494000000000BC5B3E40
956	73	596	597	13	703.599204671931489	00:00:50.659143	0102000020E610000008000000010000C0C438494000000000B75B3E40010000C0C438494000000000BC5B3E40FBFFFFDFA738494000000000C45B3E40FFFFFFDF8A38494000000040CE5B3E400400006063384940000000E0D95B3E40040000603738494000000040E85B3E40FCFFFF9F0838494000000060F75B3E4004000060DB374940000000E0065C3E40
957	73	597	598	14	530.300800406227495	00:00:38.181658	0102000020E61000000A000000000000A0DB374940000000A0015C3E4004000060DB374940000000E0065C3E40020000E0C5374940000000800C5C3E4005000020A837494000000060185C3E40FBFFFF7F9B374940000000C01D5C3E40070000A08D37494000000060245C3E40020000E081374940000000C02B5C3E40FFFFFF3F7337494000000040365C3E40000000605C37494000000000515C3E40FCFFFF9F3C37494000000080815C3E40
958	73	598	599	15	841.501300701661648	00:01:00.588094	0102000020E610000009000000040000C03B374940000000807B5C3E40FCFFFF9F3C37494000000080815C3E40040000601F374940000000E0AE5C3E400000000000374940000000C0DE5C3E40FCFFFF9FE0364940000000200E5D3E40060000E0BC364940000000C0455D3E40000000A09F36494000000000725D3E40020000E081364940000000C09F5D3E40FCFFFF9F6836494000000020C75D3E40
959	73	599	600	16	772.962329994841639	00:00:55.653288	0102000020E610000010000000000000006836494000000080C15D3E40FCFFFF9F6836494000000020C75D3E40070000A05536494000000000E55D3E40020000803D364940000000E0095E3E40070000A035364940000000A00A5E3E40050000203036494000000000055E3E40FCFFFFFF2C364940000000E0FB5D3E40FAFFFFBF2A36494000000000EB5D3E40000000002C364940000000A0D85D3E40040000602F364940000000C0CC5D3E40050000804036494000000060B35D3E40FCFFFF3F48364940000000C0B25D3E40070000A04D36494000000060BA5D3E40030000A05236494000000080CF5D3E40070000A05536494000000000E55D3E40FEFFFF1F6A364940000000407D5E3E40
960	73	600	601	17	643.649629813105435	00:00:46.342773	0102000020E610000008000000FCFFFF3F6836494000000000805E3E40FEFFFF1F6A364940000000407D5E3E40000000A08736494000000060675F3E40FAFFFFBF86364940000000E0845F3E40FFFFFF3F83364940000000A0B25F3E40FFFFFFDF7E36494000000080C55F3E40FEFFFF7F7A36494000000080D15F3E40020000807136494000000080E55F3E40
961	73	601	602	18	380.770923291046699	00:00:27.415506	0102000020E610000006000000010000C07036494000000060E15F3E40020000807136494000000080E55F3E40F9FFFF5F5A3649400000004014603E40FEFFFF1F4A3649400000000035603E40F9FFFF5F3A3649400000006063603E40040000C0273649400000002098603E40
962	73	602	428	19	616.164767009708839	00:00:44.363863	0102000020E610000008000000FAFFFFBF26364940000000A094603E40040000C0273649400000002098603E40FAFFFFBF1A364940000000E0BF603E40FCFFFF9F0C364940000000E0EC603E40FAFFFF1F0736494000000080FE603E40F9FFFF5FEA354940000000805A613E4005000080CC354940000000A0BB613E4001000020C535494000000080D4613E40
963	73	428	429	20	615.456094101320218	00:00:44.312839	0102000020E610000008000000FBFFFFDFC335494000000000D1613E4001000020C535494000000080D4613E4004000060B7354940000000E008623E4006000040AD354940000000A02F623E40070000A0A53549400000000051623E400000000094354940000000609E623E40FCFFFFFF8035494000000000F1623E40FEFFFF1F763549400000002020633E40
964	73	429	430	21	931.062180335679159	00:01:07.036477	0102000020E61000000E000000060000E074354940000000401D633E40FEFFFF1F763549400000002020633E40FBFFFF7F633549400000004071633E40050000205835494000000060A6633E40000000605435494000000080BB633E40000000A04F35494000000020DB633E400000006044354940000000C033643E40FEFFFF7F3A3549400000008082643E40FFFFFF3F3335494000000040A4643E40040000002B354940000000E0C3643E40070000A02135494000000000E0643E40F9FFFF5F1635494000000020FD643E40FCFFFF9F103549400000008009653E4004000060073549400000008017653E40
965	73	430	431	22	468.01107629996477	00:00:33.696797	0102000020E61000000A000000FFFFFFDF063549400000004012653E4004000060073549400000008017653E40030000A0F6344940000000C028653E4006000040E5344940000000E038653E40FCFFFF9FD83449400000000047653E40FDFFFF5FC93449400000008058653E40070000A0B9344940000000C06E653E40040000C0AF344940000000207E653E4003000040A63449400000008090653E40FCFFFF9F90344940000000C0C2653E40
967	73	432	603	24	872.499534594384613	00:01:02.819966	0102000020E61000000C000000020000E049344940000000E0B9663E40FFFFFFDF4A344940000000A0BC663E40040000604334494000000060E9663E40060000E03C3449400000000016673E4005000080343449400000004055673E40000000602C34494000000080A1673E400600004025344940000000C0F2673E4000000000203449400000004036683E40010000201D344940000000E062683E40060000401D344940000000C07F683E40FBFFFFDF1F3449400000008095683E40010000C02434494000000000B2683E40
968	74	\N	604	0	0	00:00:00	\N
969	74	604	382	1	889.402326916293532	00:01:04.036968	0102000020E61000000B000000FDFFFFBF35344940F9FFFF5F52683E400500002034344940FAFFFFBF52683E40FEFFFF1F32344940020000E021683E40000000603434494002000080B9673E40FAFFFF1F37344940FCFFFF3F9C673E40060000403D3449400400006063673E40FEFFFF1F463449400E0000A01B673E40F9FFFF5F4E3449400A000040E8663E400500008058344940FAFFFF1FB3663E40FDFFFFBF61344940F9FFFF5F8A663E40020000E06D344940F7FFFF7F58663E40
970	74	382	383	2	436.665099939883305	00:00:31.439887	0102000020E610000007000000040000006F344940F2FFFF5F5C663E40020000E06D344940F7FFFF7F58663E40FBFFFF7F7F344940F8FFFFDF18663E40060000409134494000000060E8653E40FBFFFF7FA73449400C000080B2653E40FDFFFFBFAD344940F4FFFFDFA5653E40040000C0BF3449400B00000089653E40
971	74	383	384	3	315.375660623807732	00:00:22.707048	0102000020E61000000A000000FCFFFF3FC0344940060000408D653E40040000C0BF3449400B00000089653E40F9FFFF5FC6344940FEFFFF1F7E653E40F9FFFFFFD1344940F5FFFFFF6E653E40020000E0DD3449400A00004060653E40FAFFFFBFEE344940F6FFFF5F4F653E40FAFFFF1FFF344940FFFFFF3F3F653E40030000A00A3549400300004032653E400400000013354940F5FFFFFF26653E400700000016354940F9FFFFFF21653E40
972	74	384	385	4	850.948753627362521	00:01:01.26831	0102000020E610000017000000FEFFFF7F16354940F5FFFFFF26653E400700000016354940F9FFFFFF21653E40010000201D354940FEFFFF1F16653E40FCFFFF3F24354940F5FFFFFF06653E40030000402A354940F8FFFF3FF9643E40010000203135494005000020E4643E400400006037354940FCFFFFFFCC643E40050000803C354940FDFFFFBFB5643E40000000604035494000000000A0643E40FBFFFFDF43354940010000C088643E40FCFFFF3F48354940FBFFFF7F63643E40FCFFFF9F503549400C00002022643E40FCFFFF3F5835494003000040EA633E40030000A062354940FFFFFF3FF7633E400500002068354940060000E0FC633E40FEFFFF1F6E3549400B000060F9633E40FEFFFF7F72354940F8FFFFDFF0633E4001000020753549400C000080E2633E40FDFFFFBF79354940F4FFFFDFBD633E40FEFFFF7F7A35494002000080A9633E40070000A079354940FBFFFFDF9B633E40FFFFFF3F77354940F8FFFFDF90633E40FDFFFF5F75354940FCFFFFFF8C633E40
973	74	385	386	5	882.177004091638196	00:01:03.516744	0102000020E61000000B0000000700000076354940F7FFFF7F88633E40FDFFFF5F75354940FCFFFFFF8C633E40FBFFFF7F63354940F8FFFF3F71633E40FEFFFF1F76354940F7FFFF1F20633E40FCFFFFFF803549400B000000F1623E400000000094354940070000609E623E40070000A0A53549400B00000051623E4006000040AD354940000000A02F623E4004000060B7354940F8FFFFDF08623E4001000020C535494005000080D4613E4005000080CC3549400E0000A0BB613E40
974	74	386	605	6	459.166828795970787	00:00:33.060012	0102000020E610000006000000070000A0CD35494008000020BF613E4005000080CC3549400E0000A0BB613E40F9FFFF5FEA3549400C0000805A613E40FAFFFF1F07364940FEFFFF7FFE603E40FCFFFF9F0C364940060000E0EC603E40000000A003364940010000C0D0603E40
975	74	605	606	7	633.10752450113921	00:00:45.583742	0102000020E610000007000000060000E004364940060000E0CC603E40000000A003364940010000C0D0603E40FBFFFF7FE7354940F8FFFF3F79603E4001000020D13549400E0000A033603E40060000E0AC3549400B000060C15F3E4004000000B3354940FCFFFF9FAC5F3E40FCFFFF9FBC354940060000408D5F3E40
976	74	606	607	8	1058.95236445101	00:01:16.24457	0102000020E610000012000000020000E0BD35494001000020915F3E40FCFFFF9FBC354940060000408D5F3E40FCFFFF9FCC354940F8FFFF3F595F3E4000000000E4354940070000000E5F3E40FAFFFFBFEE3549400D0000E0EA5E3E40010000C0F0354940FFFFFF3FD75E3E40F9FFFFFFF1354940FAFFFFBFC25E3E40FCFFFF3FF4354940F2FFFF5FB45E3E40FAFFFF1FF735494003000040AA5E3E4006000040F9354940F4FFFFDF9D5E3E40FEFFFF7F0A364940F9FFFF9F795E3E40FEFFFF1F12364940020000E0695E3E40030000402636494007000060465E3E40040000003736494002000080295E3E40020000E055364940F9FFFF5FFA5D3E40040000C06F36494004000000D35D3E400600004079364940FDFFFF5FC55D3E40FAFFFFBF8E364940020000E0A95D3E40
977	74	607	608	9	588.923994201948744	00:00:42.402528	0102000020E610000009000000040000008F364940FFFFFFDFAE5D3E40FAFFFFBF8E364940020000E0A95D3E40070000009E364940F5FFFF3F965D3E4002000080AD364940F6FFFF5F7F5D3E4004000060CB364940FAFFFFBF525D3E4004000000EB3649400D000040235D3E40FCFFFF3F00374940F2FFFFFF035D3E40030000A01A374940FBFFFFDFDB5C3E40060000402537494004000060CB5C3E40
978	74	608	609	10	625.161280006165043	00:00:45.011612	0102000020E61000000D000000FDFFFFBF253749400A0000A0D05C3E40060000402537494004000060CB5C3E40FFFFFFDF3A374940F9FFFF5FAA5C3E40050000804C374940FFFFFF3F8F5C3E40FCFFFF9F5C374940070000A0755C3E40FBFFFFDF63374940F3FFFFBF6C5C3E40030000A06E374940F7FFFF1F605C3E40FEFFFF1F7A374940F5FFFFFF565C3E40FEFFFF7F8E3749400A0000A0485C3E40FCFFFF9F9C374940F8FFFF3F415C3E4002000080B537494000000000385C3E40FAFFFFBFC63749400C000020325C3E4000000000DC374940FAFFFFBF2A5C3E40
979	74	609	610	11	691.13847389891248	00:00:49.76197	0102000020E61000000A000000FCFFFF3FDC37494000000060305C3E4000000000DC374940FAFFFFBF2A5C3E4000000060F8374940030000A0225C3E40030000401A384940F6FFFFBF175C3E40FFFFFFDF3E384940050000200C5C3E40FAFFFF1F6338494008000020FF5B3E40030000A07E38494006000040F55B3E400500008094384940F4FFFFDFED5B3E40F9FFFF5FAE384940F3FFFF1FE55B3E4005000080C038494007000060DE5B3E40
980	74	610	611	12	475.193868550723835	00:00:34.213959	0102000020E61000000700000005000080C038494004000060E35B3E4005000080C038494007000060DE5B3E40FEFFFF1FD238494002000080D95B3E40030000A0FA38494005000020CC5B3E40030000A01A394940030000A0C25B3E400000006040394940F6FFFF5FB75B3E40020000805D394940F5FFFFFFAE5B3E40
981	74	611	612	13	380.762609056052383	00:00:27.414908	0102000020E610000006000000020000805D394940FBFFFFDFB35B3E40020000805D394940F5FFFFFFAE5B3E40FCFFFF3F7C394940F4FFFF7FA55B3E40040000609F3949400E0000A09B5B3E40F9FFFF5FBA394940FCFFFF9F945B3E40FFFFFF3FDB394940F5FFFF3F8E5B3E40
982	74	612	613	14	549.810923966860855	00:00:39.586387	0102000020E61000001300000004000060DB3949400D0000E0925B3E40FFFFFF3FDB394940F5FFFF3F8E5B3E4005000020EC3949400B000060895B3E40FDFFFF5FFD394940040000C0835B3E40FEFFFF7F023A4940F9FFFF9F815B3E4000000060083A4940F9FFFF5F8A5B3E40FCFFFF3F103A494007000060965B3E40FEFFFF1F163A4940FDFFFFBFA55B3E40FDFFFF5F193A4940F6FFFF5FB75B3E40070000A01D3A4940F5FFFF9FCE5B3E40020000E0213A49400E0000A0DB5B3E4003000040263A494004000000E35B3E40FCFFFF3F2C3A4940FFFFFF3FE75B3E4002000080313A4940FFFFFF3FE75B3E40020000E0393A4940F3FFFF1FE55B3E4001000020413A4940FFFFFFDFE65B3E40FBFFFF7F473A49400C000020F25B3E40FDFFFF5F4D3A4940F3FFFF1F055C3E40FAFFFFBF4E3A494005000080345C3E40
983	74	613	614	15	536.797804601780399	00:00:38.649442	0102000020E610000004000000060000404D3A4940060000E0345C3E40FAFFFFBF4E3A494005000080345C3E4005000020543A4940FAFFFF1FD35C3E4001000020593A4940FDFFFFBF6D5D3E40
984	74	614	615	16	858.309986461559674	00:01:01.798319	0102000020E610000006000000040000C0573A4940FFFFFFDF6E5D3E4001000020593A4940FDFFFFBF6D5D3E40FCFFFF9F5C3A494004000060D35D3E4006000040613A49400B000000595E3E40020000E0653A494000000060E05E3E40030000406A3A494005000020645F3E40
985	74	615	616	17	764.286272488491704	00:00:55.028612	0102000020E610000006000000FCFFFF9F683A4940060000E0645F3E40030000406A3A494005000020645F3E4000000000703A4940F4FFFF7F1D603E4005000020743A4940080000209F603E40000000A0773A49400A0000A008613E4005000080783A49400400000023613E40
986	74	616	617	18	470.840213011963385	00:00:33.900495	0102000020E610000004000000FAFFFF1F773A49400400006023613E4005000080783A49400400000023613E40FEFFFF7F7E3A4940F5FFFF3FD6613E40020000E0813A4940070000A035623E40
987	74	617	618	19	1091.58523677920857	00:01:18.594137	0102000020E610000007000000FCFFFF9F803A4940070000A035623E40020000E0813A4940070000A035623E4007000000863A494000000000B8623E40FAFFFFBF8A3A4940F8FFFF3F49633E4000000060903A4940020000E0E9633E4002000080953A4940FFFFFFDF7E643E4004000060973A4940FDFFFFBFB5643E40
988	74	618	619	20	713.149965237558149	00:00:51.346797	0102000020E610000005000000020000E0953A4940FEFFFF1FB6643E4004000060973A4940FDFFFFBFB5643E40010000209D3A49400800002057653E40FEFFFF1FA23A4940F6FFFFBFEF653E40FDFFFF5FA53A4940080000C056663E40
989	74	619	620	21	428.522607197522916	00:00:30.853628	0102000020E61000000600000000000000A43A4940F6FFFF5F57663E40FDFFFF5FA53A4940080000C056663E4007000000A63A4940F6FFFF5F77663E4003000040A63A494004000000A3663E4004000060A73A49400A000040C8663E40FFFFFF3FAB3A49400A0000A050673E40
990	74	620	491	22	467.110697517779727	00:00:33.63197	0102000020E61000000A000000020000E0A93A49400B00000051673E40FFFFFF3FAB3A49400A0000A050673E40FBFFFF7FAF3A4940F4FFFF7FCD673E40FDFFFF5FB13A4940F8FFFFDF08683E40FCFFFF9FB43A4940FFFFFF3F0F683E40FCFFFF3FB83A49400B0000C011683E40000000A0BF3A4940F3FFFFBF0C683E40FDFFFFBFC93A4940F4FFFFDFF5673E4005000020D03A4940F9FFFF5FEA673E40FBFFFF7FD73A49400D0000E0E2673E40
991	74	491	492	23	479.331479699566273	00:00:34.511867	0102000020E610000008000000FBFFFF7FD73A4940F8FFFFDFE8673E40FBFFFF7FD73A49400D0000E0E2673E40FBFFFF7FDF3A4940F2FFFF5FE4673E40FCFFFF9FF83A4940FCFFFFFFE4673E40FDFFFF5F193B4940F3FFFFBFE4673E40070000A0393B4940F2FFFF5FE4673E4004000060633B4940F2FFFFFFE3673E40040000C0773B4940F2FFFFFFE3673E40
992	74	492	493	24	337.567029373513208	00:00:24.304826	0102000020E610000006000000040000C0773B49400A000040E8673E40040000C0773B4940F2FFFFFFE3673E40FBFFFFDF8B3B4940F2FFFFFFE3673E40040000C0AF3B49400E0000A0E3673E40F9FFFFFFD93B49400E0000A0E3673E40FCFFFF9FE83B49400D000040E3673E40
993	74	493	494	25	221.410899792937869	00:00:15.941585	0102000020E610000004000000FCFFFF9FE83B49400A000040E8673E40FCFFFF9FE83B49400D000040E3673E4006000040053C49400D000040E3673E40FDFFFF5F313C494003000040E2673E40
994	74	494	621	26	270.521600154074292	00:00:19.477555	0102000020E610000005000000FDFFFF5F313C494008000020E7673E40FDFFFF5F313C494003000040E2673E40020000E0593C494003000040E2673E4005000020683C494003000040E2673E4005000020683C4940FEFFFF1FA6673E40
995	75	\N	622	0	0	00:00:00	\N
996	75	622	623	1	479.499933923805884	00:00:34.523995	0102000020E61000000E000000FCFFFFFF6C374940000000C0388E3E40000000E06B37494000000040358E3E40000000E07237494000000040218E3E40000000C07637494000000040158E3E40000000807C37494000000080068E3E40000000E07F37494000000000028E3E40000000E08B37494000000080FE8D3E400000004095374940000000E0F98D3E40000000409E37494000000080F38D3E4000000000A737494000000080EC8D3E40000000A0AF374940000000A0E18D3E4000000000C7374940000000A0C08D3E4000000080DA37494000000000A38D3E4000000080E7374940000000008F8D3E40
1074	80	675	676	6	575.302731327552692	00:00:41.421797	0102000020E610000006000000FAFFFFBF8A374940F6FFFFBFCF993E40FDFFFF5F89374940FAFFFFBFD2993E40FEFFFF1F7A374940F9FFFF9F89993E400100002069374940F7FFFF1F38993E40FBFFFF7F57374940F5FFFF3FE6983E40FAFFFF1F473749400900008097983E40
997	75	623	624	2	567.591986729601558	00:00:40.866623	0102000020E61000000B00000005000020E837494000000040948D3E4000000080E7374940000000008F8D3E40000000E006384940000000A0608D3E40000000602A384940000000202B8D3E40000000A04B384940000000E0F78C3E400000008051384940000000C0EF8C3E40000000C056384940000000C0E88C3E40000000A05C384940000000A0DF8C3E400000006062384940000000E0D28C3E40000000406B384940000000A0C08C3E40000000407238494000000060AE8C3E40
998	75	624	625	3	635.673872549376938	00:00:45.768519	0102000020E61000000E000000FAFFFF1F73384940000000E0B18C3E40000000407238494000000060AE8C3E40000000C07A38494000000040988C3E40000000E085384940000000607C8C3E40000000208E384940000000E0658C3E40000000E098384940000000E0448C3E4000000060A838494000000060158C3E4000000040BD384940000000C0D48B3E40000000A0C538494000000060BA8B3E40000000A0C838494000000060AD8B3E40000000C0CA38494000000000A18B3E40000000C0CB384940000000A0998B3E4000000040CD384940000000E08A8B3E40000000C0CE384940000000E0648B3E40
999	75	625	626	4	600.604181275346036	00:00:43.243501	0102000020E610000008000000FCFFFF9FD038494000000000668B3E40000000C0CE384940000000E0648B3E4000000000D1384940000000E02A8B3E4000000000D338494000000060FA8A3E4000000040D638494000000020DC8A3E4000000040DD38494000000080A88A3E4000000060FE384940000000C02C8A3E40000000400439494000000040178A3E40
1000	75	626	627	5	599.399190571890699	00:00:43.156742	0102000020E6100000080000000200008005394940000000201B8A3E40000000400439494000000040178A3E40000000A00A39494000000080008A3E40000000E01E39494000000000B7893E4000000080393949400000002054893E40000000404B3949400000002013893E40000000805239494000000000F7883E40000000005939494000000080DA883E40
1001	75	627	628	6	773.912837418119238	00:00:55.721724	0102000020E610000009000000030000A05A394940000000C0DD883E40000000005939494000000080DA883E40000000606D3949400000006083883E400000002085394940000000601D883E40000000009B39494000000020BF873E40000000C0A8394940000000008E873E40000000C0B0394940000000C07C873E40000000E0B6394940000000C075873E40000000E0CC394940000000E04A873E40
1002	75	628	629	7	341.612938953360583	00:00:24.596132	0102000020E61000000B000000FDFFFF5FCD394940000000C04F873E40000000E0CC394940000000E04A873E40000000C0D7394940000000C035873E40000000C0DE3949400000002029873E40000000E0E23949400000006021873E4000000040E6394940000000E017873E4000000020E8394940000000800B873E4000000040E93949400000006001873E4000000020E939494000000080F6863E40000000C0DE394940000000E0D8863E4000000020CC394940000000A0A5863E40
1003	75	629	630	8	437.836894888600682	00:00:31.524256	0102000020E61000000800000006000040CD394940000000A0A0863E4000000020CC394940000000A0A5863E4000000020B43949400000008064863E40000000C0A6394940000000E03E863E40000000C09B394940000000C020863E40000000208E39494000000020FC853E40000000E08439494000000060E6853E40000000E07A394940000000C0D3853E40
1004	75	630	631	9	542.378371404784275	00:00:39.051243	0102000020E61000000C000000040000C07B39494000000060CE853E40000000E07A394940000000C0D3853E40000000007339494000000000C6853E40000000006A394940000000A0B8853E40000000206039494000000000AD853E40000000A05739494000000040A4853E40000000604F394940000000A09E853E400000008034394940000000608C853E4000000080143949400000004077853E4000000020FC3849400000006067853E4000000000EE384940000000405D853E40000000A0D7384940000000804E853E40
1005	75	631	632	10	730.121663794155552	00:00:52.56876	0102000020E61000000E00000005000020D83849400000008049853E40000000A0D7384940000000804E853E40000000C0BD384940000000403D853E4000000020A3384940000000002B853E40000000E0993849400000008022853E40000000807E384940000000800F853E40000000806C3849400000002002853E40000000806838494000000060FF843E400000002066384940000000A0F8843E40000000405838494000000060BE843E40000000E0473849400000004077843E40000000203F384940000000404F843E40000000C03C3849400000000045843E40000000A03E3849400000008034843E40
1006	76	\N	633	0	0	00:00:00	\N
1007	76	633	634	1	222.707004369179856	00:00:16.034904	0102000020E610000006000000040000609B384940FAFFFFBFFA843E40000000209D38494000000040FC843E40000000E0993849400000008022853E400000004099384940000000602D853E40000000C0A73849400000006039853E40000000E0C2384940000000C04C853E40
1008	76	634	635	2	553.717328360577994	00:00:39.867648	0102000020E610000009000000030000A0C2384940F8FFFF3F51853E40000000E0C2384940000000C04C853E40000000E0ED3849400000008069853E40000000201D394940000000E088853E40000000E0303949400000008095853E40000000E04A394940000000C0A6853E40000000605539494000000060AE853E40000000406339494000000020BC853E40000000206E39494000000080CA853E40
1009	76	635	636	3	387.917280674742699	00:00:27.930044	0102000020E610000008000000070000A06D39494008000020CF853E40000000206E39494000000080CA853E40000000207739494000000060D9853E40000000A081394940000000C0ED853E40000000008B394940000000E003863E400000004097394940000000E024863E40000000A0A43949400000006048863E4000000000B9394940000000A080863E40
1010	76	636	637	4	402.209944645121084	00:00:28.959116	0102000020E610000007000000FBFFFFDFB73949400700000086863E4000000000B9394940000000A080863E4000000080D639494000000080D1863E40000000A0D639494000000020E4863E40000000E0D33949400000004027873E4000000020CB394940000000E03F873E4000000060C33949400000002050873E40
1011	76	637	638	5	855.358104029823267	00:01:01.585783	0102000020E61000000C000000030000A0C23949400D0000E04A873E4000000060C33949400000002050873E4000000040B73949400000006068873E4000000040B4394940000000606F873E40000000C0B0394940000000C07C873E40000000C0A8394940000000008E873E40000000009B39494000000020BF873E400000002085394940000000601D883E40000000606D3949400000006083883E40000000005939494000000080DA883E40000000805239494000000000F7883E40000000404B3949400000002013893E40
1012	76	638	639	6	453.288007258578205	00:00:32.636737	0102000020E610000005000000FDFFFFBF49394940FFFFFFDF0E893E40000000404B3949400000002013893E4000000080393949400000002054893E40000000E01E39494000000000B7893E40000000A00A39494000000080008A3E40
1013	76	639	640	7	794.259172437802704	00:00:57.18666	0102000020E61000000E000000FDFFFF5F09394940FCFFFF3FFC893E40000000A00A39494000000080008A3E40000000400439494000000040178A3E4000000060FE384940000000C02C8A3E4000000040DD38494000000080A88A3E4000000040D638494000000020DC8A3E4000000000D338494000000060FA8A3E4000000000D1384940000000E02A8B3E40000000C0CE384940000000E0648B3E4000000040CD384940000000E08A8B3E40000000C0CB384940000000A0998B3E40000000C0CA38494000000000A18B3E40000000A0C838494000000060AD8B3E40000000A0C538494000000060BA8B3E40
1014	76	640	641	8	634.920575250600109	00:00:45.714281	0102000020E61000000E00000000000000C438494009000080B78B3E40000000A0C538494000000060BA8B3E4000000040BD384940000000C0D48B3E4000000060A838494000000060158C3E40000000E098384940000000E0448C3E40000000208E384940000000E0658C3E40000000E085384940000000607C8C3E40000000C07A38494000000040988C3E40000000407238494000000060AE8C3E40000000406B384940000000A0C08C3E400000006062384940000000E0D28C3E40000000A05C384940000000A0DF8C3E40000000C056384940000000C0E88C3E400000008051384940000000C0EF8C3E40
1015	76	641	642	9	471.287930681021408	00:00:33.932731	0102000020E610000007000000FCFFFF9F503849400C000080EA8C3E400000008051384940000000C0EF8C3E40000000A04B384940000000E0F78C3E40000000602A384940000000202B8D3E40000000E006384940000000A0608D3E4000000080E7374940000000008F8D3E4000000080DA37494000000000A38D3E40
1016	76	642	643	10	607.768641447733216	00:00:43.759342	0102000020E610000010000000FDFFFF5FD9374940FDFFFFBF9D8D3E4000000080DA37494000000000A38D3E4000000000C7374940000000A0C08D3E40000000A0AF374940000000A0E18D3E4000000000A737494000000080EC8D3E40000000409E37494000000080F38D3E400000004095374940000000E0F98D3E40000000E08B37494000000080FE8D3E40000000E07F37494000000000028E3E40000000807C37494000000080068E3E40000000C07637494000000040158E3E400000004071374940000000C01D8E3E40000000405937494000000020388E3E40000000004437494000000000508E3E400000000046374940000000805F8E3E40000000A048374940000000C0728E3E40
1017	77	\N	644	0	0	00:00:00	\N
1018	77	644	645	1	440.480035035219885	00:00:31.714563	0102000020E61000000A000000FEFFFF7F4A2C494000000020F9883E40FBFFFF7F4B2C494000000040F4883E40FCFFFF3F502C4940000000E0F9883E40F9FFFFFF512C494000000060F0883E40010000205D2C4940000000000A893E40FAFFFFBF6E2C49400000004034893E40000000A07B2C4940000000E054893E40000000A0832C4940000000E067893E40000000A09B2C4940000000409B893E40FBFFFF7FA32C494000000020AC893E40
1019	77	645	646	2	518.62948305787836	00:00:37.341323	0102000020E61000000A000000030000A0A22C494000000040B0893E40FBFFFF7FA32C494000000020AC893E40FDFFFFBFB12C4940000000A0CA893E4003000040D22C494000000000178A3E40060000E0DC2C4940000000E02E8A3E40FFFFFF3FE72C4940000000403D8A3E4000000000F02C494000000020478A3E40F9FFFF5F062D4940000000205A8A3E40060000E0182D494000000080688A3E40FEFFFF7F222D4940000000A0708A3E40
1020	77	646	647	3	696.868607212396682	00:00:50.17454	0102000020E61000000E000000FEFFFF1F222D494000000020758A3E40FEFFFF7F222D4940000000A0708A3E40070000A0392D4940000000E0838A3E4005000020482D4940000000208F8A3E40010000C0542D4940000000A09E8A3E40F9FFFFFF612D4940000000C0AD8A3E40FCFFFF9F742D494000000040C38A3E4004000060832D494000000000D38A3E40FDFFFF5F992D494000000020EE8A3E40070000A0AD2D494000000000058B3E40FDFFFF5FBD2D494000000060148B3E40FCFFFF9FD42D494000000020298B3E40FEFFFF7FE62D494000000000398B3E40060000E0EC2D4940000000603F8B3E40
1021	77	647	648	4	137.368172165104824	00:00:09.890508	0102000020E610000004000000FCFFFF9FEC2D494000000040448B3E40060000E0EC2D4940000000603F8B3E40060000E0FC2D4940000000604E8B3E40FBFFFF7F132E494000000040648B3E40
1022	77	648	573	5	1490.11361947740284	00:01:47.288181	0102000020E610000017000000FAFFFF1F132E4940000000C0678B3E40FBFFFF7F132E494000000040648B3E40050000802C2E4940000000607B8B3E4000000000442E4940000000A0918B3E4005000080602E494000000040AB8B3E40FCFFFFFF7C2E494000000020C28B3E4000000000902E494000000040D28B3E40F9FFFF5F9E2E494000000000DB8B3E4001000020AD2E494000000000E18B3E40FEFFFF7FCE2E494000000060ED8B3E40FFFFFFDFEE2E494000000060FA8B3E40070000A0092F494000000080048C3E40FAFFFF1F232F4940000000E0118C3E40FDFFFFBF352F4940000000601B8C3E40040000C04B2F494000000060278C3E4005000020602F4940000000E0318C3E40060000E0782F4940000000A03A8C3E40FAFFFFBF922F4940000000E0438C3E4005000080982F4940000000E0238C3E4001000020A52F494000000040DF8B3E4000000060A82F494000000040CC8B3E4005000080AC2F494000000040B18B3E4004000060AF2F4940000000E09D8B3E40
1023	77	573	574	6	1195.29007681149005	00:01:26.060886	0102000020E610000017000000060000E0B02F494000000000A08B3E4004000060AF2F4940000000E09D8B3E40070000A0B12F4940000000808A8B3E40000000A0B32F4940000000C0738B3E40040000C0BB2F4940000000A01D8B3E40F9FFFF5FC62F494000000000AC8A3E4000000060C82F494000000060988A3E40FFFFFFDFCA2F4940000000208D8A3E40FFFFFFDFCE2F494000000040848A3E40FFFFFF3FD32F494000000080818A3E40000000A0D72F4940000000A0848A3E4000000060E42F4940000000A09E8A3E40FCFFFF9FE82F494000000000A68A3E4002000080ED2F494000000040A98A3E40040000C0F32F494000000040AA8A3E4002000080F92F494000000020A88A3E40FAFFFFBFFE2F494000000020A18A3E40040000C003304940000000C0938A3E40060000E00C30494000000020748A3E40040000601F30494000000020278A3E40040000003730494000000020C6893E40FCFFFF9F4030494000000040A3893E40FDFFFF5F493049400000008086893E40
1024	77	574	575	7	577.197322119691876	00:00:41.558207	0102000020E61000000C000000F9FFFF5F4A304940000000008B893E40FDFFFF5F493049400000008086893E40FCFFFFFF60304940000000003D893E40F9FFFFFF693049400000004021893E400500008070304940000000E00E893E40030000407630494000000080FF883E40060000E08030494000000060EA883E40060000408930494000000020D9883E40000000A093304940000000C0C4883E40020000809D304940000000E0B3883E40FBFFFFDFAB304940000000E09F883E40FCFFFF9FC03049400000004082883E40
1025	77	575	576	8	490.995726974791864	00:00:35.351692	0102000020E61000000800000006000040C1304940000000A087883E40FCFFFF9FC03049400000004082883E40020000E0D1304940000000606A883E4004000000DB304940000000205E883E40FEFFFF7FF2304940000000A047883E40FAFFFF1F1B3149400000000022883E40000000A033314940000000200B883E40F9FFFF5F4E314940000000E0F2873E40
1026	77	576	577	9	583.320257136421333	00:00:41.999059	0102000020E61000000C000000FFFFFFDF4E31494000000080F8873E40F9FFFF5F4E314940000000E0F2873E40050000205C31494000000080E6873E40FFFFFFDF6A31494000000040DA873E40FAFFFFBF8E314940000000A0C1873E40FFFFFF3FA731494000000060B0873E4004000000D7314940000000A08D873E4006000040E1314940000000A086873E40FCFFFF3FE8314940000000E084873E40FAFFFF1FEF314940000000E085873E40020000E0F53149400000000089873E40FFFFFF3F033249400000006096873E40
1027	77	577	578	10	255.111849761054884	00:00:18.368053	0102000020E610000005000000FFFFFFDF02324940000000A09B873E40FFFFFF3F033249400000006096873E40FDFFFF5F1932494000000000AE873E40FFFFFFDF3E32494000000040D4873E40FBFFFF7F4B324940000000E0E0873E40
1028	77	578	579	11	301.501161579719394	00:00:21.708084	0102000020E610000009000000FFFFFF3F4B324940000000E0E6873E40FBFFFF7F4B324940000000E0E0873E40020000E059324940000000A0EE873E40FFFFFFDF6232494000000060F7873E40070000007E3249400000004006883E40000000608C324940000000E00B883E40010000C098324940000000800C883E40060000E0A4324940000000200B883E40F9FFFFFFA9324940000000600A883E40
1029	77	579	580	12	528.061700386316943	00:00:38.020442	0102000020E61000000C000000FEFFFF1FAA324940000000600F883E40F9FFFFFFA9324940000000600A883E40FDFFFF5FB13249400000006009883E40010000C0B8324940000000A007883E40F9FFFFFFC932494000000020FF873E40FBFFFF7FD732494000000000F5873E4005000020E432494000000060E9873E4000000000F832494000000080D2873E40060000400D33494000000080B1873E40FEFFFF7F1E3349400000000094873E40FCFFFF3F2C334940000000807D873E40F9FFFFFF393349400000002064873E40
1030	77	580	581	13	940.839712615697067	00:01:07.740459	0102000020E610000011000000040000003B334940000000C068873E40F9FFFFFF393349400000002064873E40FCFFFF3F50334940000000803E873E400300004062334940000000801E873E40040000607733494000000040FA863E40010000207D334940000000E0F1863E40070000A081334940000000A0E6863E40030000409A33494000000000A7863E40FDFFFF5FA1334940000000A092863E4007000000A63349400000004086863E4001000020B5334940000000E063863E40FFFFFFDFC23349400000002043863E40FEFFFF7FCA3349400000000026863E40000000A0CF334940000000200F863E40000000A0D3334940000000C001863E40FCFFFF3FE8334940000000A0C5853E40F9FFFF5FF233494000000020A9853E40
1031	77	581	582	14	329.621799295136952	00:00:23.73277	0102000020E61000000B00000004000060F333494000000000AD853E40F9FFFF5FF233494000000020A9853E400000006004344940000000E075853E40FAFFFF1F0B344940000000E062853E40FEFFFF7F12344940000000A04B853E4004000000173449400000008042853E40FBFFFF7F1B344940000000403D853E40FCFFFF9F20344940000000A03D853E400500002028344940000000E043853E40FCFFFFFF2C344940000000C04E853E40FFFFFFDF323449400000008063853E40
1032	77	582	583	15	1142.92877913252687	00:01:22.290872	0102000020E61000001C000000070000A0313449400000006066853E40FFFFFFDF323449400000008063853E40FEFFFF7F3A344940000000A07F853E40000000A03F3449400000006093853E40060000404934494000000080A8853E40FDFFFFBF5D34494000000000F3853E40F9FFFF5F66344940000000A018863E40F9FFFFFF693449400000000033863E40040000606B3449400000000046863E40040000006B3449400000004059863E400000006068344940000000606D863E40FFFFFF3F63344940000000E084863E40040000005F344940000000E098863E40FDFFFF5F5D344940000000A0AD863E40FCFFFFFF5C34494000000000C1863E40FAFFFF1F5F34494000000080D8863E40030000A062344940000000C0E9863E40040000606734494000000020F6863E40070000006E3449400000004000873E4005000020743449400000008003873E40F9FFFFFF793449400000004000873E40050000208034494000000040FA863E40FEFFFF1F8634494000000000F4863E400500002094344940000000A0E0863E40FAFFFFBFAA344940000000E0C3863E4000000000C034494000000080A9863E4000000000CC344940000000609A863E4000000060D8344940000000808A863E40
1033	78	\N	553	0	0	00:00:00	\N
1034	78	553	554	1	994.555094204364309	00:01:11.607967	0102000020E610000013000000030000A0CE344940F9FFFF9F21863E40040000C0CF344940F6FFFF5F27863E40FDFFFFBFC53449400B0000C041863E40030000A0B6344940060000E064863E4005000080B0344940020000E071863E40FDFFFF5F9D344940000000A09F863E4006000040993449400B0000C0A1863E4006000040953449400A000040A0863E400500008090344940050000809C863E40020000E08D344940FEFFFF1F96863E40070000A0813449400000006068863E4000000000703449400D0000402B863E400000000068344940F6FFFF5F07863E400500002060344940060000E0E4853E40FAFFFF1F573449400C000080C2853E40FEFFFF7F4A3449400400000093853E40FAFFFFBF3E3449400700000066853E40030000A036344940F6FFFF5F47853E40FBFFFFDF2F344940F7FFFF1F28853E40
1035	78	554	555	2	1443.30234444129337	00:01:43.917769	0102000020E6100000220000000200008031344940FDFFFF5F25853E40FBFFFFDF2F344940F7FFFF1F28853E40070000A0253449400B000060F9843E40FBFFFFDF1F344940F5FFFF9FDE843E400100002019344940F7FFFF1FC8843E400000000014344940040000C0B3843E40FBFFFFDF0B344940F6FFFF5F9F843E40FEFFFF7F02344940FEFFFF1F8E843E40FCFFFFFFF0334940F5FFFFFF76843E40FEFFFF7FDA3349400C0000805A843E40FDFFFFBFCD334940030000404A843E4003000040C2334940FCFFFF3F3C843E4004000060B3334940040000602B843E4005000080B0334940FEFFFF7F2E843E4004000000AF334940F6FFFF5F37843E40FAFFFF1FAF334940FEFFFF1F46843E40FBFFFFDFB7334940FAFFFFBF52843E40FDFFFFBFC93349400900008067843E40FFFFFFDFD6334940FFFFFF3F77843E4001000020E1334940FCFFFF9F84843E40000000A0E3334940FDFFFFBF8D843E40010000C0E4334940F6FFFF5F9F843E40FDFFFFBFE53349400D0000E0C2843E40020000E0E533494000000060E0843E40030000A0E6334940040000C0F3843E4005000020E8334940F3FFFF1F0D853E40FBFFFF7FEF3349400200008029853E4004000060F7334940F6FFFFBF47853E4005000020F8334940F9FFFFFF59853E4005000020F8334940F3FFFFBF6C853E40020000E0F53349400D0000408B853E40FCFFFF3FE8334940030000A0B2853E4004000060DB334940030000A0D2853E40FFFFFF3FD7334940F4FFFF7FDD853E40
1036	78	555	556	3	944.569540265604132	00:01:08.009007	0102000020E61000001100000000000040D533494000000020D4853E40FFFFFF3FD7334940F4FFFF7FDD853E4000000000C4334940030000A012863E40FCFFFF3FBC334940F7FFFF1F28863E40FFFFFF3FB7334940F3FFFF1F35863E40FDFFFFBFB13349400C0000204A863E40F9FFFF5FA2334940F3FFFF1F7D863E40070000A099334940FDFFFFBF95863E40050000208C334940F4FFFF7FBD863E40FCFFFFFF7C334940000000A0E7863E400000006078334940F2FFFFFFF3863E40040000607733494003000040FA863E400300004062334940FEFFFF7F1E873E40FCFFFF3F50334940FEFFFF7F3E873E40F9FFFFFF393349400500002064873E40FCFFFF3F2C334940F4FFFF7F7D873E40FEFFFF7F1E334940F2FFFFFF93873E40
1037	78	556	557	4	427.625710064564657	00:00:30.789051	0102000020E61000000B000000FDFFFF5F1D334940F7FFFF1F90873E40FEFFFF7F1E334940F2FFFFFF93873E40060000400D33494002000080B1873E4000000000F83249400C000080D2873E4005000020E43249400B000060E9873E40FBFFFF7FD7324940FCFFFFFFF4873E40F9FFFFFFC932494008000020FF873E40010000C0B8324940000000A007883E40FDFFFF5FB13249400B00006009883E40F9FFFFFFA9324940F9FFFF5F0A883E40060000E0A4324940FAFFFF1F0B883E40
1038	78	557	558	5	285.23575207016205	00:00:20.536974	0102000020E61000000800000005000080A4324940F4FFFFDF05883E40060000E0A4324940FAFFFF1F0B883E40010000C098324940050000800C883E40000000608C324940FBFFFFDF0B883E40070000007E324940F5FFFF3F06883E40FFFFFFDF62324940F6FFFF5FF7873E40020000E059324940F5FFFF9FEE873E40FBFFFF7F4B324940F8FFFFDFE0873E40
1039	78	558	559	6	321.377573430008624	00:00:23.139185	0102000020E610000007000000FBFFFFDF4B3249400D000040DB873E40FBFFFF7F4B324940F8FFFFDFE0873E40FFFFFFDF3E324940FCFFFF3FD4873E40FDFFFF5F1932494007000000AE873E40FFFFFF3F033249400700006096873E40020000E0F53149400B00000089873E40FAFFFF1FEF314940F4FFFFDF85873E40
1040	78	559	560	7	472.237684380808162	00:00:34.001113	0102000020E61000000900000004000000EF3149400A00004080873E40FAFFFF1FEF314940F4FFFFDF85873E40FCFFFF3FE8314940060000E084873E4006000040E1314940F5FFFF9F86873E4004000000D7314940070000A08D873E40FFFFFF3FA731494000000060B0873E40FAFFFFBF8E314940F9FFFF9FC1873E40FFFFFFDF6A31494003000040DA873E40050000205C314940FEFFFF7FE6873E40
1041	78	560	561	8	793.787544248271502	00:00:57.152703	0102000020E61000000E000000040000605B314940F8FFFF3FE1873E40050000205C314940FEFFFF7FE6873E40F9FFFF5F4E3149400D0000E0F2873E40000000A033314940FAFFFF1F0B883E40FAFFFF1F1B314940F9FFFFFF21883E40FEFFFF7FF2304940000000A047883E4004000000DB304940FEFFFF1F5E883E40020000E0D1304940F9FFFF5F6A883E40FCFFFF9FC03049400300004082883E40FBFFFFDFAB304940090000E09F883E40020000809D304940FBFFFFDFB3883E40000000A093304940F3FFFFBFC4883E40060000408930494001000020D9883E40060000E080304940F9FFFF5FEA883E40
1042	78	561	562	9	378.195717515353238	00:00:27.230092	0102000020E610000008000000040000607F304940F2FFFFFFE3883E40060000E080304940F9FFFF5FEA883E40030000407630494009000080FF883E400500008070304940FFFFFFDF0E893E40F9FFFFFF69304940F8FFFF3F21893E40FCFFFFFF60304940FCFFFFFF3C893E40FDFFFF5F49304940FEFFFF7F86893E40FCFFFF9F403049400D000040A3893E40
1043	78	562	563	10	1108.36286962579538	00:01:19.802127	0102000020E610000015000000FBFFFF7F3F304940F6FFFF5F9F893E40FCFFFF9F403049400D000040A3893E400400000037304940FEFFFF1FC6893E40040000601F30494008000020278A3E40060000E00C30494005000020748A3E40040000C003304940040000C0938A3E40FAFFFFBFFE2F494001000020A18A3E4002000080F92F4940F7FFFF1FA88A3E40040000C0F32F494003000040AA8A3E4002000080ED2F4940F8FFFF3FA98A3E40FCFFFF9FE82F494007000000A68A3E4000000060E42F4940F5FFFF9F9E8A3E40000000A0D72F4940FCFFFF9F848A3E40FFFFFF3FD32F494002000080818A3E40FFFFFFDFCE2F4940FCFFFF3F848A3E40FFFFFFDFCA2F4940F3FFFF1F8D8A3E4000000060C82F494000000060988A3E40F9FFFF5FC62F49400E000000AC8A3E40040000C0BB2F4940070000A01D8B3E40000000A0B32F4940040000C0738B3E40070000A0B12F49400C0000808A8B3E40
1044	78	563	649	11	1522.89084342154842	00:01:49.648141	0102000020E61000001800000000000000B02F494001000020898B3E40070000A0B12F49400C0000808A8B3E4004000060AF2F4940F4FFFFDF9D8B3E4005000080AC2F4940F8FFFF3FB18B3E4000000060A82F4940FCFFFF3FCC8B3E4001000020A52F4940FFFFFF3FDF8B3E4005000080982F4940FBFFFFDF238C3E40FAFFFFBF922F4940FBFFFFDF438C3E40060000E0782F4940030000A03A8C3E4005000020602F4940020000E0318C3E40040000C04B2F4940F6FFFF5F278C3E40FDFFFFBF352F4940040000601B8C3E40FAFFFF1F232F4940020000E0118C3E40070000A0092F494005000080048C3E40FFFFFFDFEE2E4940F9FFFF5FFA8B3E40FEFFFF7FCE2E4940FDFFFF5FED8B3E4001000020AD2E49400B000000E18B3E40F9FFFF5F9E2E494004000000DB8B3E4000000000902E494003000040D28B3E40FCFFFFFF7C2E49400C000020C28B3E4005000080602E49400D000040AB8B3E4000000000442E4940F9FFFF9F918B3E40050000802C2E4940040000607B8B3E40FBFFFF7F132E4940FCFFFF3F648B3E40
1045	78	649	650	12	216.118599461123324	00:00:15.560539	0102000020E61000000600000000000000142E494000000060608B3E40FBFFFF7F132E4940FCFFFF3F648B3E40060000E0FC2D4940070000604E8B3E40060000E0EC2D4940F6FFFF5F3F8B3E40FEFFFF7FE62D49400B000000398B3E40FCFFFF9FD42D494001000020298B3E40
1046	78	650	651	13	648.4424491207443	00:00:46.687856	0102000020E61000000D000000010000C0D42D4940FCFFFF3F248B3E40FCFFFF9FD42D494001000020298B3E40FDFFFF5FBD2D4940F2FFFF5F148B3E40070000A0AD2D4940FCFFFFFF048B3E40FDFFFF5F992D4940FEFFFF1FEE8A3E4004000060832D494004000000D38A3E40FCFFFF9F742D49400D000040C38A3E40F9FFFFFF612D4940FDFFFFBFAD8A3E40010000C0542D4940F5FFFF9F9E8A3E4005000020482D4940080000208F8A3E40070000A0392D4940FBFFFFDF838A3E40FEFFFF7F222D49400A0000A0708A3E40060000E0182D4940F7FFFF7F688A3E40
1047	78	651	652	14	421.067698997102866	00:00:30.316874	0102000020E610000008000000FCFFFFFF182D4940F2FFFFFF638A3E40060000E0182D4940F7FFFF7F688A3E40F9FFFF5F062D49400C0000205A8A3E4000000000F02C494008000020478A3E40FFFFFF3FE72C4940060000403D8A3E40060000E0DC2C4940FFFFFFDF2E8A3E4003000040D22C4940F5FFFFFF168A3E40FDFFFFBFB12C4940030000A0CA893E40
1048	78	652	653	15	545.88275885025871	00:00:39.303559	0102000020E61000000D000000030000A0B22C4940FEFFFF7FC6893E40FDFFFFBFB12C4940030000A0CA893E40FBFFFF7FA32C494005000020AC893E40000000A09B2C49400D0000409B893E40000000A0832C4940090000E067893E40000000A07B2C4940060000E054893E40FAFFFFBF6E2C4940FCFFFF3F34893E40010000205D2C4940F9FFFFFF09893E40F9FFFFFF512C494000000060F0883E40FEFFFF1F4A2C4940F4FFFF7FE5883E40FFFFFF3F472C49400E0000A0E3883E40F9FFFF5F462C4940F3FFFF1FED883E40FBFFFF7F4B2C4940FCFFFF3FF4883E40
1049	79	\N	654	0	0	00:00:00	\N
1050	79	654	655	1	707.668928513815558	00:00:50.952163	0102000020E61000000D000000000000E01E384940000000C0A8863E40000000002038494000000040AC863E40030000A01A38494000000040BF863E40FFFFFFDF1638494000000040CC863E40FDFFFFBF1138494000000000E7863E400500002004384940000000403A873E40FAFFFFBFFE374940000000E05E873E40010000C0FC374940000000E072873E4000000060F837494000000060A9873E40FDFFFFBFF137494000000060FD873E4000000060F03749400000004013883E40060000E0F0374940000000E01F883E40010000C0F4374940000000603D883E40
1051	79	655	656	2	682.325749565757064	00:00:49.127454	0102000020E610000007000000000000A0F3374940000000203F883E40010000C0F4374940000000603D883E40F9FFFF5F0238494000000000A9883E40060000E014384940000000C038893E40F9FFFF5F1E3849400000004083893E40010000C024384940000000A0B0893E40FBFFFF7F2F384940000000A0B5893E40
1052	79	656	657	3	660.001015106382738	00:00:47.520073	0102000020E61000000B000000FFFFFF3F2F384940000000E0BB893E40FBFFFF7F2F384940000000A0B5893E40FEFFFF1F56384940000000C0C5893E40F9FFFF5F8238494000000060D7893E40FCFFFFFF9C384940000000E0E1893E4003000040BE384940000000C0EC893E40FEFFFF7FC238494000000060EC893E40F9FFFF5FC6384940000000E0E8893E40070000A0C938494000000080E0893E4005000080D438494000000040BB893E4000000060E838494000000060F1893E40
1053	79	657	640	4	831.549041290481114	00:00:59.871531	0102000020E61000000F00000004000060E7384940000000E0F5893E4000000060E838494000000060F1893E4003000040FE384940000000202D8A3E40FCFFFF9FF038494000000020608A3E40000000A0DF384940000000409E8A3E40FDFFFF5FDD38494000000020A88A3E40FEFFFF7FDA38494000000020BA8A3E4005000080D438494000000000EC8A3E40030000A0D2384940000000E0028B3E40060000E0D0384940000000C02D8B3E40FAFFFFBFCE384940000000A0658B3E40FDFFFF5FCD38494000000000878B3E40FBFFFFDFCB38494000000060998B3E4001000020C938494000000040AC8B3E4001000020C5384940000000C0BA8B3E40
1054	79	640	658	5	1187.09532411627174	00:01:25.470863	0102000020E61000001300000000000000C438494000000080B78B3E4001000020C5384940000000C0BA8B3E40FFFFFF3FBF384940000000C0CE8B3E40FDFFFF5FB9384940000000A0E08B3E40FBFFFFDFAB384940000000800A8C3E40060000E0A0384940000000E02B8C3E40060000E090384940000000E05E8C3E40FFFFFFDF8238494000000020848C3E40FEFFFF1F7238494000000000AE8C3E40010000C06438494000000000CE8C3E40FEFFFF1F6238494000000040D38C3E40FCFFFF3F60384940000000C0C38C3E40FCFFFF9F5C38494000000040B38C3E40FCFFFF9F58384940000000809D8C3E40060000405138494000000060628C3E400500008048384940000000A0128C3E40040000003F38494000000080B68B3E40FBFFFFDF3738494000000080708B3E40060000403538494000000080708B3E40
1055	79	658	659	6	290.771145146039714	00:00:20.935522	0102000020E6100000060000000100002035384940000000606A8B3E40060000403538494000000080708B3E40050000801C38494000000000728B3E4005000020E8374940000000A0778B3E40FFFFFF3FDF37494000000000798B3E4002000080D5374940000000607A8B3E40
1056	79	659	660	7	385.349650617187308	00:00:27.745175	0102000020E61000000A000000FDFFFF5FD537494000000080758B3E4002000080D5374940000000607A8B3E40040000C0CB374940000000207C8B3E40FFFFFF3FBF37494000000060818B3E40FDFFFF5FAD374940000000E0848B3E40070000A08D37494000000040858B3E40FBFFFF7F7B37494000000060868B3E40010000206D374940000000A0848B3E40000000605C374940000000C0818B3E400300004056374940000000207B8B3E40
1057	79	660	661	8	236.522777203076828	00:00:17.02964	0102000020E610000006000000040000005737494000000020768B3E400300004056374940000000207B8B3E40020000805137494000000060738B3E40010000204D374940000000E06A8B3E400600004045374940000000C0548B3E40040000002B374940000000000C8B3E40
1058	79	661	662	9	1347.65079296238832	00:01:37.030857	0102000020E610000018000000FBFFFFDF2B374940000000E0088B3E40040000002B374940000000000C8B3E40FAFFFFBF1237494000000020C78A3E40060000E00437494000000020A28A3E40010000C000374940000000A0B08A3E4001000020F136494000000020E98A3E40FDFFFF5FED364940000000C0FA8A3E40FBFFFFDFE7364940000000001F8B3E4007000000E6364940000000802E8B3E40060000E0E436494000000020438B3E40FCFFFFFFE4364940000000005A8B3E40F9FFFF5FE6364940000000606D8B3E40040000C0EB364940000000A09E8B3E40FBFFFF7FFB36494000000080048C3E40050000800037494000000000278C3E40FEFFFF1F02374940000000203C8C3E40F9FFFF5F0237494000000020568C3E400300004002374940000000806B8C3E40060000E000374940000000807E8C3E4003000040FE36494000000080908C3E40FEFFFF7FFA364940000000E0978C3E40000000A0E336494000000060BC8C3E40010000C0C836494000000020E48C3E40010000C0BC36494000000040FA8C3E40
1059	79	662	663	10	595.851897991366968	00:00:42.901337	0102000020E61000000A00000005000020BC364940000000C0F58C3E40010000C0BC36494000000040FA8C3E40FBFFFF7FB3364940000000400D8D3E4000000000B036494000000020178D3E40FBFFFFDFAB364940000000202B8D3E40FCFFFF9FA836494000000080448D3E4001000020A536494000000060698D3E40FEFFFF1F9E364940000000C0D08D3E40030000409A36494000000000108E3E40FAFFFFBF96364940000000A0498E3E40
1060	79	663	664	11	1085.113843904129	00:01:18.128197	0102000020E610000011000000FDFFFF5F9536494000000060498E3E40FAFFFFBF96364940000000A0498E3E40030000A09236494000000060988E3E400000006090364940000000A0B58E3E40050000208436494000000040288F3E40FBFFFFDF7F364940000000E04D8F3E40FAFFFFBF76364940000000C06B8F3E40060000E06C36494000000080878F3E40000000605C36494000000080B58F3E40050000805836494000000040C38F3E40030000A056364940000000C0D28F3E400600004055364940000000A0DD8F3E40060000E05436494000000080F58F3E40FCFFFF3F543649400000008008903E40FFFFFFDF52364940000000E021903E40FDFFFF5F4D3649400000002054903E40000000A04336494000000020AE903E40
1061	79	664	665	12	3418.23794964820854	00:04:06.113132	0102000020E61000001D000000030000404236494000000080AC903E40000000A04336494000000020AE903E40FCFFFF9F3C364940000000A0EC903E4000000000383649400000000019913E40FAFFFFBF363649400000000034913E40020000E0353649400000006053913E4003000040363649400000002070913E400400006037364940000000A09E913E40FCFFFF3F3836494000000080BD913E40030000403A36494000000000DA913E40020000E03D36494000000040FE913E40FEFFFF7F4A3649400000008057923E400300004056364940000000A0A7923E40FDFFFFBF653649400000004014933E40FBFFFFDF73364940000000A074933E40010000C080364940000000E0CD933E4003000040923649400000006043943E40FFFFFF3F9F364940000000A09B943E40FCFFFF3FAC36494000000000F2943E40030000A0C23649400000008087953E40020000E0D136494000000080EE953E4003000040E2364940000000805C963E40F9FFFFFFF1364940000000C0C7963E400000000004374940000000A040973E40000000600C374940000000E076973E40000000001837494000000040C6973E40060000E01C374940000000C0E3973E40010000C02C374940000000002F983E40000000A0333749400000002050983E40
1062	79	665	666	13	617.561879217497676	00:00:44.464455	0102000020E610000007000000F9FFFF5F32374940000000C053983E40000000A0333749400000002050983E40060000E03C374940000000007C983E40000000004837494000000020B2983E400400006057374940000000A0FA983E400100002069374940000000804D993E40040000007B37494000000040A2993E40
1063	79	666	667	14	583.944908599291239	00:00:42.044033	0102000020E610000006000000020000E079374940000000E0A4993E40040000007B37494000000040A2993E40FDFFFF5F89374940000000E0E7993E40FCFFFF9F9C374940000000E0419A3E40F9FFFF5FAE37494000000040959A3E40FFFFFFDFBE37494000000080E29A3E40
1064	79	667	668	15	1259.43686621197867	00:01:30.679454	0102000020E61000000C000000FDFFFFBFBD37494000000080E59A3E40FFFFFFDFBE37494000000080E29A3E40FCFFFF3FD037494000000080359B3E40060000E0E0374940000000A0839B3E4005000080EC374940000000C0BF9B3E40FCFFFF3FF437494000000080E99B3E400500002000384940000000A02B9C3E40000000600C384940000000007A9C3E40030000401238494000000060A19C3E40070000A01D38494000000040EC9C3E40050000802C384940000000E04A9D3E40FAFFFFBF3A38494000000040A59D3E40
1065	79	668	669	16	428.237840131318535	00:00:30.833124	0102000020E610000004000000FDFFFF5F3938494000000020A89D3E40FAFFFFBF3A38494000000040A59D3E40F9FFFFFF49384940000000800A9E3E40040000C05F384940000000A0959E3E40
1066	79	669	670	17	542.057646403880426	00:00:39.028151	0102000020E610000006000000FEFFFF7F5E38494000000040989E3E40040000C05F384940000000A0959E3E400300004072384940000000A00E9F3E400400000083384940000000207F9F3E40070000A08938494000000000AB9F3E40010000208D384940000000E0C79F3E40
1067	79	670	308	18	687.960435656106597	00:00:49.533151	0102000020E610000014000000000000A08B38494000000020CA9F3E40010000208D384940000000E0C79F3E40030000408E38494000000020DF9F3E40040000608F3849400000000003A03E40040000008F384940000000401CA03E40FDFFFFBF8D384940000000A030A03E40FDFFFFBF8D384940000000E041A03E40FEFFFF7F8E3849400000000052A03E40FDFFFF5F913849400000006064A03E40070000A095384940000000806DA03E40FAFFFF1F9B384940000000A070A03E4005000020A0384940000000A06FA03E40FCFFFF9FA4384940000000A06AA03E40FEFFFF1FB23849400000002054A03E40FAFFFF1FB7384940000000C04BA03E40FCFFFF9FBC3849400000002040A03E4005000020C0384940000000203AA03E4000000000C4384940000000803AA03E4004000000D73849400000006052A03E40000000A0CB38494000000040AAA03E40
1069	80	308	671	1	914.086808468761888	00:01:05.81425	0102000020E610000019000000FEFFFF7FCA38494000000060A8A03E40000000A0CB38494003000040AAA03E4000000000C4384940020000E0E9A03E40F9FFFF5FC2384940FAFFFF1FFBA03E40FCFFFFFFB8384940F2FFFF5FECA03E40030000A0A2384940F8FFFF3FD1A03E40FBFFFFDF8B384940000000A0B7A03E40FFFFFF3F8F3849400600004095A03E40FEFFFF7F9A384940060000407DA03E4005000020A0384940000000A06FA03E40FCFFFF9FA4384940030000A06AA03E4000000060B03849400600004055A03E40FCFFFF9FB4384940F8FFFFDF48A03E4003000040B6384940080000C03EA03E40020000E0B53849400500008034A03E4005000080B4384940040000602BA03E4005000020B0384940FCFFFF3F1CA03E40FEFFFF1FAE384940F5FFFF3F16A03E40FEFFFF1FAE384940F2FFFFFF13A03E40000000A0A33849400B00000001A03E40020000E0A1384940FDFFFF5FFD9F3E40FFFFFFDF9E38494006000040F59F3E400200008095384940070000A0D59F3E40050000809038494004000000C39F3E40020000E089384940FAFFFFBF929F3E40
1070	80	671	672	2	425.09438140773193	00:00:30.606795	0102000020E610000006000000FAFFFF1F8B384940F7FFFF7F909F3E40020000E089384940FAFFFFBF929F3E40FDFFFF5F85384940060000E0749F3E40040000C07B384940FCFFFF9F349F3E40FBFFFF7F6F38494004000060E39E3E40020000806538494004000060A39E3E40
1071	80	672	673	3	440.35089934025757	00:00:31.705265	0102000020E610000005000000FFFFFFDF66384940010000C0A09E3E40020000806538494004000060A39E3E40000000605C384940F4FFFFDF659E3E40040000004F384940F7FFFF1F109E3E40FBFFFF7F3F384940FBFFFFDFAB9D3E40
1072	80	673	674	4	1180.37790921750366	00:01:24.987209	0102000020E61000000C000000010000C040384940F8FFFFDFA89D3E40FBFFFF7F3F384940FBFFFFDFAB9D3E40020000E031384940F3FFFFBF549D3E400500008024384940FFFFFFDFFE9C3E40FCFFFFFF1838494004000060B39C3E40040000C00B384940F5FFFF3F5E9C3E40FAFFFFBF02384940FBFFFF7F239C3E40FFFFFFDFFA3749400A0000A0F89B3E4005000020EC374940F6FFFF5FA79B3E4005000020E03749400E0000A06B9B3E40040000C0D7374940F2FFFFFF439B3E40020000E0CD37494005000080149B3E40
1073	80	674	675	5	586.75947748006206	00:00:42.246682	0102000020E610000007000000FFFFFFDFCE374940020000E0119B3E40020000E0CD37494005000080149B3E4005000080C4374940090000E0E79A3E40FAFFFFBFB6374940F9FFFF9FA99A3E4004000060A737494001000020619A3E40010000C0983749400D0000E01A9A3E40FDFFFF5F89374940FAFFFFBFD2993E40
1075	80	676	677	7	3542.66176702481198	00:04:15.071647	0102000020E610000023000000FCFFFF9F48374940040000C093983E40FAFFFF1F473749400900008097983E400000000034374940FDFFFFBF3D983E40FCFFFFFF24374940FDFFFF5FF5973E40040000C01F37494005000020DC973E40FBFFFF7F1B37494005000020C4973E4006000040153749400A0000A098973E40FFFFFF3F0F374940020000E071973E400300004006374940F3FFFF1F35973E40040000C0F3364940000000A0B7963E40FDFFFFBFE93649400300004072963E40070000A0D93649400700000006963E4003000040CA364940F6FFFF5F9F953E40FEFFFF7FBA364940F4FFFFDF35953E40FAFFFFBFAA364940F3FFFF1FCD943E40070000A09D364940FCFFFF3F74943E40FDFFFFBF91364940F4FFFF7F25943E40010000208536494000000060D0933E40FFFFFF3F77364940FBFFFF7F73933E40FAFFFF1F6B364940FEFFFF7F1E933E40FBFFFFDF5F364940060000E0CC923E4003000040563649400D0000E08A923E40FCFFFFFF4C364940060000404D923E400500008048364940FCFFFFFF2C923E40FAFFFF1F43364940F6FFFF5F07923E40040000C03F364940FBFFFF7FEB913E40020000E03D364940FEFFFF7FD6913E40FCFFFFFF3C3649400A0000A0C0913E40FBFFFF7F3B364940F6FFFF5F87913E40FAFFFF1F3B364940FDFFFF5F6D913E40FAFFFF1F3B364940080000C04E913E40050000203C3649400D0000402B913E40030000403E3649400100002009913E40FBFFFF7F433649400A000040D8903E40FBFFFFDF47364940F9FFFF5FB2903E40
1076	80	677	678	8	698.161918967876659	00:00:50.267658	0102000020E61000000F0000000100002049364940FBFFFF7FB3903E40FBFFFFDF47364940F9FFFF5FB2903E40FFFFFF3F4F3649400A00004070903E40FBFFFFDF53364940070000A045903E40FAFFFFBF56364940030000402A903E40FDFFFF5F59364940F4FFFFDF15903E40FEFFFF7F5E364940FEFFFF7FEE8F3E400600004061364940FAFFFFBFDA8F3E400600004065364940FCFFFFFFC48F3E40FBFFFF7F6B364940040000C0AB8F3E40FAFFFFBF723649400A000040908F3E40FCFFFFFF78364940F4FFFFDF758F3E40050000807C3649400D0000E0628F3E40FBFFFFDF7F364940F4FFFFDF4D8F3E4005000020843649400A000040288F3E40
1077	80	678	679	9	485.665041879152341	00:00:34.967883	0102000020E610000006000000020000E085364940F8FFFF3F298F3E4005000020843649400A000040288F3E400000006090364940070000A0B58E3E40030000A09236494000000060988E3E40FAFFFFBF96364940F9FFFF9F498E3E40030000409A36494000000000108E3E40
1078	80	679	680	10	545.495649624475618	00:00:39.275687	0102000020E61000000A000000040000C09B36494000000060108E3E40030000409A36494000000000108E3E40FEFFFF1F9E364940010000C0D08D3E4001000020A53649400B000060698D3E40FCFFFF9FA836494005000080448D3E40FBFFFFDFAB364940FAFFFF1F2B8D3E4000000000B036494008000020178D3E40FBFFFF7FB3364940060000400D8D3E40010000C0BC36494003000040FA8C3E40010000C0C836494005000020E48C3E40
1079	80	680	681	11	1126.10489324652735	00:01:21.079552	0102000020E610000015000000070000A0C93649400B0000C0E98C3E40010000C0C836494005000020E48C3E40000000A0E3364940F2FFFF5FBC8C3E40FEFFFF7FFA364940090000E0978C3E4003000040FE364940F7FFFF7F908C3E40060000E000374940FEFFFF7F7E8C3E400300004002374940FBFFFF7F6B8C3E40F9FFFF5F02374940FEFFFF1F568C3E40FEFFFF1F02374940050000203C8C3E400500008000374940F5FFFFFF268C3E40FBFFFF7FFB36494005000080048C3E40040000C0EB364940F5FFFF9F9E8B3E40F9FFFF5FE6364940FDFFFF5F6D8B3E40FCFFFFFFE4364940F9FFFFFF598B3E40060000E0E4364940FAFFFF1F438B3E4007000000E6364940FEFFFF7F2E8B3E40FBFFFFDFE7364940F5FFFFFF1E8B3E40FDFFFF5FED364940FAFFFFBFFA8A3E4001000020F136494001000020E98A3E40010000C0003749400A0000A0B08A3E40010000C00C3749400A0000A0D08A3E40
1080	80	681	682	12	451.979669045978767	00:00:32.542536	0102000020E610000009000000040000C00B37494005000080D48A3E40010000C00C3749400A0000A0D08A3E40020000E02D374940030000A02A8B3E40FEFFFF7F46374940080000C06E8B3E40FFFFFFDF4A3749400A0000A0788B3E40050000205037494000000000808B3E40FCFFFF3F54374940FBFFFFDF838B3E40000000605C3749400B0000C0818B3E40010000206D374940FCFFFF9F848B3E40
1081	80	682	683	13	336.244369628153947	00:00:24.209595	0102000020E610000009000000010000206D37494001000020898B3E40010000206D374940FCFFFF9F848B3E40FBFFFF7F7B37494007000060868B3E40070000A08D37494006000040858B3E40FDFFFF5FAD374940060000E0848B3E40FFFFFF3FBF3749400B000060818B3E4004000000C7374940FCFFFF9F8C8B3E40000000A0CF374940FAFFFF1F9B8B3E40FCFFFFFFD437494006000040A58B3E40
1082	80	683	684	14	577.148678037785089	00:00:41.554705	0102000020E61000000800000000000060D4374940020000E0A98B3E40FCFFFFFFD437494006000040A58B3E4005000080FC374940F8FFFFDFF08B3E40070000A011384940F3FFFF1F158C3E40FAFFFF1F1B38494000000000288C3E40040000C03738494006000040658C3E400500002048384940F6FFFFBF8F8C3E40060000E050384940F5FFFFFFA68C3E40
1083	80	684	624	15	177.264074666317413	00:00:12.763013	0102000020E610000005000000FBFFFFDF4F384940FBFFFF7FAB8C3E40060000E050384940F5FFFFFFA68C3E40FEFFFF1F623849400D000040D38C3E40010000C06438494007000000CE8C3E40FEFFFF1F7238494007000000AE8C3E40
1084	80	624	625	16	634.896291782757771	00:00:45.712533	0102000020E61000000D000000FAFFFF1F73384940020000E0B18C3E40FEFFFF1F7238494007000000AE8C3E40FFFFFFDF8238494005000020848C3E40060000E090384940FFFFFFDF5E8C3E40060000E0A0384940FBFFFFDF2B8C3E40FBFFFFDFAB3849400C0000800A8C3E40FDFFFF5FB93849400A0000A0E08B3E40FFFFFF3FBF384940080000C0CE8B3E4001000020C5384940FAFFFFBFBA8B3E4001000020C9384940FCFFFF3FAC8B3E40FBFFFFDFCB3849400B000060998B3E40FDFFFF5FCD384940F5FFFFFF868B3E40FAFFFFBFCE384940070000A0658B3E40
1085	80	625	685	17	680.380170602128601	00:00:48.987372	0102000020E61000000B000000FCFFFF9FD038494007000000668B3E40FAFFFFBFCE384940070000A0658B3E40060000E0D0384940FDFFFFBF2D8B3E40030000A0D23849400D0000E0028B3E4005000080D43849400E000000EC8A3E40FEFFFF7FDA3849400C000020BA8A3E40FDFFFF5FDD384940F7FFFF1FA88A3E40000000A0DF384940F5FFFF3F9E8A3E40FCFFFF9FF0384940F7FFFF1F608A3E4003000040FE384940F3FFFF1F2D8A3E4000000060E83849400B000060F1893E40
1086	80	685	686	18	768.477380557836454	00:00:55.330371	0102000020E61000000D00000002000080E9384940F4FFFF7FED893E4000000060E83849400B000060F1893E4005000080D43849400D000040BB893E40070000A0C9384940F7FFFF7FE0893E40F9FFFF5FC6384940F8FFFFDFE8893E40FEFFFF7FC2384940F2FFFF5FEC893E4003000040BE384940F3FFFFBFEC893E40FCFFFFFF9C384940020000E0E1893E40F9FFFF5F82384940F6FFFF5FD7893E40FEFFFF1F56384940FDFFFFBFC5893E40FBFFFF7F2F384940070000A0B5893E40010000C0243849400A0000A0B0893E40F9FFFF5F1E3849400D00004083893E40
1087	80	686	687	19	681.660726524582515	00:00:49.079572	0102000020E610000008000000040000C01F3849400100002081893E40F9FFFF5F1E3849400D00004083893E40060000E014384940010000C038893E40F9FFFF5F023849400B000000A9883E40010000C0F4374940FDFFFF5F3D883E40060000E0F0374940090000E01F883E4000000060F03749400D00004013883E40FDFFFFBFF1374940FDFFFF5FFD873E40
1088	80	687	688	20	560.414654678760371	00:00:40.349855	0102000020E610000009000000000000A0F3374940FDFFFFBFFD873E40FDFFFFBFF1374940FDFFFF5FFD873E4000000060F83749400B000060A9873E40010000C0FC3749400D0000E072873E40FAFFFFBFFE374940FFFFFFDF5E873E400500002004384940030000403A873E40FDFFFFBF11384940F5FFFFFFE6863E40FFFFFFDF16384940FCFFFF3FCC863E40030000A01A384940FFFFFF3FBF863E40
1089	81	\N	689	0	0	00:00:00	\N
1090	81	689	593	1	920.051870867908519	00:01:06.243735	0102000020E61000000B000000FBFFFF7F6F3B4940000000E0F95A3E40000000606F3B4940000000E0FE5A3E4000000060523B4940000000E0065B3E40000000C0283B4940000000E0135B3E40000000C0FD3A494000000060225B3E40000000E0D13A494000000060305B3E40000000E0A43A4940000000E03F5B3E4000000080783A4940000000404D5B3E40000000E0613A494000000040545B3E40000000A04D3A4940000000405A5B3E40000000403D3A494000000040605B3E40
1091	81	593	594	2	305.280955995201452	00:00:21.980229	0102000020E610000006000000FDFFFF5F3D3A4940000000E0595B3E40000000403D3A494000000040605B3E40000000E0213A494000000000695B3E4000000080FC39494000000020735B3E4000000000E9394940000000C0785B3E4000000000DA394940000000007C5B3E40
1092	81	594	595	3	384.423049662417668	00:00:27.67846	0102000020E610000008000000FEFFFF1FDA394940000000C0775B3E4000000000DA394940000000007C5B3E4000000040C4394940000000C07E5B3E40000000A0AA394940000000C0835B3E40000000208B39494000000040885B3E40000000A077394940000000808B5B3E400000006066394940000000A08F5B3E40000000E05939494000000080925B3E40
1093	81	595	596	4	452.102544060376431	00:00:32.551383	0102000020E610000008000000FEFFFF1F5A394940000000E08C5B3E40000000E05939494000000080925B3E40000000C03F39494000000080985B3E40000000E024394940000000609E5B3E400000006017394940000000E0A05B3E4000000060FD38494000000060A95B3E4000000040E5384940000000C0B15B3E40000000C0C438494000000000BC5B3E40
1094	81	596	597	5	703.599204673102918	00:00:50.659143	0102000020E610000008000000010000C0C438494000000000B75B3E40000000C0C438494000000000BC5B3E40000000E0A738494000000000C45B3E40000000E08A38494000000040CE5B3E400000006063384940000000E0D95B3E40000000603738494000000040E85B3E40000000A00838494000000060F75B3E4000000060DB374940000000E0065C3E40
1095	81	597	598	6	530.300800402204004	00:00:38.181658	0102000020E61000000A000000000000A0DB374940000000A0015C3E4000000060DB374940000000E0065C3E40000000E0C5374940000000800C5C3E4000000020A837494000000060185C3E40000000809B374940000000C01D5C3E40000000A08D37494000000060245C3E40000000E081374940000000C02B5C3E40000000407337494000000040365C3E40000000605C37494000000000515C3E40000000A03C37494000000080815C3E40
1096	81	598	599	7	841.501300702175854	00:01:00.588094	0102000020E610000009000000040000C03B374940000000807B5C3E40000000A03C37494000000080815C3E40000000601F374940000000E0AE5C3E400000000000374940000000C0DE5C3E40000000A0E0364940000000200E5D3E40000000E0BC364940000000C0455D3E40000000A09F36494000000000725D3E40000000E081364940000000C09F5D3E40000000A06836494000000020C75D3E40
1097	81	599	690	8	1016.87162613991882	00:01:13.214757	0102000020E61000000C000000000000006836494000000080C15D3E40000000A06836494000000020C75D3E40000000A05536494000000000E55D3E40000000803D364940000000E0095E3E40000000201C364940000000203B5E3E40000000800D36494000000000535E3E40000000C0F3354940000000C0805E3E4000000060E9354940000000C0955E3E4000000080D935494000000020BD5E3E40000000C0BF354940000000A00D5F3E40000000A09D35494000000040795F3E40000000009635494000000040935F3E40
1098	81	690	691	9	1027.93360516586336	00:01:14.01122	0102000020E610000007000000060000E09435494000000020905F3E40000000009635494000000040935F3E400000002077354940000000E0F85F3E400000004057354940000000A060603E40000000A031354940000000E0D8603E40000000A00F354940000000C044613E4000000080F034494000000060A5613E40
1099	81	691	692	10	1185.85355063278485	00:01:25.381456	0102000020E61000000900000000000080EF344940000000A0A1613E4000000080F034494000000060A5613E40000000A0C9344940000000601F623E40000000A0A73449400000004089623E40000000009934494000000060B3623E40000000E08934494000000020E7623E4000000080693449400000004056633E400000008047344940000000E0C2633E40000000C0313449400000002009643E40
1100	81	692	693	11	1633.55735518383744	00:01:57.61613	0102000020E61000000E000000000000202F344940000000A000643E40000000C0313449400000002009643E4000000060243449400000000033643E4000000060153449400000008063643E40000000C0103449400000000074643E40000000C001344940000000E0AB643E40000000E0FC33494000000040BE643E4000000020F133494000000060F4643E40000000A0E9334940000000201D653E4000000000D7334940000000C088653E4000000040C733494000000080E5653E4000000080AF334940000000A074663E40000000409D33494000000060DE663E40000000807F334940000000808C673E40
1101	81	693	694	12	2271.92098127088548	00:02:43.578311	0102000020E61000000F000000070000007E334940000000A089673E40000000807F334940000000808C673E40000000C06A334940000000000B683E40000000C0603349400000004050683E40000000204F33494000000040E4683E40000000A03E334940000000C054693E40000000602A334940000000C0CD693E40000000001333494000000080576A3E40000000E000334940000000C0C26A3E4000000000F1324940000000201E6B3E40000000E0DB32494000000020926B3E4000000000CF32494000000000D06B3E4000000040B9324940000000002F6C3E4000000060AC324940000000605E6C3E4000000020A132494000000000896C3E40
1102	81	694	695	13	559.119656919728413	00:00:40.256615	0102000020E610000009000000040000C09F32494000000020856C3E4000000020A132494000000000896C3E40000000609B324940000000A09C6C3E40000000608E324940000000C0C46C3E40000000E07C324940000000A0FB6C3E400000004077324940000000800D6D3E400000000067324940000000C0386D3E40000000C04A324940000000A0826D3E40000000A03F324940000000C09E6D3E40
1103	81	695	696	14	461.384276433732907	00:00:33.219668	0102000020E610000008000000FAFFFFBF3E324940000000C0996D3E40000000A03F324940000000C09E6D3E40000000A036324940000000E0AE6D3E40000000002932494000000000C46D3E40000000601E324940000000A0D76D3E40000000E01232494000000060F26D3E4000000080F4314940000000A0446E3E40000000A0E331494000000060736E3E40
1104	81	696	697	15	796.968499255439838	00:00:57.381732	0102000020E610000006000000030000A0E2314940000000206F6E3E40000000A0E331494000000060736E3E40000000A0CC314940000000E0B06E3E4000000040A031494000000020296F3E400000000075314940000000A09F6F3E40000000205331494000000020FC6F3E40
1105	81	697	698	16	1073.70418191162253	00:01:17.306701	0102000020E610000009000000020000E05131494000000080F76F3E40000000205331494000000020FC6F3E4000000020323149400000000055703E40000000A01C314940000000608E703E40000000C00D31494000000020B7703E40000000C0ED304940000000A00D713E4000000000D1304940000000C05C713E4000000040B330494000000080AC713E40000000808F304940000000800D723E40
1106	81	698	699	17	901.079697153205416	00:01:04.877738	0102000020E610000008000000030000408E3049400000006009723E40000000808F304940000000800D723E40000000E071304940000000C05D723E40000000605B3049400000008099723E40000000C04B30494000000000C3723E40000000C02A304940000000A01D733E400000002008304940000000E07B733E4000000040EB2F494000000040C9733E40
1107	81	699	700	18	1142.44350242330211	00:01:22.255932	0102000020E61000001700000003000040EA2F494000000000C6733E4000000040EB2F494000000040C9733E4000000040D12F49400000004011743E4000000080C82F4940000000C02C743E4000000020B72F49400000008068743E40000000C0A22F4940000000E0A3743E40000000E0842F494000000000F4743E40000000206E2F49400000004032753E4000000000632F49400000008050753E4000000040502F49400000006082753E40000000604B2F49400000000086753E4000000020462F49400000008084753E4000000020402F4940000000C07A753E40000000803D2F49400000008070753E40000000203C2F49400000008064753E40000000C03B2F49400000004057753E40000000E03C2F4940000000E04A753E40000000A03F2F4940000000A03E753E40000000C0432F49400000008035753E40000000C0482F49400000004032753E40000000804E2F4940000000C035753E4000000060552F4940000000203D753E4000000040592F4940000000C048753E40
1108	81	700	701	19	450.73991867854636	00:00:32.453274	0102000020E61000000600000000000000582F4940000000A04B753E4000000040592F4940000000C048753E4000000000622F49400000004065753E40000000C0812F4940000000C0C8753E4000000040932F494000000040FF753E4000000080A22F4940000000602E763E40
1109	81	701	702	20	430.57712178762273	00:00:31.001553	0102000020E610000005000000FDFFFF5FA12F4940000000E031763E4000000080A22F4940000000602E763E4000000080BE2F4940000000C082763E4000000060D72F4940000000E0CC763E40000000C0EA2F4940000000E006773E40
1110	81	702	350	21	853.861185056216414	00:01:01.478005	0102000020E61000000A00000000000060E82F4940000000000E773E40000000C0EA2F4940000000E006773E400000008002304940000000604F773E40000000601C304940000000609D773E40000000002F304940000000C0D7773E40000000A04A304940000000C02A783E40000000C0613049400000002072783E40000000A06C3049400000008094783E400000000072304940000000C0A6783E400000000076304940000000A0B7783E40
1111	81	350	378	22	1358.67149451752493	00:01:37.824348	0102000020E610000017000000000000607430494000000040BC783E400000000076304940000000A0B7783E40000000808630494000000060F9783E40000000E095304940000000E03A793E40000000A09D304940000000605F793E40000000C0A8304940000000A096793E4000000000B930494000000040EA793E4000000060C3304940000000001F7A3E4000000000C530494000000060267A3E4000000000CB304940000000E02A7A3E40000000A0DE304940000000A03F7A3E40000000A0F630494000000040587A3E4000000000F930494000000000607A3E40000000C0FA304940000000006C7A3E4000000040FB304940000000E0757A3E4000000040F930494000000060817A3E4000000020F5304940000000A08B7A3E40000000A0E2304940000000E0B07A3E40000000C0D930494000000020817A3E4000000020CF304940000000E0497A3E4000000000CB304940000000E02A7A3E40000000A0C6304940000000A0117A3E4000000060C0304940000000A0F1793E40
1112	82	\N	378	0	0	00:00:00	\N
1113	82	378	703	1	681.581775564164786	00:00:49.073888	0102000020E61000000A000000000000E0C130494000000040EE793E4000000060C0304940000000A0F1793E4000000060AA3049400000002081793E4000000000A23049400000006058793E40000000809B304940000000C039793E4000000040973049400000002027793E40000000008630494000000060DE783E40000000C07930494000000060AB783E4000000020743049400000000097783E40000000206D304940000000607F783E40
1114	82	703	704	2	872.768503658614122	00:01:02.839332	0102000020E61000000B000000030000406E304940FBFFFFDF7B783E40000000206D304940000000607F783E40000000805D304940000000A04E783E4000000080543049400000002033783E40000000A0493049400000006011783E400000004034304940000000C0D1773E400000002024304940000000809F773E40000000000E304940000000605D773E4000000060FB2F4940000000C024773E40000000A0E62F494000000020E5763E4000000020DB2F494000000060C3763E40
1115	82	704	705	3	733.388255054107276	00:00:52.803954	0102000020E61000000B000000FCFFFF9FDC2F4940F3FFFF1FBD763E4000000020DB2F494000000060C3763E4000000080CB2F49400000000094763E4000000020B62F4940000000E052763E4000000020A62F4940000000C023763E40000000C0992F494000000020FE753E40000000C0962F4940000000E0EB753E4000000000932F494000000000D3753E4000000020912F4940000000C0BB753E40000000C0902F494000000060A1753E4000000000922F4940000000A039753E40
1116	82	705	706	4	752.271265960982873	00:00:54.163531	0102000020E61000000E000000FBFFFF7F932F4940F9FFFF5F3A753E4000000000922F4940000000A039753E40000000C0922F4940000000E016753E40000000A0932F49400000004005753E4000000060972F4940000000C0EE743E40000000609A2F494000000080E3743E40000000A0AB2F494000000000B2743E4000000020B82F4940000000C08E743E4000000080BD2F4940000000A07F743E40000000E0C32F4940000000C061743E4000000000CF2F49400000000046743E4000000080E02F4940000000A017743E4000000020FC2F494000000020CE733E40000000600430494000000000B7733E40
1117	82	706	707	5	804.848258043102078	00:00:57.949075	0102000020E610000008000000FDFFFF5F05304940FAFFFFBFBA733E40000000600430494000000000B7733E40000000401D3049400000008074733E40000000A03D304940000000401D733E40000000005130494000000040E9723E400000008066304940000000E0AD723E40000000607F304940000000A069723E40000000E096304940000000602A723E40
1118	82	707	708	6	1138.14731571447305	00:01:21.946607	0102000020E61000000B0000000000000098304940F4FFFF7F2D723E40000000E096304940000000602A723E40000000C0B130494000000040E2713E40000000E0CA304940000000209E713E40000000C0E03049400000006063713E40000000C0F13049400000006036713E40000000600831494000000040F9703E40000000001F31494000000040BA703E40000000C0333149400000000082703E400000004052314940000000C02F703E40000000E066314940000000E0F76F3E40
1119	82	708	709	7	744.854632949579582	00:00:53.629534	0102000020E610000007000000000000A06731494004000000FB6F3E40000000E066314940000000E0F76F3E40000000208631494000000080A26F3E4000000080A5314940000000604D6F3E40000000E0BF31494000000000066F3E4000000020DC31494000000060BA6E3E40000000A0EE31494000000080886E3E40
1120	82	709	710	8	463.458305343051961	00:00:33.368998	0102000020E61000000600000004000060EF3149400E0000A08B6E3E40000000A0EE31494000000080886E3E4000000000FD31494000000020616E3E40000000A00D32494000000020346E3E40000000C024324940000000E0F46D3E40000000204232494000000060A46D3E40
1121	82	710	711	9	551.890554266390154	00:00:39.73612	0102000020E610000008000000FFFFFF3F4332494008000020A76D3E40000000204232494000000060A46D3E40000000004A32494000000060926D3E40000000C05B32494000000040626D3E40000000406C32494000000020396D3E40000000E07B324940000000000B6D3E40000000209232494000000080C76C3E40000000C0A232494000000060916C3E40
1122	82	711	712	10	2391.25865669520999	00:02:52.170623	0102000020E610000012000000FBFFFFDFA3324940FBFFFF7F936C3E40000000C0A232494000000060916C3E40000000E0AC324940000000E06D6C3E4000000060B8324940000000003D6C3E4000000080CC32494000000040E76B3E40000000E0DC324940000000409A6B3E40000000E0EE32494000000040396B3E4000000000FD32494000000000E86A3E40000000201033494000000020766A3E40000000401F334940000000401F6A3E40000000402F33494000000000BF693E40000000E041334940000000C04E693E40000000C05133494000000040EA683E40000000805B33494000000040AF683E40000000406C334940000000C04C683E40000000807E33494000000020E0673E40000000608F334940000000207A673E40000000E0953349400000004054673E40
1123	82	712	713	11	1476.93387534153362	00:01:46.339239	0102000020E61000000A000000FFFFFF3F97334940F5FFFFFF56673E40000000E0953349400000004054673E4000000000AC334940000000C0CB663E4000000040BF334940000000405B663E4000000000D6334940000000C0D7653E40000000A0ED334940000000C050653E4000000040F9334940000000400D653E40000000A00634494000000000CE643E40000000001B344940000000E07E643E40000000E0383449400000002023643E40
1124	82	713	714	12	1184.36739944386409	00:01:25.274453	0102000020E61000000B000000000000003A344940000000A026643E40000000E0383449400000002023643E40000000E052344940000000E0CF633E4000000080693449400000006087633E40000000C073344940000000C067633E40000000E08A344940000000401C633E40000000E0A9344940000000A0B6623E4000000000BB344940000000007F623E40000000E0CE344940000000E040623E4000000060E43449400000008001623E4000000000F834494000000080C0613E40
1125	82	714	715	13	1041.83575757979679	00:01:15.012175	0102000020E61000000800000000000040F9344940000000A0C3613E4000000000F834494000000080C0613E400000004016354940000000805F613E40000000C03835494000000000F0603E4000000000563549400000004093603E40000000C0723549400000002038603E40000000208835494000000000F55F3E4000000020A0354940000000A0A75F3E40
1126	82	715	607	14	1133.02822489531331	00:01:21.578032	0102000020E61000000F00000006000040A1354940FBFFFF7FAB5F3E4000000020A0354940000000A0A75F3E4000000080B535494000000080635F3E4000000060CF354940000000E0115F3E4000000040E735494000000020CA5E3E40000000E0EB35494000000020BD5E3E4000000040F9354940000000E09D5E3E40000000800A364940000000A0795E3E400000002012364940000000E0695E3E40000000402636494000000060465E3E40000000003736494000000080295E3E40000000E05536494000000060FA5D3E40000000C06F36494000000000D35D3E40000000407936494000000060C55D3E40000000C08E364940000000E0A95D3E40
1127	82	607	608	15	588.923994197030083	00:00:42.402528	0102000020E610000009000000040000008F364940FFFFFFDFAE5D3E40000000C08E364940000000E0A95D3E40000000009E36494000000040965D3E4000000080AD364940000000607F5D3E4000000060CB364940000000C0525D3E4000000000EB36494000000040235D3E40000000400037494000000000045D3E40000000A01A374940000000E0DB5C3E40000000402537494000000060CB5C3E40
1128	82	608	609	16	625.161280009431493	00:00:45.011612	0102000020E61000000D000000FDFFFFBF253749400A0000A0D05C3E40000000402537494000000060CB5C3E40000000E03A37494000000060AA5C3E40000000804C374940000000408F5C3E40000000A05C374940000000A0755C3E40000000E063374940000000C06C5C3E40000000A06E37494000000020605C3E40000000207A37494000000000575C3E40000000808E374940000000A0485C3E40000000A09C37494000000040415C3E4000000080B537494000000000385C3E40000000C0C637494000000020325C3E4000000000DC374940000000C02A5C3E40
1129	82	609	610	17	691.138473893659921	00:00:49.76197	0102000020E61000000A000000FCFFFF3FDC37494000000060305C3E4000000000DC374940000000C02A5C3E4000000060F8374940000000A0225C3E40000000401A384940000000C0175C3E40000000E03E384940000000200C5C3E40000000206338494000000020FF5B3E40000000A07E38494000000040F55B3E400000008094384940000000E0ED5B3E4000000060AE38494000000020E55B3E4000000080C038494000000060DE5B3E40
1130	82	610	611	18	475.193868553555831	00:00:34.213959	0102000020E61000000700000005000080C038494004000060E35B3E4000000080C038494000000060DE5B3E4000000020D238494000000080D95B3E40000000A0FA38494000000020CC5B3E40000000A01A394940000000A0C25B3E40000000604039494000000060B75B3E40000000805D39494000000000AF5B3E40
1131	82	611	612	19	380.762609054548193	00:00:27.414908	0102000020E610000006000000020000805D394940FBFFFFDFB35B3E40000000805D39494000000000AF5B3E40000000407C39494000000080A55B3E40000000609F394940000000A09B5B3E4000000060BA394940000000A0945B3E4000000040DB394940000000408E5B3E40
1132	82	612	716	20	376.353305353826443	00:00:27.097438	0102000020E61000000700000004000060DB3949400D0000E0925B3E4000000040DB394940000000408E5B3E4000000020EC39494000000060895B3E4000000060FD394940000000C0835B3E4000000080023A4940000000A0815B3E40000000A0483A4940000000C06B5B3E4000000000573A4940000000E0665B3E40
1133	82	716	717	21	752.341413785409031	00:00:54.168582	0102000020E610000008000000FAFFFF1F573A4940FAFFFF1F6B5B3E4000000000573A4940000000E0665B3E40000000E0783A4940000000A05A5B3E4000000040A63A4940000000804B5B3E40000000E0D23A4940000000003D5B3E40000000A0FE3A4940000000A02E5B3E40000000A0343B4940000000001D5B3E40000000E0503B4940000000E0135B3E40
1134	83	\N	718	0	0	00:00:00	\N
1135	83	718	719	1	2388.11960864970979	00:02:51.944612	0102000020E610000013000000FAFFFF1FC746494000000040F4553E4000000060C846494000000000F0553E40000000E0DC464940000000E040563E4000000040CF4649400000000069563E40000000A0C6464940000000E081563E4000000000AA46494000000020C7563E40000000C08C4649400000000017573E400000004077464940000000A04F573E40000000605146494000000020B3573E40000000404246494000000020DA573E40000000E02D464940000000800F583E40000000200F4649400000004064583E4000000020EA454940000000C0C8583E4000000060D24549400000006008593E4000000020A8454940000000E077593E40000000209B454940000000A098593E40000000407445494000000040005A3E400000006045454940000000807F5A3E40000000C03E454940000000C08F5A3E40
1136	83	719	720	2	741.691818683516203	00:00:53.401811	0102000020E610000006000000060000403D454940000000C0895A3E40000000C03E454940000000C08F5A3E40000000002345494000000040D95A3E40000000A00C454940000000A0145B3E40000000C0D9444940000000C09E5B3E40000000A0BE444940000000003D5B3E40
1137	83	720	721	3	493.805117280221339	00:00:35.553968	0102000020E61000000C00000000000020C0444940000000E0385B3E40000000A0BE444940000000003D5B3E4000000020B844494000000000285B3E4000000040B1444940000000A0155B3E40000000C0A144494000000020DF5A3E40000000409A44494000000020C55A3E40000000409844494000000000BB5A3E40000000A09844494000000080B15A3E40000000A09344494000000060A25A3E40000000608A44494000000080C45A3E40000000007C444940000000E0EB5A3E40000000407344494000000080045B3E40
1138	83	721	722	4	416.31100388917389	00:00:29.974392	0102000020E610000007000000020000E07144494000000080FE5A3E40000000407344494000000080045B3E40000000C06744494000000020245B3E40000000606044494000000080385B3E40000000A052444940000000C05D5B3E40000000C03444494000000060AB5B3E40000000E027444940000000E0CC5B3E40
1139	83	722	723	5	269.556360679690783	00:00:19.408058	0102000020E610000004000000000000C02644494000000040C85B3E40000000E027444940000000E0CC5B3E40000000E00E44494000000000105C3E40000000A0F7434940000000404E5C3E40
1140	83	723	724	6	283.687399473953349	00:00:20.425493	0102000020E61000000600000000000060F6434940000000004A5C3E40000000A0F7434940000000404E5C3E40000000A0E8434940000000A0755C3E4000000080CE43494000000060B95C3E4000000080C743494000000060CB5C3E4000000080C343494000000080D55C3E40
1141	83	724	725	7	301.520340563516868	00:00:21.709465	0102000020E610000005000000FEFFFF7FC243494000000000D15C3E4000000080C343494000000080D55C3E4000000040AB434940000000A0175D3E40000000809343494000000040575D3E40000000808D43494000000020675D3E40
1142	83	725	726	8	276.141068312766038	00:00:19.882157	0102000020E610000005000000FCFFFF3F8C434940000000C0625D3E40000000808D43494000000020675D3E40000000007743494000000020A25D3E40000000405F43494000000000E25D3E40000000A05D43494000000000D75D3E40
1143	83	726	727	9	1285.49336331140034	00:01:32.555522	0102000020E610000011000000FAFFFFBF5E434940000000E0D25D3E40000000A05D43494000000000D75D3E40000000005043494000000040A45D3E40000000C03543494000000000445D3E40000000C020434940000000E0F45C3E40000000201643494000000020D45C3E40000000400C43494000000020BA5C3E40000000A00143494000000060AA5C3E4000000000F842494000000040A35C3E40000000C0ED424940000000E0A15C3E40000000E0D142494000000080A15C3E4000000080A142494000000080A05C3E400000000082424940000000C09F5C3E40000000A055424940000000209F5C3E400000006038424940000000009E5C3E40000000C023424940000000209F5C3E40000000801442494000000040A25C3E40
1144	83	727	478	10	1634.81655142289856	00:01:57.706792	0102000020E610000018000000010000C014424940000000C09B5C3E40000000801442494000000040A25C3E40000000000C424940000000E0A15C3E40000000800542494000000020A15C3E40000000E002424940000000E0A05C3E4000000040F941494000000000A15C3E40000000E0E941494000000040A65C3E40000000C0C941494000000040B35C3E4000000080AF414940000000E0BD5C3E40000000608F41494000000080CA5C3E40000000207141494000000020D65C3E40000000605741494000000000E15C3E40000000403B41494000000080EB5C3E40000000601F41494000000020F65C3E40000000400041494000000020035D3E4000000000E3404940000000A00E5D3E4000000060C2404940000000A01A5D3E40000000A09C40494000000060295D3E40000000C07E404940000000A0345D3E40000000205F404940000000A0405D3E40000000003C404940000000604E5D3E40000000E019404940000000005B5D3E40000000000640494000000060625D3E4000000080F63F494000000080655D3E40
1145	83	478	728	11	2734.32863162451076	00:03:16.871661	0102000020E61000001D000000030000A0F63F494000000060605D3E4000000080F63F494000000080655D3E40000000E0E43F4940000000A0685D3E4000000060CD3F4940000000406E5D3E4000000080AF3F494000000000765D3E40000000E0993F4940000000007C5D3E4000000080803F494000000080845D3E4000000080603F4940000000008F5D3E40000000C03F3F4940000000A0945D3E4000000020273F494000000080925D3E40000000A0143F4940000000008F5D3E40000000E0F73E4940000000A0815D3E4000000040EA3E4940000000607C5D3E4000000060CF3E494000000060685D3E4000000060AF3E4940000000404C5D3E40000000E0923E494000000040335D3E40000000E0683E494000000080105D3E40000000A03F3E4940000000C0EE5C3E4000000020143E4940000000C0C85C3E40000000C0EF3D494000000020A95C3E4000000060BB3D4940000000607C5C3E40000000408A3D4940000000E0505C3E40000000006D3D494000000080365C3E40000000A03D3D4940000000800A5C3E40000000C01D3D494000000000EE5B3E40000000200C3D494000000060DE5B3E4000000020ED3C494000000020C55B3E4000000080C53C4940000000A0A25B3E40000000C09C3C494000000080805B3E40
1146	83	728	729	12	323.605351973077632	00:00:23.299585	0102000020E610000006000000060000409D3C4940000000407B5B3E40000000C09C3C494000000080805B3E40000000E07D3C494000000080665B3E40000000E0573C494000000040485B3E40000000A0493C4940000000C03C5B3E40000000403B3C4940000000C0325B3E40
1147	83	729	730	13	479.757669213059671	00:00:34.542552	0102000020E61000000B000000000000803B3C4940000000802C5B3E40000000403B3C4940000000C0325B3E40000000E0183C4940000000801E5B3E40000000E0023C4940000000E0135B3E4000000020F73B4940000000A00E5B3E4000000020F73B4940000000A00E5B3E4000000040DE3B494000000020055B3E4000000000CF3B494000000040015B3E40000000E0BC3B4940000000C0FD5A3E4000000020AD3B494000000060FC5A3E40000000209F3B4940000000A0FB5A3E40
1148	84	\N	731	0	0	00:00:00	\N
1149	84	731	732	1	534.151243148920003	00:00:38.45889	0102000020E61000000B000000000000A0A63B4940000000C0135B3E40000000A0A53B494000000000095B3E40000000A0B43B4940000000C0095B3E40000000C0BF3B4940000000C0095B3E40000000E0DA3B4940000000C0105B3E40000000C0EE3B494000000060165B3E40000000C0EE3B494000000060165B3E4000000060023C4940000000C01E5B3E40000000201C3C4940000000802B5B3E40000000A02C3C494000000000365B3E40000000804F3C4940000000404F5B3E40
1150	84	732	733	2	278.997303826436394	00:00:20.087806	0102000020E610000005000000000000204F3C4940000000E0595B3E40000000804F3C4940000000404F5B3E4000000040683C494000000000635B3E40000000008E3C4940000000A0815B3E4000000020A03C4940000000C0905B3E40
1151	84	733	504	3	2702.25823953318877	00:03:14.562593	0102000020E610000022000000040000C09F3C494006000040955B3E4000000020A03C4940000000C0905B3E4000000080AD3C4940000000409A5B3E4000000060BB3C494000000000A45B3E4000000060DE3C494000000080C05B3E4000000040033D494000000080DF5B3E40000000C00A3D494000000080E65B3E40000000E0173D494000000040F15B3E4000000060203D494000000020F85B3E40000000602E3D494000000020065C3E4000000080363D4940000000A00E5C3E40000000404C3D4940000000A0285C3E40000000A0573D4940000000A0365C3E40000000806C3D4940000000004B5C3E4000000080953D4940000000A06D5C3E40000000C0C43D494000000080965C3E4000000080F43D4940000000E0BE5C3E40000000C0203E494000000080E55C3E4000000080473E494000000040075D3E4000000080723E4940000000402C5D3E4000000040983E4940000000A04D5D3E4000000080BF3E4940000000006E5D3E40000000E0E13E4940000000A0885D3E4000000020F73E494000000040945D3E40000000A0163F4940000000E09F5D3E40000000A01F3F494000000000A35D3E40000000A0413F4940000000E0A55D3E4000000000513F494000000080A45D3E40000000006B3F4940000000C09C5D3E4000000040813F494000000080915D3E40000000A0893F4940000000008E5D3E40000000A09E3F494000000060895D3E40000000E0C33F494000000040815D3E40000000C0ED3F4940000000C0775D3E40
1152	84	504	734	4	1660.33387834115274	00:01:59.544039	0102000020E610000013000000020000E0ED3F4940FBFFFFDF7B5D3E40000000C0ED3F4940000000C0775D3E40000000E00640494000000080725D3E400000002033404940000000A0615D3E40000000205F40494000000080515D3E40000000007E404940000000E0445D3E400000000098404940000000603B5D3E4000000040BA404940000000602E5D3E4000000080E4404940000000201D5D3E400000000016414940000000C0095D3E40000000403C41494000000040FA5C3E40000000206C41494000000000E75C3E40000000809B414940000000A0D35C3E4000000080D741494000000060BC5C3E4000000000FA41494000000060AE5C3E40000000600142494000000060AB5C3E40000000800442494000000040A95C3E400000000011424940000000A0A35C3E40000000801442494000000040A25C3E40
1153	84	734	735	5	1284.54493104550693	00:01:32.487235	0102000020E6100000110000000500008014424940F5FFFF3FA65C3E40000000801442494000000040A25C3E40000000C023424940000000209F5C3E400000006038424940000000009E5C3E40000000A055424940000000209F5C3E400000000082424940000000C09F5C3E4000000080A142494000000080A05C3E40000000E0D142494000000080A15C3E40000000C0ED424940000000E0A15C3E4000000000F842494000000040A35C3E40000000A00143494000000060AA5C3E40000000400C43494000000020BA5C3E40000000201643494000000020D45C3E40000000C020434940000000E0F45C3E40000000C03543494000000000445D3E40000000005043494000000040A45D3E40000000A05D43494000000000D75D3E40
1154	84	735	736	6	3082.34762031494165	00:03:41.929029	0102000020E610000022000000FCFFFFFF5C43494004000000DB5D3E40000000A05D43494000000000D75D3E40000000405F43494000000000E25D3E40000000606243494000000020F15D3E40000000606E434940000000A01F5E3E40000000E080434940000000E0635E3E40000000A0A8434940000000A0F85D3E4000000040B543494000000080D65D3E40000000A0D0434940000000208F5D3E40000000E0E8434940000000204E5D3E40000000C00644494000000080FB5C3E40000000E01B44494000000040C25C3E40000000202F444940000000208C5C3E40000000E04E44494000000000375C3E40000000205D444940000000E00E5C3E400000006074444940000000C0D05B3E40000000008144494000000040AE5B3E40000000408444494000000040AF5B3E40000000C08844494000000040A85B3E40000000A09644494000000040825B3E40000000E0AF444940000000C03D5B3E4000000020B844494000000000285B3E40000000A0BA44494000000020255B3E4000000080C0444940000000601C5B3E4000000020C944494000000040085B3E4000000040EE44494000000080A45A3E40000000200A454940000000C05B5A3E40000000401D45494000000040275A3E40000000C021454940000000401A5A3E400000006034454940000000405F5A3E400000000040454940000000C08A5A3E40000000404C454940000000C0B75A3E40000000405F45494000000060FD5A3E40000000A075454940000000A04F5B3E40
1155	84	736	737	7	943.575720978148297	00:01:07.937452	0102000020E61000000B000000000000A07345494000000000545B3E40000000A075454940000000A04F5B3E40000000A07D454940000000206C5B3E40000000C095454940000000C0C55B3E40000000E0AF454940000000A0285C3E40000000C0B5454940000000203F5C3E40000000E0BB454940000000004A5C3E4000000040D4454940000000C0445C3E40000000200146494000000040365C3E40000000E02446494000000040285C3E40000000005646494000000040145C3E40
1156	84	737	738	8	890.36427728995136	00:01:04.106228	0102000020E61000000A000000000000E055464940000000201A5C3E40000000005646494000000040145C3E40000000E02446494000000040285C3E40000000200146494000000040365C3E4000000040D4454940000000C0445C3E40000000E0BB454940000000004A5C3E40000000C0B5454940000000203F5C3E40000000E0AF454940000000A0285C3E40000000C095454940000000C0C55B3E40000000A07D454940000000206C5B3E40
1157	84	738	739	9	454.929977241747451	00:00:32.754958	0102000020E610000007000000000000C07E45494000000040685B3E40000000A07D454940000000206C5B3E40000000A075454940000000A04F5B3E40000000405F45494000000060FD5A3E40000000404C454940000000C0B75A3E400000000040454940000000C08A5A3E400000006045454940000000807F5A3E40
1158	84	739	740	10	471.381749898593625	00:00:33.939486	0102000020E6100000040000000000004046454940000000C0825A3E400000006045454940000000807F5A3E40000000407445494000000040005A3E40000000209B454940000000A098593E40
1159	84	740	741	11	1887.26111302075515	00:02:15.8828	0102000020E610000010000000FCFFFF3F9C454940040000C09B593E40000000209B454940000000A098593E4000000020A8454940000000E077593E4000000060D24549400000006008593E4000000020EA454940000000C0C8583E40000000200F4649400000004064583E40000000E02D464940000000800F583E40000000404246494000000020DA573E40000000605146494000000020B3573E400000004077464940000000A04F573E40000000C08C4649400000000017573E4000000000AA46494000000020C7563E40000000A0C6464940000000E081563E4000000040CF4649400000000069563E40000000E0DC464940000000E040563E4000000060C846494000000000F0553E40
\.


--
-- Data for Name: route_types; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY route_types (id, transport_id, visible) FROM stdin;
c_route_metro	c_metro	1
c_route_trolley	c_trolley	1
c_route_bus	c_bus	1
c_route_tram	c_tram	1
c_route_station_input	c_foot	0
c_route_transition	c_foot	0
c_route_metro_transition	c_foot	0
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY routes (id, city_id, cost, route_type_id, number, name_key) FROM stdin;
1	1	0	c_route_station_input		4
2	2	0	c_route_station_input		6
3	1	2	c_route_trolley	324e	35
4	1	2	c_route_metro		36
5	1	2	c_route_metro		37
6	1	3.5	c_route_bus	34e	38
24	2	1.5	c_route_bus	5	240
26	2	1.5	c_route_bus	2	312
27	2	1.5	c_route_bus	6	374
28	2	1.5	c_route_bus	7	385
29	2	1.5	c_route_bus	1	416
30	2	1.5	c_route_bus	9	473
31	2	1.5	c_route_bus	11	487
32	2	1.5	c_route_bus	12	517
33	2	1.5	c_route_bus	14	545
34	2	1.5	c_route_bus	11	546
35	2	1.5	c_route_bus	12	547
36	2	1.5	c_route_bus	14	548
37	2	1.5	c_route_bus	16	559
38	2	1.5	c_route_bus	21	598
39	2	1.5	c_route_bus	20	630
40	2	1.5	c_route_bus	23	669
41	2	1.5	c_route_bus	24	692
42	2	1.5	c_route_bus	27	703
43	2	1.5	c_route_bus	55	739
44	2	3	c_route_bus	56	769
45	2	1.5	c_route_bus	30	794
\.


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY schedule (id, direct_route_id) FROM stdin;
1	3
2	4
3	5
4	6
5	7
6	8
7	9
8	10
43	41
44	42
47	45
48	46
49	47
50	48
51	49
52	50
53	51
54	52
55	53
56	54
57	55
58	56
59	57
60	58
61	59
62	60
63	61
64	62
65	63
66	64
67	65
68	66
69	67
70	68
71	69
72	70
73	71
74	72
75	73
76	74
77	75
78	76
79	77
80	78
83	81
84	82
85	83
86	84
87	79
88	80
\.


--
-- Data for Name: schedule_group_days; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY schedule_group_days (id, schedule_group_id, day_id) FROM stdin;
1	1	c_all
2	2	c_all
3	3	c_all
4	4	c_all
5	5	c_all
6	6	c_all
7	7	c_all
8	8	c_all
43	43	c_all
44	44	c_all
47	47	c_all
48	48	c_all
49	49	c_all
50	50	c_all
51	51	c_all
52	52	c_all
53	53	c_all
54	54	c_all
55	55	c_all
56	56	c_all
57	57	c_all
58	58	c_all
59	59	c_all
60	60	c_all
61	61	c_all
62	62	c_all
63	63	c_all
64	64	c_all
65	65	c_all
66	66	c_all
67	67	c_all
68	68	c_all
69	69	c_all
70	70	c_all
71	71	c_all
72	72	c_all
73	73	c_all
74	74	c_all
75	75	c_all
76	76	c_all
77	77	c_all
78	78	c_all
79	79	c_all
80	80	c_all
83	83	c_all
84	84	c_all
85	85	c_all
86	86	c_all
87	87	c_all
88	88	c_all
\.


--
-- Data for Name: schedule_groups; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY schedule_groups (id, schedule_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
43	43
44	44
47	47
48	48
49	49
50	50
51	51
52	52
53	53
54	54
55	55
56	56
57	57
58	58
59	59
60	60
61	61
62	62
63	63
64	64
65	65
66	66
67	67
68	68
69	69
70	70
71	71
72	72
73	73
74	74
75	75
76	76
77	77
78	78
79	79
80	80
83	83
84	84
85	85
86	86
87	87
88	88
\.


--
-- Data for Name: station_transports; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY station_transports (station_id, transport_type_id) FROM stdin;
1	c_metro
2	c_metro
3	c_metro
4	c_metro
5	c_metro
6	c_metro
7	c_metro
8	c_metro
9	c_metro
10	c_metro
11	c_metro
12	c_metro
13	c_metro
14	c_metro
15	c_metro
16	c_metro
17	c_metro
18	c_metro
19	c_metro
20	c_metro
21	c_metro
22	c_metro
23	c_metro
24	c_metro
25	c_metro
26	c_metro
27	c_metro
28	c_metro
\.


--
-- Data for Name: stations; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY stations (id, city_id, name_key, location) FROM stdin;
1	1	7	0101000020E61000007EB33F293F034940000000DC042B4240
2	1	8	0101000020E61000000CA2E1FB430249400500002C3D2A4240
3	1	9	0101000020E61000000FD0045427014940010000CCAD284240
4	1	10	0101000020E61000001B20A8964B00494002000072EB264240
5	1	11	0101000020E61000002816A34023004940050000F08F224240
6	1	12	0101000020E610000043976CBC7C004940020000E0B11F4240
7	1	13	0101000020E6100000E2C2EBD99700494003000040EA1D4240
8	1	14	0101000020E610000010D40F0819FF4840FAFFFF2B981D4240
9	1	15	0101000020E61000008765A2D18B04494006000070251C4240
10	1	16	0101000020E6100000F11BF98E6C034940FBFFFFDF871C4240
11	1	17	0101000020E61000007F0551FAA6014940FAFFFFBFF21C4240
12	1	18	0101000020E6100000B370F7149F004940FEFFFF4F9E1D4240
13	1	19	0101000020E610000033F23344E1FF4840FCFFFF6FC81E4240
14	1	20	0101000020E6100000E45F93B48EFE4840FEFFFF97E8214240
15	1	21	0101000020E610000054E913D64EFD4840FEFFFFFBA2214240
16	1	22	0101000020E6100000EE1ACCEEBCFD4840FAFFFF7740174240
17	1	23	0101000020E6100000B939B2B4AFFE4840FAFFFFCB431A4240
18	1	24	0101000020E6100000D65C270F14FF484001000090141C4240
19	1	25	0101000020E61000006B1168B4F1FE4840FEFFFF1FCE1D4240
20	1	26	0101000020E6100000943444717FFD4840FEFFFF97181F4240
21	1	27	0101000020E6100000912644E35EFD4840FBFFFF9761214240
22	1	28	0101000020E61000006464C05BEBFC4840FFFFFFD3F5234240
23	1	29	0101000020E61000002EF3E35B70FC4840F9FFFF6B97264240
24	1	30	0101000020E6100000089446E4ADFB48400600004C1E294240
25	1	31	0101000020E6100000597D9B0F1EFB484002000074E42B4240
26	1	32	0101000020E61000007924E5EAAFFA484000000070162E4240
27	1	33	0101000020E6100000B9B61CE2EFF94840FEFFFF4379304240
28	1	34	0101000020E61000008B13F6862BF94840FDFFFF6B12334240
279	2	313	0101000020E6100000000000A067414940FFFFFF3F8F943E40
280	2	314	0101000020E6100000FBFFFF7F43424940060000E0BC953E40
281	2	315	0101000020E6100000070000A0B5424940FAFFFF1FFB953E40
282	2	316	0101000020E6100000FBFFFFDF4343494004000060B3953E40
284	2	318	0101000020E610000005000080EC434940F8FFFFDFD8973E40
285	2	319	0101000020E6100000FCFFFF9FF84349400E0000005C993E40
286	2	320	0101000020E6100000FBFFFF7F9F434940FDFFFFBFE5993E40
287	2	321	0101000020E6100000070000A015434940010000C098993E40
288	2	322	0101000020E6100000030000A0D2424940010000C010993E40
289	2	323	0101000020E6100000FDFFFF5F894249400C000020B2983E40
290	2	324	0101000020E6100000010000C02C424940F9FFFFFF699A3E40
291	2	325	0101000020E6100000FBFFFF7FFB414940F4FFFFDFB59A3E40
292	2	326	0101000020E6100000F9FFFFFFA9414940070000A0D5993E40
293	2	327	0101000020E6100000FDFFFFBF19414940FEFFFF7F1E993E40
294	2	328	0101000020E6100000FFFFFFDF7E404940F6FFFFBF1F9A3E40
295	2	329	0101000020E6100000FFFFFFDFCA3F4940FDFFFFBF4D9B3E40
296	2	330	0101000020E6100000020000E03D3F4940FBFFFFDFA39B3E40
297	2	331	0101000020E6100000FCFFFFFF983E4940FFFFFFDF369C3E40
298	2	332	0101000020E6100000FAFFFF1F3B3E4940F9FFFF9FB19C3E40
299	2	333	0101000020E610000000000060283D4940000000A0279E3E40
300	2	334	0101000020E6100000F9FFFFFFC93C49400A000040A89E3E40
301	2	335	0101000020E6100000F9FFFFFF313C4940FBFFFFDF739F3E40
302	2	336	0101000020E6100000FFFFFFDF9E3B49400600004055A03E40
303	2	337	0101000020E6100000FBFFFFDF3B3B4940FCFFFFFFC4A03E40
304	2	338	0101000020E6100000FFFFFFDFBE3A49400A0000A070A13E40
305	2	339	0101000020E6100000020000E0393A4940000000A0F7A13E40
306	2	340	0101000020E6100000FFFFFFDFB6394940F8FFFFDF48A13E40
307	2	341	0101000020E610000000000060383949400B000060B1A03E40
308	2	342	0101000020E6100000FBFFFFDFCB384940030000A0AAA03E40
309	2	343	0101000020E6100000050000204C3949400D0000E0E2A03E40
310	2	344	0101000020E6100000060000E0B83949400800002067A13E40
311	2	345	0101000020E610000000000000C03A4940FEFFFF1F8EA13E40
312	2	346	0101000020E6100000040000C0373B494005000080F4A03E40
313	2	347	0101000020E6100000FBFFFFDF8B3B4940F2FFFF5F84A03E40
314	2	348	0101000020E6100000FEFFFF1F363C494002000080999F3E40
315	2	349	0101000020E6100000FCFFFF3FC03C4940070000A0CD9E3E40
316	2	350	0101000020E6100000F9FFFF5F4A3D49400C000020129E3E40
317	2	351	0101000020E6100000FDFFFFBF5D3E4940040000C09B9C3E40
318	2	352	0101000020E610000002000080AD3E4940F9FFFF9F399C3E40
319	2	353	0101000020E6100000FAFFFF1F773F4940F7FFFF7FA89B3E40
320	2	354	0101000020E6100000FCFFFF3FEC3F494000000060209B3E40
321	2	355	0101000020E6100000FCFFFF9F54404940FAFFFF1F739A3E40
322	2	356	0101000020E6100000FCFFFF9FC440494001000020B9993E40
323	2	357	0101000020E61000000000000008414940FFFFFF3F47993E40
324	2	358	0101000020E6100000FBFFFF7F5B4149400E000000BC983E40
325	2	359	0101000020E6100000FFFFFF3F6F4149400D000040DB983E40
326	2	360	0101000020E6100000020000E09941494005000080AC993E40
327	2	361	0101000020E6100000070000A0F9414940F7FFFF7FC09A3E40
328	2	362	0101000020E6100000FBFFFF7F2F424940FFFFFF3F6F9A3E40
329	2	363	0101000020E6100000010000209D42494000000000B0983E40
330	2	364	0101000020E6100000FAFFFF1FD7424940FEFFFF7F26993E40
331	2	365	0101000020E610000005000080304349400D000040DB993E40
332	2	366	0101000020E610000003000040B6434940010000C0D0993E40
333	2	367	0101000020E6100000020000E0F9434940F4FFFF7F65993E40
184	2	215	0101000020E6100000000000006C34494005000080F4843E40
185	2	216	0101000020E6100000040000606B354940F8FFFFDFC0833E40
186	2	217	0101000020E6100000FDFFFFBF8D354940F2FFFF5F24843E40
187	2	218	0101000020E6100000FAFFFFBF3236494005000080DC843E40
188	2	219	0101000020E6100000010000C074364940030000408A843E40
189	2	220	0101000020E6100000FFFFFFDFD6364940F6FFFF5F1F843E40
190	2	221	0101000020E6100000FEFFFF1F3E374940FCFFFFFF1C843E40
191	2	222	0101000020E610000004000000AB3749400D0000401B843E40
192	2	223	0101000020E6100000FDFFFFBFCD37494005000020F4833E40
334	2	368	0101000020E610000002000080F5434940F7FFFF7FF8973E40
193	2	224	0101000020E6100000040000C0D7374940FDFFFF5FFD813E40
194	2	225	0101000020E6100000FDFFFF5F35384940000000A09F803E40
195	2	226	0101000020E61000000400006083384940F2FFFF5FD47F3E40
196	2	227	0101000020E6100000000000C06F384940000000E0797D3E40
197	2	228	0101000020E6100000FFFFFF3F6F384940000000A0777D3E40
198	2	229	0101000020E6100000070000009E384940F9FFFF5FD27E3E40
199	2	230	0101000020E61000000500008044384940F4FFFFDF957F3E40
200	2	231	0101000020E6100000FAFFFF1FFF3749400D0000E04A803E40
201	2	232	0101000020E6100000FCFFFF3FB4374940080000C00E813E40
202	2	233	0101000020E610000004000060773749400000006070833E40
335	2	369	0101000020E6100000020000E0A1434940FDFFFF5F0D963E40
203	2	234	0101000020E6100000FDFFFF5FFD364940FAFFFFBF6A833E40
204	2	235	0101000020E6100000FAFFFFBFB23649400800002087833E40
336	2	370	0101000020E610000002000080394349400A000040B0953E40
205	2	236	0101000020E6100000050000204C364940F5FFFFFF06843E40
206	2	237	0101000020E6100000FCFFFF3F94354940FAFFFFBF32843E40
207	2	238	0101000020E61000000000008061354940000000E0BC833E40
208	2	239	0101000020E6100000000000407334494000000060AB843E40
337	2	371	0101000020E6100000010000C0AC424940F7FFFF1FE8953E40
338	2	372	0101000020E6100000FBFFFFDF3B4249400B000000B1953E40
339	2	373	0101000020E610000003000040B2404940F5FFFFFFB6943E40
283	2	317	0101000020E6100000010000C0A04349400B00000019963E40
380	2	417	0101000020E610000004000000B7344940FEFFFF7FAE683E40
381	2	418	0101000020E6100000FFFFFFDF8A344940F8FFFFDF80673E40
382	2	419	0101000020E6100000040000006F344940F2FFFF5F5C663E40
383	2	420	0101000020E6100000FCFFFF3FC0344940060000408D653E40
384	2	421	0101000020E6100000FEFFFF7F16354940F5FFFFFF26653E40
385	2	422	0101000020E61000000700000076354940F7FFFF7F88633E40
386	2	423	0101000020E6100000070000A0CD35494008000020BF613E40
387	2	424	0101000020E6100000040000C01B36494004000060C3603E40
388	2	425	0101000020E6100000060000E09C3649400700006016603E40
389	2	426	0101000020E610000006000040C9364940F7FFFF1F78613E40
390	2	427	0101000020E6100000FAFFFFBF023749400A00004030633E40
391	2	428	0101000020E6100000010000C02C374940F3FFFF1F7D643E40
392	2	429	0101000020E6100000060000E090374940F8FFFFDF88673E40
393	2	430	0101000020E6100000050000804838494003000040AA683E40
394	2	431	0101000020E610000003000040D238494007000000FE683E40
395	2	432	0101000020E6100000FCFFFFFFF438494000000000006A3E40
396	2	433	0101000020E6100000040000003B394940030000409A6B3E40
397	2	434	0101000020E6100000FFFFFFDFA639494003000040126B3E40
398	2	435	0101000020E6100000020000802D3A49400B000060E16A3E40
399	2	436	0101000020E6100000060000E09C3A49400D0000E08A6B3E40
400	2	437	0101000020E6100000FDFFFF5FF53A4940FFFFFFDFEE6D3E40
401	2	438	0101000020E610000004000060233B4940F6FFFFBFCF6F3E40
402	2	439	0101000020E610000004000000373B4940020000E039713E40
403	2	440	0101000020E6100000040000C03F3B4940080000C086733E40
404	2	441	0101000020E6100000030000A0423B4940F8FFFF3F91743E40
405	2	442	0101000020E610000003000040423B494009000080D7753E40
406	2	443	0101000020E6100000030000A0323B4940FEFFFF1F1E773E40
407	2	444	0101000020E6100000FDFFFF5F293B49400E0000A053793E40
408	2	445	0101000020E610000002000080613B4940FFFFFF3F97793E40
409	2	446	0101000020E6100000FFFFFF3F1F3B494009000080FF7A3E40
410	2	447	0101000020E6100000070000001E3B49400B000000017B3E40
411	2	448	0101000020E610000002000080253B49400800002037793E40
412	2	449	0101000020E6100000FFFFFF3F333B49400700000056773E40
413	2	450	0101000020E6100000FEFFFF7F463B49400B000000A1753E40
414	2	451	0101000020E6100000060000E0443B4940F9FFFFFF51743E40
415	2	452	0101000020E6100000FAFFFFBF423B49400700006086733E40
416	2	453	0101000020E6100000030000403A3B49400900008037713E40
417	2	454	0101000020E6100000FCFFFFFF243B4940F3FFFFBFB46F3E40
418	2	455	0101000020E610000004000000F33A494007000060C66D3E40
419	2	456	0101000020E6100000FCFFFF9FA03A4940F8FFFF3F816B3E40
420	2	457	0101000020E6100000FFFFFFDF223A4940F8FFFF3FD96A3E40
340	2	375	0101000020E6100000F9FFFF5FFE384940F6FFFFBFCF7E3E40
341	2	376	0101000020E6100000FCFFFF3F58394940F5FFFFFFD67D3E40
342	2	377	0101000020E610000005000080C83949400E0000A0BB7F3E40
343	2	378	0101000020E610000004000000EF394940FCFFFF3F74803E40
344	2	379	0101000020E6100000000000C0293A4940000000005F813E40
345	2	380	0101000020E6100000FCFFFF3F183A49400300004022813E40
346	2	381	0101000020E6100000FCFFFF9FFC394940080000209F803E40
347	2	382	0101000020E6100000FEFFFF1FD2394940F6FFFF5FD77F3E40
348	2	383	0101000020E6100000040000602F39494000000060E07D3E40
349	2	384	0101000020E610000002000080E9384940F8FFFFDF307E3E40
350	2	386	0101000020E6100000000000607430494000000040BC783E40
351	2	387	0101000020E6100000000000E0D430494000000000867A3E40
352	2	388	0101000020E6100000FBFFFFDF07314940F8FFFFDF807B3E40
353	2	389	0101000020E61000000000000032314940000000605B7C3E40
354	2	390	0101000020E6100000000000600431494000000020B87D3E40
355	2	391	0101000020E6100000000000600C314940000000C0E07E3E40
356	2	392	0101000020E6100000000000C014314940000000C02D803E40
357	2	393	0101000020E61000000000008032314940000000C04E813E40
358	2	394	0101000020E6100000000000807F3149400000006062823E40
359	2	395	0101000020E6100000000000809A314940000000C099843E40
360	2	396	0101000020E6100000000000C0F231494000000040DF863E40
361	2	397	0101000020E6100000000000A048324940000000E0CF853E40
362	2	398	0101000020E6100000000000A0813249400000004017853E40
363	2	399	0101000020E610000000000020C53249400000006072843E40
364	2	400	0101000020E610000000000000D3324940000000807E823E40
365	2	401	0101000020E6100000000000E0DD324940000000E025823E40
366	2	402	0101000020E610000000000020C33249400000006066843E40
367	2	403	0101000020E6100000000000407B324940000000001E853E40
368	2	404	0101000020E6100000000000803E324940000000A0DF853E40
369	2	405	0101000020E610000000000080F031494000000020D6863E40
370	2	406	0101000020E6100000000000A09D3149400000002094843E40
371	2	407	0101000020E61000000000000083314940000000E05F823E40
372	2	408	0101000020E610000000000060263149400000004026813E40
373	2	409	0101000020E6100000000000E017314940000000602D803E40
374	2	410	0101000020E6100000000000600E314940000000609E7E3E40
375	2	411	0101000020E6100000000000E00731494000000000647D3E40
244	2	277	0101000020E6100000FAFFFF1FCB344940FDFFFFBFCD683E40
245	2	278	0101000020E6100000FCFFFF3FD034494001000020F16A3E40
246	2	279	0101000020E61000000000006004354940FFFFFF3F6F6C3E40
247	2	280	0101000020E6100000070000A0D5344940FBFFFF7FDB6D3E40
248	2	281	0101000020E6100000FCFFFFFF98354940FAFFFFBFFA6E3E40
249	2	282	0101000020E6100000020000E0013649400B000060196F3E40
250	2	283	0101000020E6100000FBFFFF7F4B364940FEFFFF1F666D3E40
251	2	284	0101000020E610000003000040E636494006000040F56D3E40
252	2	285	0101000020E61000000400006017374940000000A0AF6C3E40
253	2	286	0101000020E6100000FCFFFF9F7837494009000080AF693E40
254	2	287	0101000020E6100000FBFFFF7F03384940F7FFFF7F08693E40
255	2	288	0101000020E6100000060000E0143849400100002029693E40
256	2	289	0101000020E6100000FFFFFFDF7E384940FCFFFF3FAC6A3E40
257	2	290	0101000020E6100000FDFFFFBF31394940FDFFFF5FD56B3E40
258	2	291	0101000020E6100000060000E030394940F5FFFF3F2E6D3E40
259	2	292	0101000020E6100000030000A0323949400D000040CB6E3E40
260	2	293	0101000020E6100000FBFFFF7FBF39494005000020346F3E40
261	2	294	0101000020E6100000FCFFFF3F583A4940F5FFFFFFE66F3E40
262	2	295	0101000020E6100000000000802F3A494000000020F1713E40
263	2	296	0101000020E61000000500008090394940090000E0976F3E40
264	2	297	0101000020E610000001000020293949400B0000C0B96E3E40
265	2	298	0101000020E6100000070000A03D394940010000C0F86C3E40
266	2	299	0101000020E61000000100002039394940090000E0BF6B3E40
267	2	300	0101000020E6100000FFFFFFDFFA38494007000060E6693E40
268	2	301	0101000020E6100000040000C0E33849400D0000402B693E40
269	2	302	0101000020E6100000FFFFFF3F3F384940FFFFFFDF96683E40
270	2	303	0101000020E6100000FEFFFF7FD6374940FAFFFF1FA3693E40
271	2	304	0101000020E6100000FCFFFF3F00384940F9FFFF5F426B3E40
272	2	305	0101000020E6100000FEFFFF1F42374940F5FFFFFF366C3E40
273	2	306	0101000020E6100000030000400E374940F2FFFFFFC36C3E40
274	2	307	0101000020E6100000030000A0CE364940FCFFFF9F046E3E40
275	2	308	0101000020E6100000FAFFFF1FFB354940F9FFFFFF316F3E40
276	2	309	0101000020E6100000FDFFFF5F953549400D0000E0E26E3E40
277	2	310	0101000020E6100000FEFFFF7FD234494000000060E86A3E40
278	2	311	0101000020E6100000000000C0D234494000000040D4683E40
376	2	412	0101000020E6100000000000A02B314940F2FFFFFF237C3E40
377	2	413	0101000020E6100000FAFFFF1F07314940F8FFFF3F697B3E40
378	2	414	0101000020E6100000000000E0C130494000000040EE793E40
379	2	415	0101000020E6100000000000E06C3049400000006081783E40
421	2	458	0101000020E6100000FAFFFFBF963949400E0000001C6B3E40
422	2	459	0101000020E6100000FEFFFF1F3A394940020000E0916B3E40
423	2	460	0101000020E6100000000000A0E3374940F5FFFF9FFE683E40
424	2	461	0101000020E6100000FCFFFF3F743749400700006056663E40
425	2	462	0101000020E6100000040000C047374940F8FFFFDFF8643E40
426	2	463	0101000020E6100000060000E01C374940FBFFFF7FA3633E40
427	2	464	0101000020E6100000FCFFFF3F803649400D00004063623E40
428	2	465	0101000020E6100000FBFFFFDFC33549400B000000D1613E40
429	2	466	0101000020E6100000060000E074354940060000401D633E40
430	2	467	0101000020E6100000FFFFFFDF063549400300004012653E40
431	2	468	0101000020E6100000FBFFFFDF8F344940FEFFFF1FBE653E40
432	2	469	0101000020E6100000020000E049344940020000E0B9663E40
433	2	470	0101000020E6100000050000207034494007000060B6663E40
434	2	471	0101000020E61000000100002089344940040000C0AB673E40
435	2	472	0101000020E6100000FFFFFFDFBA3449400C000080C2683E40
436	2	474	0101000020E6100000040000C09B3B494003000040FAA43E40
437	2	475	0101000020E6100000040000C0373C4940FEFFFF1F36A83E40
438	2	476	0101000020E6100000FAFFFF1F5B3C49400C00002052AA3E40
439	2	477	0101000020E6100000030000408A3C4940080000C0A6AB3E40
440	2	478	0101000020E6100000000000600C3D4940000000A057AB3E40
441	2	479	0101000020E6100000FFFFFF3F973D49400500002054AB3E40
442	2	480	0101000020E6100000FAFFFFBF2A3E49400A00004050AB3E40
443	2	481	0101000020E6100000FFFFFFDF2A3E4940040000C04BAB3E40
444	2	482	0101000020E6100000FAFFFF1F973D4940030000A04AAB3E40
445	2	483	0101000020E6100000FDFFFFBF053D4940070000A055AB3E40
446	2	484	0101000020E610000005000020743C494002000080E1AB3E40
447	2	485	0101000020E6100000FCFFFFFF003C4940F9FFFF5FA2A83E40
448	2	486	0101000020E6100000FCFFFFFF9C3B4940F6FFFFBFF7A43E40
449	2	488	0101000020E6100000FDFFFF5F3D374940F4FFFF7F15783E40
450	2	489	0101000020E61000000000006018374940FFFFFFDFEE783E40
451	2	490	0101000020E610000004000000AB364940FEFFFF7FCE793E40
452	2	491	0101000020E6100000040000C017364940F5FFFF3FBE793E40
453	2	492	0101000020E6100000F9FFFFFF8135494007000060AE7B3E40
454	2	493	0101000020E6100000050000208C354940FDFFFF5F957C3E40
455	2	494	0101000020E6100000F9FFFF5F96354940FBFFFF7FE37D3E40
456	2	495	0101000020E6100000010000C0E8354940070000601E803E40
457	2	496	0101000020E6100000F9FFFF5F82354940080000207F7D3E40
458	2	497	0101000020E6100000FEFFFF7F3E3549400D0000409B7D3E40
459	2	498	0101000020E610000005000020F4344940F7FFFF1F807D3E40
460	2	499	0101000020E6100000FDFFFFBFCD344940F5FFFF9F5E7F3E40
461	2	500	0101000020E6100000FFFFFF3F8F34494007000000E6813E40
462	2	501	0101000020E6100000FBFFFFDFCB344940F9FFFF9F99833E40
463	2	502	0101000020E6100000020000E0C9344940080000C06E833E40
464	2	503	0101000020E6100000FBFFFF7F8F344940090000E0CF813E40
465	2	504	0101000020E6100000FAFFFF1FBF34494004000000DB803E40
466	2	505	0101000020E6100000000000A0D3344940F8FFFF3F297F3E40
467	2	506	0101000020E6100000FFFFFFDFF6344940FEFFFF7F867D3E40
468	2	507	0101000020E6100000010000C03C354940FDFFFFBFA57D3E40
469	2	508	0101000020E6100000FFFFFF3F6F354940090000E07F7D3E40
470	2	509	0101000020E6100000F9FFFF5F96354940FBFFFF7FE37D3E40
471	2	510	0101000020E6100000010000C0E8354940070000601E803E40
472	2	511	0101000020E6100000FFFFFF3F8B35494001000020697D3E40
473	2	512	0101000020E6100000FAFFFFBF92354940F9FFFFFF817C3E40
474	2	513	0101000020E610000005000080843549400E0000A0B37B3E40
475	2	514	0101000020E610000004000000B3354940FCFFFF9FEC7A3E40
476	2	515	0101000020E6100000030000401A36494007000000C6793E40
477	2	516	0101000020E6100000FEFFFF1F3E3749400B00006011783E40
478	2	518	0101000020E6100000030000A0F63F494000000060605D3E40
479	2	519	0101000020E6100000020000808D3F4940F8FFFF3FD95E3E40
480	2	520	0101000020E6100000000000401E3F4940000000001D613E40
481	2	521	0101000020E610000000000060903E4940090000E0F7633E40
482	2	522	0101000020E610000000000060643E49400A0000A0D8643E40
483	2	523	0101000020E6100000060000E02C3E4940F5FFFFFFAE653E40
484	2	524	0101000020E6100000FCFFFF3FAC3D4940FEFFFF7F8E673E40
485	2	525	0101000020E6100000000000A07F3D494000000080DB673E40
486	2	526	0101000020E610000001000020FD3C4940FBFFFFDFDB673E40
487	2	527	0101000020E6100000F9FFFFFF593C4940FCFFFF9FDC673E40
488	2	528	0101000020E6100000F9FFFFFFD93B4940070000A0DD673E40
489	2	529	0101000020E6100000FBFFFF7F633B494008000020DF673E40
490	2	530	0101000020E6100000000000E0C53A4940000000C0CC673E40
491	2	531	0101000020E6100000FBFFFF7FD73A4940F8FFFFDFE8673E40
492	2	532	0101000020E6100000040000C0773B49400A000040E8673E40
493	2	533	0101000020E6100000FCFFFF9FE83B49400A000040E8673E40
494	2	534	0101000020E6100000FDFFFF5F313C494008000020E7673E40
495	2	535	0101000020E6100000010000C0783C494009000080E7673E40
496	2	536	0101000020E6100000FCFFFF9FD03C494008000020E7673E40
497	2	537	0101000020E6100000000000A0843D494000000060E4673E40
498	2	538	0101000020E6100000FBFFFF7FCF3D4940060000E02C673E40
499	2	539	0101000020E610000003000040323E4940F3FFFF1FBD653E40
500	2	540	0101000020E6100000020000806D3E494005000080BC643E40
501	2	541	0101000020E6100000FBFFFF7F933E494005000020FC633E40
502	2	542	0101000020E6100000FDFFFFBF313F494002000080D1603E40
503	2	543	0101000020E6100000FAFFFFBF9A3F4940FEFFFF1FB65E3E40
504	2	544	0101000020E6100000000000E0ED3F4940000000A0775D3E40
505	2	549	0101000020E6100000FAFFFF1FFB314940FEFFFF7FC6AA3E40
506	2	550	0101000020E6100000FDFFFF5F75324940F5FFFF9FF6AB3E40
507	2	551	0101000020E610000006000040F93249400C0000806AAD3E40
508	2	552	0101000020E610000005000020543349400D0000E06AAE3E40
509	2	553	0101000020E610000001000020A1334940030000A0DAAE3E40
510	2	554	0101000020E6100000FEFFFF7FA23349400B000060D9AE3E40
511	2	555	0101000020E6100000FEFFFF1F56334940F9FFFFFF61AE3E40
512	2	556	0101000020E6100000FBFFFF7F173349400E0000A0B3AD3E40
513	2	557	0101000020E6100000FBFFFF7F6F324940010000C0D8AB3E40
514	2	558	0101000020E610000000000060FC314940F9FFFF9FC1AA3E40
515	2	560	0101000020E610000000000000E043494003000040329C3E40
516	2	561	0101000020E610000000000060F04249400B000060F99B3E40
517	2	562	0101000020E61000000500002084424940020000E0A99B3E40
518	2	563	0101000020E61000000000006060414940070000A06D983E40
519	2	564	0101000020E6100000FCFFFF3F40414940F8FFFFDFB0973E40
520	2	565	0101000020E610000000000060104149400A00004098963E40
521	2	566	0101000020E610000007000000D640494006000040BD953E40
522	2	567	0101000020E6100000000000A05F404940FDFFFFBF85953E40
523	2	568	0101000020E6100000FEFFFF7F2E404940F7FFFF7FE8953E40
524	2	569	0101000020E6100000FFFFFF3F0B404940F6FFFFBFC7963E40
525	2	570	0101000020E6100000070000A0A93F494005000020DC963E40
526	2	571	0101000020E6100000F9FFFF5F6E3F4940F5FFFF3FF6943E40
527	2	572	0101000020E610000005000020703F4940060000E0C4923E40
528	2	573	0101000020E6100000FFFFFFDF663F494002000080218F3E40
529	2	574	0101000020E6100000FBFFFFDF233F49400D0000E0428B3E40
530	2	575	0101000020E6100000FCFFFFFF803E49400700006026863E40
531	2	576	0101000020E6100000FFFFFF3F933E4940F5FFFF9F06823E40
532	2	577	0101000020E6100000060000E05C3E49400A0000A0607F3E40
533	2	578	0101000020E6100000FDFFFFBF213E4940F8FFFF3FA97F3E40
534	2	579	0101000020E6100000FEFFFF7F863E49400D0000404B803E40
535	2	580	0101000020E6100000030000A08A3E4940060000E004823E40
536	2	581	0101000020E6100000FDFFFFBF853E4940060000400D833E40
537	2	582	0101000020E6100000030000A07A3E4940F6FFFF5F1F853E40
538	2	583	0101000020E6100000070000A0853E49400B00000061873E40
539	2	584	0101000020E6100000000000A01B3F4940F9FFFFFF518B3E40
540	2	585	0101000020E6100000000000A05F3F4940FFFFFF3F2F8F3E40
541	2	586	0101000020E6100000FBFFFF7F673F49400B0000C0C9923E40
542	2	587	0101000020E6100000030000A0663F4940FFFFFFDFEE943E40
543	2	588	0101000020E6100000F9FFFF5FBA3F4940FCFFFF9FEC963E40
544	2	589	0101000020E6100000FAFFFFBF0A404940020000E0E9963E40
545	2	590	0101000020E6100000010000C060404940FFFFFFDF8E953E40
546	2	591	0101000020E6100000000000A0E3404940F9FFFF5FF2953E40
547	2	592	0101000020E6100000FDFFFF5F154149400C000080CA963E40
548	2	593	0101000020E6100000FEFFFF1F4E414940F9FFFFFF19983E40
549	2	594	0101000020E6100000FCFFFF3F2442494000000060189B3E40
550	2	595	0101000020E61000000300004086424940FFFFFF3FB79B3E40
551	2	596	0101000020E6100000000000A01B434940FDFFFFBF0D9C3E40
552	2	597	0101000020E610000002000080E5434940000000A0379C3E40
553	2	599	0101000020E6100000030000A0CE344940F9FFFF9F21863E40
554	2	600	0101000020E61000000200008031344940FDFFFF5F25853E40
555	2	601	0101000020E610000000000040D533494000000020D4853E40
556	2	602	0101000020E6100000FDFFFF5F1D334940F7FFFF1F90873E40
557	2	603	0101000020E610000005000080A4324940F4FFFFDF05883E40
558	2	604	0101000020E6100000FBFFFFDF4B3249400D000040DB873E40
559	2	605	0101000020E610000004000000EF3149400A00004080873E40
560	2	606	0101000020E6100000040000605B314940F8FFFF3FE1873E40
561	2	607	0101000020E6100000040000607F304940F2FFFFFFE3883E40
562	2	608	0101000020E6100000FBFFFF7F3F304940F6FFFF5F9F893E40
563	2	609	0101000020E610000000000000B02F494001000020898B3E40
564	2	610	0101000020E6100000000000E0742F4940000000E00C8D3E40
565	2	611	0101000020E610000000000020312F4940000000A0888D3E40
566	2	612	0101000020E610000000000080D62E4940000000E0A18E3E40
567	2	613	0101000020E6100000000000C08B2E4940000000404F8F3E40
568	2	614	0101000020E6100000000000A0322E494000000060FD8E3E40
569	2	615	0101000020E610000000000000342E4940000000E0FF8E3E40
570	2	616	0101000020E6100000FBFFFFDF6B2E4940F9FFFF5F4A8E3E40
571	2	617	0101000020E6100000FCFFFF9F942E4940000000A0C78C3E40
572	2	618	0101000020E610000005000020582F4940010000C0D08C3E40
573	2	619	0101000020E6100000060000E0B02F494000000000A08B3E40
574	2	620	0101000020E6100000F9FFFF5F4A304940040000008B893E40
575	2	621	0101000020E610000006000040C1304940000000A087883E40
576	2	622	0101000020E6100000FFFFFFDF4E314940F7FFFF7FF8873E40
577	2	623	0101000020E6100000FFFFFFDF023249400E0000A09B873E40
578	2	624	0101000020E6100000FFFFFF3F4B324940FFFFFFDFE6873E40
579	2	625	0101000020E6100000FEFFFF1FAA324940F6FFFF5F0F883E40
580	2	626	0101000020E6100000040000003B334940010000C068873E40
581	2	627	0101000020E610000004000060F3334940FCFFFFFFAC853E40
582	2	628	0101000020E6100000070000A0313449400700006066853E40
583	2	629	0101000020E610000000000060D8344940000000808A863E40
584	2	631	0101000020E6100000FDFFFFBF693C4940FEFFFF1FA6673E40
585	2	632	0101000020E610000000000060643C49400E0000A053653E40
586	2	633	0101000020E6100000FAFFFFBF6E3B4940F9FFFFFF59653E40
587	2	634	0101000020E6100000FCFFFF3FB83A49400E0000005C653E40
588	2	635	0101000020E6100000010000209D3A494004000000B3643E40
589	2	636	0101000020E610000005000020883A4940F4FFFF7F4D623E40
590	2	637	0101000020E6100000010000207D3A49400E0000A0FB603E40
591	2	638	0101000020E6100000FFFFFFDF6E3A4940090000E0575F3E40
592	2	639	0101000020E6100000FFFFFF3F5F3A4940050000807C5D3E40
593	2	640	0101000020E6100000FDFFFF5F3D3A4940020000E0595B3E40
594	2	641	0101000020E6100000FEFFFF1FDA394940F6FFFFBF775B3E40
595	2	642	0101000020E6100000FEFFFF1F5A394940060000E08C5B3E40
596	2	643	0101000020E6100000010000C0C4384940F5FFFFFFB65B3E40
597	2	644	0101000020E6100000000000A0DB374940F9FFFF9F015C3E40
598	2	645	0101000020E6100000040000C03B374940FBFFFF7F7B5C3E40
599	2	646	0101000020E6100000000000006836494002000080C15D3E40
600	2	647	0101000020E6100000FCFFFF3F6836494000000000805E3E40
601	2	648	0101000020E6100000010000C0703649400B000060E15F3E40
602	2	649	0101000020E6100000FAFFFFBF26364940FCFFFF9F94603E40
603	2	650	0101000020E6100000010000C024344940F9FFFFFFB1683E40
604	2	651	0101000020E6100000FDFFFFBF35344940F9FFFF5F52683E40
605	2	652	0101000020E6100000060000E004364940060000E0CC603E40
606	2	653	0101000020E6100000020000E0BD35494001000020915F3E40
607	2	654	0101000020E6100000040000008F364940FFFFFFDFAE5D3E40
608	2	655	0101000020E6100000FDFFFFBF253749400A0000A0D05C3E40
609	2	656	0101000020E6100000FCFFFF3FDC37494000000060305C3E40
610	2	657	0101000020E610000005000080C038494004000060E35B3E40
611	2	658	0101000020E6100000020000805D394940FBFFFFDFB35B3E40
612	2	659	0101000020E610000004000060DB3949400D0000E0925B3E40
613	2	660	0101000020E6100000060000404D3A4940060000E0345C3E40
614	2	661	0101000020E6100000040000C0573A4940FFFFFFDF6E5D3E40
615	2	662	0101000020E6100000FCFFFF9F683A4940060000E0645F3E40
616	2	663	0101000020E6100000FAFFFF1F773A49400400006023613E40
617	2	664	0101000020E6100000FCFFFF9F803A4940070000A035623E40
618	2	665	0101000020E6100000020000E0953A4940FEFFFF1FB6643E40
619	2	666	0101000020E610000000000000A43A4940F6FFFF5F57663E40
620	2	667	0101000020E6100000020000E0A93A49400B00000051673E40
621	2	668	0101000020E610000005000020683C4940FEFFFF1FA6673E40
622	2	670	0101000020E6100000FCFFFFFF6C374940010000C0388E3E40
623	2	671	0101000020E610000005000020E8374940FCFFFF3F948D3E40
624	2	672	0101000020E6100000FAFFFF1F73384940020000E0B18C3E40
625	2	673	0101000020E6100000FCFFFF9FD038494007000000668B3E40
626	2	674	0101000020E61000000200008005394940FAFFFF1F1B8A3E40
627	2	675	0101000020E6100000030000A05A394940FDFFFFBFDD883E40
628	2	676	0101000020E6100000FDFFFF5FCD394940F6FFFFBF4F873E40
629	2	677	0101000020E610000006000040CD3949400A0000A0A0863E40
630	2	678	0101000020E6100000040000C07B39494007000060CE853E40
631	2	679	0101000020E610000005000020D83849400200008049853E40
632	2	680	0101000020E6100000000000A03E3849400000008034843E40
633	2	681	0101000020E6100000040000609B384940FAFFFFBFFA843E40
634	2	682	0101000020E6100000030000A0C2384940F8FFFF3F51853E40
635	2	683	0101000020E6100000070000A06D39494008000020CF853E40
636	2	684	0101000020E6100000FBFFFFDFB73949400700000086863E40
637	2	685	0101000020E6100000030000A0C23949400D0000E04A873E40
638	2	686	0101000020E6100000FDFFFFBF49394940FFFFFFDF0E893E40
639	2	687	0101000020E6100000FDFFFF5F09394940FCFFFF3FFC893E40
640	2	688	0101000020E610000000000000C438494009000080B78B3E40
641	2	689	0101000020E6100000FCFFFF9F503849400C000080EA8C3E40
642	2	690	0101000020E6100000FDFFFF5FD9374940FDFFFFBF9D8D3E40
643	2	691	0101000020E6100000000000A048374940000000C0728E3E40
644	2	693	0101000020E6100000FEFFFF7F4A2C494001000020F9883E40
645	2	694	0101000020E6100000030000A0A22C49400A000040B0893E40
646	2	695	0101000020E6100000FEFFFF1F222D4940F3FFFF1F758A3E40
647	2	696	0101000020E6100000FCFFFF9FEC2D4940FCFFFF3F448B3E40
648	2	697	0101000020E6100000FAFFFF1F132E4940F6FFFFBF678B3E40
649	2	698	0101000020E610000000000000142E494000000060608B3E40
650	2	699	0101000020E6100000010000C0D42D4940FCFFFF3F248B3E40
651	2	700	0101000020E6100000FCFFFFFF182D4940F2FFFFFF638A3E40
652	2	701	0101000020E6100000030000A0B22C4940FEFFFF7FC6893E40
653	2	702	0101000020E6100000FBFFFF7F4B2C4940FCFFFF3FF4883E40
654	2	704	0101000020E6100000000000E01E384940000000C0A8863E40
655	2	705	0101000020E6100000000000A0F3374940080000203F883E40
656	2	706	0101000020E6100000FFFFFF3F2F384940FBFFFFDFBB893E40
657	2	707	0101000020E610000004000060E7384940F4FFFFDFF5893E40
658	2	708	0101000020E61000000100002035384940F9FFFF5F6A8B3E40
659	2	709	0101000020E6100000FDFFFF5FD5374940F4FFFF7F758B3E40
660	2	710	0101000020E61000000400000057374940FEFFFF1F768B3E40
661	2	711	0101000020E6100000FBFFFFDF2B374940F8FFFFDF088B3E40
662	2	712	0101000020E610000005000020BC364940FDFFFFBFF58C3E40
663	2	713	0101000020E6100000FDFFFF5F953649400B000060498E3E40
664	2	714	0101000020E6100000030000404236494005000080AC903E40
665	2	715	0101000020E6100000F9FFFF5F32374940040000C053983E40
666	2	716	0101000020E6100000020000E079374940060000E0A4993E40
667	2	717	0101000020E6100000FDFFFFBFBD374940F4FFFF7FE59A3E40
668	2	718	0101000020E6100000FDFFFF5F39384940F7FFFF1FA89D3E40
669	2	719	0101000020E6100000FEFFFF7F5E3849400A000040989E3E40
670	2	720	0101000020E6100000000000A08B3849400C000020CA9F3E40
671	2	721	0101000020E6100000FAFFFF1F8B384940F7FFFF7F909F3E40
672	2	722	0101000020E6100000FFFFFFDF66384940010000C0A09E3E40
673	2	723	0101000020E6100000010000C040384940F8FFFFDFA89D3E40
674	2	724	0101000020E6100000FFFFFFDFCE374940020000E0119B3E40
675	2	725	0101000020E6100000FAFFFFBF8A374940F6FFFFBFCF993E40
676	2	726	0101000020E6100000FCFFFF9F48374940040000C093983E40
677	2	727	0101000020E61000000100002049364940FBFFFF7FB3903E40
678	2	728	0101000020E6100000020000E085364940F8FFFF3F298F3E40
679	2	729	0101000020E6100000040000C09B36494000000060108E3E40
680	2	730	0101000020E6100000070000A0C93649400B0000C0E98C3E40
681	2	731	0101000020E6100000040000C00B37494005000080D48A3E40
682	2	732	0101000020E6100000010000206D37494001000020898B3E40
683	2	733	0101000020E610000000000060D4374940020000E0A98B3E40
684	2	734	0101000020E6100000FBFFFFDF4F384940FBFFFF7FAB8C3E40
685	2	735	0101000020E610000002000080E9384940F4FFFF7FED893E40
686	2	736	0101000020E6100000040000C01F3849400100002081893E40
687	2	737	0101000020E6100000000000A0F3374940FDFFFFBFFD873E40
688	2	738	0101000020E6100000030000A01A384940FFFFFF3FBF863E40
689	2	740	0101000020E6100000FBFFFF7F6F3B4940020000E0F95A3E40
690	2	741	0101000020E6100000060000E094354940F7FFFF1F905F3E40
691	2	742	0101000020E610000000000080EF344940000000A0A1613E40
692	2	743	0101000020E6100000000000202F344940000000A000643E40
693	2	744	0101000020E6100000070000007E334940F9FFFF9F89673E40
694	2	745	0101000020E6100000040000C09F324940F3FFFF1F856C3E40
695	2	746	0101000020E6100000FAFFFFBF3E3249400B0000C0996D3E40
696	2	747	0101000020E6100000030000A0E2314940080000206F6E3E40
697	2	748	0101000020E6100000020000E05131494009000080F76F3E40
698	2	749	0101000020E6100000030000408E3049400B00006009723E40
699	2	750	0101000020E610000003000040EA2F494007000000C6733E40
700	2	751	0101000020E610000000000000582F49400E0000A04B753E40
701	2	752	0101000020E6100000FDFFFF5FA12F4940020000E031763E40
702	2	753	0101000020E610000000000060E82F4940000000000E773E40
703	2	754	0101000020E6100000030000406E304940FBFFFFDF7B783E40
704	2	755	0101000020E6100000FCFFFF9FDC2F4940F3FFFF1FBD763E40
705	2	756	0101000020E6100000FBFFFF7F932F4940F9FFFF5F3A753E40
706	2	757	0101000020E6100000FDFFFF5F05304940FAFFFFBFBA733E40
707	2	758	0101000020E61000000000000098304940F4FFFF7F2D723E40
708	2	759	0101000020E6100000000000A06731494004000000FB6F3E40
709	2	760	0101000020E610000004000060EF3149400E0000A08B6E3E40
710	2	761	0101000020E6100000FFFFFF3F4332494008000020A76D3E40
711	2	762	0101000020E6100000FBFFFFDFA3324940FBFFFF7F936C3E40
712	2	763	0101000020E6100000FFFFFF3F97334940F5FFFFFF56673E40
713	2	764	0101000020E6100000000000003A344940000000A026643E40
714	2	765	0101000020E610000000000040F9344940000000A0C3613E40
715	2	766	0101000020E610000006000040A1354940FBFFFF7FAB5F3E40
716	2	767	0101000020E6100000FAFFFF1F573A4940FAFFFF1F6B5B3E40
717	2	768	0101000020E6100000000000E0503B4940000000E0135B3E40
718	2	770	0101000020E6100000FAFFFF1FC7464940FCFFFF3FF4553E40
719	2	771	0101000020E6100000060000403D4549400B0000C0895A3E40
720	2	772	0101000020E610000000000020C0444940000000E0385B3E40
721	2	773	0101000020E6100000020000E071444940FEFFFF7FFE5A3E40
722	2	774	0101000020E6100000000000C02644494000000040C85B3E40
723	2	775	0101000020E610000000000060F6434940000000004A5C3E40
724	2	776	0101000020E6100000FEFFFF7FC24349400B000000D15C3E40
725	2	777	0101000020E6100000FCFFFF3F8C434940FAFFFFBF625D3E40
726	2	778	0101000020E6100000FAFFFFBF5E4349400D0000E0D25D3E40
727	2	779	0101000020E6100000010000C014424940040000C09B5C3E40
728	2	780	0101000020E6100000060000409D3C49400D0000407B5B3E40
729	2	781	0101000020E6100000000000803B3C4940000000802C5B3E40
730	2	782	0101000020E6100000000000209F3B4940000000A0FB5A3E40
731	2	783	0101000020E6100000000000A0A63B4940000000C0135B3E40
732	2	784	0101000020E6100000000000204F3C4940000000E0595B3E40
733	2	785	0101000020E6100000040000C09F3C494006000040955B3E40
734	2	786	0101000020E61000000500008014424940F5FFFF3FA65C3E40
735	2	787	0101000020E6100000FCFFFFFF5C43494004000000DB5D3E40
736	2	788	0101000020E6100000000000A07345494000000000545B3E40
737	2	789	0101000020E6100000000000E055464940000000201A5C3E40
738	2	790	0101000020E6100000000000C07E45494000000040685B3E40
739	2	791	0101000020E61000000000004046454940000000C0825A3E40
740	2	792	0101000020E6100000FCFFFF3F9C454940040000C09B593E40
741	2	793	0101000020E610000000000060C846494000000000F0553E40
\.


--
-- Data for Name: string_keys; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY string_keys (id, name) FROM stdin;
1	\N
2	\N
3	\N
4	\N
5	\N
6	\N
7	\N
8	\N
9	\N
10	\N
11	\N
12	\N
13	\N
14	\N
15	\N
16	\N
17	\N
18	\N
19	\N
20	\N
21	\N
22	\N
23	\N
24	\N
25	\N
26	\N
27	\N
28	\N
29	\N
30	\N
31	\N
32	\N
33	\N
34	\N
35	\N
36	\N
37	\N
38	\N
313	\N
314	\N
315	\N
316	\N
317	\N
318	\N
319	\N
320	\N
321	\N
322	\N
323	\N
324	\N
325	\N
326	\N
327	\N
328	\N
329	\N
330	\N
331	\N
332	\N
333	\N
334	\N
335	\N
336	\N
337	\N
338	\N
339	\N
340	\N
341	\N
342	\N
343	\N
215	\N
216	\N
217	\N
218	\N
219	\N
220	\N
221	\N
222	\N
223	\N
224	\N
225	\N
226	\N
227	\N
228	\N
229	\N
344	\N
230	\N
345	\N
346	\N
231	\N
347	\N
348	\N
232	\N
233	\N
349	\N
234	\N
235	\N
236	\N
237	\N
350	\N
351	\N
238	\N
239	\N
240	\N
352	\N
353	\N
354	\N
355	\N
356	\N
357	\N
358	\N
359	\N
360	\N
361	\N
362	\N
363	\N
364	\N
365	\N
366	\N
367	\N
368	\N
369	\N
370	\N
371	\N
372	\N
373	\N
374	\N
375	\N
376	\N
377	\N
378	\N
379	\N
380	\N
381	\N
382	\N
383	\N
384	\N
385	\N
386	\N
387	\N
388	\N
389	\N
390	\N
391	\N
392	\N
393	\N
394	\N
395	\N
396	\N
397	\N
398	\N
399	\N
400	\N
401	\N
402	\N
403	\N
404	\N
405	\N
406	\N
407	\N
408	\N
409	\N
410	\N
411	\N
412	\N
413	\N
414	\N
415	\N
416	\N
417	\N
418	\N
419	\N
420	\N
421	\N
422	\N
423	\N
424	\N
425	\N
426	\N
427	\N
428	\N
429	\N
430	\N
431	\N
277	\N
278	\N
279	\N
280	\N
281	\N
282	\N
283	\N
284	\N
285	\N
286	\N
287	\N
288	\N
289	\N
290	\N
291	\N
292	\N
293	\N
294	\N
295	\N
296	\N
297	\N
298	\N
299	\N
300	\N
301	\N
302	\N
303	\N
304	\N
305	\N
306	\N
307	\N
308	\N
309	\N
310	\N
311	\N
312	\N
432	\N
433	\N
434	\N
435	\N
436	\N
437	\N
438	\N
439	\N
440	\N
441	\N
442	\N
443	\N
444	\N
445	\N
446	\N
447	\N
448	\N
449	\N
450	\N
451	\N
452	\N
453	\N
454	\N
455	\N
456	\N
457	\N
458	\N
459	\N
460	\N
461	\N
462	\N
463	\N
464	\N
465	\N
466	\N
467	\N
468	\N
469	\N
470	\N
471	\N
472	\N
473	\N
474	\N
475	\N
476	\N
477	\N
478	\N
479	\N
480	\N
481	\N
482	\N
483	\N
484	\N
485	\N
486	\N
487	\N
488	\N
489	\N
490	\N
491	\N
492	\N
493	\N
494	\N
495	\N
496	\N
497	\N
498	\N
499	\N
500	\N
501	\N
502	\N
503	\N
504	\N
505	\N
506	\N
507	\N
508	\N
509	\N
510	\N
511	\N
512	\N
513	\N
514	\N
515	\N
516	\N
517	\N
518	\N
519	\N
520	\N
521	\N
522	\N
523	\N
524	\N
525	\N
526	\N
527	\N
528	\N
529	\N
530	\N
531	\N
532	\N
533	\N
534	\N
535	\N
536	\N
537	\N
538	\N
539	\N
540	\N
541	\N
542	\N
543	\N
544	\N
545	\N
546	\N
547	\N
548	\N
549	\N
550	\N
551	\N
552	\N
553	\N
554	\N
555	\N
556	\N
557	\N
558	\N
559	\N
560	\N
561	\N
562	\N
563	\N
564	\N
565	\N
566	\N
567	\N
568	\N
569	\N
570	\N
571	\N
572	\N
573	\N
574	\N
575	\N
576	\N
577	\N
578	\N
579	\N
580	\N
581	\N
582	\N
583	\N
584	\N
585	\N
586	\N
587	\N
588	\N
589	\N
590	\N
591	\N
592	\N
593	\N
594	\N
595	\N
596	\N
597	\N
598	\N
599	\N
600	\N
601	\N
602	\N
603	\N
604	\N
605	\N
606	\N
607	\N
608	\N
609	\N
610	\N
611	\N
612	\N
613	\N
614	\N
615	\N
616	\N
617	\N
618	\N
619	\N
620	\N
621	\N
622	\N
623	\N
624	\N
625	\N
626	\N
627	\N
628	\N
629	\N
630	\N
631	\N
632	\N
633	\N
634	\N
635	\N
636	\N
637	\N
638	\N
639	\N
640	\N
641	\N
642	\N
643	\N
644	\N
645	\N
646	\N
647	\N
648	\N
649	\N
650	\N
651	\N
652	\N
653	\N
654	\N
655	\N
656	\N
657	\N
658	\N
659	\N
660	\N
661	\N
662	\N
663	\N
664	\N
665	\N
666	\N
667	\N
668	\N
669	\N
670	\N
671	\N
672	\N
673	\N
674	\N
675	\N
676	\N
677	\N
678	\N
679	\N
680	\N
681	\N
682	\N
683	\N
684	\N
685	\N
686	\N
687	\N
688	\N
689	\N
690	\N
691	\N
692	\N
693	\N
694	\N
695	\N
696	\N
697	\N
698	\N
699	\N
700	\N
701	\N
702	\N
703	\N
704	\N
705	\N
706	\N
707	\N
708	\N
709	\N
710	\N
711	\N
712	\N
713	\N
714	\N
715	\N
716	\N
717	\N
718	\N
719	\N
720	\N
721	\N
722	\N
723	\N
724	\N
725	\N
726	\N
727	\N
728	\N
729	\N
730	\N
731	\N
732	\N
733	\N
734	\N
735	\N
736	\N
737	\N
738	\N
739	\N
740	\N
741	\N
742	\N
743	\N
744	\N
745	\N
746	\N
747	\N
748	\N
749	\N
750	\N
751	\N
752	\N
753	\N
754	\N
755	\N
756	\N
757	\N
758	\N
759	\N
760	\N
761	\N
762	\N
763	\N
764	\N
765	\N
766	\N
767	\N
768	\N
769	\N
770	\N
771	\N
772	\N
773	\N
774	\N
775	\N
776	\N
777	\N
778	\N
779	\N
780	\N
781	\N
782	\N
783	\N
784	\N
785	\N
786	\N
787	\N
788	\N
789	\N
790	\N
791	\N
792	\N
793	\N
794	\N
\.


--
-- Data for Name: string_values; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY string_values (id, key_id, lang_id, value) FROM stdin;
1	1	c_ru	Отсутствует
2	1	c_en	Dissapear
3	2	c_ru	Студенческий
4	2	c_en	Student
5	3	c_ru	Харьков
6	3	c_en	Kharkov
7	5	c_ru	Киев
8	5	c_en	Kyiv
9	7	c_ru	Героев труда
10	7	c_en	Geroiv praci
11	8	c_ru	Студенческая
12	8	c_en	Studentska
13	9	c_ru	Академика Павлова
14	9	c_en	Academica Pavlova
15	10	c_ru	Академика Барабашова
16	10	c_en	Academica Barabashova
17	11	c_ru	Киевская
18	11	c_en	Kievskaia
19	12	c_ru	Пушкинская
20	12	c_en	Pushkinskaia
21	13	c_ru	Университет
22	13	c_en	University
23	14	c_ru	Исторический музей
24	14	c_en	Istor. musem
25	15	c_ru	23 августа
26	15	c_en	23 August
27	16	c_ru	Ботанический сад
28	16	c_en	Botan sad
29	17	c_ru	Научная
30	17	c_en	Nauchnaia
31	18	c_ru	Госпром
32	18	c_en	Gosprom
33	19	c_ru	Архитектора Бекетова
34	19	c_en	Arch Beketova 
35	20	c_ru	Площадь восстания
36	20	c_en	Vosstania square
37	21	c_ru	Метростроителей им. Ващенка
38	21	c_en	Metrostroitelei Vashenka
39	22	c_ru	Холодная гора
40	22	c_en	Xolodna gora
41	23	c_ru	Южный вокзал
42	23	c_en	Ugniy vokzal
43	24	c_ru	Центральный рынок
44	24	c_en	Central market
45	25	c_ru	Советская
46	25	c_en	Radianska
47	26	c_ru	Проспект Гагарина
48	26	c_en	Prospect Gagarina
49	27	c_ru	Спортивная
50	27	c_en	Sportivna
51	28	c_ru	Завод им. Малышева
52	28	c_en	Zavod im. Malisheva
53	29	c_ru	Московский проспект
54	29	c_en	Moskovskii prospect
55	30	c_ru	Маршала Жукова
56	30	c_en	Marshala Gykova
57	31	c_ru	Советской армии
58	31	c_en	Sovetskoi armii
59	32	c_ru	Масельского
60	32	c_en	Maselskogo
61	33	c_ru	Тракторный завод
62	33	c_en	Traktornii zavod
63	34	c_ru	Пролетарская
64	34	c_en	Proletarska
65	36	c_en	Oleksiivska line
66	36	c_ru	Алексеевская линия
67	37	c_en	Xolondo-gersko-zavodskaia line
68	37	c_ru	Холодногорско-заводская линия
836	313	c_ru	 ул. Боженко
837	313	c_en	 Bozhenko St
838	313	c_uk	 вул. Боженко
839	314	c_ru	 Сельсовет
840	314	c_en	 Silrada
841	314	c_uk	 Сільрада
842	315	c_ru	 ул. Ленина
843	315	c_en	 Lenina St
844	315	c_uk	 вул. Леніна
845	316	c_ru	 ул. Суворова
846	316	c_en	 Suvorova St
847	316	c_uk	 вул. Суворова
851	318	c_ru	 ул. Славская
852	318	c_en	 Slavska St
853	318	c_uk	 вул. Славська
854	319	c_ru	 ул. Милославская
855	319	c_en	 Myloslavska St
856	319	c_uk	 вул. Милославська
857	320	c_ru	 ул. Будищанская
858	320	c_en	 Budyshanska St
859	320	c_uk	 вул. Будищанська
860	321	c_ru	 ул. Лисковская
861	321	c_en	 Lyskivska St
862	321	c_uk	 вул. Лисківська
863	322	c_ru	 магазин Радунь
864	322	c_en	 magazyn Radun
865	322	c_uk	 магазин Радунь
866	323	c_ru	 ул. Радунская
867	323	c_en	 Radunska St
868	323	c_uk	 вул. Радунська
869	324	c_ru	 ул. Градинская
870	324	c_en	 Hradynska St
871	324	c_uk	 вул. Градинська
872	325	c_ru	 ул. Александра Сабурова
873	325	c_en	 Oleksandra Saburova St
874	325	c_uk	 вул. Олександра Сабурова
875	326	c_ru	 ул. Викентия Беретти
876	326	c_en	 Vikentiya Bereti St
877	326	c_uk	 вул. Вікентія Береті
878	327	c_ru	 АТС
879	327	c_en	 ATS
880	327	c_uk	 АТС
1119	408	c_en	 Korpus 2
881	328	c_ru	 кинотеатр Флоренция
882	328	c_en	 kinoteatr Florentsia
883	328	c_uk	 кінотеатр Флоренція
884	329	c_ru	 ул. Николая Закревского
885	329	c_en	 Mykoly Zakrevskoho St
886	329	c_uk	 вул. Миколи Закревського
887	330	c_ru	 пр. Генерала Ватутина
888	330	c_en	 Henerala Vatutina Ave
889	330	c_uk	 пр. Генерала Ватутіна
890	331	c_ru	 Школа милиции
891	331	c_en	 Shkola militsii
892	331	c_uk	 Школа міліції
893	332	c_ru	 ул. Сулеймана Стальского
894	332	c_en	 Suleymana Stalskoho St
895	332	c_uk	 вул. Сулеймана Стальского
896	333	c_ru	 пр. Лесной
897	333	c_en	 Lisovyi Ave
898	333	c_uk	 пр. Лісовий
899	334	c_ru	 Медучилище
900	334	c_en	 Meduchylyshe
901	334	c_uk	 Медучилище
902	335	c_ru	 рынок Лесной
903	335	c_en	 rynok Lisnyi
904	335	c_uk	 ринок Лісний
905	336	c_ru	 ул. Бойченко
906	336	c_en	 Boychenko St
907	336	c_uk	 вул. Бойченко
908	337	c_ru	 ул. Малышко
909	337	c_en	 Malyshko St
910	337	c_uk	 вул. Малишко
911	338	c_ru	 ст. м. Черниговская
912	338	c_en	 Chernihivska 
913	338	c_uk	 ст. м. Чернігівська
914	339	c_ru	 ул. Крвсноткацкая
915	339	c_en	 Chervonotkatska St
916	339	c_uk	 вул. Червоноткацька
917	340	c_ru	 бульв. Верховного Совета
918	340	c_en	 Verkhovnoi Rady Blvd
919	340	c_uk	 бульв. Верховної Ради
920	341	c_ru	 ул. Павла Усенко
921	341	c_en	 Pavla Usenko St
922	341	c_uk	 вул. Павла Усенко
923	342	c_ru	 площадь Ленинградская
924	342	c_en	 Leninhradska square
925	342	c_uk	 площа Ленінградська
926	343	c_ru	 ул. Павла Усенко
927	343	c_en	 Pavla Usenko St
928	343	c_uk	 вул. Павла Усенко
929	344	c_ru	 бульв. Верховного Совета
930	344	c_en	 Verkhovnoi Rady Blvd
931	344	c_uk	 бульв. Верховної Ради
932	345	c_ru	 ст. м. Черниговская
933	345	c_en	 Chernihivska 
934	345	c_uk	 ст. м. Чернігівська
935	346	c_ru	 ул. Малышко
936	346	c_en	 Malyshko St
937	346	c_uk	 вул. Малишко
938	347	c_ru	 ул. Бойченко
939	347	c_en	 Boychenko St
940	347	c_uk	 вул. Бойченко
941	348	c_ru	 рынок Лесной
942	348	c_en	 rynok Lisnyi
943	348	c_uk	 ринок Лісний
944	349	c_ru	 Медучилище
945	349	c_en	 Meduchylyshe
946	349	c_uk	 Медучилище
947	350	c_ru	 пр. Лесной
948	350	c_en	 Lisovyi Ave
949	350	c_uk	 пр. Лісовий
950	351	c_ru	 ул. Крайняя
951	351	c_en	 Kraynya St
952	351	c_uk	 вул. Крайня
571	221	c_uk	 ст. м. Олімпійська
572	222	c_ru	 ул. Жилянская
573	222	c_en	 Zhylyanska St
574	222	c_uk	 вул. Жилянська
575	223	c_ru	 ул. Красноармейская
576	223	c_en	 Chervonoarmiyska St
577	223	c_uk	 вул. Червоноармійська
578	224	c_ru	 Ветеренарная аптека
579	224	c_en	 Veterenarna apteka
580	224	c_uk	 Ветеринарна аптека
953	352	c_ru	 Школа милиции
954	352	c_en	 Shkola militsii
955	352	c_uk	 Школа міліції
956	353	c_ru	 рынок Троещина
957	353	c_en	 rynok Troeshyna
958	353	c_uk	 ринок Троєщина
959	354	c_ru	 ул. Николая Закревского
960	354	c_en	 Mykoly Zakrevskoho St
961	354	c_uk	 вул. Миколи Закревського
581	225	c_ru	 ул. Паньковская
582	225	c_en	 Pankovska St
583	225	c_uk	 вул. Паньковська
584	226	c_ru	 ул. Льва Толстого
585	226	c_en	 Lva Tolstoho St
586	226	c_uk	 вул. Льва Толстого
962	355	c_ru	 кинотеатр Флоренция
587	227	c_ru	 ж/д вокзал Центральный
963	355	c_en	 kinoteatr Florentsia
964	355	c_uk	 кінотеатр Флоренція
965	356	c_ru	 пр. Владимира Маяковского
966	356	c_en	 Volodymyra Mayakovskoho Ave
967	356	c_uk	 пр. Володимира Мояковського
968	357	c_ru	 АТС
969	357	c_en	 ATS
970	357	c_uk	 АТС
971	358	c_ru	 ул. Бальзака
972	358	c_en	 Balzaka St
973	358	c_uk	 вул. Бальзака
974	359	c_ru	 ул. Дрейзера
975	359	c_en	 Dreyzera St
976	359	c_uk	 вул. Дрейзера
977	360	c_ru	 ул. Викентия Беретти
978	360	c_en	 Vikentiya Bereti St
979	360	c_uk	 вул. Вікентія Береті
980	361	c_ru	 ул. Александра Сабурова
981	361	c_en	 Oleksandra Saburova St
982	361	c_uk	 вул. Олександра Сабурова
983	362	c_ru	 ул. Градинская
984	362	c_en	 Hradynska St
985	362	c_uk	 вул. Градинська
986	363	c_ru	 ул. Радунская
987	363	c_en	 Radunska St
988	363	c_uk	 вул. Радунська
989	364	c_ru	 магазин Радунь
990	364	c_en	 magazyn Radun
991	364	c_uk	 магазин Радунь
992	365	c_ru	 ул. Лисковская
993	365	c_en	 Lyskivska St
994	365	c_uk	 вул. Лисківська
995	366	c_ru	 ул. Будищанская/ ул. Радунская
996	366	c_en	 Budyshanska St / Radunska St
997	366	c_uk	 вул. Будищанська / вул. Радунська
998	367	c_ru	 ул. Милославская
999	367	c_en	 Myloslavska St
1000	367	c_uk	 вул. Милославська
1001	368	c_ru	 ул. Славская
1002	368	c_en	 Slavska St
1003	368	c_uk	 вул. Славська
1004	369	c_ru	 село Троещина
1005	369	c_en	 Troeshina village
1006	369	c_uk	 село Троєщина
1007	370	c_ru	 ул. Суворова
1008	370	c_en	 Suvorova St
1009	370	c_uk	 вул. Суворова
1010	371	c_ru	 ул. Ленина
1011	371	c_en	 Lenina St
1012	371	c_uk	 вул. Леніна
1013	372	c_ru	 Сельсовет
1014	372	c_en	 Silrada
1015	372	c_uk	 Сільрада
1016	373	c_ru	 Автостоянка
1017	373	c_en	 Autostoyanka
798	299	c_en	 Zavod
799	299	c_uk	 Завод реле та автоматики
800	300	c_ru	 ул. Героев Севастополя
801	300	c_en	 Heroiv Sevastopolya St
802	300	c_uk	 вул. Героїв Севастополя
803	301	c_ru	 6-й КАРЗ
804	301	c_en	 Karz
805	301	c_uk	 6-й КАРЗ
806	302	c_ru	 ул. Василия Чумака
807	302	c_en	 Vasylya Chumaka St
808	302	c_uk	 вул. Василя Чумака
809	303	c_ru	 Поликлиника
810	303	c_en	 Poliklinika
811	303	c_uk	 Поліклініка
812	304	c_ru	 пр. Комарова
813	304	c_en	 Komarova Ave
814	304	c_uk	 пр. Комарова
815	305	c_ru	 ул. Академика Биленького
816	305	c_en	 Akademika Bilenkoho St
551	215	c_ru	 ул. Изюмская
552	215	c_en	 Izumska St
553	215	c_uk	 вул. Ізюмська
817	305	c_uk	 вул. Академіка Біленького
818	306	c_ru	 кинотеатр Тампере
819	306	c_en	 kinoteatr Tempere
820	306	c_uk	 кінотеатр Темпере
821	307	c_ru	 ул. Героев Севастополя
822	307	c_en	 Heroiv Sevastopolya St
823	307	c_uk	 вул. Героїв Севастополя
824	308	c_ru	 ул. Суздальская
825	308	c_en	 Suzdalska St
554	216	c_ru	 Байковое кладбище
555	216	c_en	 Baykove kladovyshe
556	216	c_uk	 Байкове кладовище
826	308	c_uk	 вул. Суздальська
1018	373	c_uk	 Автостоянка
557	217	c_ru	 ул. Ямская
558	217	c_en	 Yamska St
559	217	c_uk	 вул. Ямська
560	218	c_ru	 ул. Щорса
561	218	c_en	 Shorsa St
562	218	c_uk	 вул. Щорса
563	219	c_ru	 ул. Лабораторная
564	219	c_en	 Laboratorna St
565	219	c_uk	 вул. Лабораторна
566	220	c_ru	 ул. Федорова
567	220	c_en	 Fedorova St
568	220	c_uk	 вул. Федорова
569	221	c_ru	 ст. м. Олимпийская
570	221	c_en	 Olimpiyska
588	227	c_en	 vokzal Tsentralnyi
589	227	c_uk	 залізничний вокзал Центральний
590	228	c_ru	 ж/д вокзал Центральный
591	228	c_en	 vokzal Tsentralnyi
592	228	c_uk	 залізничний вокзал Центральний
593	229	c_ru	 ул. Жилянская
594	229	c_en	 Zhylyanska St
595	229	c_uk	 вул. Жилянська
596	230	c_ru	 ул. Льва Толстого
597	230	c_en	 Lva Tolstoho St
598	230	c_uk	 вул. Льва Толстого
599	231	c_ru	 ул. Паньковская
600	231	c_en	 Pankovska St
601	231	c_uk	 вул. Паньковська
602	232	c_ru	 Центр занятости
603	232	c_en	 Tsentr zanyatosti
604	232	c_uk	 Центр занятості
605	233	c_ru	 ул. Горького / ул. Жилянская
606	233	c_en	 Horkoho St / Zhylyanska St
607	233	c_uk	 вул. Горького / вул. Жилянська
608	234	c_ru	 ул. Димитрова
609	234	c_en	 Dymytrova St
610	234	c_uk	 вул. Димитрова
611	235	c_ru	 ул. Ивана Федорова
612	235	c_en	 Ivana Fedorova St
613	235	c_uk	 вул. Івана Федорова
614	236	c_ru	 ул. Лабораторная
615	236	c_en	 Laboratorna St
616	236	c_uk	 вул. Лабораторна
617	237	c_ru	 ул. Ямская
618	237	c_en	 Yamska St
619	237	c_uk	 вул. Ямська
620	238	c_ru	 ул. Николая Гринченко
621	238	c_en	 Mykoly Hrinchenka St
622	238	c_uk	 вул. Миколи Грінченка
623	239	c_ru	 ул. Изюмская
624	239	c_en	 Izumska St
625	239	c_uk	 вул. Ізюмська
731	277	c_ru	 ул. Булгакова
732	277	c_en	 Bulhakova St
733	277	c_uk	 вул. Булгакова
734	278	c_ru	 Борщаговский Химзавод
735	278	c_en	 Borshahivskyi Khimzavod
736	278	c_uk	 Борщагівський Хімзавод
737	279	c_ru	 Киев-Волынская
738	279	c_en	 Kyiv-Volynska
739	279	c_uk	 Київ-Волинська
740	280	c_ru	 Пост-Волынский
741	280	c_en	 Post-Volynskyi
742	280	c_uk	 Пост-Волинський
743	281	c_ru	 ул. Ново-Полевая
744	281	c_en	 Novo-Polova St
745	281	c_uk	 вул. Ново-Польова
746	282	c_ru	 ул. Суздальская
747	282	c_en	 Suzdalska St
748	282	c_uk	 вул. Суздальська
749	283	c_ru	 бульвар Ивана Лепсе
750	283	c_en	 Ivana Lepse Blvd
751	283	c_uk	 бульвар Івана Лепсе
752	284	c_ru	 пр. Отрадный
753	284	c_en	 Otradnyi Ave
754	284	c_uk	 пр. Отрадний
755	285	c_ru	 кинотеатр Тампере
756	285	c_en	 kinoteatr Tempere
757	285	c_uk	 кінотеатр Темпере
758	286	c_ru	 Медгородок
759	286	c_en	 Medmistechko
760	286	c_uk	 Медмістечко
761	287	c_ru	 бул. Лепсе
762	287	c_en	 Lepse Blvd
763	287	c_uk	 бул. Лепсе
764	288	c_ru	 ул. Академика Каблукова
765	288	c_en	 Akademika Kablukova St
766	288	c_uk	 вул. Академіка Каблукова
767	289	c_ru	 Библиотека
768	289	c_en	 Biblioteka
769	289	c_uk	 Бібліотека
770	290	c_ru	 Завод реле и автоматики
771	290	c_en	 Zavod
772	290	c_uk	 Завод реле та автоматики
773	291	c_ru	 ПО Росток
774	291	c_en	 Rostok
775	291	c_uk	 ПО Росток
776	292	c_ru	 Дом культуры
777	292	c_en	 Dim kultury
778	292	c_uk	 Дім культури
779	293	c_ru	 завод Большевик
780	293	c_en	 Bilshovyk
781	293	c_uk	 завод Більшовик
782	294	c_ru	 ул. Гарматная
783	294	c_en	 Harmatna St
784	294	c_uk	 вул. Гарматна
785	295	c_ru	 ст. м. Шулявская
786	295	c_en	 Shulyavska 
787	295	c_uk	 ст. м. Шулявська
788	296	c_ru	 Общежитие
789	296	c_en	 Hurtozhytok
790	296	c_uk	 Гуртожиток
791	297	c_ru	 Дом культуры
792	297	c_en	 Dim kultury
793	297	c_uk	 Дім культури
794	298	c_ru	 ПО Росток
795	298	c_en	 Rostok
796	298	c_uk	 ПО Росток
797	299	c_ru	 Завод реле и автоматики
827	309	c_ru	 ул. Ново-Полевая
828	309	c_en	 Novo-Polova St
829	309	c_uk	 вул. Ново-Польова
830	310	c_ru	 Борщаговский Химзавод
831	310	c_en	 Borshahivskyi Khimzavod
832	310	c_uk	 Борщагівський Хімзавод
833	311	c_ru	 ул. Булгакова
834	311	c_en	 Bulhakova St
835	311	c_uk	 вул. Булгакова
1019	375	c_ru	 ул. Саксаганского
1020	375	c_en	 Saksahanskoho St
1021	375	c_uk	 вул. Саксаганського
1022	376	c_ru	 Цирк
1023	376	c_en	 Tsyrk
1024	376	c_uk	 Цирк
1025	377	c_ru	 Ортопедический институт
1026	377	c_en	 Ortopedychyi instytut
1027	377	c_uk	 Ортопедичний інститут
1028	378	c_ru	 Центральный рынок
1029	378	c_en	 Tsentralnyi rynok
1030	378	c_uk	 Центральний ринок
1031	379	c_ru	 Львовская площадь
1032	379	c_en	 Lvivska plosha
1033	379	c_uk	 Львівська площа
1034	380	c_ru	 Львовская площадь
1035	380	c_en	 Lvivska plosha
1036	380	c_uk	 Львівська площа
1037	381	c_ru	 Центральный рынок
1038	381	c_en	 Tsentralnyi rynok
1039	381	c_uk	 Центральний ринок
1040	382	c_ru	 Ортопедический институт
1041	382	c_en	 Ortopedychyi instytut
1042	382	c_uk	 Ортопедичний інститут
1043	383	c_ru	 площадь Победы
1044	383	c_en	 Peremogy square
1045	383	c_uk	 площа Перемоги
1046	384	c_ru	 ул. Жилянская
1047	384	c_en	 Zhylyanska St
1048	384	c_uk	 вул. Жилянська
1049	317	c_en	 Troeshina village
1050	317	c_ru	 село Троещина
1051	317	c_uk	 село Троєщина
1052	386	c_ru	 Автостанция Южная
1053	386	c_en	 Autostantsia Pivdena
1054	386	c_uk	 Автостанція Південна
1055	387	c_ru	 ст. м. Выставочный центр
1056	387	c_en	 Vystavkovyi tsentr
1057	387	c_uk	 ст. м. Виставковий центр
1058	388	c_ru	 магазин-салон Приборы
1059	388	c_en	 Prylady
1060	388	c_uk	 магазин-салон Прилади
1061	389	c_ru	 отель Голосеевский
1062	389	c_en	 Golosiivs'kyi
1063	389	c_uk	 готель Голосіївський
1064	390	c_ru	 ул. Полковника Потехина
1065	390	c_en	 Polkovnyka Potekhina St
1066	390	c_uk	 вул. Полковника Потєхіна
1067	391	c_ru	 Корпус 4
1068	391	c_en	 Korpus 4
1069	391	c_uk	 Корпус 4
1070	392	c_ru	 Корпус 3
1071	392	c_en	 Korpus 3
1072	392	c_uk	 Корпус 3
1073	393	c_ru	 Корпус 2
1074	393	c_en	 Korpus 2
1075	393	c_uk	 Корпус 2
1076	394	c_ru	 Общежитие
1077	394	c_en	 Hurtozhytok
1078	394	c_uk	 Гуртожиток
1079	395	c_ru	 Общежитие №8
1080	395	c_en	 Hurtozhyk 8
1081	395	c_uk	 Гуртожиток №8
1082	396	c_ru	 ул. Добрый Путь
1083	396	c_en	 Dobryi Shlyakh St
1084	396	c_uk	 вул. Добрий шлях
1085	397	c_ru	 ул. Конотопская
1086	397	c_en	 Konotopska St
1087	397	c_uk	 вул. Конотопська
1088	398	c_ru	 ул. Кошового
1089	398	c_en	 Koshovoho St
1090	398	c_uk	 вул. Кошового
1091	399	c_ru	 Ювелирная фабрика
1092	399	c_en	 Yuvelirna fabryka
1093	399	c_uk	 Ювелірна фабрика
1094	400	c_ru	 ст. м. Голосеевская
1095	400	c_en	 Holosiivska 
1096	400	c_uk	 ст.м. Голосіївська
1097	401	c_ru	 ст. м. Голосеевская
1098	401	c_en	 Holosiivska 
1099	401	c_uk	 ст.м. Голосіївська
1100	402	c_ru	 Ювелирная фабрика
1101	402	c_en	 Yuvelirna fabryka
1102	402	c_uk	 Ювелірна фабрика
1103	403	c_ru	 ул. Кошового
1104	403	c_en	 Koshovoho St
1105	403	c_uk	 вул. Кошового
1106	404	c_ru	 ул. Конотопская
1107	404	c_en	 Konotopska St
1108	404	c_uk	 вул. Конотопська
1109	405	c_ru	 ул. Добрый Путь
1110	405	c_en	 Dobryi Shlyakh St
1111	405	c_uk	 вул. Добрий шлях
1112	406	c_ru	 Общежитие №8
1113	406	c_en	 Hurtozhyk 8
1114	406	c_uk	 Гуртожиток №8
1115	407	c_ru	 Общежитие
1116	407	c_en	 Hurtozhytok
1117	407	c_uk	 Гуртожиток
1118	408	c_ru	 Корпус 2
1120	408	c_uk	 Корпус 2
1121	409	c_ru	 Корпус 3
1122	409	c_en	 Korpus 3
1123	409	c_uk	 Корпус 3
1124	410	c_ru	 Корпус 10
1125	410	c_en	 Korpus 10
1126	410	c_uk	 Корпус 10
1127	411	c_ru	 ул. Полковника Потехина
1128	411	c_en	 Polkovnyka Potekhina St
1129	411	c_uk	 вул. Полковника Потєхіна
1130	412	c_ru	 отель Голосеевский
1131	412	c_en	 Golosiivs'kyi
1132	412	c_uk	 готель Голосіївський
1133	413	c_ru	 магазин-салон Приборы
1134	413	c_en	 Prylady
1135	413	c_uk	 магазин-салон Прилади
1136	414	c_ru	 ст. м. Выставочный центр
1137	414	c_en	 Vystavkovyi tsentr
1138	414	c_uk	 ст. м. Виставковий центр
1139	415	c_ru	 Автостанция Южная
1140	415	c_en	 Autostantsia Pivdena
1141	415	c_uk	 Автостанція Південна
1142	417	c_ru	 ул. Булгакова
1143	417	c_en	 Bulhakova St
1144	417	c_uk	 вул. Булгакова
1145	418	c_ru	 Детский сад
1146	418	c_en	 Dytyachyi sadok
1147	418	c_uk	 Дитячий садок
1148	419	c_ru	 ул. Булгакова
1149	419	c_en	 Bulhakova St
1150	419	c_uk	 вул. Булгакова
1151	420	c_ru	 ул. Григоровича-Барского
1152	420	c_en	 Hryhorovycha-Barskoho St
1153	420	c_uk	 вул. Григоровича-Барського
1154	421	c_ru	 ул. Жолудева
1155	421	c_en	 Zholudeva St
1156	421	c_uk	 вул. Жолудєва
1157	422	c_ru	 бул. Кольцова
1158	422	c_en	 Koltsova Blvd
1159	422	c_uk	 бул. Кольцова
1160	423	c_ru	 Дом быта
1161	423	c_en	 Budynok pobutu
1162	423	c_uk	 Будинок побуту
1163	424	c_ru	 школа №131
1164	424	c_en	 shkola 131
1165	424	c_uk	 школа №131
1166	425	c_ru	 бульвар Кольцова
1167	425	c_en	 Koltsova Blvd
1168	425	c_uk	 бульвар Кольцова
1169	426	c_ru	 ул. Владимира Ульянова
1170	426	c_en	 Volodymyra Ulyanova St
1171	426	c_uk	 вул. Володимира Ул'янова
1172	427	c_ru	 кинотеатр Лейпциг
1173	427	c_en	 kinoteatr Leyptsyg
1174	427	c_uk	 кінотеатр Лейпциг
1175	428	c_ru	 ул. Академика Королева
1176	428	c_en	 Akademika Korolova St
1177	428	c_uk	 вул. Академіка Корольова
1178	429	c_ru	 станция Борщаговка
1179	429	c_en	 stantsiya Borshagivka
1180	429	c_uk	 станція Борщагівка
1181	430	c_ru	 ул. Василия Чумака
1182	430	c_en	 Vasylya Chumaka St
1183	430	c_uk	 вул. Василя Чумака
1184	431	c_ru	 6-й КАРЗ
1185	431	c_en	 Karz
1186	431	c_uk	 6-й КАРЗ
1187	432	c_ru	 ул. Героев Севастополя
1188	432	c_en	 Heroiv Sevastopolya St
1189	432	c_uk	 вул. Героїв Севастополя
1190	433	c_ru	 ул. Николая Василенко
1191	433	c_en	 Mykoly Vasylenka St
1192	433	c_uk	 вул. Миколи Василенка
1193	434	c_ru	 Фабрика ремонта обуви
1194	434	c_en	 Fabryka remontu vzuttya
1195	434	c_uk	 Фабрика ремонту взуття
1196	435	c_ru	 ул. Козелецкая
1197	435	c_en	 Kozeletska St
1198	435	c_uk	 вул. Козелецька
1199	436	c_ru	 ст. м. Берестейская
1200	436	c_en	 Beresteyska
1201	436	c_uk	 ст. м. Берестейська
1202	437	c_ru	 ул. Николая Шпака
1203	437	c_en	 Mykoly Shpaka St
1204	437	c_uk	 вул. Миколи Шпака
1205	438	c_ru	 ул. Ивана Шевцова
1206	438	c_en	 Ivana Shevtsova St
1207	438	c_uk	 вул. Івана Шевцова
1208	439	c_ru	 Институт Газа
1209	439	c_en	 Instytut Hazu
1210	439	c_uk	 Інститут Газу
1211	440	c_ru	 ул. Елены Телиги
1212	440	c_en	 Oleny Telihy St
1213	440	c_uk	 вул. Олени Теліги
1214	441	c_ru	 Больница
1215	441	c_en	 Likarnya
1216	441	c_uk	 Лікарня
1217	442	c_ru	 Хлебокомбинат
1218	442	c_en	 Khlibokombinat
1219	442	c_uk	 Хлібокомбінат
1220	443	c_ru	 ул. Зоологическая
1221	443	c_en	 Zoolohichna St
1222	443	c_uk	 вул. Зоологічна
1223	444	c_ru	 ул. Довнар-Запольского
1224	444	c_en	 Dovnar-Zapolskoho St
1225	444	c_uk	 вул. Довнар-Запольского
1226	445	c_ru	 ул. Довнар-Запольского
1227	445	c_en	 Dovnar-Zapolskoho St
1228	445	c_uk	 вул. Довнар-Запольского
1229	446	c_ru	 площадь Лукьяновская
1230	446	c_en	 plosha Lukyanivska
1231	446	c_uk	 площа Лук'янівська
1232	447	c_ru	 площадь Лукьяновская
1233	447	c_en	 plosha Lukyanivska
1234	447	c_uk	 площа Лук'янівська
1235	448	c_ru	 ул. Довнар-Запольского
1236	448	c_en	 Dovnar-Zapolskoho St
1237	448	c_uk	 вул. Довнар-Запольского
1238	449	c_ru	 ул. Зоологическая
1239	449	c_en	 Zoolohichna St
1240	449	c_uk	 вул. Зоологічна
1241	450	c_ru	 Хлебокомбинат
1242	450	c_en	 Khlibokombinat
1243	450	c_uk	 Хлібокомбінат
1244	451	c_ru	 Больница
1245	451	c_en	 Likarnya
1246	451	c_uk	 Лікарня
1247	452	c_ru	 ул. Елены Телиги
1248	452	c_en	 Oleny Telihy St
1249	452	c_uk	 вул. Олени Теліги
1250	453	c_ru	 Институт Газа
1251	453	c_en	 Instytut Hazu
1252	453	c_uk	 Інститут Газу
1253	454	c_ru	 ул. Ивана Шевцова
1254	454	c_en	 Ivana Shevtsova St
1255	454	c_uk	 вул. Івана Шевцова
1256	455	c_ru	 ул. Николая Шпака
1257	455	c_en	 Mykoly Shpaka St
1258	455	c_uk	 вул. Миколи Шпака
1259	456	c_ru	 ст. м. Берестейская
1260	456	c_en	 Beresteyska
1261	456	c_uk	 ст. м. Берестейська
1262	457	c_ru	 ул. Козелецкая
1263	457	c_en	 Kozeletska St
1264	457	c_uk	 вул. Козелецька
1265	458	c_ru	 Фабрика ремонта обуви
1266	458	c_en	 Fabryka remontu vzuttya
1267	458	c_uk	 Фабрика ремонту взуття
1268	459	c_ru	 ул. Николая Василенко
1269	459	c_en	 Mykoly Vasylenka St
1270	459	c_uk	 вул. Миколи Василенка
1271	460	c_ru	 рынок Отрадный
1272	460	c_en	 rynok Otradnyi
1273	460	c_uk	 ринок Отрадний
1274	461	c_ru	 станция Борщаговка
1275	461	c_en	 stantsiya Borshagivka
1276	461	c_uk	 станція Борщагівка
1277	462	c_ru	 ул. Василия Верховинца
1278	462	c_en	 Vasylya Verhovyntsya St
1279	462	c_uk	 вул. Василя Верховинця
1280	463	c_ru	 кинотеатр Лейпциг
1281	463	c_en	 kinoteatr Leyptsyg
1282	463	c_uk	 кінотеатр Лейпциг
1283	464	c_ru	 ул. Генерала Потапова
1284	464	c_en	 Henerala Potapova St
1285	464	c_uk	 вул. Генерала Потапова
1286	465	c_ru	 Дом быта
1287	465	c_en	 Budynok pobutu
1288	465	c_uk	 Будинок побуту
1289	466	c_ru	 ул. Семьи Сосниных
1290	466	c_en	 Simyi Sosninykh
1291	466	c_uk	 вул. Сім'ї Сосніних
1292	467	c_ru	 ул. Жолудева
1293	467	c_en	 Zholudeva St
1294	467	c_uk	 вул. Жолудєва
1295	468	c_ru	 ул. Григоровича-Барского
1296	468	c_en	 Hryhorovycha-Barskoho St
1297	468	c_uk	 вул. Григоровича-Барського
1298	469	c_ru	 ул. Булгакова
1299	469	c_en	 Bulhakova St
1300	469	c_uk	 вул. Булгакова
1301	470	c_ru	 ул. Булгакова
1302	470	c_en	 Bulhakova St
1303	470	c_uk	 вул. Булгакова
1304	471	c_ru	 Детский сад
1305	471	c_en	 Dytyachyi sadok
1306	471	c_uk	 Дитячий садок
1307	472	c_ru	 ул. Булгакова
1308	472	c_en	 Bulhakova St
1309	472	c_uk	 вул. Булгакова
1310	474	c_ru	 ст. м. Лесная
1311	474	c_en	 Lisna
1312	474	c_uk	 ст. м. Лісна
1313	475	c_ru	 Лесничество
1314	475	c_en	 Lisnytstvo
1315	475	c_uk	 Лісництво
1316	476	c_ru	 Минутка
1317	476	c_en	 Khvylynka
1318	476	c_uk	 Хвилинка
1319	477	c_ru	 Школа
1320	477	c_en	 Shkola
1321	477	c_uk	 Школа
1322	478	c_ru	 пер. Быковнянский
1323	478	c_en	 Bykovnyanskyi Ln
1324	478	c_uk	 пров. Биковнянський
1325	479	c_ru	 ул. Радистов
1326	479	c_en	 Radystiv St
1327	479	c_uk	 вул. Радистів
1328	480	c_ru	 Радиоцентр
1329	480	c_en	 Radiotsentr
1330	480	c_uk	 Радіоцентр
1331	481	c_ru	 Радиоцентр
1332	481	c_en	 Radiotsentr
1333	481	c_uk	 Радіоцентр
1334	482	c_ru	 ул. Радистов
1335	482	c_en	 Radystiv St
1336	482	c_uk	 вул. Радистів
1337	483	c_ru	 пер. Быковнянский
1338	483	c_en	 Bykovnyanskyi Ln
1339	483	c_uk	 пров. Биковнянський
1340	484	c_ru	 Быковня
1341	484	c_en	 Bykovnya
1342	484	c_uk	 Биковня
1343	485	c_ru	 ДЭУ Днепровского района
1344	485	c_en	 DEU
1345	485	c_uk	 ДЕУ Дніпровського району
1346	486	c_ru	 ст. м. Лесная
1347	486	c_en	 Lisna
1348	486	c_uk	 ст. м. Лісна
1349	488	c_ru	 площадь Соломенская 
1350	488	c_en	 Solom'yanska square
1351	488	c_uk	 площа Солом'янська 
1352	489	c_ru	 ул. Соломенская
1353	489	c_en	 Solomyanska St
1354	489	c_uk	 вул. Солом'янська
1355	490	c_ru	 Государственный университет
1356	490	c_en	 Derzhavnyi universytet
1357	490	c_uk	 Державний університет
1358	491	c_ru	 ул. Алексеевская
1359	491	c_en	 Oleksiivska St
1360	491	c_uk	 вул. Олексіївська
1361	492	c_ru	 ул. Университетская
1362	492	c_en	 Universytetska St
1363	492	c_uk	 вул. Університетська
1364	493	c_ru	 ул. Зенитная
1365	493	c_en	 Zenitna St
1366	493	c_uk	 вул. Зенітна
1367	494	c_ru	 Сахарный институт
1368	494	c_en	 Tsukrovyi instytut
1369	494	c_uk	 Цукровий інститут
1370	495	c_ru	 Тубинститут
1371	495	c_en	 Tubinstytut
1372	495	c_uk	 Тубінститут
1373	496	c_ru	 Божков Яр
1374	496	c_en	 Bozhkov Yar
1375	496	c_uk	 Божков Яр
1376	497	c_ru	 ул. Гаевая
1377	497	c_en	 Haeva St
1378	497	c_uk	 вул. Гаєва
1379	498	c_ru	 ул. Нечуй-Левицкого
1380	498	c_en	 Nechui-Levytskoho St
1381	498	c_uk	 вул. Нечуй-Левицького
1382	499	c_ru	 Почта
1383	499	c_en	 Poshta
1384	499	c_uk	 Пошта
1385	500	c_ru	 Фрометовский спуск
1386	500	c_en	 Frometivskyi descent
1387	500	c_uk	 Фрометівський узвіз
1388	501	c_ru	 ул. Изюмская
1389	501	c_en	 Izumska St
1390	501	c_uk	 вул. Ізюмська
1391	502	c_ru	 ул. Кировоградская
1392	502	c_en	 Kyrovohradska St
1393	502	c_uk	 вул. Кировоградська
1394	503	c_ru	 Фрометовский спуск
1395	503	c_en	 Frometivskyi descent
1396	503	c_uk	 Фрометівський узвіз
1397	504	c_ru	 Магазин
1398	504	c_en	 Magazin
1399	504	c_uk	 Магазин
1400	505	c_ru	 Почта
1401	505	c_en	 Poshta
1402	505	c_uk	 Пошта
1403	506	c_ru	 ул. Нечуй-Левицкого
1404	506	c_en	 Nechui-Levytskoho St
1405	506	c_uk	 вул. Нечуй-Левицького
1406	507	c_ru	 ул. Гаевая
1407	507	c_en	 Haeva St
1408	507	c_uk	 вул. Гаєва
1409	508	c_ru	 ул. Яслинская
1410	508	c_en	 Yaslinska St
1411	508	c_uk	 вул. Яслінська
1412	509	c_ru	 Сахарный институт
1413	509	c_en	 Tsukrovyi instytut
1414	509	c_uk	 Цукровий інститут
1415	510	c_ru	 Тубинститут
1416	510	c_en	 Tubinstytut
1417	510	c_uk	 Тубінститут
1418	511	c_ru	 Сахарный институт
1419	511	c_en	 Tsukrovyi instytut
1420	511	c_uk	 Цукровий інститут
1421	512	c_ru	 ул. Зенитная
1422	512	c_en	 Zenitna St
1423	512	c_uk	 вул. Зенітна
1424	513	c_ru	 ул. Университетская
1425	513	c_en	 Universytetska St
1426	513	c_uk	 вул. Університетська
1427	514	c_ru	 ул. Андрея Головко
1428	514	c_en	 Andriya Holovko St
1429	514	c_uk	 вул. Андрія Головко
1430	515	c_ru	 ул. Алексеевская
1431	515	c_en	 Oleksiivska St
1432	515	c_uk	 вул. Олексіївська
1433	516	c_ru	 площадь Соломенская 
1949	698	c_ru	 завод ЖБК
1434	516	c_en	 Solom'yanska square
1435	516	c_uk	 площа Солом'янська 
1436	518	c_ru	 ул. Синеозерная
1437	518	c_en	 Synoozerna St
1438	518	c_uk	 вул. Синьоозерна
1439	519	c_ru	 Берковцы
1440	519	c_en	 Berkovtsi
1441	519	c_uk	 Берковці
1442	520	c_ru	 ул. Газопроводная
1443	520	c_en	 Hazoprovidna St
1444	520	c_uk	 вул. Газопровідна
1445	521	c_ru	 АП-5
1446	521	c_en	 AP-5
1447	521	c_uk	 АП-5
1448	522	c_ru	 Городское кладбище
1449	522	c_en	 Miskyi tsvyntar
1450	522	c_uk	 Міський цвинтар
1451	523	c_ru	 Сады
1452	523	c_en	 Sady
1453	523	c_uk	 Сади
1454	524	c_ru	 площадь Интернациональная
1455	524	c_en	 Internatsionalna square
1456	524	c_uk	 площа Інтернаціональна
1457	525	c_ru	 ул. Стеценко
1458	525	c_en	 Stytsenko St
1459	525	c_uk	 вул. Стеценка
1460	526	c_ru	 Поликлиника
1461	526	c_en	 Poliklinika
1462	526	c_uk	 Поліклініка
1463	527	c_ru	 ул. Салютная
1464	527	c_en	 Salutna St
1465	527	c_uk	 вул. Салютна
1466	528	c_ru	 ул. Краснодарская
1467	528	c_en	 Krasnodarska St
1468	528	c_uk	 вул. Краснодарська
1469	529	c_ru	 ул. Эстонская
1470	529	c_en	 Estonska St
1471	529	c_uk	 вул. Естонська
1472	530	c_ru	 ст. м. Нивки
1473	530	c_en	 Nyvky
1474	530	c_uk	 ст. м. Нивки
1475	531	c_ru	 ст. м. Нивки
1476	531	c_en	 Nyvky
1477	531	c_uk	 ст. м. Нивки
1478	532	c_ru	 ул. Эстонская
1479	532	c_en	 Estonska St
1480	532	c_uk	 вул. Естонська
1481	533	c_ru	 ул. Краснодарская
1482	533	c_en	 Krasnodarska St
1483	533	c_uk	 вул. Краснодарська
1484	534	c_ru	 ул. Вильгельма Пика
1485	534	c_en	 Vilhelma Pika St
1486	534	c_uk	 вул. Вільгельма Піка
1487	535	c_ru	 ул. Салютная
1488	535	c_en	 Salutna St
1489	535	c_uk	 вул. Салютна
1490	536	c_ru	 Поликлиника
1491	536	c_en	 Poliklinika
1492	536	c_uk	 Поліклініка
1493	537	c_ru	 ул. Стеценко
1494	537	c_en	 Stetsenko St
1495	537	c_uk	 вул. Стеценка
1496	538	c_ru	 площадь Интернациональная
1497	538	c_en	 Internatsionalna square
1498	538	c_uk	 площа Інтернаціональна
1499	539	c_ru	 Сады
1500	539	c_en	 Sady
1501	539	c_uk	 Сади
1502	540	c_ru	 Городское кладбище
1503	540	c_en	 Miskyi tsvyntar
1504	540	c_uk	 Міський цвинтар
1505	541	c_ru	 АП-5
1506	541	c_en	 AP-5
1507	541	c_uk	 АП-5
1508	542	c_ru	 ул. Газопроводная
1509	542	c_en	 Hazoprovidna St
1510	542	c_uk	 вул. Газопровідна
1511	543	c_ru	 Берковцы
1512	543	c_en	 Berkovtsi
1513	543	c_uk	 Берковці
1514	544	c_ru	 Лесорассадник
1515	544	c_en	 Lisorozsadnyk
1516	544	c_uk	 Лісорозсадник
1517	549	c_ru	 Станция Аэрации
1518	549	c_en	 Stantsiya Aeratsii
1519	549	c_uk	 Станція Аерації
1520	550	c_ru	 Орасительная система
1521	550	c_en	 Zroshuvalna systema
1522	550	c_uk	 Зрошувальна система
1523	551	c_ru	 завод Радиоизмеритель
1524	551	c_en	 zavod Radiovymiruvach
1525	551	c_uk	 завод Радіовимірювач
1526	552	c_ru	 площадь Харьковская
1527	552	c_en	 Kharkivska square
1528	552	c_uk	 площа Харківська
1529	553	c_ru	 ст. м. Бориспольская
1530	553	c_en	 Boryspilska
1531	553	c_uk	 ст. м. Бориспільська
1532	554	c_ru	 ст. м. Бориспольская
1533	554	c_en	 Boryspilska
1534	554	c_uk	 ст. м. Бориспільська
1535	555	c_ru	 площадь Харьковская
1536	555	c_en	 Kharkivska square
1537	555	c_uk	 площа Харківська
1538	556	c_ru	 завод Радиоизмеритель
1539	556	c_en	 zavod Radiovymiruvach
1540	556	c_uk	 завод Радіовимірювач
1541	557	c_ru	 Орасительная система
1542	557	c_en	 Zroshuvalna systema
1543	557	c_uk	 Зрошувальна система
1544	558	c_ru	 Станция Аэрации
1545	558	c_en	 Stantsiya Aeratsii
1546	558	c_uk	 Станція Аерації
1547	560	c_ru	 ул. Милославская
1548	560	c_en	 Myloslavska St
1549	560	c_uk	 вул. Милославська
1550	561	c_ru	 ул. Марины Цветаевой
1551	561	c_en	 Matyny Tsvetaevoi St
1552	561	c_uk	 вул. Марини Цвєтаєвої
1553	562	c_ru	 ул. Константина Данькевича
1554	562	c_en	 Kostyantyna Dankevycha St
1555	562	c_uk	 вул. Костянтина Данкевича
1556	563	c_ru	 ул. Дрейзера
1557	563	c_en	 Dreyzera St
1558	563	c_uk	 вул. Дрейзера
1559	564	c_ru	 ул. Архитектора Николаева
1560	564	c_en	 Architektora Nikolaeva St
1561	564	c_uk	 вул. Архітектора Ніколаєва
1562	565	c_ru	 Блок услуг
1563	565	c_en	 Blok poslug
1564	565	c_uk	 Блок послуг
1565	566	c_ru	 ул. Каштановая
1566	566	c_en	 Kashtanova St
1567	566	c_uk	 вул. Каштанова
1568	567	c_ru	 микрорайон №3
1569	567	c_en	 mikrorayon nomer try
1570	567	c_uk	 мікрорайон №3
1571	568	c_ru	 микрорайон №2
1572	568	c_en	 mikrorayon nomer dva
1573	568	c_uk	 мікрорайон №2
1574	569	c_ru	 Универсам
1575	569	c_en	 Universam
1576	569	c_uk	 Універсам
1577	570	c_ru	 ул. Николая Закревского
1578	570	c_en	 Mykoly Zakrevskoho St
1579	570	c_uk	 вул. Миколи Закревського
1580	571	c_ru	 массив Радужный
1581	571	c_en	 masyv Raduzhnyi
1582	571	c_uk	 масив Радужний
1583	572	c_ru	 станция Генерал Ватутина
1584	572	c_en	 stantsiya Henerala Vatutina
1585	572	c_uk	 станція Генерала Ватутіна
1586	573	c_ru	 Торговый центр
1587	573	c_en	 Torhivelnyi tsentr
1588	573	c_uk	 Торгівельний центр
1589	574	c_ru	 парк Дружбы народов
1590	574	c_en	 park Druzhby narodiv
1591	574	c_uk	 парк Дружби народів
1592	575	c_ru	 пр. Героев Сталинграда
1593	575	c_en	 Heroiv Stalinhradu Ave
1594	575	c_uk	 пр. Героїв Сталінграду
1595	576	c_ru	 ул. Лайоша Гавро
1596	576	c_en	 Layosha Gavro St
1597	576	c_uk	 вул. Лайоша Гавро
1598	577	c_ru	 ст. м. Петровка
1599	577	c_en	 Petrivka
1600	577	c_uk	 ст. м. Петрівка
1601	578	c_ru	 ст. м. Петровка
1602	578	c_en	 Petrivka
1603	578	c_uk	 ст. м. Петрівка
1604	579	c_ru	 Торговий центр
1605	579	c_en	 Torhivelnyi tsentr
1606	579	c_uk	 Торгівельний центр
1607	580	c_ru	 ул. Лайоша Гавро
1608	580	c_en	 Layosha Gavro St
1609	580	c_uk	 вул. Лайоша Гавро
1610	581	c_ru	 супермаркет Домострой
1611	581	c_en	 supermarket Domostroi
1612	581	c_uk	 супермаркет Домострой
1613	582	c_ru	 супермаркет
1614	582	c_en	 supermarket
1615	582	c_uk	 супермаркет
1616	583	c_ru	 пр. Героев Сталинграда
1617	583	c_en	 Heroiv Stalinhradu Ave
1618	583	c_uk	 пр. Героїв Сталінграду
1619	584	c_ru	 парк Дружбы народов
1620	584	c_en	 park Druzhby narodiv
1621	584	c_uk	 парк Дружби народів
1622	585	c_ru	 Торговый центр
1623	585	c_en	 Torhivelnyi tsentr
1624	585	c_uk	 Торгівельний центр
1625	586	c_ru	 станция Генерал Ватутина
1626	586	c_en	 stantsiya Henerala Vatutina
1627	586	c_uk	 станція Генерала Ватутіна
1628	587	c_ru	 массив Радужный
1629	587	c_en	 masyv Raduzhnyi
1630	587	c_uk	 масив Радужний
1631	588	c_ru	 ул. Николая Закревского
1632	588	c_en	 Mykoly Zakrevskoho St
1633	588	c_uk	 вул. Миколи Закревського
1634	589	c_ru	 Универсам
1635	589	c_en	 Universam
1636	589	c_uk	 Універсам
1637	590	c_ru	 микрорайон №3
1638	590	c_en	 mikrorayon nomer try
1639	590	c_uk	 мікрорайон №3
1640	591	c_ru	 ул. Каштановая
1641	591	c_en	 Kashtanova St
1642	591	c_uk	 вул. Каштанова
1643	592	c_ru	 Блок услуг
1644	592	c_en	 Blok poslug
1645	592	c_uk	 Блок послуг
1646	593	c_ru	 ул. Архитектора Николаева
1647	593	c_en	 Architektora Nikolaeva St
1648	593	c_uk	 вул. Архітектора Ніколаєва
1649	594	c_ru	 ул. Александра Сабурова
1650	594	c_en	 Oleksandra Saburova St
1651	594	c_uk	 вул. Олександра Сабурова
1652	595	c_ru	 ул. Константина Данькевича
1653	595	c_en	 Kostyantyna Dankevycha St
1654	595	c_uk	 вул. Костянтина Данкевича
1655	596	c_ru	 ул. Марины Цветаевой
1656	596	c_en	 Matyny Tsvetaevoi St
1657	596	c_uk	 вул. Марини Цвєтаєвої
1658	597	c_ru	 ул. Милославская
1659	597	c_en	 Myloslavska St
1660	597	c_uk	 вул. Милославська
1661	599	c_ru	 ст. м. Лыбедская
1662	599	c_en	 Lybidska 
1663	599	c_uk	 ст. м. Либідська
1664	600	c_ru	 Автовокзал
1665	600	c_en	 Autovokzal
1666	600	c_uk	 Автовокзал
1667	601	c_ru	 пр. Науки
1668	601	c_en	 Nauky Ave
1669	601	c_uk	 пр. Науки
1670	602	c_ru	 Кинотеатр Салют
1671	602	c_en	 Kinoteatr Salut
1672	602	c_uk	 Кінотеатр Салют
1673	603	c_ru	 ул. Павла Грабовского
1674	603	c_en	 Pavla Hrabovskoho St
1675	603	c_uk	 вул. Павла Грабовського
1676	604	c_ru	 Гидрометеорологическая
1677	604	c_en	 Hidrometeolohochna
1678	604	c_uk	 Гідрометеологічна
1679	605	c_ru	 ул. Лысогорская
1680	605	c_en	 Lysohorska St
1681	605	c_uk	 вул. Лисогорська
1682	606	c_ru	 Институт физики
1683	606	c_en	 Instytut phizyky
1684	606	c_uk	 Інститут фізики
1685	607	c_ru	 Багриновая гора
1686	607	c_en	 Bahrinova hora
1687	607	c_uk	 Багрінова гора
1688	608	c_ru	 ул. Маршальская
1689	608	c_en	 Marshalska St
1690	608	c_uk	 вул. Маршальська
1691	609	c_ru	 ул. Китаевская
1692	609	c_en	 Kytaevska St
1693	609	c_uk	 вул. Китаєвська
1694	610	c_ru	 ул. Набережно-Корчеватская
1695	610	c_en	 Naberezhno-Korchuvatska St
1696	610	c_uk	 вул. Набережно-Корчуватська
1697	611	c_ru	 Остановка
1698	611	c_en	 Stop
1699	611	c_uk	 Зупинка
1700	612	c_ru	 Укрпочта
1701	612	c_en	 Ukrposhta
1702	612	c_uk	 Укрпошта
1703	613	c_ru	 Школа
1704	613	c_en	 Shkola
1705	613	c_uk	 Школа
1706	614	c_ru	 ж/м Корчувате
1707	614	c_en	 Korchuvate
1708	614	c_uk	 ж/м Корчувате
1709	615	c_ru	 ж/м Корчувате
1710	615	c_en	 Korchuvate
1711	615	c_uk	 ж/м Корчувате
1712	616	c_ru	 Овощная база
1713	616	c_en	 Ovocheva baza
1714	616	c_uk	 Овочева база
1715	617	c_ru	 Корчеватое 2
1716	617	c_en	 Korchevate 2
1717	617	c_uk	 Корчевате 2
1718	618	c_ru	 Корчеватский КБМ
1719	618	c_en	 Korchevatskyi KBM
1720	618	c_uk	 Корчеватський КБМ
1721	619	c_ru	 ул. Китаевская
1722	619	c_en	 Kytaevska St
1723	619	c_uk	 вул. Китаєвська
1724	620	c_ru	 ул. Маршальская
1725	620	c_en	 Marshalska St
1726	620	c_uk	 вул. Маршальська
1727	621	c_ru	 Багриновая гора
1728	621	c_en	 Bahrinova hora
1729	621	c_uk	 Багрінова гора
1730	622	c_ru	 Институт физики
1731	622	c_en	 Instytut phizyky
1732	622	c_uk	 Інститут фізики
1733	623	c_ru	 ул. Лысогорская
1734	623	c_en	 Lysohorska St
1735	623	c_uk	 вул. Лисогорська
1736	624	c_ru	 Гидрометеорологическая
1737	624	c_en	 Hidrometeolohochna
1738	624	c_uk	 Гідрометеологічна
1739	625	c_ru	 ул. Павла Грабовского
1740	625	c_en	 Pavla Hrabovskoho St
1741	625	c_uk	 вул. Павла Грабовського
1742	626	c_ru	 Кинотеатр Салют
1743	626	c_en	 Kinoteatr Salut
1744	626	c_uk	 Кінотеатр Салют
1745	627	c_ru	 Кондитерская фабрика
1746	627	c_en	 Kondyterska fabryka
1747	627	c_uk	 Кондитерська фабрика
1748	628	c_ru	 Автовокзал
1749	628	c_en	 Autovokzal
1750	628	c_uk	 Автовокзал
1751	629	c_ru	 ст. м. Лыбедская
1752	629	c_en	 Lybidska 
1753	629	c_uk	 ст. м. Либідська
1754	631	c_ru	 ул. Салютная
1755	631	c_en	 Salutna St
1756	631	c_uk	 вул. Салютна
1757	632	c_ru	 ул. Салютная
1758	632	c_en	 Salutna St
1759	632	c_uk	 вул. Салютна
1760	633	c_ru	 ул. Эстонская
1761	633	c_en	 Estonska St
1762	633	c_uk	 вул. Естонська
1763	634	c_ru	 завод 50-летия Октября
1764	634	c_en	 zavod pyatydesyatyrichya Zhovtnya
1765	634	c_uk	 завод 50-річчя Жовтня
1766	635	c_ru	 ст. м. Святошин
1767	635	c_en	 Svyatoshyn
1768	635	c_uk	 ст. м. Святошин
1769	636	c_ru	 ул. Генерала Витрука
1770	636	c_en	 Henerala Vitruka St
1771	636	c_uk	 вул. Генерала Вітрука
1772	637	c_ru	 бул. Академика Вернадского
1773	637	c_en	 Akademika Vernadskoho Blvd
1774	637	c_uk	 бул. Академіка Вернадського
1775	638	c_ru	 ул. Ивана Крамского
1776	638	c_en	 Ivana Kramskoho St
1777	638	c_uk	 вул. Івана Крамського
1778	639	c_ru	 ст. м. Житомирская
1779	639	c_en	 Zhytomyrska
1780	639	c_uk	 ст. м. Житомирська
1781	640	c_ru	 пр. Победы
1782	640	c_en	 Peremohy Ave
1783	640	c_uk	 пр. Перемоги
1784	641	c_ru	 ул. Верховинная
1785	641	c_en	 Verkhovynna St
1786	641	c_uk	 вул. Верховинна
1787	642	c_ru	 Святошинское кладбище
1788	642	c_en	 Svyatoshynske kladovyshe
1789	642	c_uk	 Святошинське кладовище
1790	643	c_ru	 ул. Янтарная
1791	643	c_en	 Yantarna St
1792	643	c_uk	 вул. Янтарна
1793	644	c_ru	 ул. Жмеринская
1794	644	c_en	 Zhmerynska St
1795	644	c_uk	 вул. Жмеринська
1796	645	c_ru	 завод Электронмаш
1797	645	c_en	 zavod Elektronmash
1798	645	c_uk	 завод Електронмаш
1799	646	c_ru	 пр. Леся Курбаса
1800	646	c_en	 Lesya Kurbasa Ave
1801	646	c_uk	 пр. Леся Курбаса
1802	647	c_ru	 Кольцевая дорога
1803	647	c_en	 Kiltseva doroga
1804	647	c_uk	 Кільцева дорога
1805	648	c_ru	 бул. Кольцова
1806	648	c_en	 Koltsova Blvd
1807	648	c_uk	 бул. Кольцова
1808	649	c_ru	 школа №131
1809	649	c_en	 shkola 131
1810	649	c_uk	 школа №131
1811	650	c_ru	 ул. Симиренко
1812	650	c_en	 Symyrenka St
1813	650	c_uk	 вул. Симиренка
1814	651	c_ru	 ул. Симиренко
1815	651	c_en	 Symyrenka St
1816	651	c_uk	 вул. Симиренка
1817	652	c_ru	 школа №131
1818	652	c_en	 shkola 131
1819	652	c_uk	 школа №131
1820	653	c_ru	 ул. Зодчих
1821	653	c_en	 Zodchych St
1822	653	c_uk	 вул. Зодчих
1823	654	c_ru	 пр. Леся Курбаса
1824	654	c_en	 Lesya Kurbasa Ave
1825	654	c_uk	 пр. Леся Курбаса
1826	655	c_ru	 ПО Электронмаш
1827	655	c_en	 Elektronmash
1828	655	c_uk	 ПО Електронмаш
1829	656	c_ru	 ул. Жмеринская
1830	656	c_en	 Zhmerynska St
1831	656	c_uk	 вул. Жмеринська
1832	657	c_ru	 ул. Янтарная
1833	657	c_en	 Yantarna St
1834	657	c_uk	 вул. Янтарна
1835	658	c_ru	 Святошинское кладбище
1836	658	c_en	 Svyatoshynske kladovyshe
1837	658	c_uk	 Святошинське кладовище
1838	659	c_ru	 ул. Верховинная
1839	659	c_en	 Verkhovynna St
1840	659	c_uk	 вул. Верховинна
1841	660	c_ru	 пр. Победы
1842	660	c_en	 Peremohy Ave
1843	660	c_uk	 пр. Перемоги
1844	661	c_ru	 ст. м. Житомирская
1845	661	c_en	 Zhytomyrska
1846	661	c_uk	 ст. м. Житомирська
1847	662	c_ru	 ул. Ивана Крамского
1848	662	c_en	 Ivana Kramskoho St
1849	662	c_uk	 вул. Івана Крамського
1850	663	c_ru	 бул. Академика Вернадского
1851	663	c_en	 Akademika Vernadskoho Blvd
1852	663	c_uk	 бул. Академіка Вернадського
1853	664	c_ru	 ул. Генерала Витрука
1854	664	c_en	 Henerala Vitruka St
1855	664	c_uk	 вул. Генерала Вітрука
1856	665	c_ru	 ст. м. Святошин
1857	665	c_en	 Svyatoshyn
1858	665	c_uk	 ст. м. Святошин
1859	666	c_ru	 ул. Невская
1860	666	c_en	 Nevska St
1861	666	c_uk	 вул. Невська
1862	667	c_ru	 ул. Щербакова
1863	667	c_en	 Sherbakova St
1864	667	c_uk	 вул. Щербакова
1865	668	c_ru	 ул. Салютная
1866	668	c_en	 Salutna St
1867	668	c_uk	 вул. Салютна
1868	670	c_ru	 Музей Истории Великой Отечественной войны
1869	670	c_en	 Muzey Istorii Velykoi Vitchyznyanoi viyny
1971	706	c_en	 Klovskyi descent
1870	670	c_uk	 Музей Історії Великої Вітчизняної війни
1871	671	c_ru	 Киево-Печерский заповедник
1872	671	c_en	 Kyevo-Pecherskyi zapovidnyk
1873	671	c_uk	 Києво-Печерський заповідник
1874	672	c_ru	 площадь Славы
1875	672	c_en	 plosha Slavy
1876	672	c_uk	 площа Слави
1877	673	c_ru	 площадь Арсенальная
1878	673	c_en	 plosha Arsenalna
1879	673	c_uk	 площа Арсенальна
1880	674	c_ru	 пер. Крепостной
1881	674	c_en	 Krepostnyi Ln
1882	674	c_uk	 пров. Крепостний
1883	675	c_ru	 ул. Садовая
1884	675	c_en	 Sadova St
1885	675	c_uk	 вул. Садова
1886	676	c_ru	 Европейская площадь
1887	676	c_en	 Evropeyska square
1888	676	c_uk	 Євпропейська площа
1889	677	c_ru	 Гостиница Крещатик
1890	677	c_en	 Hotel Khreshchatyk
1891	677	c_uk	 Готель Хрещатик
1892	678	c_ru	 ул. Архитектора Городецкого
1893	678	c_en	 Arkhitektora Horodetskoho St
1894	678	c_uk	 вул. Архітектора Городецького
1895	679	c_ru	 ул. Крещатик
1896	679	c_en	 Khreshatyk St
1897	679	c_uk	 вул. Хрещатик
1898	680	c_ru	 ст. м. Льва Толстого
1899	680	c_en	 Lwa Tolstoho
1900	680	c_uk	 ст. м. Льва Толстого
1901	681	c_ru	 площадь Бессарабская
1902	681	c_en	 Bessarabska square
1903	681	c_uk	 площа Бессарабська
1904	682	c_ru	 Центральный универмаг
1905	682	c_en	 Tsentralnyi univermah
1906	682	c_uk	 Центральний універмаг
1907	683	c_ru	 ул. Архитектора Городецкого
1908	683	c_en	 Arkhitektora Horodetskoho St
1909	683	c_uk	 вул. Архітектора Городецького
1910	684	c_ru	 Европейская площадь
1911	684	c_en	 Evropeyska square
1912	684	c_uk	 Євпропейська площа
1913	685	c_ru	 ул. Грушевского
1914	685	c_en	 Hrushevskoho St
1915	685	c_uk	 вул. Грушевського
1916	686	c_ru	 ул. Садовая
1917	686	c_en	 Sadova St
1918	686	c_uk	 вул. Садова
1919	687	c_ru	 пер. Крепостной
1920	687	c_en	 Krepostnyi Ln
1921	687	c_uk	 пров. Крепостний
1922	688	c_ru	 площадь Арсенальная
1923	688	c_en	 plosha Arsenalna
1924	688	c_uk	 площа Арсенальна
1925	689	c_ru	 площадь Славы
1926	689	c_en	 plosha Slavy
1927	689	c_uk	 площа Слави
1928	690	c_ru	 Киево-Печерский заповедник
1929	690	c_en	 Kyevo-Pecherskyi zapovidnyk
1930	690	c_uk	 Києво-Печерський заповідник
1931	691	c_ru	 Музей Истории Великой Отечественной войны
1932	691	c_en	 Muzey Istorii Velykoi Vitchyznyanoi viyny
1933	691	c_uk	 Музей Історії Великої Вітчизняної війни
1934	693	c_ru	 с. Пирогов
1935	693	c_en	 Pirihov
1936	693	c_uk	 с. Пірогов
1937	694	c_ru	 АТП-1007
1938	694	c_en	 ATP-1007
1939	694	c_uk	 АТП-1007
1940	695	c_ru	 завод Славутич
1941	695	c_en	 zavod Slavutych
1942	695	c_uk	 завод Славутич
1943	696	c_ru	 ул. Краснознаменная
1944	696	c_en	 Chervonoznamenna St
1945	696	c_uk	 вул. Червонознаменна
1946	697	c_ru	 завод ЖБК
1947	697	c_en	 zavod ZBK
1948	697	c_uk	 завод ЗБК
1950	698	c_en	 zavod ZBK
1951	698	c_uk	 завод ЗБК
1952	699	c_ru	 ул. Краснознаменная
1953	699	c_en	 Chervonoznamenna St
1954	699	c_uk	 вул. Червонознаменна
1955	700	c_ru	 завод Славутич
1956	700	c_en	 zavod Slavutych
1957	700	c_uk	 завод Славутич
1958	701	c_ru	 АТП-1007
1959	701	c_en	 ATP-1007
1960	701	c_uk	 АТП-1007
1961	702	c_ru	 с. Пирогов
1962	702	c_en	 Pirihov
1963	702	c_uk	 с. Пірогов
1964	704	c_ru	 ул. Мечникова
1965	704	c_en	 Mechnikova St
1966	704	c_uk	 вул. Мечнікова
1967	705	c_ru	 ст. м. Кловская
1968	705	c_en	 Klovska
1969	705	c_uk	 ст. м. Кловська
1970	706	c_ru	 спуск Кловский
1972	706	c_uk	 узвіз Кловський
1973	707	c_ru	 пер. Крепостной
1974	707	c_en	 Krepostnyi Ln
1975	707	c_uk	 пров. Крепостний
1976	708	c_ru	 завод Арсенал
1977	708	c_en	 zavod Arsenal
1978	708	c_uk	 завод Арсенал
1979	709	c_ru	 кинотеатр Зоряный
1980	709	c_en	 kinoteatr Zoryanyi
1981	709	c_uk	 кінотеатр Зоряний
1982	710	c_ru	 ул. Панаса Мирного
1983	710	c_en	 Panasa Myrnoho St
1984	710	c_uk	 вул. Панаса Мирного
1985	711	c_ru	 ул. Кутузова
1986	711	c_en	 Kutuzova St
1987	711	c_uk	 вул. Кутузова
1988	712	c_ru	 Водоканал
1989	712	c_en	 Vodokanal
1990	712	c_uk	 Водоканал
1991	713	c_ru	 пер. Редутный
1992	713	c_en	 Redutnyi Ln
1993	713	c_uk	 пров. Редутний
1994	714	c_ru	 мост им. Патона
1995	714	c_en	 most Patona
1996	714	c_uk	 мост ім. Патона
1997	715	c_ru	 Русанкова
1998	715	c_en	 Rusanivka
1999	715	c_uk	 Русанівка
2000	716	c_ru	 бульвар А. Давыдова
2001	716	c_en	 Davydoba Blvd
2002	716	c_uk	 бульвар О. Давидова
2003	717	c_ru	 Березняки
2004	717	c_en	 Bereznyaky
2005	717	c_uk	 Березняки
2006	718	c_ru	 ул. Тампере
2007	718	c_en	 Tampere St
2008	718	c_uk	 вул. Тампере
2009	719	c_ru	 завод Вулкан
2010	719	c_en	 zavod Vulkan
2011	719	c_uk	 завод Вулкан
2012	720	c_ru	 универмаг Дарницкий
2013	720	c_en	 univermah Darnytskyi
2014	720	c_uk	 універмаг Дарницький
2015	721	c_ru	 универмаг Дарницкий
2016	721	c_en	 univermah Darnytskyi
2017	721	c_uk	 універмаг Дарницький
2018	722	c_ru	 завод Вулкан
2019	722	c_en	 zavod Vulkan
2020	722	c_uk	 завод Вулкан
2021	723	c_ru	 ул. Тампере
2022	723	c_en	 Tampere St
2023	723	c_uk	 вул. Тампере
2024	724	c_ru	 Березняки
2025	724	c_en	 Bereznyaky
2026	724	c_uk	 Березняки
2027	725	c_ru	 бульвар А. Давыдова
2028	725	c_en	 Davydoba Blvd
2029	725	c_uk	 бульвар О. Давидова
2030	726	c_ru	 Русанкова
2031	726	c_en	 Rusanivka
2032	726	c_uk	 Русанівка
2033	727	c_ru	 мост им. Патона
2034	727	c_en	 most Patona
2035	727	c_uk	 мост ім. Патона
2036	728	c_ru	 ул. Старонаводницкая
2037	728	c_en	 Staronavodnytska St
2038	728	c_uk	 вул. Старонаводницька
2039	729	c_ru	 пер. Редутный
2040	729	c_en	 Redutnyi Ln
2041	729	c_uk	 пров. Редутний
2042	730	c_ru	 Водоканал
2043	730	c_en	 Vodokanal
2044	730	c_uk	 Водоканал
2045	731	c_ru	 ул. Кутузова
2046	731	c_en	 Kutuzova St
2047	731	c_uk	 вул. Кутузова
2048	732	c_ru	 ул. Панаса Мирного
2049	732	c_en	 Panasa Myrnoho St
2050	732	c_uk	 вул. Панаса Мирного
2051	733	c_ru	 ул. Суворова
2052	733	c_en	 Suvorova St
2053	733	c_uk	 вул. Суворова
2054	734	c_ru	 площадь Славы
2055	734	c_en	 plosha Slavy
2056	734	c_uk	 площа Слави
2057	735	c_ru	 пер. Крепостной
2058	735	c_en	 Krepostnyi Ln
2059	735	c_uk	 пров. Крепостний
2060	736	c_ru	 спуск Кловский
2061	736	c_en	 Klovskyi descent
2062	736	c_uk	 узвіз Кловський
2063	737	c_ru	 ст. м. Кловская
2064	737	c_en	 Klovska
2065	737	c_uk	 ст. м. Кловська
2066	738	c_ru	 ул. Мечникова
2067	738	c_en	 Mechnikova St
2068	738	c_uk	 вул. Мечнікова
2069	740	c_ru	 ст. м. Академгородок
2070	740	c_en	 Akademmistechko
2071	740	c_uk	 ст. м. Академмістечко
2072	741	c_ru	 ул. Литвиненко-Вольгемут
2073	741	c_en	 Lytvynenka-Volhemut St
2074	741	c_uk	 вул. Литвиненка-Вольгемут
2075	742	c_ru	 автосалон Тойота
2076	742	c_en	 Toyota autosalon
2077	742	c_uk	 автосалон Тойота
2078	743	c_ru	 Южная Борщаговка
2079	743	c_en	 Pivdenna Borshahivka
2080	743	c_uk	 Південна Борщагівка
2081	744	c_ru	 Совхоз Совки
2082	744	c_en	 Rodhosp Sovki
2083	744	c_uk	 Радгосп Совкі
2084	745	c_ru	 Путепровод
2085	745	c_en	 Shlyahoprovid
2086	745	c_uk	 Шляхопровід
2087	746	c_ru	 ул. Ватутина
2088	746	c_en	 Vatutina St
2089	746	c_uk	 вул. Ватутіна
2090	747	c_ru	 село Жуляны-2
2091	747	c_en	 Zhulyany-2
2092	747	c_uk	 село Жуляни-2
2093	748	c_ru	 село Жуляны-1
2094	748	c_en	 Zhulyany-1
2095	748	c_uk	 село Жуляни-1
2096	749	c_ru	 ул. Лятошинского
2097	749	c_en	 Lyatoshynskoho St
2098	749	c_uk	 вул. Лятошинського
2099	750	c_ru	 Массив Теремки-1
2100	750	c_en	 Masyv Teremky-1
2101	750	c_uk	 Масив Теремки-1
2102	751	c_ru	 площадь Одесская
2103	751	c_en	 plosha Odeska
2104	751	c_uk	 площа Одеська
2105	752	c_ru	 площадь Одесская
2106	752	c_en	 plosha Odeska
2107	752	c_uk	 площа Одеська
2108	753	c_ru	 Ледовый стадион
2109	753	c_en	 Lodovyi stadion
2110	753	c_uk	 Льодовий стадіон
2111	754	c_ru	 Автостанция Южная
2112	754	c_en	 Autostantsia Pivdena
2113	754	c_uk	 Автостанція Південна
2114	755	c_ru	 Ледовый стадион
2115	755	c_en	 Lodovyi stadion
2116	755	c_uk	 Льодовий стадіон
2117	756	c_ru	 площадь Одесская
2118	756	c_en	 plosha Odeska
2119	756	c_uk	 площа Одеська
2120	757	c_ru	 Массив Теремки-1
2121	757	c_en	 Masyv Teremky-1
2122	757	c_uk	 Масив Теремки-1
2123	758	c_ru	 ул. Лятошинского
2124	758	c_en	 Lyatoshynskoho St
2125	758	c_uk	 вул. Лятошинського
2126	759	c_ru	 село Жуляны-1
2127	759	c_en	 Zhulyany-1
2128	759	c_uk	 село Жуляни-1
2129	760	c_ru	 село Жуляны-2
2130	760	c_en	 Zhulyany-2
2131	760	c_uk	 село Жуляни-2
2132	761	c_ru	 ул. Ватутина
2133	761	c_en	 Vatutina St
2134	761	c_uk	 вул. Ватутіна
2135	762	c_ru	 Путепровод
2136	762	c_en	 Shlyahoprovid
2137	762	c_uk	 Шляхопровід
2138	763	c_ru	 Совхоз Совки
2139	763	c_en	 Rodhosp Sovki
2140	763	c_uk	 Радгосп Совкі
2141	764	c_ru	 Южная Борщаговка
2142	764	c_en	 Pivdenna Borshahivka
2143	764	c_uk	 Південна Борщагівка
2144	765	c_ru	 автосалон Тойота
2145	765	c_en	 Toyota autosalon
2146	765	c_uk	 автосалон Тойота
2147	766	c_ru	 ул. Литвиненко-Вольгемут
2148	766	c_en	 Lytvynenka-Volhemut St
2149	766	c_uk	 вул. Литвиненка-Вольгемут
2150	767	c_ru	 пр. Победы
2151	767	c_en	 Peremohy Ave
2152	767	c_uk	 пр. Перемоги
2153	768	c_ru	 ст. м. Академгородок
2154	768	c_en	 Akademmistechko
2155	768	c_uk	 ст. м. Академмістечко
2156	770	c_ru	 Пуща-Водица
2157	770	c_en	 Pushya-Vodytsya
2158	770	c_uk	 Пуща-Водиця
2159	771	c_ru	 7-ая линия
2160	771	c_en	 Soma liniya
2161	771	c_uk	 7-ма лінія
2162	772	c_ru	 ул. Юнкерова
2163	772	c_en	 Unkerova St
2164	772	c_uk	 вул. Юнкерова
2165	773	c_ru	 Школа интернат
2166	773	c_en	 Shkola internat
2167	773	c_uk	 Школа інтернат
2168	774	c_ru	 Госпиталь
2169	774	c_en	 Shpital
2170	774	c_uk	 Шпіталь
2171	775	c_ru	 3-я линия
2172	775	c_en	 Tretya liniya
2173	775	c_uk	 3-я лінія
2174	776	c_ru	 2-я линия
2175	776	c_en	 Druha liniya
2176	776	c_uk	 2-га лінія
2177	777	c_ru	 1-я линия
2178	777	c_en	 Persha liniya
2179	777	c_uk	 1-ша лінія
2180	778	c_ru	 ул. Городская
2181	778	c_en	 Horodska St
2182	778	c_uk	 вул. Городська
2183	779	c_ru	 дорога на Гостомель
2184	779	c_en	 doroha na Hostomel
2185	779	c_uk	 дорога на Гостомель
2186	780	c_ru	 ул. Генерала Наумова
2187	780	c_en	 Henerala Naumova St
2188	780	c_uk	 вул. Генерала Наумова
2189	781	c_ru	 Нефтяник
2190	781	c_en	 Neftyanyk
2191	781	c_uk	 Нефтяник
2192	782	c_ru	 ст. м. Академгородок
2193	782	c_en	 Akademmistechko
2194	782	c_uk	 ст. м. Академмістечко
2195	783	c_ru	 ст. м. Академгородок
2196	783	c_en	 Akademmistechko
2197	783	c_uk	 ст. м. Академмістечко
2198	784	c_ru	 Нефтяник
2199	784	c_en	 Neftyanyk
2200	784	c_uk	 Нефтяник
2201	785	c_ru	 ул. Генерала Наумова
2202	785	c_en	 Henerala Naumova St
2203	785	c_uk	 вул. Генерала Наумова
2204	786	c_ru	 дорога на Гостомель
2205	786	c_en	 doroha na Hostomel
2206	786	c_uk	 дорога на Гостомель
2207	787	c_ru	 ул. Городская
2208	787	c_en	 Horodska St
2209	787	c_uk	 вул. Городська
2210	788	c_ru	 Радиологический центр
2211	788	c_en	 Radiolohochnyi tsentr
2212	788	c_uk	 Радіологічний центр
2213	789	c_ru	 санаторий Лесная поляна
2214	789	c_en	 sanatoriy Lisna polyana
2215	789	c_uk	 санаторій Лісна поляна
2216	790	c_ru	 Радиологический центр
2217	790	c_en	 Radiolohochnyi tsentr
2218	790	c_uk	 Радіологічний центр
2219	791	c_ru	 7-ая линия
2220	791	c_en	 Soma liniya
2221	791	c_uk	 7-ма лінія
2222	792	c_ru	 Детский сад
2223	792	c_en	 Dytyachyi sadok
2224	792	c_uk	 Дитячий садок
2225	793	c_ru	 Пуща-Водица
2226	793	c_en	 Pushya-Vodytsya
2227	793	c_uk	 Пуща-Водиця
\.


--
-- Data for Name: timetable; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY timetable (id, schedule_group_id, time_a, time_b, frequency) FROM stdin;
1	1	06:00:00	22:00:00	00:05:00
2	2	06:00:00	22:00:00	00:05:00
3	3	06:00:00	22:00:00	00:05:00
4	4	06:00:00	22:00:00	00:05:00
5	5	06:00:00	22:00:00	00:05:00
6	6	06:00:00	22:00:00	00:05:00
7	7	06:00:00	22:00:00	00:05:00
8	8	06:00:00	22:00:00	00:05:00
43	43	06:01:00	23:00:00	00:19:00
44	44	06:01:00	23:00:00	00:19:00
47	47	06:01:00	23:00:00	01:16:00
48	48	06:01:00	23:00:00	01:16:00
49	49	07:33:00	20:30:00	01:37:00
50	50	07:33:00	20:30:00	01:37:00
51	51	07:00:00	19:15:00	00:30:00
52	52	07:00:00	19:15:00	00:30:00
53	53	06:01:00	23:00:00	00:30:00
54	54	06:01:00	23:00:00	00:30:00
55	55	05:53:00	19:08:00	00:49:00
56	56	05:53:00	19:08:00	00:49:00
57	57	06:19:00	22:23:00	00:18:00
58	58	06:19:00	22:23:00	00:18:00
59	59	06:53:00	20:57:00	00:25:00
60	60	06:53:00	20:57:00	00:25:00
61	61	06:43:00	20:37:00	00:22:00
62	62	06:43:00	20:37:00	00:22:00
63	63	06:19:00	22:23:00	00:18:00
64	64	06:19:00	22:23:00	00:18:00
65	65	06:53:00	20:57:00	00:25:00
66	66	06:53:00	20:57:00	00:25:00
67	67	06:43:00	20:37:00	00:22:00
68	68	06:43:00	20:37:00	00:22:00
69	69	07:12:00	17:01:00	00:22:00
70	70	07:12:00	17:01:00	00:22:00
71	71	06:20:00	22:25:00	00:07:00
72	72	06:20:00	22:25:00	00:07:00
73	73	06:20:00	22:05:00	00:10:00
74	74	06:20:00	22:05:00	00:10:00
75	75	06:06:00	07:00:00	00:08:00
76	75	07:00:00	11:00:00	00:05:00
77	75	11:00:00	16:00:00	00:08:00
78	75	16:00:00	19:00:00	00:05:00
79	75	19:00:00	21:51:00	00:08:00
80	76	06:06:00	07:00:00	00:08:00
81	76	07:00:00	11:00:00	00:05:00
82	76	11:00:00	16:00:00	00:08:00
83	76	16:00:00	19:00:00	00:05:00
84	76	19:00:00	21:51:00	00:08:00
85	77	07:52:00	18:56:00	00:11:00
86	78	07:52:00	18:56:00	00:11:00
87	79	06:11:00	22:19:00	00:20:00
88	80	06:11:00	22:19:00	00:20:00
99	83	06:44:00	21:16:00	00:18:00
100	84	06:44:00	21:16:00	00:18:00
101	85	06:15:00	20:36:00	00:20:00
102	86	06:15:00	20:36:00	00:20:00
103	87	06:40:00	07:00:00	00:11:00
104	87	07:00:00	11:00:00	00:06:00
105	87	11:00:00	16:00:00	00:11:00
106	87	16:00:00	19:00:00	00:06:00
107	87	19:00:00	21:17:00	00:11:00
108	88	06:40:00	07:00:00	00:11:00
109	88	07:00:00	11:00:00	00:06:00
110	88	11:00:00	16:00:00	00:11:00
111	88	16:00:00	19:00:00	00:06:00
112	88	19:00:00	21:17:00	00:11:00
\.


--
-- Data for Name: transport_types; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY transport_types (id, ev_speed) FROM stdin;
c_metro	44
c_bus	50
c_tram	48
c_trolley	45
c_foot	5
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY user_roles (id, name) FROM stdin;
1	admin
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: bus; Owner: postgres
--

COPY users (id, role_id, login, password) FROM stdin;
1	1	roma	14R199009
2	1	marianna	14R199009
\.


--
-- Name: city_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT city_pk PRIMARY KEY (id);


--
-- Name: direct_routes_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY direct_routes
    ADD CONSTRAINT direct_routes_pk PRIMARY KEY (id);


--
-- Name: direct_routes_unique; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY direct_routes
    ADD CONSTRAINT direct_routes_unique UNIQUE (route_id, direct);


--
-- Name: discount_by_route_type_id_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY discount_by_route_types
    ADD CONSTRAINT discount_by_route_type_id_pk PRIMARY KEY (discount_id, route_type_id);


--
-- Name: discounts_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY discounts
    ADD CONSTRAINT discounts_pk PRIMARY KEY (id);


--
-- Name: graph_relations_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY graph_relations
    ADD CONSTRAINT graph_relations_pk PRIMARY KEY (id);


--
-- Name: import_objectss_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY import_objects
    ADD CONSTRAINT import_objectss_pk PRIMARY KEY (id);


--
-- Name: languages_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pk PRIMARY KEY (id);


--
-- Name: node_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT node_pk PRIMARY KEY (id);


--
-- Name: route_relations_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY route_relations
    ADD CONSTRAINT route_relations_pk PRIMARY KEY (id);


--
-- Name: route_type_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY route_types
    ADD CONSTRAINT route_type_pk PRIMARY KEY (id);


--
-- Name: routes_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT routes_pk PRIMARY KEY (id);


--
-- Name: schedule_group_days_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedule_group_days
    ADD CONSTRAINT schedule_group_days_pk PRIMARY KEY (id);


--
-- Name: schedule_groups_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedule_groups
    ADD CONSTRAINT schedule_groups_pk PRIMARY KEY (id);


--
-- Name: schedule_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedule_pk PRIMARY KEY (id);


--
-- Name: station_transport_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY station_transports
    ADD CONSTRAINT station_transport_pk PRIMARY KEY (station_id, transport_type_id);


--
-- Name: string_keys_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY string_keys
    ADD CONSTRAINT string_keys_pk PRIMARY KEY (id);


--
-- Name: string_values_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY string_values
    ADD CONSTRAINT string_values_pk PRIMARY KEY (id);


--
-- Name: timetable_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY timetable
    ADD CONSTRAINT timetable_pk PRIMARY KEY (id);


--
-- Name: transport_type_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transport_types
    ADD CONSTRAINT transport_type_pk PRIMARY KEY (id);


--
-- Name: user_id_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_id_pk PRIMARY KEY (id);


--
-- Name: user_role_id_pk; Type: CONSTRAINT; Schema: bus; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_role_id_pk PRIMARY KEY (id);


--
-- Name: city_createname_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER city_createname_key_trigger BEFORE INSERT ON cities FOR EACH ROW EXECUTE PROCEDURE create_name_key();


--
-- Name: city_delete_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER city_delete_trigger BEFORE DELETE ON cities FOR EACH ROW EXECUTE PROCEDURE on_delete_city();


--
-- Name: city_deletename_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER city_deletename_key_trigger AFTER DELETE ON cities FOR EACH ROW EXECUTE PROCEDURE delete_name_key();


--
-- Name: city_insert_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER city_insert_trigger AFTER INSERT ON cities FOR EACH ROW EXECUTE PROCEDURE on_insert_city();


--
-- Name: discount_createname_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER discount_createname_key_trigger BEFORE INSERT ON discounts FOR EACH ROW EXECUTE PROCEDURE create_name_key();


--
-- Name: discount_deletename_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER discount_deletename_key_trigger AFTER DELETE ON discounts FOR EACH ROW EXECUTE PROCEDURE delete_name_key();


--
-- Name: route_createname_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER route_createname_key_trigger BEFORE INSERT ON routes FOR EACH ROW EXECUTE PROCEDURE create_name_key();


--
-- Name: route_deletename_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER route_deletename_key_trigger AFTER DELETE ON routes FOR EACH ROW EXECUTE PROCEDURE delete_name_key();


--
-- Name: station_createname_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER station_createname_key_trigger BEFORE INSERT ON stations FOR EACH ROW EXECUTE PROCEDURE create_name_key();


--
-- Name: station_deletename_key_trigger; Type: TRIGGER; Schema: bus; Owner: postgres
--

CREATE TRIGGER station_deletename_key_trigger AFTER DELETE ON stations FOR EACH ROW EXECUTE PROCEDURE delete_name_key();


--
-- Name: city_name_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT city_name_fk FOREIGN KEY (name_key) REFERENCES string_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: direct_route_routeid_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY direct_routes
    ADD CONSTRAINT direct_route_routeid_fk FOREIGN KEY (route_id) REFERENCES routes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: discount_name_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY discounts
    ADD CONSTRAINT discount_name_fk FOREIGN KEY (name_key) REFERENCES string_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: discount_tr_disid_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY discount_by_route_types
    ADD CONSTRAINT discount_tr_disid_fk FOREIGN KEY (discount_id) REFERENCES discounts(id);


--
-- Name: discount_tr_trid_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY discount_by_route_types
    ADD CONSTRAINT discount_tr_trid_fk FOREIGN KEY (route_type_id) REFERENCES route_types(id);


--
-- Name: graph_relations_city_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY graph_relations
    ADD CONSTRAINT graph_relations_city_id_fk FOREIGN KEY (city_id) REFERENCES cities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: graph_relations_relation_a_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY graph_relations
    ADD CONSTRAINT graph_relations_relation_a_id_fk FOREIGN KEY (relation_a_id) REFERENCES route_relations(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: graph_relations_relation_b_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY graph_relations
    ADD CONSTRAINT graph_relations_relation_b_id_fk FOREIGN KEY (relation_b_id) REFERENCES route_relations(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: import_objects_city_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY import_objects
    ADD CONSTRAINT import_objects_city_id_fk FOREIGN KEY (city_id) REFERENCES cities(id) ON UPDATE CASCADE;


--
-- Name: key_string_values_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY string_values
    ADD CONSTRAINT key_string_values_fk FOREIGN KEY (key_id) REFERENCES string_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lang_string_values_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY string_values
    ADD CONSTRAINT lang_string_values_fk FOREIGN KEY (lang_id) REFERENCES languages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: node_city_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT node_city_id_fk FOREIGN KEY (city_id) REFERENCES cities(id);


--
-- Name: node_name_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT node_name_fk FOREIGN KEY (name_key) REFERENCES string_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: route_city_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT route_city_id_fk FOREIGN KEY (city_id) REFERENCES cities(id);


--
-- Name: route_name_key_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT route_name_key_fk FOREIGN KEY (name_key) REFERENCES string_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: route_relations_directroute_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY route_relations
    ADD CONSTRAINT route_relations_directroute_id_fk FOREIGN KEY (direct_route_id) REFERENCES direct_routes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: route_relations_station_a_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY route_relations
    ADD CONSTRAINT route_relations_station_a_id_fk FOREIGN KEY (station_a_id) REFERENCES stations(id);


--
-- Name: route_relations_station_b_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY route_relations
    ADD CONSTRAINT route_relations_station_b_id_fk FOREIGN KEY (station_b_id) REFERENCES stations(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: route_type_transporttype_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY route_types
    ADD CONSTRAINT route_type_transporttype_fk FOREIGN KEY (transport_id) REFERENCES transport_types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: schedule_directroute_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedule_directroute_id_fk FOREIGN KEY (direct_route_id) REFERENCES direct_routes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: schedule_group_days_schedule_group_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule_group_days
    ADD CONSTRAINT schedule_group_days_schedule_group_id_fk FOREIGN KEY (schedule_group_id) REFERENCES schedule_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: schedule_groups_schedule_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY schedule_groups
    ADD CONSTRAINT schedule_groups_schedule_id_fk FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: station_trasnport_nid_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY station_transports
    ADD CONSTRAINT station_trasnport_nid_fk FOREIGN KEY (station_id) REFERENCES stations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: station_trasnport_ttid_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY station_transports
    ADD CONSTRAINT station_trasnport_ttid_fk FOREIGN KEY (transport_type_id) REFERENCES transport_types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: timetable_schedule_group_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY timetable
    ADD CONSTRAINT timetable_schedule_group_id_fk FOREIGN KEY (schedule_group_id) REFERENCES schedule_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_role_id_fk; Type: FK CONSTRAINT; Schema: bus; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_role_id_fk FOREIGN KEY (role_id) REFERENCES user_roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


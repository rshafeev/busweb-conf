--===============================================================================================================
  
CREATE OR REPLACE FUNCTION bus.get_relation_input_id(_city_id bigint)
RETURNS integer AS
$BODY$
DECLARE
  _relation_input_id bigint;
BEGIN
 SELECT bus.route_relations.id INTO _relation_input_id FROM bus.routes 
	 JOIN bus.direct_routes   ON bus.direct_routes.route_id = bus.routes.id
	 JOIN bus.route_relations ON bus.route_relations.direct_route_id = bus.direct_routes.id
 WHERE route_type_id=bus.route_type_enum('c_route_station_input') and city_id = _city_id;

 return _relation_input_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
--=================================================================================================

CREATE OR REPLACE FUNCTION bus.drop_functions()
RETURNS void AS
$BODY$
DECLARE
 --DROP TYPE bus.markers;
 --DROP TYPE bus.short_path;
BEGIN
   DROP FUNCTION bus.init_system_data();
   DROP FUNCTION bus.insert_user_role( character);
   DROP FUNCTION bus.insert_user(bigint,character, character);
   DROP FUNCTION bus.insert_user(character,character, character);
   DROP FUNCTION bus.authenticate(character,character, character);
   DROP FUNCTION bus.get_city_id (lang_enum, text);
   DROP FUNCTION bus.get_discount_id (lang_enum, text);

   DROP FUNCTION bus.find_nearest_stations(geometry,bigint,bus.transport_type_enum[],double precision);
   DROP FUNCTION bus.data_clear();
  /* DROP FUNCTION bus.shortest_ways(  	bigint,
 		geometry,
						 		geometry,
						 	day_enum,
						  	time without time zone,
					         	double precision,
					         	bus.transport_type_enum[],
					            bigint);*/
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;			

--=================================================================================================

CREATE OR REPLACE FUNCTION bus.init_system_data()
RETURNS  void AS
$BODY$
DECLARE
  _discount bus.discounts%ROWTYPE;
BEGIN
--============== system data=======================
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_metro',44);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_bus',50);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_tram',48);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_trolley',45);
INSERT INTO bus.transport_types (id,ev_speed) VALUES ('c_foot',5);

INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_metro','c_metro');
INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_metro_transition','c_foot');
INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_trolley','c_trolley');
INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_bus','c_bus');
INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_tram','c_tram');
INSERT INTO bus.route_types (id,transport_id) VALUES ('c_route_foot','c_foot');


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
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),0.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_bus'),1);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_trolley'),0.5);

--========================================================
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
--====================================================================================================================	
CREATE OR REPLACE FUNCTION bus.get_city_id (_lang lang_enum, _name text)
RETURNS  bigint AS
$BODY$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT * INTO _id FROM bus.cities JOIN bus.string_values ON bus.string_values.key_id = bus.cities.name_key
    WHERE value = _name AND lang_id = _lang;
    
  RETURN  _id;
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
--====================================================================================================================	
CREATE OR REPLACE FUNCTION bus.get_discount_id (_lang lang_enum, _name text)
RETURNS  bigint AS
$BODY$
DECLARE
 _id bigint;

BEGIN
--bus.cities.id INTO _id
  SELECT bus.discounts .id INTO _id FROM bus.discounts JOIN bus.string_values ON bus.string_values.key_id = bus.discounts.name_key
    WHERE value = _name AND lang_id = _lang;
  RETURN  _id;
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--====================================================================================================================	
-- function returns sql-array of route_relation_id indexes
CREATE OR REPLACE FUNCTION bus.find_nearest_stations(
   _location geography,
   _city_id  bigint,
   _transports bus.transport_type_enum[],
   max_distance double precision
)
RETURNS SETOF integer AS
$BODY$
DECLARE
  _relation_id integer;
BEGIN
    FOR _relation_id IN SELECT bus.route_relations.id FROM bus.route_relations
                   JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                   JOIN bus.station_transports ON bus.station_transports.station_id = bus.stations.id
                   WHERE city_id = _city_id AND 
                         st_distance(location,_location) < max_distance AND 
                         transport_type_id =  ANY(_transports)
    LOOP
         RETURN NEXT _relation_id;
   END LOOP;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  
/*

CREATE OR REPLACE FUNCTION bus.find_shortest_ways(
									city_id  bigint,
									p1 geometry,
									p2 geometry,
									v_day_id day_enum,
									time_start  time without time zone,
									max_distance double precision)
RETURNS SETOF bus.way AS
$BODY$
DECLARE
  role_id bigint;
BEGIN
  INSERT INTO bus.user_roles (name)  VALUES(role_name) RETURNING id INTO role_id;
  RETURN role_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  */
/*
CREATE OR REPLACE FUNCTION bus.find_shortest_way( 
							v_stationA_id        bigint,
 						    v_stationB_id        bigint,
 						    v_day_id             day_enum,
 						    time_start           time without time zone)
RETURNS SETOF bus.way AS
$BODY$
DECLARE
  role_id bigint;
BEGIN
  INSERT INTO bus.user_roles (name)  VALUES(role_name) RETURNING id INTO role_id;
  RETURN role_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
*/

 
--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.insert_user_role(role_name character)
RETURNS bigint AS
$BODY$
DECLARE
  role_id bigint;
BEGIN
  INSERT INTO bus.user_roles (name)  VALUES(role_name) RETURNING id INTO role_id;
  RETURN role_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.insert_user(role_id bigint,login character, password character)
RETURNS bigint AS
$BODY$
DECLARE
 user_id bigint;
BEGIN
  INSERT INTO bus.users (role_id,login,password)  VALUES(role_id,login,password) RETURNING id INTO user_id;
  RETURN user_id;
END;
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--=============================

CREATE OR REPLACE FUNCTION bus.insert_user(role_name character,login character, password character)
RETURNS bigint AS
$BODY$
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
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================

-- return 0 : ok
-- return 1 : invalid role
-- return 2 : invalid login
-- return 3 : invalid password

CREATE OR REPLACE FUNCTION bus.authenticate(role_name character,v_login character, v_password character)
RETURNS bigint AS
$BODY$
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
$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;	

--====================================================================================================================
CREATE OR REPLACE FUNCTION bus.data_clear()
RETURNS void AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
  
 --====================================================================================================================	
 
 CREATE OR REPLACE FUNCTION enum_del(enum_name character varying, enum_elem character varying, enum_schema character varying DEFAULT 'public'::character varying)
  RETURNS void AS
$BODY$
DECLARE
    type_oid INTEGER;
    rec RECORD;
    sql VARCHAR;
    ret INTEGER;
    schemaoid INTEGER;
BEGIN
    SELECT oid INTO schemaoid FROM pg_namespace WHERE nspname = enum_schema;
    IF NOT FOUND THEN
    RAISE EXCEPTION 'Could not find schema ''%''', enum_schema;
    END IF;
    SELECT pg_type.oid
    FROM pg_type
    WHERE typtype = 'e' AND typname = enum_name AND typnamespace = schemaoid
    INTO type_oid;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cannot find a enum: %', enum_name;
    END IF;
    -- Check column DEFAULT value references.
    SELECT *
    FROM
        pg_attrdef
        JOIN pg_attribute ON attnum = adnum AND atttypid = type_oid
        JOIN pg_class ON pg_class.oid = attrelid
        JOIN pg_namespace ON pg_namespace.oid = relnamespace
    WHERE
        adsrc = quote_literal(enum_elem) || '::' || quote_ident(enum_name)
    LIMIT 1
    INTO rec;
    IF FOUND THEN
        RAISE EXCEPTION
            'Cannot delete the ENUM element %.%: column %.%.% has DEFAULT value of ''%''',
            quote_ident(enum_name), quote_ident(enum_elem),
            quote_ident(rec.nspname), quote_ident(rec.relname),
            rec.attname, quote_ident(enum_elem);
    END IF;
    -- Check data references.
    FOR rec IN
        SELECT *
        FROM
            pg_attribute
            JOIN pg_class ON pg_class.oid = attrelid
            JOIN pg_namespace ON pg_namespace.oid = relnamespace
        WHERE
            atttypid = type_oid
            AND relkind = 'r'
    LOOP
        sql :=
            'SELECT 1 FROM ONLY '
            || quote_ident(rec.nspname) || '.'
            || quote_ident(rec.relname) || ' '
            || ' WHERE '
            || quote_ident(rec.attname) || ' = '
            || quote_literal(enum_elem)
            || ' LIMIT 1';
        EXECUTE sql INTO ret;
        IF ret IS NOT NULL THEN
            RAISE EXCEPTION
                'Cannot delete the ENUM element %.%: column %.%.% contains references',
                quote_ident(enum_name), quote_ident(enum_elem),
                quote_ident(rec.nspname), quote_ident(rec.relname),
                rec.attname;
        END IF;
    END LOOP;
    -- OK. We may delete.
    DELETE FROM pg_enum WHERE enumtypid = type_oid AND enumlabel = enum_elem;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



CREATE SCHEMA bus;
        
--======================================= Create types ===========================================================
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
   
CREATE TYPE bus.transport_type_enum AS ENUM
   (
    'c_metro',
    'c_bus',
    'c_trolley',
    'c_tram',
    'c_foot',
    'c_electric_train',
    'c_taxi'
    );

CREATE TYPE bus.route_type_enum AS ENUM
   (
    'c_route_metro',
    'c_route_trolley',
    'c_route_bus',
    'c_route_tram',
    'c_route_electric_train',
    
    'c_route_transition',
    'c_route_metro_transition',
    'c_route_station_input'
    ); 

CREATE TYPE bus.alg_strategy AS ENUM
(
   'c_time',
   'c_cost',
   'c_opt'
);    
CREATE TYPE bus.nearest_relation AS
(
  id          integer,
  distance    double precision
);

CREATE TYPE bus.nearest_station AS
(
  id          bigint,
  distance    double precision
);

CREATE TYPE bus.relation AS 
(
   source  integer,
   target  integer,
   distance double precision,
   source_route_type bus.route_type_enum,
   target_route_type bus.route_type_enum
);


CREATE TYPE bus.filter_path AS
   (
    path_id integer,
    graph_id bigint,
    index integer,
    relation_id integer,
    direct_route_id bigint,
    relation_index integer,
    station_id bigint,
    route_type bus.route_type_enum,
    move_time interval,
    cost double precision,
    distance double precision,
    is_transition  boolean);

CREATE TYPE bus.path_t AS
(
   path_id                integer,
   index                  integer,
   direct_route_id        bigint,
   route_type             bus.route_type_enum,
   route_name             text,
   
   relation_index_a       integer,
   relation_index_b       integer,
   station_name_a           text,
   station_name_b           text,
   move_time              interval,
   wait_time              interval,
   cost                   double precision,
   distance               double precision
);	

CREATE TYPE bus.path_elem AS
(
     path_id     integer,
     index       integer,
     relation_id integer,
     graph_id    bigint
);

CREATE TYPE bus.paths_result AS
(
     path_id     integer,
     vertex_id   integer,
     edge_id     integer
);

CREATE TYPE bus.route_transition AS
(
  route_relation_a_id bigint 	       ,
  route_relation_b_id bigint 	       ,
  index_a             integer           ,
  index_b             integer          ,
  distance            double precision 
);

-- create views
CREATE OR REPLACE VIEW bus.time_routes AS 
 SELECT routes.id AS route_id, avg(timetable.frequency) AS freq, 
    min(timetable.time_a) AS time_a, max(timetable.time_b) AS time_b
   FROM bus.routes
   JOIN bus.direct_routes ON direct_routes.route_id = routes.id
   JOIN bus.schedule ON schedule.direct_route_id = direct_routes.id
   JOIN bus.schedule_groups ON schedule_groups.schedule_id = schedule.id
   JOIN bus.timetable ON timetable.schedule_group_id = schedule_groups.id
  WHERE direct_routes.direct = B'1'::"bit"
  GROUP BY routes.id;
  



--============================================ create table - enums ========================================================
CREATE TABLE bus.languages
(
  id        bus.lang_enum              NOT NULL,
  name      character varying(50)  NOT NULL,
  
  CONSTRAINT languages_pk PRIMARY KEY (id)
);

--==============

CREATE TABLE bus.transport_types
(
  id 		bus.transport_type_enum	NOT NULL,
  ev_speed 	double precision 	    NOT NULL,
  CONSTRAINT    "transport_type_pk" PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

--==============

CREATE TABLE bus.route_types
(
  id 		    bus.route_type_enum	    NOT NULL,
  transport_id 	bus.transport_type_enum	NOT NULL,
  visible       BIT(1)   			    NOT NULL,
  
  CONSTRAINT    "route_type_pk" PRIMARY KEY (id),
  CONSTRAINT route_type_transporttype_fk FOREIGN KEY (transport_id)
      REFERENCES bus.transport_types (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE 
)
WITH (
  OIDS=FALSE
);



--============================================== route tables =================================================================

CREATE TABLE bus.user_roles
(
  id       bigserial              NOT NULL,
  name     character varying(256) NOT NULL,
  CONSTRAINT user_role_id_pk PRIMARY KEY (id)
);

--===============

CREATE TABLE bus.users
(
  id        bigserial              NOT NULL,
  role_id   bigint                 NOT NULL,
  login     character varying(256) NOT NULL,
  password  character varying(256) NOT NULL,
  
  CONSTRAINT user_id_pk PRIMARY KEY (id),

  CONSTRAINT users_role_id_fk FOREIGN KEY (role_id)
      REFERENCES bus.user_roles (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
  
);

--============================================== string values tables =================================================================

CREATE TABLE bus.string_keys
(
  id     bigserial 					NOT NULL,
  name   character varying(256) 	,

   CONSTRAINT string_keys_pk PRIMARY KEY (id)
);

--===============

CREATE TABLE bus.string_values
(
  id       bigserial    NOT NULL,
  key_id   bigint       NOT NULL,
  lang_id  bus.lang_enum    NOT NULL,
  value    text         NOT NULL,


  CONSTRAINT string_values_pk PRIMARY KEY (id),

  CONSTRAINT lang_string_values_fk FOREIGN KEY (lang_id)
      REFERENCES bus.languages (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  
  CONSTRAINT key_string_values_fk FOREIGN KEY (key_id)
      REFERENCES bus.string_keys(id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
      
);

--================

CREATE TABLE bus.discounts
(
  id 				bigserial 	NOT NULL,
  name_key          bigint		NOT NULL,
  
  CONSTRAINT discounts_pk PRIMARY KEY (id),
  
  CONSTRAINT discount_name_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL
)
WITH (
  OIDS=FALSE
);

--================

CREATE TABLE bus.discount_by_route_types
(
  discount_id 		    bigint 					NOT NULL,
  route_type_id 	    bus.route_type_enum 	NOT NULL,
  discount	            double precision 		NOT NULL,
  
  CONSTRAINT discount_by_route_type_id_pk PRIMARY KEY (discount_id, route_type_id),

  CONSTRAINT discount_tr_disid_fk FOREIGN KEY (discount_id)
      REFERENCES bus.discounts (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT discount_tr_trid_fk FOREIGN KEY (route_type_id)
      REFERENCES bus.route_types (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT discount_route_types_discount_after_check 
             CHECK (discount >= 0::double precision AND discount <= 1::double precision)
)
WITH (
  OIDS=FALSE
);

--============================================== basic tables =================================================================

CREATE TABLE bus.cities
(
  id 			bigserial 			NOT NULL,
  key           text                NOT NULL,
  name_key      bigint				NOT NULL,
  lat 			double precision 	NOT NULL,
  lon 			double precision 	NOT NULL,
  scale 		bigint 				NOT NULL,
  is_show       bit(1)              NOT NULL,
      
  CONSTRAINT city_pk PRIMARY KEY (id),

  CONSTRAINT city_name_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE  CASCADE
      
)
WITH (
  OIDS=FALSE
);

--===============

CREATE TABLE bus.stations
(
  id 			bigserial 				NOT NULL,
  city_id 		bigint 					NOT NULL,
  name_key      bigint                  NOT NULL,
  location      GEOGRAPHY(POINT,4326)	NOT NULL,
  
  CONSTRAINT node_pk PRIMARY KEY (id),

  CONSTRAINT node_city_id_fk FOREIGN KEY (city_id)
      REFERENCES bus.cities (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT node_name_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);

--================

CREATE TABLE bus.routes
(
  id 				bigserial 				NOT NULL,
  city_id 			bigint 					NOT NULL,
  cost  			double precision 		NOT NULL,
  route_type_id 	bus.route_type_enum 	NOT NULL,
  number 			character varying(128)  NOT NULL,
  name_key 			bigint					,
  
  CONSTRAINT routes_pk PRIMARY KEY (id),

  CONSTRAINT route_name_key_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL,
      
  CONSTRAINT route_city_id_fk FOREIGN KEY (city_id)
      REFERENCES bus.cities (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
 
)
WITH (
  OIDS=FALSE
);

--================

CREATE TABLE bus.direct_routes
(
  id           bigserial NOT NULL,
  route_id     bigint    NOT NULL,
  direct       BIT(1)    NOT NULL,

 CONSTRAINT direct_routes_pk PRIMARY KEY (id),
 CONSTRAINT direct_routes_unique UNIQUE(route_id, direct),
 
 CONSTRAINT direct_route_routeid_fk FOREIGN KEY (route_id)
      REFERENCES bus.routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
  
);

--================

CREATE TABLE bus.route_relations
(
  id   				serial 		     		NOT NULL,
  direct_route_id 	bigint    		 		NOT NULL,
  station_A_id      bigint    		 		,
  station_B_id      bigint    		 		,
  position_index    bigint    		 		NOT NULL,
  distance          double precision	    NOT NULL,  -- kilometers
  ev_time           interval    	 		NOT NULL,  -- seconds
  geom              GEOGRAPHY(LINESTRING,4326)	,
  CONSTRAINT route_relations_pk PRIMARY KEY (id),

  CONSTRAINT route_relations_directroute_id_fk FOREIGN KEY (direct_route_id)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
        
  CONSTRAINT route_relations_station_A_id_fk FOREIGN KEY (station_A_id)
      REFERENCES bus.stations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  
  CONSTRAINT route_relations_station_B_id_fk FOREIGN KEY (station_B_id)
      REFERENCES bus.stations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED     
    
);
--================

CREATE TABLE bus.schedule 
(
   id bigserial 					 NOT NULL,
   direct_route_id 	bigint    		 NOT NULL,

   CONSTRAINT schedule_pk PRIMARY KEY (id),
   CONSTRAINT schedule_directroute_id_fk FOREIGN KEY (direct_route_id)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
);

--================

CREATE TABLE bus.schedule_groups
(
  id 			bigserial   NOT NULL,
  schedule_id   bigint 		NOT NULL,
  
  CONSTRAINT schedule_groups_pk PRIMARY KEY (id),

  CONSTRAINT schedule_groups_schedule_id_fk FOREIGN KEY (schedule_id)
      REFERENCES bus.schedule (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE  
);

--================

CREATE TABLE bus.schedule_group_days
(
  id                 bigserial NOT NULL,
  schedule_group_id  bigint    NOT NULL,
  day_id 		     bus.day_enum  NOT NULL,

  CONSTRAINT schedule_group_days_pk PRIMARY KEY (id),

  CONSTRAINT schedule_group_days_schedule_group_id_fk FOREIGN KEY (schedule_group_id)
      REFERENCES bus.schedule_groups (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE    
);

--================

CREATE TABLE bus.timetable 
(
   id                 bigserial NOT NULL,
   schedule_group_id  bigint    NOT NULL,
   time_A             time      NOT NULL,
   time_B             time      NOT NULL,
   frequency interval           NOT NULL,
   
  CONSTRAINT timetable_pk PRIMARY KEY (id),

  CONSTRAINT timetable_schedule_group_id_fk FOREIGN KEY (schedule_group_id)
      REFERENCES bus.schedule_groups (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE            
);


--================ Переходы между маршрутами
/*
CREATE TABLE bus.route_transitions
(
   id  			          bigserial 			 NOT NULL,
   route_relation_a_id    bigint                 NOT NULL,
   route_relation_b_id    bigint                 NOT NULL,
   disatnce               double precision       NOT NULL,
   move_time              interval               NOT NULL,
   cost                   double precision       NOT NULL,
    
  CONSTRAINT route_transitions_pk PRIMARY KEY (id),
  CONSTRAINT route_transitions_unique UNIQUE (route_relation_a_id,route_relation_b_id),
  
  CONSTRAINT route_transitions_station_a_id_fk FOREIGN KEY (route_relation_a_id)
      REFERENCES bus.route_transitions (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,

  CONSTRAINT route_transitions_station_b_id_fk FOREIGN KEY (route_relation_b_id)
      REFERENCES bus.route_transitions (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
   	
);
*/

--================ Переходы между станциями
CREATE TABLE bus.station_transitions
(
   id  			   bigserial 			  NOT NULL,
   station_a_id    bigint                 NOT NULL,
   station_b_id    bigint                 NOT NULL,
   distance        double precision       NOT NULL,
   move_time       interval               NOT NULL,
   is_manual       bool                   NOT NULL, -- создано админом или автоматически с помощью функции update_station_transitions(station_id)
  
  CONSTRAINT station_transitions_pk PRIMARY KEY (id),
  CONSTRAINT station_transitions_unique UNIQUE (station_a_id,station_b_id),
  
  CONSTRAINT station_transitions_station_a_id_fk FOREIGN KEY (station_a_id)
      REFERENCES bus.stations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,

  CONSTRAINT station_transitions_station_b_id_fk FOREIGN KEY (station_b_id)
      REFERENCES bus.stations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
   
);

--================
CREATE TABLE bus._graph_nodes
(
  id 				  bigserial        	    NOT NULL,
  station_id          bigint                NOT NULL,
  route_relation_id   bigint,
  
  CONSTRAINT _graph_nodes_pk PRIMARY KEY (id),
  CONSTRAINT _graph_nodes_relation_unique UNIQUE (route_relation_id),
  
  CONSTRAINT _graph_node_station_id_fk FOREIGN KEY (station_id)
      REFERENCES bus.stations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,

  CONSTRAINT _graph_node_relation_id_fk FOREIGN KEY (route_relation_id)
      REFERENCES bus.route_relations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE
        
);

--================
-- Таблица хранения графа по опред. городу. Является избыточной информацией, но необходимой
-- для быстрого формирования графа при поиске кратчайших путей
CREATE TABLE bus._graph_relations
(
  id 				  bigserial        	    NOT NULL,
  city_id 		      bigint 				NOT NULL,
  node_a_id           bigint 				NOT NULL,
  node_b_id           bigint 				NOT NULL,
  route_relation_id   bigint,
  route_id            bigint,
  relation_type       bus.route_type_enum   NOT NULL,
  move_time           interval   			NOT NULL,
  wait_time           interval   			NOT NULL,
  cost_money          double precision 		NOT NULL,
  cost_time           double precision      NOT NULL,
  distance            double precision      NOT NULL,
  
  CONSTRAINT _graph_relations_pk PRIMARY KEY (id),
  CONSTRAINT _graph_relations_modes_unique UNIQUE (node_a_id,node_b_id),
  
  CONSTRAINT _graph_relations_city_id_fk FOREIGN KEY (city_id)
      REFERENCES bus.cities (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT _graph_relations_route_id_fk FOREIGN KEY (route_id)
      REFERENCES bus.routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
        
  CONSTRAINT _graph_relations_route_relation_id_fk FOREIGN KEY (route_relation_id)
      REFERENCES bus.route_relations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
      
  CONSTRAINT _graph_relations_node_a_id_fk FOREIGN KEY (node_a_id)
      REFERENCES bus._graph_nodes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
  
  CONSTRAINT _graph_relations_node_b_id_fk FOREIGN KEY (node_b_id)
      REFERENCES bus._graph_nodes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
  

);

--================
CREATE TABLE bus.route_transitions
(
  id			      bigserial 		 NOT NULL,
  droute_a_id         bigint  			 NOT NULL,
  droute_b_id         bigint  			 NOT NULL,
  from_index_a_id     integer 			 NOT NULL,
  to_index_b_id       integer 			 NOT NULL,
  transition_distance double precision   NOT NULL,
  transition_time     interval           NOT NULL,
  transition_discount real               NOT NULL, -- Скидка на проезд [0..1]
  set_manual          bool               NOT NULL,
                   
  CONSTRAINT _route_transitions_pk PRIMARY KEY (id),
  
  CONSTRAINT _route_transitions_droute_a_id_fk FOREIGN KEY (droute_a_id)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
  
  CONSTRAINT _route_transitions_droute_b_id_fk FOREIGN KEY (droute_b_id)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
  
);
--================
CREATE TABLE bus.import_objects
(
  id			bigserial 			 NOT NULL,
  city_key   	text    			 NOT NULL,
  route_type    bus.route_type_enum  NOT NULL,
  route_number  text                 NOT NULL,
  obj           text         		 NOT NULL,
 
 CONSTRAINT import_objectss_pk PRIMARY KEY (id)
);

--================


--===================== VIEWS =============================================

CREATE OR REPLACE VIEW bus.view_schedule_droutes AS 
 SELECT
 bus.direct_routes.route_id as route_id, 
  direct_routes.id AS direct_route_id, 
  timetable.frequency, 
    timetable.time_a, 
    timetable.time_b, 
    schedule_group_days.day_id as day_id
   FROM bus.direct_routes
   JOIN bus.schedule ON schedule.direct_route_id = direct_routes.id
   JOIN bus.schedule_groups ON schedule_groups.schedule_id = schedule.id
   JOIN bus.timetable ON timetable.schedule_group_id = schedule_groups.id
   JOIN bus.schedule_group_days ON schedule_group_days.schedule_group_id = schedule_groups.id;

  
/*CREATE TABLE bus._graph_relations
(
  id 				  bigserial        	    NOT NULL,
  city_id 		      bigint 				NOT NULL,
  relation_a_id       integer 				NOT NULL,
  relation_b_id       integer 				NOT NULL,
  relation_b_type     bus.route_type_enum   NOT NULL,
  move_time           interval   			NOT NULL,
  wait_time           interval   			NOT NULL,
  cost_money          double precision 		NOT NULL,
  cost_time           double precision      NOT NULL,
  distance            double precision      NOT NULL,
  is_transition       boolean                NOT NULL,
  CONSTRAINT _graph_relations_pk PRIMARY KEY (id),

  CONSTRAINT _graph_relations_city_id_fk FOREIGN KEY (city_id)
      REFERENCES bus.cities (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT _graph_relations_relation_a_id_fk FOREIGN KEY (relation_a_id)
      REFERENCES bus.route_relations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
   CONSTRAINT _graph_relations_relation_b_id_fk FOREIGN KEY (relation_b_id)
      REFERENCES bus.route_relations (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
  

);*/

/*

select row_number() over (order by t1.id) as id, 
t1.id as relation_A, t2.id as relation_B,t1.direct_route_id as direct_route_A,t2.direct_route_id as direct_route_B
   FROM bus.route_stations as t1
   JOIN ( SELECT * FROM bus.route_stations) t2 ON t1.station_b_id = t2.station_a_id;
*/


/*

--================
CREATE TABLE bus._droute_trees
(
  id 				  bigserial        	    NOT NULL,  -- id текущего нода
  parent_id           bigint                        ,  -- ссылка на нод родителя
  root_rid  		  bigint        	    NOT NULL,  -- direct_route_id корня дерева 
  root_index          integer               NOT NULL,
  curr_rid            bigint                NOT NULL,  -- текущий direct_route_id
  curr_index          integer               NOT NULL,
  level               integer               NOT NULL,  -- уровень дерева
  parent_relation_id  bigint                        , 
  
  subpath_time_cost   timestamp             NOT NULL,  -- затраченное время на путь, исключая концы
  subpath_money_cost  timestamp             NOT NULL,  -- стоимость всего пути
  
  CONSTRAINT _droute_trees_pk PRIMARY KEY (id),

  CONSTRAINT _droute_trees_parent_id_fk FOREIGN KEY (parent_id)
      REFERENCES bus._droute_trees (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  
  CONSTRAINT _droute_trees_root_rid_fk FOREIGN KEY (root_rid)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  
  CONSTRAINT _droute_trees_curr_rid_fk FOREIGN KEY (curr_rid)
      REFERENCES bus.direct_routes (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
      
  CONSTRAINT _droute_trees_parent_relation_id_fk FOREIGN KEY (parent_relation_id)
      REFERENCES bus.route_relations (id) MATCH SIMPLE
      ON UPDATE SET NULL ON DELETE SET NULL
       
);
--######################################

CREATE TABLE bus.discounts
(
  id bigserial NOT NULL,
  name_key          bigint		NOT NULL,
  
  CONSTRAINT discounts_pk PRIMARY KEY (id),
  
  CONSTRAINT discount_name_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.discounts OWNER TO postgres;

--######################################


CREATE TABLE bus.discount_transports
(
  discount_id 		    bigint 			NOT NULL,
  transport_type_id 	bus.transport_type_enum NOT NULL,
  discount_after 	    double precision 	NOT NULL,
  
  CONSTRAINT facility_transports_pk PRIMARY KEY (discount_id, transport_type_id),

  CONSTRAINT discount_tr_disid_fk FOREIGN KEY (discount_id)
      REFERENCES bus.discounts (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT discount_tr_trid_fk FOREIGN KEY (transport_type_id)
      REFERENCES bus.transport_types (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT discount_transports_discount_after_check 
             CHECK (discount_after > 0::double precision AND discount_after <= 1::double precision)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.discount_transports OWNER TO postgres;


--######################################

CREATE TABLE bus.terms
(
  id 			bigserial NOT NULL,
  optimize_method 	bigint    NOT NULL,

  CONSTRAINT term_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.terms OWNER TO postgres;

--######################################

CREATE TABLE bus.term_transports
(
  term_id 		bigint NOT NULL,
  transport_type_id 	bus.transport_type_enum NOT NULL,
  
  CONSTRAINT term_transports_pk PRIMARY KEY (term_id, transport_type_id),

  CONSTRAINT term_tr_termid_fk FOREIGN KEY (term_id)
      REFERENCES bus.terms (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
          
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.term_transports OWNER TO postgres;


--######################################

CREATE TABLE bus.term_discounts
(
  term_id     bigint NOT NULL,
  discount_id bigint NOT NULL,
  
  CONSTRAINT term_discount_pk PRIMARY KEY (term_id, discount_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.term_discounts OWNER TO postgres;

--######################################



--######################################

CREATE TABLE bus.routes
(
  id 		  bigserial 		NOT NULL,
  city_id 	  bigint 		NOT NULL,
  route_type_id   bus.route_type_enum   NOT NULL,
  number          character(256)        ,
  base_cost 	  money 		NOT NULL,
  name_key        bigint                NOT NULL,
     
  CONSTRAINT routes_pk PRIMARY KEY (id),
      
  CONSTRAINT routes_city_id_fk FOREIGN KEY (city_id)
      REFERENCES bus.cities (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
      
  CONSTRAINT routes_route_type_id_fk FOREIGN KEY (route_type_id)
      REFERENCES bus.route_types (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,

        
  CONSTRAINT routes_name_fk FOREIGN KEY (name_key)
      REFERENCES bus.string_keys (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
             
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.routes OWNER TO postgres;


--######################################

CREATE TABLE bus.route_ways
(
  id bigserial NOT NULL,
  route_id bigint NOT NULL,
  direct_type bit NOT NULL, -- 1 - direct...
  CONSTRAINT route_ways_pkey PRIMARY KEY (id),
  CONSTRAINT route_way_direct_uniq UNIQUE(route_id, direct_type),

  CONSTRAINT route_way_routeid_fk FOREIGN KEY (route_id)
      REFERENCES bus.routes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.route_ways OWNER TO postgres;
COMMENT ON COLUMN bus.route_ways.direct_type IS
'0 - direct
1 - reverse';


--######################################

CREATE TABLE bus.route_way_daygroups
(
  id bigserial NOT NULL,
  CONSTRAINT route_way_daygroup_id_pk PRIMARY KEY (id)

)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.route_way_daygroups OWNER TO postgres;

--######################################

CREATE TABLE bus.route_way_days
(
  route_daygroup_id   bigint   NOT NULL,
  day_id              day_enum NOT NULL,
  route_way_id        bigint   NOT NULL,
  
  CONSTRAINT route_way_day_id_pk PRIMARY KEY (route_daygroup_id,day_id),

  CONSTRAINT route_way_day_daygroup_id_fk FOREIGN KEY (route_daygroup_id)
      REFERENCES bus.route_way_daygroups (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
      
  CONSTRAINT route_way_day_wayid_fk FOREIGN KEY (route_way_id)
      REFERENCES bus.route_ways (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

   CONSTRAINT route_way_day_secondpk_uniq UNIQUE (day_id, route_way_id)        
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.route_way_days OWNER TO postgres;

--######################################


CREATE TABLE bus.route_schedule
(
  id                bigserial NOT NULL,
  route_daygroup_id bigint NOT NULL,
  time_a            time without time zone NOT NULL,
  time_b            time without time zone NOT NULL,
  time_frequancy    interval NOT NULL,
  
  CONSTRAINT route_schedule_pk PRIMARY KEY (id),
  CONSTRAINT route_schedule_fk FOREIGN KEY (route_daygroup_id)
      REFERENCES bus.route_way_daygroups (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.route_schedule OWNER TO postgres;

--######################################

CREATE TABLE bus.route_way_nodes
(
  id bigserial NOT NULL,
  route_way_id bigint NOT NULL,
  prev_node_id bigint,
  curr_node_id bigint NOT NULL,
  distance     double precision NOT NULL,
  time         interval NOT NULL,
  "index" bigint,
  
  CONSTRAINT route_node_pk PRIMARY KEY (id),
  CONSTRAINT route_curr_node_id_fk FOREIGN KEY (curr_node_id)
      REFERENCES bus.nodes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT route_prev_node_id_fk FOREIGN KEY (prev_node_id)
      REFERENCES bus.nodes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT route_way_fk FOREIGN KEY (route_way_id)
      REFERENCES bus.route_ways (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT route_node_index_uniq UNIQUE (route_way_id, index),
  CONSTRAINT route_node_secondpk_uniq UNIQUE (route_way_id, curr_node_id)
)
WITH (
  OIDS=FALSE
);



--######################################


CREATE TABLE bus.calc_shortest_ways
(
  id bigint NOT NULL,
  term_id bigint,
  full_cost money NOT NULL,
  full_time interval NOT NULL,
  rating_program bigint NOT NULL,
  rating_expert bigint,
  node_start_id bigint,
  node_finish_id bigint,
  CONSTRAINT calc_shortest_way_id_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.calc_shortest_ways OWNER TO postgres;


--######################################

CREATE TABLE bus.calc_shortest_way_times
(
  id bigserial NOT NULL,
  shortest_way_id bigint NOT NULL,
  time1 time without time zone NOT NULL,
  time2 time without time zone NOT NULL,
  
  CONSTRAINT calc_shortest_way_time_id_pk PRIMARY KEY (id),
  CONSTRAINT calc_shortest_way_id_fk FOREIGN KEY (shortest_way_id)
      REFERENCES bus.calc_shortest_ways (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE bus.calc_shortest_way_times OWNER TO postgres;
*/







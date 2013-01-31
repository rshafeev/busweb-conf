

--===============================================================================================================
/* Преобразует interval к double precision
  @m_interval    Интервал времени
  @return        Интервал времени в сек, привед. к типу double         
*/
CREATE OR REPLACE FUNCTION bus.interval_to_double(m_interval interval)
RETURNS  double precision AS
$BODY$
DECLARE
BEGIN
  return EXTRACT(EPOCH FROM m_interval);
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE;
  			  
--===============================================================================================================
/* Функция вычисляет время, необходимое человеку для преодоления расстояния m_distance со средней скоростью шага
  @m_distance    Расстояние
  @return        Время передвижения       
*/
CREATE OR REPLACE FUNCTION bus.get_walking_move_time(m_distance double precision)
RETURNS  interval AS
$BODY$
DECLARE
BEGIN
  return (m_distance/1000.0/bus._WALKING_SPEED()) * interval '01:00:00';
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE;
  
--====================================================================================================================	
/* Функция ищет станции, удаленные от местоположения m_location не более max_distance
  @m_location    Местоположение точки назначения
  @m_city_id     Город
  @max_distance  Максимальное расстояние от/до точки назначения
  @return        Таблица (ID станции, расстояние)            
*/
CREATE OR REPLACE FUNCTION bus.find_nearest_stations( m_location       geography,          
													  m_city_id        bigint,             
													  max_distance     double precision)
RETURNS SETOF bus.nearest_station AS
$BODY$
DECLARE
  _relation bus.nearest_station;
BEGIN
    for _relation in select 
                              bus.stations.id           as id ,
                              st_distance(location,m_location) as distance
                     from bus.stations 
                     where city_id = m_city_id and  ST_DWithin(location, m_location,max_distance) = true
    loop
         return next _relation;
    end loop;
    
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE;	

--==========================================================================================================================  
/*
  Функция добавляет дугу в граф
  @edit           INSERT into bus._graph_relations
*/
CREATE OR REPLACE FUNCTION bus._insert_graph_relation( m_city_id bigint,
													   m_node_a_id bigint,
													   m_node_b_id bigint,
													   m_relation_id bigint,
													   m_route_id   bigint,
													   m_relation_type bus.route_type_enum,
													   m_move_time   interval,
													   m_wait_time  interval,
													   m_cost_money double precision,
													   m_distance   double precision)
 RETURNS bigint AS
$BODY$
DECLARE
 _id bigint;
BEGIN
  if m_relation_id is not null then
	insert into bus._graph_relations (
					city_id,
					node_a_id,
					node_b_id,
					relation_type,
					move_time,
					wait_time,
					cost_money,
					cost_time,
					distance,
					route_relation_id,
					route_id) 
	     values (
					m_city_id,
					m_node_a_id,
					m_node_b_id,
					m_relation_type,
					m_move_time,
					m_wait_time,
					m_cost_money,
					EXTRACT(EPOCH FROM m_move_time + m_wait_time),
					m_distance,
					m_relation_id,
					m_route_id
	     ) returning id into _id;  
  else 
 	insert into bus._graph_relations (
					city_id,
					node_a_id,
					node_b_id,
					relation_type,
					move_time,
					wait_time,
					cost_money,
					cost_time,
					distance) 
	     values (
					m_city_id,
					m_node_a_id,
					m_node_b_id,
					m_relation_type,
					m_move_time,
					m_wait_time,
					m_cost_money,
					EXTRACT(EPOCH FROM m_move_time + m_wait_time),
					m_distance
	     ) returning id into _id;   
  
  end if;
  return _id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Функция обновляет узлы и дуги в графе, соотв.  маршруту (_direct_route_id)
  @_direct_route_id  ID машрута (таблица bus.direct_routes)
  @edit              CRUD in bus._graph_nodes
  @edit              CRUD in bus._graph_relations
*/
CREATE OR REPLACE FUNCTION bus.refresh_graph_by_droute(_direct_route_id bigint)
 RETURNS void AS
$BODY$
DECLARE
  _r bus.route_relations%ROWTYPE;
  _node_a_id bigint;
  _node_b_id bigint;
  _city_id bigint;
  m_route_id bigint;
  m_wait_time interval;
  m_pause interval;
  m_cost double precision;
  m_route_type bus.route_type_enum;
  m_route_freq interval;
BEGIN

 m_pause     := interval '00:00:08';
 
  -- Узнаем id города данного маршрута; id, тип, стоимость маршрута
  select city_id, route_type_id, cost  , bus.routes.id into 
        _city_id, m_route_type , m_cost, m_route_id     from bus.direct_routes 
       join bus.routes on bus.routes.id = route_id
       where bus.direct_routes.id = _direct_route_id limit 1;
  -- Узнаем время ожидания транспортного средства данного маршрута
  select freq into m_route_freq from bus.time_routes where route_id = m_route_id limit 1;
  
  -- Удалим все узлы из графа, соответств. данному маршруту
  delete from bus._graph_nodes where route_relation_id in 
  ( select id from bus.route_relations where direct_route_id = _direct_route_id);
  
  /* Удалим все дуги, соотв. данному маршруту 
  впринципе, можно опустить, т.к.  дуги должны были удалиться каскадно после удаления узлов*/
  delete from bus._graph_relations where route_relation_id in 
  ( select id from bus.route_relations where direct_route_id = _direct_route_id);
  
  -- Добавим узлы, соотв. данному маршруту (id,station_b_id) из таблицы bus.route_relations
  insert into bus._graph_nodes (station_id,route_relation_id)
  select station_b_id as station_id, id as route_relation_id 
         from bus.route_relations
         where direct_route_id =  _direct_route_id;
  
  -- Добавим дуги 
  for _r in select * from  bus.route_relations  where direct_route_id =  _direct_route_id
  loop
       _node_a_id := bus._refresh_graph_node_by_station(_r.station_b_id,null);
       _node_b_id := bus._refresh_graph_node_by_station(_r.station_b_id,_r.id);
    --  raise notice '%,%,%,%',_r.direct_route_id,_node_a_id,_node_b_id,_r;
       -- Добавим вход в маршрут
     perform bus._insert_graph_relation(_city_id,_node_a_id,_node_b_id,null,null,bus.route_type_enum('c_route_station_input'),
                                           interval '00:00:00',m_route_freq,m_cost, 0.0);
  
     perform bus._insert_graph_relation(_city_id,_node_b_id,_node_a_id,null,null,bus.route_type_enum('c_route_station_output'),
                                           interval '00:00:00',interval '00:00:00',0.0, 0.0);
     if _r.station_a_id is not null then
		 _node_a_id := bus.get_graph_node_by_route(_r.station_a_id,_r.direct_route_id);
	     _node_b_id := bus.get_graph_node_by_station(_r.station_b_id,_r.id);
		 perform bus._insert_graph_relation(_city_id,_node_a_id,_node_b_id,_r.id,m_route_id,m_route_type,
                                           _r.ev_time + m_pause ,interval '00:00:00',0.0, _r.distance);
     end if;
     
   end loop;  
    

END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Функция удаляет переход м/у станциями
  @station_transition_id  ID перехода
  @edit           DELETE from bus.station_transitions
  @edit           DELETE from bus_graph_relations
*/
CREATE OR REPLACE FUNCTION bus.delete_station_transition(station_transition_id bigint)
 RETURNS void AS
$BODY$
DECLARE
BEGIN
  -- Удалим переход из графа 
  execute _delete_station_transition_from_graph(station_transition_id);
  -- Удалим переход
  delete from bus.station_transitions where id = _station_transition_id;
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Функция добавляет переход м/у станциями
  @_station_a_id  Начальная станция
  @_station_b_id  Конечная станция
  @_is_manual     Переход был добавлен администратором (true) или с помощью  ф-ции bus.refresh_station_transitions() 
  @edit           INSERT into bus.station_transitions
  @edit           INSERT into bus_graph_relations
*/
CREATE OR REPLACE FUNCTION bus.add_station_transition(_station_a_id bigint,
													  _station_b_id bigint,
													  _is_manual bool)
 RETURNS void AS
$BODY$
DECLARE
 _transition_id bigint;
BEGIN
  raise notice 'add_station_transition()';
  select id into _transition_id from bus.station_transitions where station_a_id = _station_a_id and station_b_id = _station_b_id;
  if _transition_id is not null then
     return;
  end if;
  -- Добавим возможные переходы со станции _station_id
  insert into bus.station_transitions (station_a_id,station_b_id,distance,move_time,is_manual) 
     values(
       _station_a_id,
       _station_b_id,
       bus.stations_distance(_station_a_id,_station_b_id),
       bus.get_walking_move_time(bus.stations_distance(_station_a_id,_station_b_id)),
       _is_manual
     ) returning id into _transition_id;

  execute bus._refresh_graph_node_by_station(_station_a_id,null);
  execute bus._refresh_graph_node_by_station(_station_b_id,null);
  
  
  -- Добавим переход в граф
  execute bus._add_station_transition_into_graph(_transition_id);
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Ищет ID узла в графе, который соответствует станции с ID = _station_id
  @_station_id    Станция маршрута
  @droute_id      Маршрут
  @edit           none
  @return         ID узла в графе
*/
CREATE OR REPLACE FUNCTION bus.get_graph_node_by_route(_station_id bigint, droute_id bigint)
RETURNS bigint AS
$BODY$
DECLARE
  _node_id  bigint;
BEGIN
   select bus._graph_nodes.id into _node_id from bus._graph_nodes
          join bus.route_relations on bus.route_relations.id = bus._graph_nodes.route_relation_id
          where station_b_id = _station_id and direct_route_id = droute_id limit 1;
   return _node_id;
   
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Ищет ID узла в графе, который соответствует станции с ID = _station_id
  @_station_id    Станция
  @_route_relation_id   Дуга маршрута, can null
  @edit           none
  @return         ID узла в графе
*/
CREATE OR REPLACE FUNCTION bus.get_graph_node_by_station(_station_id bigint, _route_relation_id bigint)
RETURNS bigint AS
$BODY$
DECLARE
  _node_id  bigint;
BEGIN
   if _route_relation_id is null then
		select id into _node_id from bus._graph_nodes where station_id = _station_id and route_relation_id is null;
		return _node_id;
   end if;
  select id into _node_id from bus._graph_nodes where station_id = _station_id and route_relation_id = _route_relation_id;
  return _node_id;
   
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Удаляем дугу из графа, которая соответствует переходу station_transition_id(таблица bus.station_transitions) 
  @station_transition_id    ID перехода м/у станциями
  @edit           DELTE from bus._graph_relations
*/
CREATE OR REPLACE FUNCTION bus._delete_station_transition_from_graph(station_transition_id bigint)
RETURNS void AS
$BODY$
DECLARE
  _transition  bus.station_transitions%ROWTYPE;
  _node_a_id bigint;
  _node_b_id bigint;
BEGIN
   -- Узнаем id начального и конечного узла для перехода
   select * into _transition from bus.station_transitions where id = station_transition_id limit 1;
   _node_a_id := bus.get_graph_node_by_station(_transition.station_a_id,null);
   _node_b_id := bus.get_graph_node_by_station(_transition.station_b_id,null);
   
   -- Удалим переход из графа
   delete from bus._graph_relations where node_a_id = _node_a_id and node_b_id = _node_b_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Добавляет дугу в граф, которая соответствует переходу между станциями(таблица bus.station_transitions) 
  @station_transition_id    ID перехода м/у станциями
  @edit                     INSERT into bus._graph_relations
*/
CREATE OR REPLACE FUNCTION bus._add_station_transition_into_graph(station_transition_id bigint)
RETURNS void AS
$BODY$
DECLARE
  _transition  bus.station_transitions%ROWTYPE;
  _node_a_id bigint;
  _node_b_id bigint;
  _graph_relation_id bigint;
  _city_id bigint;
BEGIN
   
   -- Узнаем id начального и конечного узла для перехода
   select * into _transition from bus.station_transitions where id = station_transition_id limit 1;
   
   _node_a_id := bus.get_graph_node_by_station(_transition.station_a_id,null);
   if _node_a_id is null then
     return;
   end if;
   
   _node_b_id := bus.get_graph_node_by_station(_transition.station_b_id,null);
   
   if _node_b_id is null then
     return;
   end if;
   
   -- Узнаем город, в котором находится данный переход
   select city_id into _city_id from bus.stations where id = _transition.station_a_id limit 1;
   
   -- Проверим, был ли ранее добавлен переход в граф
   _graph_relation_id:= null;
   select id into _graph_relation_id from bus._graph_relations
             where node_a_id = _node_a_id and node_b_id = _node_b_id limit 1;
  
   --raise notice 'node_a % , node_b %',_node_a_id,_node_b_id;
   
   -- Если переход уже был добавлен в граф, выходим
   if _graph_relation_id is not null then
     return;
   end if;
   
   -- Добавим переход в граф
   insert into bus._graph_relations (
					city_id,
					node_a_id,
					node_b_id,
					relation_type,
					move_time,
					wait_time,
					cost_money,
					cost_time,
					distance) 
	     values (
					_city_id,
					_node_a_id,
					_node_b_id,
					bus.route_type_enum('c_route_transition'),
					_transition.move_time,
					interval '00:00:00',
					0.0,
					EXTRACT(EPOCH FROM _transition.move_time),
					_transition.distance
	     );     
   
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Обновляет узел графа, который соотносится со станцией _station_id.
  В случае, если узел уже есть, ничего не делает. Если узла нет, то добавляет его.
  @_station_id          Станция
  @_route_relation_id   Дуга маршрута, can null
  @edit                 CRUD in bus._graph_nodes
  @return               Расстояние между станциями
*/
CREATE OR REPLACE FUNCTION bus._refresh_graph_node_by_station(_station_id bigint,_route_relation_id bigint)
RETURNS bigint AS
$BODY$
DECLARE
  _node_id  bigint;
BEGIN

   if _route_relation_id is null then
		select id into _node_id from bus._graph_nodes where 
		          station_id =  _station_id and route_relation_id  is null limit 1;
		if _node_id is null then
			insert into bus._graph_nodes (station_id) 
			                       values(_station_id) returning id into _node_id;
		end if;
  else
   		select id into _node_id from bus._graph_nodes where 
		          station_id =  _station_id and route_relation_id  = _route_relation_id;
		if _node_id is null then
			insert into bus._graph_nodes (station_id,route_relation_id)
			                       values(_station_id,_route_relation_id) returning id into _node_id;
		end if;
  end if;
  return _node_id;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
         
--==========================================================================================================================  
/*
  Функция вычисляет геогр. расстояние между станциями
  @_station_a_id  Первая станция
  @_station_b_id  Вторая станция
  @edit           IMMUTABLE
  @return         Расстояние между станциями
*/
CREATE OR REPLACE FUNCTION bus.stations_distance(_station_a_id bigint, _station_b_id bigint)
RETURNS double precision AS
$BODY$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;

 return st_distance(p1, p2);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--==========================================================================================================================  
/*
  Функция определяет, являются ли геогр. расстояние между станциями меньше max_distance
  @_station_a_id  Первая станция
  @_station_b_id  Вторая станция
  @edit           IMMUTABLE
  @return         True: расстояние м/у станциями меньше max_distance, False : иначе
*/
CREATE OR REPLACE FUNCTION bus.is_nearest_stations(_station_a_id bigint, _station_b_id bigint,max_distance double precision)
RETURNS bool AS
$BODY$
DECLARE
 _distance double precision;
 p1 geography;
 p2 geography;
BEGIN
 SELECT location INTO p1 FROM bus.stations where id = _station_a_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;
 SELECT location INTO p2 FROM bus.stations where id = _station_b_id LIMIT 1;
 IF NOT FOUND THEN
	return false;
 END IF;

 return ST_DWithin(p1, p2,max_distance);
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--==========================================================================================================================  
/*
  Функция refresh_station_transitions добавляет возможные переходы со станции _station_id
  @_station_id  Id станции, для которой ищем переход на другие станции
  @edit         bus.station_transitions
  @edit         bus._graph_nodes
  @edit         bus._graph_relations  
*/
CREATE OR REPLACE FUNCTION bus.refresh_station_transitions(_station_id bigint)
 RETURNS void AS
$BODY$
DECLARE
 _curr_rid bigint;
 _parent_id bigint;
 _city_id  bigint;
 _r record;
BEGIN
  
  
  -- Узнаем city_id для станции station_id
  select city_id from into  _city_id bus.stations where id = _station_id limit 1;

  /* В процессе изменения станции возможно было изменение ее местоположения и в таком случае нужно
   удалить все старые переходы, которые уже невозможны c/на станцию _station_id
  */
  perform bus.delete_station_transition(id) from bus.station_transitions 
          where (station_a_id = _station_id or station_b_id = _station_id ) and 
                bus.is_nearest_stations(station_a_id,station_b_id,bus._MAX_TRANSITION_DISTANCE()) = false and 
                is_manual = false;
  -- Обновим узел в графе		       
  perform bus._refresh_graph_node_by_station(_station_id,null);
 
  -- обновим изменения 
  /*  not implemented */ 
  
  -- Добавим возможные переходы со станции _station_id
  perform bus.add_station_transition(_station_id,bus.stations.id,false) from bus.stations
		 left join bus.station_transitions on bus.station_transitions.station_a_id = _station_id and
		                                      bus.station_transitions.station_b_id = bus.stations.id 
		 where bus.stations.city_id = _city_id and
		       bus.station_transitions.station_a_id is null and
		       bus.stations.id <> _station_id and
		       bus.is_nearest_stations(_station_id,bus.stations.id,bus._MAX_TRANSITION_DISTANCE()) = true;

  -- Добавим возможные переходы на станцию _station_id
  perform bus.add_station_transition(bus.stations.id,_station_id,false) from bus.stations
		 left join bus.station_transitions on bus.station_transitions.station_a_id = bus.stations.id and
										      bus.station_transitions.station_b_id = _station_id
		 where bus.stations.city_id = _city_id and
		       bus.station_transitions.station_a_id is null and
		       bus.stations.id <> _station_id and
		       bus.is_nearest_stations(_station_id,bus.stations.id,bus._MAX_TRANSITION_DISTANCE()) = true;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
/*
  Функция refresh_station_transitions добавляет возможные переходы со станции _station_id
  @_direct_route_id  Маршрут
  @_station_A_id     Начальная станция дуги
  @_station_B_id     Конечная станция дуги
  @_index            Индекс дуги в маргруте (порядковый номер)
  @_geom             Геогр. полилиния дуги
  @return            ID новой дуги маршрута
*/
CREATE OR REPLACE FUNCTION bus.insert_route_relation(
												 _direct_route_id	bigint,
												 _station_A_id 		bigint, 
												 _station_B_id 		bigint,
												 _index        		bigint,
												 _geom               geography
												) 
RETURNS bigint AS
$BODY$
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
$BODY$
LANGUAGE plpgsql VOLATILE;

--===============================================================================================================

CREATE OR REPLACE FUNCTION bus.lib_shortest_paths(sql text, source_id integer, target_id integer, directed boolean, has_reverse_cost boolean)
  RETURNS SETOF bus.paths_result AS
'$libdir/libpgcityways', 'shortest_paths'
  LANGUAGE c IMMUTABLE STRICT
COST 1 ROWS 1000;

--==========================================================================================================================  
CREATE OR REPLACE FUNCTION bus._get_prev_relation(_direct_route_id bigint,_prev_index bigint)
RETURNS bus.route_relations AS
$BODY$
DECLARE
 _prev_relation    bus.route_relations;
BEGIN
 _prev_index := _prev_index + 1;
  SELECT * INTO _prev_relation FROM bus.route_relations WHERE direct_route_id = _direct_route_id AND position_index = _prev_index LIMIT 1;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _prev_relation;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--===============================================================================================================
CREATE OR REPLACE FUNCTION bus._get_next_relation(_direct_route_id bigint,_curr_index bigint)
RETURNS bus.route_relations AS
$BODY$
DECLARE
 _next_relation    bus.route_relations;
BEGIN
 _curr_index := _curr_index + 1;
  SELECT * INTO _next_relation FROM bus.route_relations WHERE direct_route_id = _direct_route_id AND position_index = _curr_index LIMIT 1;
  IF NOT FOUND THEN
	return null;
  END IF;
  return _next_relation;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;

--===============================================================================================================
CREATE OR REPLACE FUNCTION bus.get_string_without_null(str text)
RETURNS  text AS
$BODY$
DECLARE
BEGIN
  IF str IS NOT NULL THEN
    return str;
  END IF;
  return '';
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
--===============================================================================================================
CREATE OR REPLACE FUNCTION bus.route_full_name(number text,name text)
RETURNS  text AS
$BODY$
DECLARE
BEGIN
  IF name IS NULL THEN
    return number;
  END IF;
  return name;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;	
--===============================================================================================================    

--===============================================================================================================

  CREATE OR REPLACE FUNCTION bus.find_shortest_paths(	_city_id  	bigint,
							_p1 		geography,
							_p2 		geography,
							_day_id 	bus.day_enum,
							_time_start  	time,
					        _max_distance 	double precision,
					        _route_types 	text[],
					        _discounts      double precision[],
					        _alg_strategy   bus.alg_strategy,
					        _lang_id        bus.lang_enum)
RETURNS SETOF bus.way_elem AS
$BODY$
DECLARE
 _foot_speed            double precision;
 _nearest_relation      bus.nearest_relation%ROWTYPE;
 relations_A 		    bus.nearest_relation[];
 relations_B 		    bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 --count_i 		integer;
 --count_j 		integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path;
 _temp_filter_path	bus.filter_path;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
 _id_arr                integer[];
 _id                    integer;
 _start_id              integer;
 _finish_id             integer;
 _r                     record;
BEGIN

  -- Сохраним скорость движения пешехода (км/ч) в переменную  _foot_speed
  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
  
  
  -- создадим временную таблицу  use_routes(id,discount) используемых типов маршрутов и 
  -- скидки по каждому в процентном эквиваленте(от 0 до 1)
  CREATE TEMPORARY  TABLE temp_use_routes  ON COMMIT DROP AS
    SELECT route_type as id,discount FROM 
	(select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)
	) as route_types
    JOIN
    ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)
    ) as discounts
    ON discounts.id =  route_types.id;

  
 -- Зададим id начальной и конечной дуги
 _start_id  := -10;
 _finish_id := -11;
  
 -- Найдем ближайшие дуги от начальной точки назначения и сохраним их во временную таблицу  nearest_relations
 CREATE TEMPORARY  TABLE temp_nearest_relations  ON COMMIT DROP AS
    (SELECT   -row_number() over (ORDER BY (select 0))-1 		      			   as id,
              _start_id           												   as node_a_id,
              bus._graph_nodes.id  												   as node_b_id,
              bus.route_type_enum('c_route_transition')                            as relation_type,
              bus.get_walking_move_time(stations.distance)                         as move_time,
              interval '00:00:00'	                    						   as wait_time,
			  0                                                                    as cost_money,
			  bus.interval_to_double(bus.get_walking_move_time(stations.distance)) as cost_time,
			  stations.distance                                                    as distance
		FROM bus.find_nearest_stations(_p1, _city_id, _max_distance) as stations
        join bus._graph_nodes    ON bus._graph_nodes.station_id = stations.id and bus._graph_nodes.route_relation_id is null
     ); 
     
  -- Найдем ближайшие дуги до конечной точки назначения и сохраним их в таблицу nearest_relations
  SELECT min(id) INTO i FROM temp_nearest_relations;  
  
  INSERT INTO temp_nearest_relations(id,node_a_id,node_b_id,relation_type,move_time,
                                wait_time,cost_money,cost_time,distance)
    (SELECT   -row_number() over (ORDER BY (select 0)) + i		      			   as id,
              bus._graph_nodes.id  												   as node_a_id,
              _finish_id           												   as node_b_id,
              bus.route_type_enum('c_route_transition')                            as relation_type,
              bus.get_walking_move_time(stations.distance)                         as move_time,
              interval '00:00:00'	                    						   as wait_time,
			  0                                                                    as cost_money,
			  bus.interval_to_double(bus.get_walking_move_time(stations.distance)) as cost_time,
			  stations.distance                                                    as distance
		FROM bus.find_nearest_stations(_p2, _city_id, _max_distance) as stations
        join bus._graph_nodes    ON bus._graph_nodes.station_id = stations.id and bus._graph_nodes.route_relation_id is null
     );
  
  -- Составим query графа
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
  	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        node_a_id::integer                           as source,' ||
  	         '        node_b_id::integer                           as target,' || 
  	         '        cost_time                           as cost, '   ||
  	         '        false                               as is_transition, '   ||
  	         '        bus._graph_relations.route_id       as route_id '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        node_a_id::integer                           as source,' ||
  	         '        node_b_id::integer                           as target,' || 
  	         '        cost_time                           as cost, '   ||
  	         '        false                               as is_transition, '   ||
  	         '        0                               as route_id '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_type' ||
  	         ')';
  	ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  ELSE
   END IF;	
   i:=1;
   
 /*  FOR _r IN EXECUTE ('select * from ( '|| query || ' ) as tt1') 
   LOOP
     RAISE  NOTICE 'output data: %',_r; 
     i := i + 1;
   END LOOP;*/
  
  -- Создадим временную таблицу paths, в которую сохраним найденные пути
  CREATE TEMPORARY TABLE temp_paths
  (
     path_id     integer, -- id пути
     index       integer, -- индекс дуги
     node_id     integer, -- id дуги из таблицы bus.route_relations
     relation_id bigint   -- id дуги из таблицы bus._graph_relations
  )ON COMMIT DROP;
  
 /* RAISE NOTICE 'paths:';
  FOR _r IN select *
		   from bus.lib_shortest_paths(query,_start_id,_finish_id,true,false) as t1
  LOOP
    RAISE NOTICE '%',_r;
  END LOOP;
  RAISE NOTICE 'paths end.';*/
  -- Найдем кратчайший путь
  BEGIN
     INSERT INTO temp_paths(path_id,index,node_id,relation_id)
		   select t1.path_id                                 as path_id,
                  row_number() over (ORDER BY (select 0))    as index,
		          t1.vertex_id                               as node_id,
		          t1.edge_id                                 as relation_id
		   from bus.lib_shortest_paths(query,_start_id,_finish_id,true,false) as t1;
  --EXCEPTION  WHEN OTHERS THEN 
      RAISE  NOTICE 'count(i222): %',i; 
  END;
 
   -- Создадим временную таблицу paths, в которую сохраним найденные пути
  CREATE TEMPORARY TABLE tmp_results
  (
	path_id                integer,
	index                  integer,
    direct_route_id        bigint,
    relation_index         integer,
    route_id               integer,
    station_id             integer,
    move_time              interval,
    distance               double precision
  )ON COMMIT DROP;
  
  INSERT INTO tmp_results(path_id,index,direct_route_id,relation_index,route_id,station_id,move_time,distance)
  select  
       t1.path_id,
       t1.index,
       t1.direct_route_id,
       t1.relation_index,
       t1.route_id as route_id,
       t1.station_id as station_id,
       t1.ev_time + ( t1.last_index - t1.first_index)*bus._STATION_TIME_PAUSE() as move_time,
       t1.distance
from(
select temp_paths.path_id as path_id,
       temp_paths.index   as index, 
       bus.route_relations.station_b_id      as station_id,
       bus.route_relations.position_index  as relation_index,
       bus.route_relations.direct_route_id as direct_route_id,
       bus.direct_routes.route_id as route_id,
       sum(bus.route_relations.distance)       OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id)as distance,
       sum(bus.route_relations.ev_time)        OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id)as ev_time,
       min(bus.route_relations.position_index) OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id) as first_index,
       max(bus.route_relations.position_index) OVER (PARTITION BY temp_paths.path_id,bus.route_relations.direct_route_id) as last_index
       from temp_paths
         join bus._graph_nodes on bus._graph_nodes.id =  temp_paths.node_id
         join bus.route_relations on bus.route_relations.id = bus._graph_nodes.route_relation_id
         join bus.direct_routes on bus.direct_routes.id = bus.route_relations.direct_route_id
 ) as t1
 where (t1.relation_index = t1.first_index or t1.relation_index = t1.last_index ) ;
  
  
  INSERT INTO tmp_results(path_id,index,move_time,distance)
  select  
       path_id,
       index,
       graph_relations.move_time,
       graph_relations.distance
from temp_paths

         join ((SELECT id,relation_type,move_time,distance FROM bus._graph_relations) 
	           UNION ALL 
	           (SELECT id,relation_type,move_time,distance FROM temp_nearest_relations)
	          ) as graph_relations 
	      on graph_relations.id =  temp_paths.relation_id 
   where graph_relations.relation_type = 'c_route_transition';
 
 -- Возвратим таблицу way_elem 
   FOR _way_elem IN 
        SELECT 
		tmp_results.path_id  			        as path_id,
		tmp_results.index 			        as index,
		tmp_results.direct_route_id		    as direct_route_id,
		bus.routes.route_type_id 	    as route_type,  
		tmp_results.relation_index            as relation_index,
		bus.route_full_name(bus.routes.number,route_names.value) as route_name,
		station_names.value              as station_name, 
		tmp_results.move_time                  as move_time,
		time_table.freq                  as wait_time,
		bus.routes.cost                       as cost,
		tmp_results.distance                   as distance
        FROM tmp_results
	    LEFT JOIN bus.routes                                 ON bus.routes.id = tmp_results.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = tmp_results.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
          LEFT JOIN (select route_id,avg(freq) as freq from bus.time_routes group by route_id) as time_table 
                             ON  time_table.route_id = bus.routes.id
        WHERE (route_names.lang_id = _lang_id or route_names.lang_id IS NULL) AND
              (station_names.lang_id = _lang_id or station_names.lang_id IS NULL)
  LOOP
    -- _way_elem.wait_time = interval '00:00:00';
         RETURN NEXT _way_elem;
  END LOOP; 
    
   
  return;   
 -- Сохраним в _paths только нужную  инфу о маршрутах
 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		temp_paths.path_id                                    as path_id,
		temp_paths.graph_id									  as graph_id,
		temp_paths.index                                      as index,
		temp_paths.relation_id                                as relation_id,
		bus.route_relations.direct_route_id                   as direct_route_id,
		bus.route_relations.position_index                    as relation_index,
		bus.route_relations.station_b_id                      as station_id,
		graph_relations.relation_b_type                       as route_type,
		graph_relations.move_time                             as move_time,
		(graph_relations.cost_money*temp_use_routes.discount) as cost,
		graph_relations.distance                              as distance,
		graph_relations.is_transition                         as is_transition
		
	    FROM temp_paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = temp_paths.relation_id
	    LEFT JOIN ( (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM bus._graph_relations) 
	                 UNION ALL 
	                (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM temp_nearest_relations)) as graph_relations 
	         ON graph_relations.id = temp_paths.graph_id
	    LEFT JOIN temp_use_routes                                 ON temp_use_routes.id = graph_relations.relation_b_type 
	ORDER BY temp_paths.path_id,temp_paths.index
  LOOP
     -- Если текущий путь не меняется, 
     IF _curr_filter_path.relation_id = _start_id THEN
			
     ELSEIF _curr_filter_path.relation_id = _finish_id THEN
			--RAISE  NOTICE 'finish path: %',_curr_filter_path; 
 			 _temp_filter_path:= null;
             _temp_filter_path.distance   := _prev_filter_path.distance;
             _temp_filter_path.move_time  := _prev_filter_path.move_time;
			 _temp_filter_path.route_type :=  bus.route_type_enum('c_route_station_output');
			 _temp_filter_path.index      := 10000;
			 _temp_filter_path.path_id    := _prev_filter_path.path_id;
			 _paths:= array_append(_paths,_temp_filter_path);

     ELSEIF _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id OR
            _prev_filter_path.direct_route_id IS NULL THEN 
			-- RAISE  NOTICE 'path: %',_curr_filter_path; 
			
			-- Добавим данные о начале  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
			_temp_filter_path.move_time := _prev_filter_path.move_time;
			_temp_filter_path.cost      := _prev_filter_path.cost;
			_temp_filter_path.distance  := _prev_filter_path.distance;
			_paths:= array_append(_paths,_temp_filter_path);
             -- Обнулим накапливающие переменные времени передвижения и длины текущего маршрута
			_move_time := _curr_filter_path.move_time;
			_distance  := _curr_filter_path.distance;
     ELSEIF _curr_filter_path.graph_id <= 0 OR 
            _curr_filter_path.is_transition = true THEN
            --RAISE  NOTICE 'path: %',_curr_filter_path; 
            -- Добавим данные о конце  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
            _temp_filter_path.move_time := _move_time;
            _temp_filter_path.cost      := null;
            _temp_filter_path.distance  := _distance;
            _paths :=  array_append(_paths,_temp_filter_path);
	 ELSE
			--RAISE  NOTICE 'path: %',_curr_filter_path; 
			_move_time := _move_time + _curr_filter_path.move_time;
			_distance  := _distance + _curr_filter_path.distance;
     
     END IF;
     _prev_filter_path := _curr_filter_path;
    -- RAISE  NOTICE 'path: %',_curr_filter_path; 
   END LOOP;
  
 -- return data
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			        as path_id,
		paths.index 			        as index,
		bus.direct_routes.id 		    as direct_route_id,
		bus.routes.route_type_id 	    as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		time_table.freq                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	    LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
          LEFT JOIN (select route_id,avg(freq) as freq from bus.time_routes group by route_id) as time_table 
                             ON  time_table.route_id = bus.routes.id
                             
        WHERE (route_names.lang_id = _lang_id or route_names.lang_id IS NULL) AND
              (station_names.lang_id = _lang_id or station_names.lang_id IS NULL)
  LOOP
         RETURN NEXT _way_elem;
   END LOOP; 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--===============================================================================================================

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

INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_metro','c_metro',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_trolley','c_trolley',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_bus','c_bus',B'1');
INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_tram','c_tram',B'1');

--INSERT INTO bus.route_types (id,transport_id,visible) VALUES ('c_route_station_input','c_foot',B'0');
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
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_transition'),1.0);
INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_metro_transition'),0.0);

--INSERT INTO bus.discount_by_route_types(discount_id,route_type_id,discount) VALUES (_discount.id,bus.route_type_enum('c_route_station_input'),1.0);
--========================================================
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		
--====================================================================================================================	
CREATE OR REPLACE FUNCTION bus.get_city_id (_lang bus.lang_enum, _name text)
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
CREATE OR REPLACE FUNCTION bus.get_discount_id (_lang bus.lang_enum, _name text)
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
/* Функция возвращает дуги от/до точки, выбранной пользователем и ближайшими
   узлами графа
*/
CREATE OR REPLACE FUNCTION bus.find_nearest_relations(
   _location       geography,           -- местоположение точки назначения
   _city_id        bigint,              -- город
   max_distance    double precision     -- максимальное расстояние от/до точки назначения
)
RETURNS SETOF bus.nearest_relation AS
$BODY$
DECLARE
  _relation bus.nearest_relation;
BEGIN
    FOR _relation IN SELECT 
                              bus.route_relations.id          as id ,
                              st_distance(location,_location) as distance
                     FROM bus.route_relations
                     JOIN bus.stations           ON bus.stations.id = bus.route_relations.station_B_id  
                     WHERE city_id = _city_id AND  ST_DWithin(location, _location,max_distance)
    LOOP
         RETURN NEXT _relation;
   END LOOP;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  
--====================================================================================================================	
-- function returns sql-array of route_relation_id indexes
CREATE OR REPLACE FUNCTION bus.find_nearest_relations(
   _location geography,
   _city_id  bigint,
   _transports bus.transport_type_enum[],
   max_distance double precision
)
RETURNS SETOF bus.nearest_relation AS
$BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE  COST 100;	
  
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
 
 --====================================================================================================================	
 

CREATE OR REPLACE FUNCTION bus.drop_functions(_schema text, _del text = '')
RETURNS text AS
$BODY$
DECLARE
    _sql   text;
    _ct    text;

BEGIN
   SELECT INTO _sql, _ct
          string_agg('DROP '
                   || CASE p.proisagg WHEN true THEN 'AGGREGATE '
                                                ELSE 'FUNCTION ' END
                   || quote_ident(n.nspname) || '.' || quote_ident(p.proname)
                   || '('
                   || pg_catalog.pg_get_function_identity_arguments(p.oid)
                   || ');'
                  ,E'\n'
          )
          ,count(*)::text
   FROM   pg_catalog.pg_proc p
   LEFT   JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
   WHERE  n.nspname = _schema;
   -- AND p.proname ~~* 'f_%';                     -- Only selected funcs?
   -- AND pg_catalog.pg_function_is_visible(p.oid) -- Only visible funcs?

IF lower(_del) = 'del' THEN                        -- Actually delete!
   EXECUTE _sql;
   RETURN _ct || E' functions deleted:\n' || _sql;
ELSE                                               -- Else only show SQL.
   RETURN _ct || E' functions to delete:\n' || _sql;
END IF;

END;
$BODY$   LANGUAGE plpgsql ;


  
 --========================CONSTANTS======================================	


CREATE OR REPLACE FUNCTION bus._STATION_TIME_PAUSE()
RETURNS interval AS
$BODY$
DECLARE
BEGIN
 return interval '00:00:06';
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE;

--================

CREATE OR REPLACE FUNCTION bus._MAX_WALKING_DISTANCE()
RETURNS double precision AS
$BODY$
DECLARE
BEGIN
 return 600.0;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE NOT LEAKPROOF;

--================

CREATE OR REPLACE FUNCTION bus._MAX_TRANSITION_DISTANCE()
RETURNS double precision AS
$BODY$
DECLARE
BEGIN
 return 350.0;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE NOT LEAKPROOF;

--================

CREATE OR REPLACE FUNCTION bus._MAX_TREE_LEVEL()
RETURNS integer AS
$BODY$
DECLARE
BEGIN
 return 5;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE NOT LEAKPROOF;

--================

CREATE OR REPLACE FUNCTION bus._WALKING_SPEED()
RETURNS integer AS
$BODY$
DECLARE
 _foot_speed double precision;
BEGIN
 _foot_speed := 5; -- default value
 SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
 return _foot_speed;
END;
$BODY$   LANGUAGE plpgsql  IMMUTABLE;

--================== OLD ==================

/*


CREATE OR REPLACE FUNCTION bus._recurs_get_path_droutes(curr_node    bigint,
													    _droutes bigint[]
                                                     )
 RETURNS bigint[] AS
$BODY$
DECLARE
 _curr_rid bigint;
 _parent_id bigint;
BEGIN
  SELECT curr_rid,parent_id INTO _curr_rid,_parent_id FROM  bus._droute_trees WHERE id = curr_node;
  _droutes := array_append(_droutes,_curr_rid);
  IF _parent_id IS NOT NULL THEN
	_droutes := bus._recurs_get_path_droutes(_parent_id,_droutes);
  END IF;
  return _droutes;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;
                                                    
--==========================================================================================================================  


CREATE OR REPLACE FUNCTION bus._recurs_make_subpaths(curr_node    bus._droute_trees,
													 curr_droutes bigint[],
													 _city_id bigint
                                                     )
RETURNS void AS
$BODY$
DECLARE
 _r          record;
 new_node    bus._droute_trees;

 transition   bus.route_transition;
 _root_index  integer;
 
BEGIN
  curr_droutes :=  array_append(curr_droutes,curr_node.curr_rid);
  RAISE NOTICE '%', curr_droutes;
  FOR _r IN 
     SELECT bus.direct_routes.id as droute_id  FROM bus.direct_routes
     JOIN   bus.routes ON bus.routes.id = bus.direct_routes.route_id
     LEFT JOIN bus._droute_trees ON bus._droute_trees.curr_rid = bus.direct_routes.id AND parent_id = curr_node.id
     WHERE  city_id = _city_id AND
            bus.direct_routes.id <> ANY(curr_droutes) AND
            bus._droute_trees.id IS NULL AND 
            bus.possible_route_transiton(curr_node.curr_rid,bus.direct_routes.id,curr_node.curr_index) = true
  LOOP
    transition:= bus.find_route_transiton(curr_node.curr_rid, _r.droute_id,curr_node.curr_index);
    new_node.id                 := -1;
    new_node.parent_id          := curr_node.id;
    new_node.root_rid           := curr_node.root_rid;
    new_node.root_index         := -1;
    new_node.curr_rid           := _r.droute_id;
    new_node.curr_index         := transition.index_b;
    new_node.level              := curr_node.level + 1;
    new_node.parent_relation_id := transition.route_relation_a_id;
     
    if curr_node.level = 0 then
		new_node.root_index := transition.index_a;
    else
        new_node.root_index := curr_node.root_index;
    end if;
    
	INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (new_node.parent_id,   -- parent_id
			        new_node.root_rid,  -- root_rid
			        new_node.root_index,  -- root_index
			        new_node.curr_rid,    -- curr_rid
			        new_node.curr_index,    -- curr_index
			        new_node.level,            -- level
			        new_node.parent_relation_id  -- parent_relation_id
			        ) RETURNING id INTO new_node.id;
    --RAISE NOTICE '%', new_node.level;
	if new_node.level < 3 then
		execute bus._recurs_make_subpaths(new_node,curr_droutes,_city_id);
    end if;
  END LOOP; 
  
  
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus._make_subpaths(droute_id bigint, _city_id bigint)
RETURNS void AS
$BODY$
DECLARE
 _curr_node  bus._droute_trees%ROWTYPE;
 droutes bigint[];
BEGIN
  FOR _curr_node IN 
     SELECT * FROM  bus._droute_trees 
     WHERE bus._droute_trees.curr_rid = droute_id AND level < bus._MAX_TREE_LEVEL()
  LOOP
     droutes := bus._recurs_get_path_droutes(_curr_node.id, droutes ) ;
     EXECUTE bus._recurs_make_subpaths(_curr_node, droutes,_city_id);
 
  END LOOP;

END;
$BODY$
LANGUAGE plpgsql VOLATILE;

--==========================================================================================================================  
CREATE OR REPLACE FUNCTION bus.update_droute_trees(droute_id bigint)
RETURNS void AS
$BODY$
DECLARE
 _r  		  record;
 _city_id     bigint;
 _route_id    bigint;
 transition   bus.route_transition;
 _root_index  integer;
BEGIN
  -- Найдем id города, которому принадлежит текущий маршрут
  SELECT bus.routes.city_id,bus.routes.id INTO _city_id,_route_id FROM bus.direct_routes
       join bus.routes ON bus.routes.id = bus.direct_routes.route_id
       where bus.direct_routes.id = droute_id LIMIT 1;
 
  -- Удалим все ноды, соотв. текущему маршруту
  DELETE FROM bus._droute_trees WHERE curr_rid = droute_id;
  
  -- Добавим корень дерева 
  INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (NULL,droute_id,0,droute_id,0,0,NULL);
 
  --Добавим ноды, соотв. текущему маршруту к тем родителям, с которых возможен переход на текущий маршрут   
 FOR _r IN 
     select bus._droute_trees.id               as node_id,
			bus._droute_trees.root_rid         as root_rid,
			bus._droute_trees.root_index       as root_index,
			bus._droute_trees.curr_rid         as curr_rid,
			bus._droute_trees.curr_rid         as curr_index,
			bus._droute_trees.level            as level
			
			from bus._droute_trees
		    join bus.direct_routes ON bus.direct_routes.id = bus._droute_trees.curr_rid
			join bus.routes        ON bus.routes.id = bus.direct_routes.route_id
			where city_id = _city_id and
				level < bus._MAX_TREE_LEVEL() and
				bus.routes.id <> _route_id and
				bus.possible_route_transiton(curr_rid,droute_id,curr_index) = true
LOOP
    transition:= find_route_transiton(_r.curr_rid,droute_id,_r.curr_index);
    if _r.level = 0 then
		_root_index := transition.index_a;
    else
       _root_index  := _r.root_index;
    end if;
	INSERT INTO bus._droute_trees (parent_id,root_rid,root_index,curr_rid,curr_index,level,parent_relation_id)
			VALUES (_r.node_id,   -- parent_id
			        _r.root_rid,  -- root_rid
			        _root_index,  -- root_index
			        droute_id,    -- curr_rid
			        transition.index_b,    -- curr_index
			        _r.level+1,            -- level
			        transition.route_relation_a_id  -- parent_relation_id
			        );
 

END LOOP;
  -- Создадим поддеревья, корнями для которых являются ноды, соотв. текущему маршруту 
  EXECUTE bus._make_subpaths(droute_id,_city_id);

END;
$BODY$
LANGUAGE plpgsql VOLATILE;


--==========================================================================================================================  

CREATE OR REPLACE FUNCTION bus.possible_route_transiton( _from_droute_id  bigint, 
                                                    _to_droute_id    bigint,
                                                    _start_index     integer
                                                    )
RETURNS bool AS
$BODY$
DECLARE
 _r bus.route_transition;
 r1_id bigint;
 r2_id bigint;
BEGIN   
  SELECT bus.direct_routes.route_id INTO r1_id FROM bus.direct_routes where id = _from_droute_id LIMIT 1;
  SELECT bus.direct_routes.route_id INTO r2_id FROM bus.direct_routes where id = _to_droute_id LIMIT 1;
  if r1_id = r2_id then
    return false;
  end if;
  _r :=  bus.find_route_transiton(_from_droute_id,_to_droute_id,_start_index);
  if _r IS NULL THEN
    return false;
  END IF;
  return true;
END;
$BODY$
LANGUAGE plpgsql IMMUTABLE;
                                              
--==========================================================================================================================  

  CREATE OR REPLACE FUNCTION bus.find_shortest_paths(	_city_id  	bigint,
							_p1 		geography,
							_p2 		geography,
							_day_id 	bus.day_enum,
							_time_start  	time,
					        _max_distance 	double precision,
					        _route_types 	text[],
					        _discounts      double precision[],
					        _alg_strategy   bus.alg_strategy,
					        _lang_id        bus.lang_enum)
RETURNS SETOF bus.way_elem AS
$BODY$
DECLARE
 _foot_speed            double precision;
 _nearest_relation      bus.nearest_relation%ROWTYPE;
 relations_A 		    bus.nearest_relation[];
 relations_B 		    bus.nearest_relation[];
 query 			text;
 i 			integer;
 j 			integer;
 k                      integer;
 --count_i 		integer;
 --count_j 		integer;
 _relation_input_id     integer;  -- id of bus.route_relations row, which of route type is 'c_route_station_input'

 _curr_filter_path	bus.filter_path%ROWTYPE;
 _prev_filter_path	bus.filter_path;
 _temp_filter_path	bus.filter_path;
 _move_time             interval;
 _distance              double precision;
 _paths                 bus.filter_path[];
 _way_elem              bus.way_elem%ROWTYPE;
 _id_arr                integer[];
 _id                    integer;
 _start_id              integer;
 _finish_id             integer;
 _r                     record;
 transition_sql         text;
BEGIN

  -- Сохраним скорость движения пешехода (км/ч) в переменную  _foot_speed
  _foot_speed := 5; -- default value
  SELECT ev_speed INTO _foot_speed  FROM bus.transport_types  
         WHERE id = bus.transport_type_enum('c_foot');
  
  
 -- get _relation_input_id

  -- создадим временную таблицу  use_routes(id,discount) используемых типов маршрутов и 
  -- скидки по каждому в процентном эквиваленте(от 0 до 1)
  CREATE TEMPORARY  TABLE temp_use_routes  ON COMMIT DROP AS
    SELECT route_type as id,discount FROM 
	(select row_number() over (ORDER BY (select 0)) as id, unnest::bus.route_type_enum as route_type from 
		unnest( _route_types)
	) as route_types
    JOIN
    ( select row_number() over (ORDER BY (select 0)) as id, unnest as discount from 
                unnest( _discounts)
    ) as discounts
    ON discounts.id =  route_types.id;

  
 -- Зададим id начальной и конечной дуги
 _start_id  := -10;
 _finish_id := -11;
 transition_sql := ' AND bus._graph_relations.is_transition = false';
 --SELECT max(id) INTO _start_id FROM bus._graph_relations;       
  if  'c_route_transition' = ANY(_route_types) then
	transition_sql := '';
  end if;
 -- Найдем ближайшие дуги от начальной точки назначения и сохраним их во временную таблицу  nearest_relations
 CREATE TEMPORARY  TABLE temp_nearest_relations  ON COMMIT DROP AS
    (SELECT    -row_number() over (ORDER BY (select 0))-1 		      			as id,
              _start_id           												as relation_a_id,
              nr_table.id         												as relation_b_id,
              bus.routes.route_type_id                                          as relation_b_type,
              bus.time_routes.freq	                    						as wait_time,
			  (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			  bus.routes.cost                                                   as cost_money,
			  EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			  interval '00:01:00' + bus.time_routes.freq/2.0)                   as cost_time,
			  nr_table.distance                                                 as distance,
			  true                                                              as is_transition
		FROM bus.find_nearest_relations(_p1,
				 _city_id,
				 _max_distance) as nr_table
		JOIN bus.route_relations ON bus.route_relations.id = nr_table.id
		JOIN bus.direct_routes   ON bus.direct_routes.id = bus.route_relations.direct_route_id
		JOIN bus.routes          ON bus.routes.id = bus.direct_routes.route_id
		JOIN bus.time_routes     ON bus.time_routes.route_id = bus.routes.id
     );
     
  -- Найдем ближайшие дуги до конечной точки назначения и сохраним их в таблицу nearest_relations
  SELECT min(id) INTO i FROM temp_nearest_relations;  
  INSERT INTO temp_nearest_relations(id,relation_a_id,relation_b_id,relation_b_type,wait_time,
                                move_time,cost_money,cost_time,distance,is_transition)
  (SELECT    -row_number() over (ORDER BY (select 0)) +i     		           as id,
             nr_table.id                                                       as relation_a_id,
             _finish_id           										  	   as relation_b_id,
             bus.route_type_enum('c_route_station_output')           		   as relation_b_type,
             interval '00:00:00'                    						   as wait_time,
			 (nr_table.distance/1000.0/_foot_speed*60) * interval '00:01:00'   as move_time,
			 0.0		                                                       as cost_money,
			 EXTRACT(EPOCH FROM (nr_table.distance/1000.0/_foot_speed*60) * 
			 interval '00:01:00') 											   as cost_time,
			 nr_table.distance                                                 as distance,
			 true                                                              as is_transition
		FROM bus.find_nearest_relations(_p2,
				 _city_id,
				 _max_distance) as nr_table
     );
   
  -- Составим query графа
  IF _alg_strategy = bus.alg_strategy('c_time') THEN
  	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        cost_time                           as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        cost_time                      as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type' ||
  	         ')';
  	ELSEIF _alg_strategy = bus.alg_strategy('c_cost') THEN
  	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        temp_use_routes.discount*cost_money as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                  as source,' ||
  	         '        relation_b_id                  as target,' || 
  	         '        temp_use_routes.discount*cost_money as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type ' ||
  	         ')';
  ELSE
     	query := '(SELECT bus._graph_relations.id             as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        (cost_money + cost_time/10.0) as cost, '   ||
  	         '        bus._graph_relations.is_transition  as is_transition '   ||
  	         ' FROM bus._graph_relations '                       ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = bus._graph_relations.relation_b_type' ||
  	         '  where city_id = ' ||  _city_id                      ||
  	         transition_sql ||
  	         ')UNION ALL'                                        ||
  	         '(SELECT temp_nearest_relations.id           as id,'     ||
  	         '        relation_a_id                       as source,' ||
  	         '        relation_b_id                       as target,' || 
  	         '        (cost_money + cost_time/10.0)       as cost, '   ||
  	         '        temp_nearest_relations.is_transition  as is_transition '   ||
  	         ' FROM temp_nearest_relations '                          ||
  	         ' JOIN temp_use_routes ON temp_use_routes.id = temp_nearest_relations.relation_b_type ' ||
  	         ')';
   END IF;	
   i:=1;

  
  -- Создадим временную таблицу paths, в которую сохраним найденные пути
  CREATE TEMPORARY TABLE temp_paths
  (
     path_id     integer, -- id пути
     index       integer, -- индекс дуги
     relation_id integer, -- id дуги из таблицы bus.route_relations
     graph_id    bigint   -- id дуги из таблицы bus._graph_relations
  )ON COMMIT DROP;
  

  -- Найдем кратчайший путь
  BEGIN
     INSERT INTO temp_paths(path_id,index,relation_id,graph_id)
		   select t1.path_id                                 as path_id,
                  row_number() over (ORDER BY (select 0))    as index,
		          t1.vertex_id                               as relation_id,
		          t1.edge_id                                 as graph_id
		   from bus.lib_shortest_paths(query,_start_id,_finish_id,true,false) as t1;
 -- EXCEPTION  WHEN OTHERS THEN 
      RAISE  NOTICE 'count(i222): %',i; 
  END;
 -- Сохраним в _paths только нужную  инфу о маршрутах
 _prev_filter_path := null;
 FOR _curr_filter_path IN 
        SELECT 
		temp_paths.path_id                                    as path_id,
		temp_paths.graph_id									  as graph_id,
		temp_paths.index                                      as index,
		temp_paths.relation_id                                as relation_id,
		bus.route_relations.direct_route_id                   as direct_route_id,
		bus.route_relations.position_index                    as relation_index,
		bus.route_relations.station_b_id                      as station_id,
		graph_relations.relation_b_type                       as route_type,
		graph_relations.move_time                             as move_time,
		(graph_relations.cost_money*temp_use_routes.discount) as cost,
		graph_relations.distance                              as distance,
		graph_relations.is_transition                         as is_transition
		
	    FROM temp_paths 
        LEFT JOIN bus.route_relations                  	     ON bus.route_relations.id = temp_paths.relation_id
	    LEFT JOIN ( (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM bus._graph_relations) 
	                 UNION ALL 
	                (SELECT id,relation_b_type,move_time,cost_money,distance,is_transition FROM temp_nearest_relations)) as graph_relations 
	         ON graph_relations.id = temp_paths.graph_id
	    LEFT JOIN temp_use_routes                                 ON temp_use_routes.id = graph_relations.relation_b_type 
	ORDER BY temp_paths.path_id,temp_paths.index
  LOOP
     -- Если текущий путь не меняется, 
     IF _curr_filter_path.relation_id = _start_id THEN
			
     ELSEIF _curr_filter_path.relation_id = _finish_id THEN
			--RAISE  NOTICE 'finish path: %',_curr_filter_path; 
 			 _temp_filter_path:= null;
             _temp_filter_path.distance   := _prev_filter_path.distance;
             _temp_filter_path.move_time  := _prev_filter_path.move_time;
			 _temp_filter_path.route_type :=  bus.route_type_enum('c_route_station_output');
			 _temp_filter_path.index      := 10000;
			 _temp_filter_path.path_id    := _prev_filter_path.path_id;
			 _paths:= array_append(_paths,_temp_filter_path);

     ELSEIF _curr_filter_path.direct_route_id <> _prev_filter_path.direct_route_id OR
            _prev_filter_path.direct_route_id IS NULL THEN 
			-- RAISE  NOTICE 'path: %',_curr_filter_path; 
			
			-- Добавим данные о начале  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
			_temp_filter_path.move_time := _prev_filter_path.move_time;
			_temp_filter_path.cost      := _prev_filter_path.cost;
			_temp_filter_path.distance  := _prev_filter_path.distance;
			_paths:= array_append(_paths,_temp_filter_path);
             -- Обнулим накапливающие переменные времени передвижения и длины текущего маршрута
			_move_time := _curr_filter_path.move_time;
			_distance  := _curr_filter_path.distance;
     ELSEIF _curr_filter_path.graph_id <= 0 OR 
            _curr_filter_path.is_transition = true THEN
            --RAISE  NOTICE 'path: %',_curr_filter_path; 
            -- Добавим данные о конце  текущего маршрута
			_temp_filter_path           := _curr_filter_path;
            _temp_filter_path.move_time := _move_time;
            _temp_filter_path.cost      := null;
            _temp_filter_path.distance  := _distance;
            _paths :=  array_append(_paths,_temp_filter_path);
	 ELSE
			--RAISE  NOTICE 'path: %',_curr_filter_path; 
			_move_time := _move_time + _curr_filter_path.move_time;
			_distance  := _distance + _curr_filter_path.distance;
     
     END IF;
     _prev_filter_path := _curr_filter_path;
    -- RAISE  NOTICE 'path: %',_curr_filter_path; 
   END LOOP;
  
 -- return data
 FOR _way_elem IN 
        SELECT 
		paths.path_id  			        as path_id,
		paths.index 			        as index,
		bus.direct_routes.id 		    as direct_route_id,
		bus.routes.route_type_id 	    as route_type,  
		paths.relation_index            as relation_index,
		text(bus.routes.number) || bus.get_string_without_null(route_names.value)     as route_name,
		station_names.value              as station_name, 
		paths.move_time                  as move_time,
		time_table.freq                  as wait_time,
		paths.cost                       as cost,
		paths.distance                   as distance
        FROM unnest(_paths) as paths
        LEFT JOIN bus.direct_routes                    	     ON bus.direct_routes.id = paths.direct_route_id
	    LEFT JOIN bus.routes                                 ON bus.routes.id = bus.direct_routes.route_id
        LEFT JOIN bus.string_values as route_names           ON route_names.key_id = bus.routes.name_key  
        LEFT JOIN bus.stations                               ON bus.stations.id = paths.station_id
        LEFT JOIN bus.string_values as station_names	     ON station_names.key_id = bus.stations.name_key  
          LEFT JOIN (select route_id,avg(freq) as freq from bus.time_routes group by route_id) as time_table 
                             ON  time_table.route_id = bus.routes.id
                             
        WHERE (route_names.lang_id = _lang_id or route_names.lang_id IS NULL) AND
              (station_names.lang_id = _lang_id or station_names.lang_id IS NULL)
  LOOP
         RETURN NEXT _way_elem;
   END LOOP; 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;		

--===============================================================================================================
*/













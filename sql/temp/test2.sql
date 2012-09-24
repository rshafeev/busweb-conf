/*
CREATE TEMPORARY  TABLE graph  ON COMMIT DROP AS
select id, relation_a_id as source,relation_b_id as target,cost from bus.graph_relations where (day_id='c_Sunday' or day_id IS NULL)
and city_id = 3;


SELECT * FROM shortest_path('select * from graph where source<>1 OR (source=1 and target=19)',
	19, 10, true, false) as path;
	*/	
--    JOIN bus.graph_relations ON bus.graph_relations.id = path.edge_id;

  
select id, relation_a_id as source,relation_b_id as target,cost from bus.graph_relations where (day_id='c_Sunday' or day_id IS NULL)
and city_id = 3;
    
--select *  from bus.graph_relations; --where route_type_id <> 'c_route_foot';-- where (day_id='c_Sunday' or day_id IS NULL);

--select * from graph;
--select * from bus.graph_relations where (day_id='c_Sunday' or day_id IS NULL); 

--select * from bus.routes;
/*
select r1.station_b_id, r2.station_b_id,v1.value,v2.value,bus.graph_relations.route_type_id,r1.direct_route_id from bus.graph_relations 
    JOIN bus.route_relations as r1 ON r1.id = bus.graph_relations.relation_a_id
    JOIN bus.route_relations as r2 ON r2.id = bus.graph_relations.relation_b_id
    LEFT JOIN bus.stations  as st1 ON st1.id = r1.station_b_id
    LEFT JOIN bus.stations  as st2 ON st2.id = r2.station_b_id
    LEFT JOIN bus.string_values as v1 ON v1.key_id = st1.name_key
    LEFT JOIN bus.string_values as v2 ON v2.key_id = st2.name_key
where (bus.graph_relations.day_id IS NULL  or bus.graph_relations.day_id = day_enum('c_Sunday')) AND
    v1.lang_id = 'c_ru' and   v2.lang_id = 'c_ru' and bus.graph_relations.route_type_id='c_route_foot';
*/
   

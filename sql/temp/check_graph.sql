select * from bus.graph_relations
          left join bus.route_relations as ra ON ra.id = bus.graph_relations.relation_a_id
          left join bus.route_relations as rb ON rb.id = bus.graph_relations.relation_b_id
          left join bus.stations as sta ON sta.id = ra.station_b_id
          left join bus.stations as stb ON stb.id = rb.station_b_id
          left join bus.string_values as str_a ON str_a.key_id = sta.name_key
          left join bus.string_values as str_b ON str_b.key_id = stb.name_key

          where (str_a.lang_id = 'c_ru' or str_a.lang_id is NULL)  
                and (str_b.lang_id = 'c_ru' or str_b.lang_id is NULL)  ;

          
#ifndef SHORTESTPATHS_H
#define SHORTESTPATHS_H


#include "db_types.h"




//--------------C++ functions-----------------------
#ifdef __cplusplus
extern "C"{
#endif

int boost_dijkstra(edge_t *edges, unsigned int count, int start_vertex, int end_vertex,
                       bool directed, bool has_reverse_cost,
                       paths_element_t **paths, int *path_count, char **err_msg);

#ifdef __cplusplus
}
#endif // extern "C"





#endif

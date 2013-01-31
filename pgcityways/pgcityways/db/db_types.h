#ifndef TYPES_H
#define TYPES_H

#include "postgres.h"

typedef struct edge_columns
{
    int id;
    int source;
    int target;
    int cost;
    int is_transition;
    int reverse_cost;
    int route_id;
} edge_columns_t;


typedef struct edge
{
    int id;
    int source;
    int target;
    float8 cost;
    bool is_transition;
    int route_id;
   // float8 reverse_cost;
} edge_t;

typedef struct paths_element
{
    int path_id;
    int vertex_id;
    int edge_id;
} paths_element_t;

typedef struct paths
{
   paths_element_t* arr;
   int count;
} paths_t;

#endif // TYPES_H

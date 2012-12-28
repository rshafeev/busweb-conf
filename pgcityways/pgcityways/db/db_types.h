#ifndef TYPES_H
#define TYPES_H

#include "postgres.h"

typedef struct edge_columns
{
    int id;
    int source;
    int target;
    int cost;
    int reverse_cost;
} edge_columns_t;


typedef struct edge
{
    int id;
    int source;
    int target;
    float8 cost;
    float8 reverse_cost;
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

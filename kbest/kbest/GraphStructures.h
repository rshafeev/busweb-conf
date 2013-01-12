#ifndef GRAPHSTRUCTURES_H
#define GRAPHSTRUCTURES_H

#include "list.h"
struct GraphArc {
  int source;
  int dest;
  float weight;
  void *data;
};

struct GraphState {
  List<GraphArc> arcs;
};

struct Graph {
  GraphState *states;
  int nStates;
};

#endif // GRAPHSTRUCTURES_H

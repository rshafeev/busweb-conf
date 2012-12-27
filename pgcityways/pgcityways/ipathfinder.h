#ifndef IPATHFINDER_H
#define IPATHFINDER_H

#include "graph.h"

struct TPatchsResult{
  PathsContainer paths;
  char *err_msg;
  int result_code;
};

class IPathFinder
{
protected:
    Graph &graph;
public:
    virtual TPatchsResult findShortestPaths(int startVertexID, int endVertexID)=0;
    IPathFinder(Graph &graph);
};

#endif // IPATHFINDER_H

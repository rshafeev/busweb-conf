#ifndef IPATHFINDER_H
#define IPATHFINDER_H

#include "graph.h"
#include "pathscontainer.h"

struct TPatchsResult{
  PathsContainer paths;
  char *err_msg;
  int result_code;
};

class IPathFinder
{
protected:
    std::shared_ptr<Graph> graph;
public:
    virtual TPatchsResult findShortestPaths(int startVertexID, int endVertexID)=0;
    IPathFinder(std::shared_ptr<Graph> graph);
};

#endif // IPATHFINDER_H

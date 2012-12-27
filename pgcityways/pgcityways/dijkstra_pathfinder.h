#ifndef PATHFINDER_H
#define PATHFINDER_H
#include "ipathfinder.h"

class DijkstraPathFinder : public IPathFinder
{
private:
    std::shared_ptr<Path> findDijkstraShortestPath(graph_t &graph,
                                   vertex_descriptor m_source,
                                   vertex_descriptor m_target,
                                   std::vector<vertex_descriptor> &predecessors,
                                   std::vector<float8> &distances);
public:
    DijkstraPathFinder(Graph &graph);
    virtual TPatchsResult findShortestPaths(int startVertexID, int endVertexID);

};

#endif // PATHFINDER_H

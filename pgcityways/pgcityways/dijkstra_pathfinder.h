#ifndef PATHFINDER_H
#define PATHFINDER_H
#include "ipathfinder.h"

class DijkstraPathFinder : public IPathFinder
{
private:
    std::shared_ptr<Path> findDijkstraShortestPath(std::shared_ptr<Graph> graph,
                                   vertex_descriptor m_source,
                                   vertex_descriptor m_target);
public:
    DijkstraPathFinder(std::shared_ptr<Graph> graph);
    virtual TPatchsResult findShortestPaths(int startVertexID, int endVertexID);

};

#endif // PATHFINDER_H

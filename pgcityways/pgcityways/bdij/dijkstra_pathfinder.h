#ifndef PATHFINDER_H
#define PATHFINDER_H
#include "../core/ipathfinder.h"
#include "boostpath.h"

class DijkstraPathFinder : public IPathFinder
{
private:
    std::shared_ptr<BoostPath> findDijkstraShortestPath(std::shared_ptr<Graph> graph,
                                   vertex_descriptor m_source,
                                   vertex_descriptor m_target);
protected:
    std::shared_ptr<Graph> graph;
    paths_t getDBPathsTable(PathsContainer &pathsContainer);

public:
    DijkstraPathFinder(std::shared_ptr<Graph> graph);
    PathsContainer findShPaths(int startVertexID, int endVertexID,int maxPathsCunt);
    virtual paths_t findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt);


};

#endif // PATHFINDER_H

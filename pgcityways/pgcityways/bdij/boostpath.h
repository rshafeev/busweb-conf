#ifndef BOOSTPATH_H
#define BOOSTPATH_H
#include "../core/path.h"

#include "graph.h"

class BoostPath : public Path
{
    std::shared_ptr<Graph> graph;
public:
    BoostPath(std::shared_ptr<Graph> graph);
    BoostPath(std::shared_ptr<Graph> graph, vector<int>  vertexes);
    double getCost();
    bool getEdge(edge_t& edge);
    bool check();

};

#endif // BOOSTPATHMANAGER_H

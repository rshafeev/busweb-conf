#ifndef EPPSTEINPATHFINDER_H
#define EPPSTEINPATHFINDER_H

#include  "../core/ipathfinder.h"
#include "../core/graphdata.h"

class EppsteinPathFinder : public IPathFinder
{
    std::shared_ptr<GraphData> data;

public:
    EppsteinPathFinder(std::shared_ptr<GraphData> data);
    virtual paths_t findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt);
};

#endif // EPPSTEINPATHFINDER_H

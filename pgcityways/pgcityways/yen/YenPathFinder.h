#ifndef YENPATHFINDER_H
#define YENPATHFINDER_H


#include  "../core/ipathfinder.h"
#include "../core/graphdata.h"

class YenPathFinder : public IPathFinder
{
    std::shared_ptr<GraphData> data;
public:
    YenPathFinder(std::shared_ptr<GraphData> data);

    virtual paths_t findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt);

};

#endif // YENPATHFINDER_H

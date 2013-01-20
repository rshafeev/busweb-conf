#ifndef GRAPHDATA_H
#define GRAPHDATA_H
#include <memory>
#include "../db/db_types.h"
class GraphData
{
public:
    edge_t* edges;
    int  edgesCount;
    bool hasReverseCost;
    bool directed;
public:
    GraphData();
    ~GraphData();
};

#endif // GRAPHDATA_H

#ifndef TESTGRAPHDATALOADER_H
#define TESTGRAPHDATALOADER_H
#include <QString>
#include "graph.h"
class TestGraphDataLoader
{
public:
    TestGraphDataLoader();
    std::shared_ptr<GraphData> loadGraphData(QString fileName);
};

#endif // TESTGRAPHDATALOADER_H

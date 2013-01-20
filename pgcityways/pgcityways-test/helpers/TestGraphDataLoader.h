#ifndef TESTGRAPHDATALOADER_H
#define TESTGRAPHDATALOADER_H
#include <QString>
#include "core/graphdata.h"
class TestGraphDataLoader
{
public:
    TestGraphDataLoader();
    std::shared_ptr<GraphData> loadEuclidGraphData(QString fileName);
    std::shared_ptr<GraphData> loadWeightGraphData(QString fileName);
};

#endif // TESTGRAPHDATALOADER_H

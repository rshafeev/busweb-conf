#ifndef TESTGRAPHDATALOADER_H
#define TESTGRAPHDATALOADER_H
#include <QString>
#include  <memory>
#include <assert.h>
#include "GraphStructures.h"
class TestGraphDataLoader
{
public:
    TestGraphDataLoader();
    Graph loadGraphData(QString fileName);
};

#endif // TESTGRAPHDATALOADER_H

#ifndef PGCITYWAYSTEST_H
#define PGCITYWAYSTEST_H

#include <QtTest>

#include "graphdata.h"
class PgCityWaysTest : public QObject
{
    Q_OBJECT
    
public:

    std::shared_ptr<GraphData> graphData;

private Q_SLOTS:

    void initTestCase()
    {
        TestGraphDataLoader loader;
        graphData = loader.loadGraphData("../test-data/graph1.dat");

        for(int i=0;i < graphData->edgesCount; i++){
            edge_t e = graphData->edges[i];
            std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }
    }

    void cleanupTestCase()
    {
    }

    void testBoostDijkstra()
    {

    }


};





#include "moc/PgCityWaysTest.moc"

#endif

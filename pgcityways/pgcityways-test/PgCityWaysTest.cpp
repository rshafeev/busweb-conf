#ifndef PGCITYWAYSTEST_H
#define PGCITYWAYSTEST_H

#include <QtTest>

#include "graphdata.h"
#include "boost_dijkstra.cpp"
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
       paths_element_t      *paths;
       int paths_count;
       char * err_msg;
       int source = 1;
       int target = 6;
       int result = boost_dijkstra(graphData->edges,
                                   graphData->edgesCount,
                                   source,
                                   target,
                                   graphData->directed,
                                   graphData->hasReverseCost,
                                   &paths,
                                   &paths_count,
                                   &err_msg);

       if(paths_count>0)
       {
           delete[] paths;
       }
    }


};





#include "moc/PgCityWaysTest.moc"

#endif

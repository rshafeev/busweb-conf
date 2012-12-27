
#ifndef GRAPHTEST_H
#define GRAPHTEST_H

#include <QtTest>
#include "graph.h"
#include "testgraphdataloader.h"

class GraphTest : public QObject
{
    Q_OBJECT

public:
    std::shared_ptr<Graph> graph;
    std::shared_ptr<GraphData> graphData;
private slots:
    void testCase1(){

        QVERIFY2(true, "Failure");

    }
    void initTestCase(){
        TestGraphDataLoader loader;
        graphData = loader.loadGraphData("../test-data/graph1.dat");

        graph = std::shared_ptr<Graph>(new Graph(graphData) );

        for(int i=0;i < graphData->edgesCount; i++){
            edge_t e = graphData->edges[i];
            std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }

    }
    void cleanupTestCase(){

    }
};

#include "graphtest.moc"

#endif

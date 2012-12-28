
#ifndef GRAPHTEST_CPP
#define GRAPHTEST_CPP

#include <QtTest>
#include <qmetaobject.h>

#include "graph.h"
#include "dijkstra_pathfinder.h"
#include "helpers/TestGraphDataLoader.h"

class GraphTest : public QObject
{
    Q_OBJECT

public:
    std::shared_ptr<GraphData> graphData;
private slots:
    void initTestCase(){
        TestGraphDataLoader loader;
        graphData = loader.loadGraphData("../test-data/graph1.dat");

        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData) );

        for(int i=0;i < graphData->edgesCount; i++){
            edge_t e = graphData->edges[i];
            std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }

    }
    void cleanupTestCase(){

    }

    void buildGraphTest(){
        Graph graph(graphData);
        // Cравним кол-во дуг в исходных данных и в созданном объекте graph
        QCOMPARE(graphData->edgesCount,graph.getNumEdges());
    }

    void removeEdgeTest(){
        Graph graph(graphData);
        int source = 1;
        int target = 2;

        // Проверим, есть ли дуга между source и target
        std::shared_ptr<edge_t> e = graph.getEdge(source,target);
        QVERIFY(e.get() != nullptr);

        // Удалим дугу
        int beforeGraphSize = graph.getNumEdges();
        graph.removeEdge(source,target);
        int afterGraphSize = graph.getNumEdges();

        // Проверим, осталась ли дуга между source и target
        QCOMPARE(beforeGraphSize - afterGraphSize, 1);
        e = graph.getEdge(source,target);
        QVERIFY(e.get() == nullptr);
    }




};

#include "moc/GraphTest.moc"

#endif

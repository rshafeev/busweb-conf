
#ifndef DIJKSTRAPATHFINDERTEST_H
#define DIJKSTRAPATHFINDERTEST_H

#include <QtTest>
#include "bdij/graph.h"
#include "bdij/dijkstra_pathfinder.h"
#include  "helpers/TestGraphDataLoader.h"
class DijkstraPathFinderTest : public QObject
{
    Q_OBJECT

public:
    std::shared_ptr<GraphData> graphData;
    std::shared_ptr<GraphData> epsGraphData1;
private Q_SLOTS:
    void initTestCase(){
        TestGraphDataLoader loader;
        graphData = loader.loadEuclidGraphData("../test-data/graph1.dat");
        epsGraphData1 = loader.loadWeightGraphData("../test-data/graph2.dat");

        /*for(int i=0;i < graphData->edgesCount; i++){
            edge_t e = graphData->edges[i];
            std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }
        */

    }

    void findPathTest(){
        int source = 1;
        int target = 6;
        int maxPathsCount = 3;
        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));
        IPathFinder *finder = new DijkstraPathFinder(graph);
        paths_t result = finder->findShortestPaths(source,target,maxPathsCount);
        QVERIFY(result.count>0);

        delete finder;
    }

    /**
     * Проверка успешности поиска кратчайших путей на тестовом графе. Т
     * Тест должен завершиться успешно
     * без выброса исключений
     * @brief findPathAndCreateDBSetTest
     */
    void findPathAndCreateDBSetTest(){
        // prepare setup info
        int source = 1;
        int target = 6;
        int maxPathsCount = 30;

        // build graph
        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));

        // find shortest paths
        DijkstraPathFinder *finder = new DijkstraPathFinder(graph);
        PathsContainer paths = finder->findShPaths(source,target,maxPathsCount);

        // check result
        QVERIFY(paths.getPathsCount()>1);
        for(int i=0;i < paths.getPathsCount(); i++){
            BoostPath* path = ((BoostPath*) paths.getPath(i).get());
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout  << "Path(" << i <<") = "<< path->getCost() <<":";
            std::cout  << path->toString();
        }

        // clean memory
        delete finder;
    }

    /**
     * Поиск пути между нодами, которых нет в графе.
     * @brief findPathAndCreateDBSetTest
     */
    void checkNotFoundDestinationVertexesTest(){
        // prepare setup info
        int source = 100;
        int target = 200;
        int maxPathsCount = 3;
        // build graph
        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));

        // find shortest paths
        DijkstraPathFinder *finder = new DijkstraPathFinder(graph);
        PathsContainer paths = finder->findShPaths(source,target,maxPathsCount);

        // check result
        QVERIFY(paths.getPathsCount()==0);

    }

    void checkNotFoundPathsTest(){
        // prepare setup info
        int source = 100;
        int target = 200;
        int maxPathsCount = 3;

        // build graph

        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));

        // find shortest paths
        DijkstraPathFinder *finder = new DijkstraPathFinder(graph);
        PathsContainer paths = finder->findShPaths(source,target,maxPathsCount);

        // check result
        QVERIFY(paths.getPathsCount()==0);
        // clean memory
        delete finder;
    }

    void FoundOnlyOnePathTest(){
        // prepare setup info
        int source = 5;
        int target = 6;
        int maxPathsCount = 3;
        // build graph

        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));

        // find shortest paths
        DijkstraPathFinder *finder = new DijkstraPathFinder(graph);
        PathsContainer paths = finder->findShPaths(source,target,maxPathsCount);

        // check result
        QVERIFY(paths.getPathsCount()>=1);

        for(int i=0;i < paths.getPathsCount(); i++){
            BoostPath* path = ((BoostPath*) paths.getPath(i).get());
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout << path->toString();
        }

        // clean memory
        delete finder;
    }

    void findDijkstraShortestPathEdgTest(){
        // prepare setup info
        int source = 0;
        int target = 5;

        std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(epsGraphData1));
        vertex_descriptor _source = graph->getVertex(source);
        vertex_descriptor _target = graph->getVertex(target);

    }

    void cleanupTestCase(){

    }


};

#include "moc/DijkstraPathFinderTest.moc"

#endif


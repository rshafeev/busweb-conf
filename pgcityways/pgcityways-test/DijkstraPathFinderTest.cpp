
#ifndef DIJKSTRAPATHFINDERTEST_H
#define DIJKSTRAPATHFINDERTEST_H

#include <QtTest>
#include "graph.h"
#include "dijkstra_pathfinder.h"
#include  "helpers/TestGraphDataLoader.h"
class DijkstraPathFinderTest : public QObject
{
    Q_OBJECT

public:
    std::shared_ptr<GraphData> graphData;

private Q_SLOTS:
    void initTestCase(){
        TestGraphDataLoader loader;
        graphData = loader.loadGraphData("../test-data/graph1.dat");

        for(int i=0;i < graphData->edgesCount; i++){
            edge_t e = graphData->edges[i];
            std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }

    }

    void findPathTest(){
        int source = 1;
        int target = 6;
        Graph graph(graphData);
        IPathFinder *finder = new DijkstraPathFinder(graph);
        TPatchsResult result = finder->findShortestPaths(source,target);
        QVERIFY(result.paths.getPathsCount()>0);
        for(int i=0;i < result.paths.getPathsCount(); i++){
            std::shared_ptr<Path> path = result.paths.getPath(i);
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout << path->toString();
        }

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

        // build graph
        Graph graph(graphData);

        // find shortest paths
        IPathFinder *finder = new DijkstraPathFinder(graph);
        TPatchsResult result = finder->findShortestPaths(source,target);

        // check result
        QVERIFY(result.paths.getPathsCount()>0);
        for(int i=0;i < result.paths.getPathsCount(); i++){
            std::shared_ptr<Path> path = result.paths.getPath(i);
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout << path->toString();
        }

        paths_t  dbSet = graph.getDBPathsTable(result.paths);

        QVERIFY(dbSet.count>0);
        // clean memory
        delete finder;
        delete[] dbSet.arr;
    }

    /**
     * Поиск пути между нодами, которых нет в графе.
     * @brief findPathAndCreateDBSetTest
     */
    void checkNotFoundDestinationVertexesTest(){
        // prepare setup info
        int source = 100;
        int target = 200;

        // build graph
        Graph graph(graphData);

        // find shortest paths
        IPathFinder *finder = new DijkstraPathFinder(graph);
        TPatchsResult result = finder->findShortestPaths(source,target);

        // check result
        QVERIFY(result.paths.getPathsCount()==0);
        for(int i=0;i < result.paths.getPathsCount(); i++){
            std::shared_ptr<Path> path = result.paths.getPath(i);
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout << path->toString();
        }

        // create data base row data
        paths_t  dbSet = graph.getDBPathsTable(result.paths);
        QVERIFY(dbSet.count==0);
        // clean memory
        delete finder;
        delete[] dbSet.arr;
    }

    void checkNotFoundPathsTest(){
        // prepare setup info
        int source = 100;
        int target = 200;

        // build graph

        Graph graph(graphData);

        // find shortest paths
        IPathFinder *finder = new DijkstraPathFinder(graph);
        TPatchsResult result = finder->findShortestPaths(source,target);

        // check result
        QVERIFY(result.paths.getPathsCount()==0);
        QCOMPARE(result.result_code,-1);
        for(int i=0;i < result.paths.getPathsCount(); i++){
            std::shared_ptr<Path> path = result.paths.getPath(i);
            QCOMPARE(path->getVertexes().at(0),target);
            QCOMPARE(path->getVertexes().at(path->getVertexesCount()-1), source);
            std::cout << path->toString();
        }

        // create data base row data
        paths_t  dbSet = graph.getDBPathsTable(result.paths);
        QVERIFY(dbSet.count==0);
        cout << "edges count:" << dbSet.count << "\n";
        // clean memory
        delete finder;
        delete[] dbSet.arr;
    }

    void cleanupTestCase(){

    }


};

#include "moc/DijkstraPathFinderTest.moc"

#endif



#ifndef EPPSTEINPATHFINDERTEST_H
#define EPPSTEINPATHFINDERTEST_H

#include <QtTest>
#include "epps/EppsteinPathFinder.h"
#include  "helpers/TestGraphDataLoader.h"

class EppsteinPathFinderTest : public QObject
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
    }

    /**
     * Проверка успешности поиска кратчайших путей на тестовом графе.
     * Тест должен завершиться успешно
     * без выброса исключений
     * @brief findPathsTest
     */
    void findShortestPathsTest(){
        // prepare setup info
        int source = 1;
        int target = 6;
        int maxPathsCount = 30;

        cout << "findShortestPathsTest():\n";
        // find shortest paths
        EppsteinPathFinder *finder = new EppsteinPathFinder(graphData);
        paths_t paths = finder->findShortestPaths(source,target,maxPathsCount);

        // clean memory
        delete finder;
    }


    void cleanupTestCase(){

    }


};

#include "moc/EppsteinPathFinderTest.moc"

#endif


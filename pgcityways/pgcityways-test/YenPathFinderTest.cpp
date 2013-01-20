
#ifndef YENPATHFINDERTEST_H
#define YENPATHFINDERTEST_H

#include <QtTest>
#include "yen/YenPathFinder.h"
#include  "helpers/TestGraphDataLoader.h"
class YenPathFinderTest : public QObject
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
     * Проверка успешности поиска кратчайших путей на тестовом графе. Т
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
        YenPathFinder *finder = new YenPathFinder(graphData);
        paths_t paths = finder->findShortestPaths(source,target,maxPathsCount);

        // check result
        QVERIFY(paths.count>0);

        for(int i=0;i < paths.count; i++){
            cout << " | " << paths.arr[i].edge_id << " " << paths.arr[i].vertex_id << "\n";
        }
        // clean memory
        delete finder;
    }


    void cleanupTestCase(){

    }


};

#include "moc/YenPathFinderTest.moc"

#endif

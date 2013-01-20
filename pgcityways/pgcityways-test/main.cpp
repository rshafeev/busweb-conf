#define  TESTING_MODE
#define  DEBUG 1
#include <QCoreApplication>
#include <QTest>
#include <iostream>
#include <cstdlib>
#include <cstdio>

#include "log/testlogger.h"
#include "YenPathFinderTest.cpp"
#include "GraphTest.cpp"
#include "PgCityWaysTest.cpp"
#include "DijkstraPathFinderTest.cpp"



int main(int argc, char *argv[])
{

    QCoreApplication a(argc, argv);

    pgInitLog("pgcityways.log");

    GraphTest graphTest;
    PgCityWaysTest pgCityWaysTest;
    DijkstraPathFinderTest dijkstraPathFinderTest;
    YenPathFinderTest yenPathFinderTest;

    QTest::qExec(&graphTest, argc, argv);
    QTest::qExec(&dijkstraPathFinderTest, argc, argv);
    QTest::qExec(&pgCityWaysTest, argc, argv);
    QTest::qExec(&yenPathFinderTest, argc, argv);


    return 0;
}

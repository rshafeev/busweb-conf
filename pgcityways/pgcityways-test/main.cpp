#define  TESTING_MODE

#include <QCoreApplication>
#include <QTest>
#include <iostream>
#include <cstdlib>
#include <cstdio>

#include "GraphTest.cpp"
#include "PgCityWaysTest.cpp"
#include "DijkstraPathFinderTest.cpp"



int main(int argc, char *argv[])
{

    QCoreApplication a(argc, argv);

    GraphTest graphTest;
    PgCityWaysTest pgCityWaysTest;
    DijkstraPathFinderTest dijkstraPathFinderTest;

    QTest::qExec(&graphTest, argc, argv);
    QTest::qExec(&dijkstraPathFinderTest, argc, argv);
    QTest::qExec(&pgCityWaysTest, argc, argv);

    return 0;
}

#include <QCoreApplication>
#include <QTest>
#include <iostream>
#include <cstdlib>
#include <cstdio>
#include "graphtest.h"
#include "tst_pgcitywaystest.h"




int main(int argc, char *argv[])
{
   // freopen("testing.log", "w", stdout);
   // QCoreApplication a(argc, argv);
    GraphTest * graphTest = new GraphTest();
    QTest::qExec(graphTest, argc, argv);
    delete graphTest;

    //QTest::qExec(new PgcitywaysTest(), argc, argv);
    return 0;
}

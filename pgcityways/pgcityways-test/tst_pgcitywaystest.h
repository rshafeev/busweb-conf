#include <QString>
#include <QtTest>


class PgcitywaysTest : public QObject
{
    Q_OBJECT
    
public:
    PgcitywaysTest();
    
private Q_SLOTS:
    void testCase1();
    void testCase2();
    void initTestCase();
    void cleanupTestCase();
};

PgcitywaysTest::PgcitywaysTest()
{
}

void PgcitywaysTest::initTestCase()
{
}

void PgcitywaysTest::cleanupTestCase()
{
}

void PgcitywaysTest::testCase1()
{
    QVERIFY2(true, "Failure");
}

void PgcitywaysTest::testCase2()
{
    QBENCHMARK {

        QString s = "sdfsdf";
        s+="sdfdsf";
    }
}



#include "tst_pgcitywaystest.moc"

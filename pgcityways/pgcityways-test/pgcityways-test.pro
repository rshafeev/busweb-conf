#-------------------------------------------------
#
# Project created by QtCreator 2012-12-23T09:06:19
#
#-------------------------------------------------


QT       += core
QT       -= gui

CONFIG   += console
CONFIG   -= app_bundle
CONFIG   += qtestlib
TARGET   = pgcityways-test

TEMPLATE = app

CONFIG(debug, debug|release) {
    OBJECTS_DIR = debug
    DESTDIR = debug
}
else {
    OBJECTS_DIR = release
    DESTDIR = release
}

# INCLUDE SOURCES pgcityways ###

INCLUDEPATH += ../pgcityways


SOURCES +=  ../pgcityways/bdij/*.cpp \
    YenPathFinderTest.cpp
SOURCES +=  ../pgcityways/core/*.cpp
SOURCES +=  ../pgcityways/yen/*.cpp
SOURCES +=  ../pgcityways/log/*.cpp

HEADERS +=  ../pgcityways/bdij/*.h
HEADERS +=  ../pgcityways/core/*.h
HEADERS +=  ../pgcityways/yen/*.h
HEADERS +=  ../pgcityways/log/*.h
HEADERS +=  ../pgcityways/db/*.h
####################################

SOURCES +=    helpers/TestGraphDataLoader.cpp \
    DijkstraPathFinderTest.cpp \
    GraphTest.cpp \
    PgCityWaysTest.cpp\
    helpers/geopoint.cpp

HEADERS +=  helpers/TestGraphDataLoader.h \
            helpers/geopoint.h

#BOOST LIB
INCLUDEPATH +=/usr/include/boost
LIBS+=-L/usr/lib/boost  -lboost_graph \
      -Wl,-rpath,lib -Wl,-rpath,.

#POSTGRESQL LIB
INCLUDEPATH +=/usr/include/postgresql/9.2/server

QMAKE_CXXFLAGS += -std=c++0x

# UNIT TESTS
SOURCES += \
    main.cpp

QMAKE_EXTRA_COMPILERS += new_moc

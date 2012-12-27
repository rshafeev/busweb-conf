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

# INCLUDE pgcityways SOURCES

INCLUDEPATH+=../pgcityways
INCLUDEPATH+=../pgcityways/db
SOURCES +=  ../pgcityways/*.cpp \
    testgraphdataloader.cpp
HEADERS +=  ../pgcityways/*.h \
    testgraphdataloader.h
HEADERS +=  ../pgcityways/db/*.h

#QMAKE_CXXFLAGS += -std=c++0x

#BOOST LIB
INCLUDEPATH +=/usr/include/boost
LIBS+=-L/usr/lib/boost  -lboost_graph \
      -Wl,-rpath,lib -Wl,-rpath,.

#POSTGRESQL LIB
INCLUDEPATH +=/usr/include/postgresql/9.2/server

QMAKE_CXXFLAGS += -std=c++0x
# UNIT TESTS
SOURCES += \
    main.cpp \
    graphtest.h \
    tst_pgcitywaystest.h


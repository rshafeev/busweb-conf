
TEMPLATE = lib
TARGET = pgcityways

CONFIG -= console
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += dll
SOURCES += \
    db/shortestpaths.c \
    boost_dijkstra.cpp \
    graph.cpp \
    ipathfinder.cpp \
    dijkstra_pathfinder.cpp \
    path.cpp \
    pathscontainer.cpp \
    geopoint.cpp\
    graphdata.cpp \
    testlogger.cpp


HEADERS += \
    db/shortestpaths.h \
    db/db_types.h \
    graph.h \
    ipathfinder.h \
    dijkstra_pathfinder.h \
    path.h \
    pathscontainer.h \
    geopoint.h \
    graphdata.h \
    testlogger.h


#BOOST LIB
INCLUDEPATH +=/usr/include/boost
LIBS+=-L/usr/lib/boost  -lboost_graph \
      -Wl,-rpath,lib -Wl,-rpath,.

#POSTGRESQL LIB
INCLUDEPATH +=/usr/include/postgresql/9.2/server


CONFIG(debug, debug|release) {
    OBJECTS_DIR = debug/
    DESTDIR = debug/
}
else {
    OBJECTS_DIR = release/
    DESTDIR = release/
}
VERSION = 1.03

target.path = /usr/lib/postgresql/9.2/lib/
#target.files = release/libpgcityways.so
INSTALLS += target

QMAKE_EXTRA_TARGETS += check

# Настройки компилятора
QMAKE_CXXFLAGS += -std=c++0x

# QMAKE_CXXFLAGS_RELEASE -= -O2
# QMAKE_CXXFLAGS_RELEASE += -O3













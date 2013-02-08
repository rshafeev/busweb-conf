
TEMPLATE = lib
TARGET = pgcityways

CONFIG -= console
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += dll
SOURCES += \
    db/shortestpaths.c \
    db/boost_dijkstra.cpp \
    bdij/graph.cpp \
    core/ipathfinder.cpp \
    bdij/dijkstra_pathfinder.cpp \
    core/path.cpp \
    core/pathscontainer.cpp \
    core/graphdata.cpp \
    log/testlogger.cpp \
    yen/YenPathFinder.cpp \
    bdij/boostpath.cpp \
    epps/EppsteinPathFinder.cpp


HEADERS += \
    db/shortestpaths.h \
    db/db_types.h \
    bdij/graph.h \
    core/ipathfinder.h \
    bdij/dijkstra_pathfinder.h \
    core/path.h \
    core/pathscontainer.h \
    core/graphdata.h \
    log/testlogger.h \
    yen/YenPathFinder.h \
    bdij/boostpath.h \
    epps/EppsteinPathFinder.h


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













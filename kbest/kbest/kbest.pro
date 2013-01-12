
QT       += core
TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle

CONFIG(debug, debug|release) {
    OBJECTS_DIR = debug/
    DESTDIR = debug/
}
else {
    OBJECTS_DIR = release/
    DESTDIR = release/
}

SOURCES += main.cpp \
    TestGraphDataLoader.cpp

HEADERS += \
    graph.h \
    heap.h \
    list.h \
    kbest.h \
    TestGraphDataLoader.h \
    GraphStructures.h

#BOOST LIB
INCLUDEPATH +=/usr/include/boost
LIBS+=-L/usr/lib/boost  -lboost_graph \
      -Wl,-rpath,lib -Wl,-rpath,.


# Настройки компилятора
QMAKE_CXXFLAGS += -std=c++0x

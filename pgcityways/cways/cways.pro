
TEMPLATE = lib
TARGET = pgcityways

CONFIG -= console
CONFIG -= app_bundle
CONFIG -= qt
CONFIG += dll
SOURCES += \
    cityways.c \
    shortestways.c

HEADERS += cityways.h \
    shortestways.h
INCLUDEPATH +=/usr/include/postgresql/9.2/server



CONFIG(debug, debug|release) {
    OBJECTS_DIR = debug
    DESTDIR = debug
}
else {
    OBJECTS_DIR = release
    DESTDIR = release/
}
VERSION = 1.02

target.path = /usr/lib/postgresql/9.2/lib/
target.files = release/libpgcityways.so
INSTALLS += target

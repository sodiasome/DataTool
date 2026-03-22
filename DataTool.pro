QT       += core gui widgets

TARGET = DataTool
TEMPLATE = app

CONFIG += c++17

SOURCES += \
    src/main.cpp

# Suppress deprecation warnings for Qt features removed in Qt 6
DEFINES += QT_DEPRECATED_WARNINGS

# Place build artifacts under a local 'build' subdirectory so that
# the output path never contains non-ASCII characters inherited from
# TEMP/TMP environment variables (works around the jom temp-file error
# that occurs when the Windows username contains CJK characters).
OBJECTS_DIR = build/.obj
MOC_DIR     = build/.moc
RCC_DIR     = build/.rcc
UI_DIR      = build/.ui
DESTDIR     = build

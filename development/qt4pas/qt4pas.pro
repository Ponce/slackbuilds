VERSION      = 5.1.72
QT          += network webkit
DEFINES     += BINUX
TEMPLATE     = lib
SOURCES     += qtpas.cpp
TARGET       = qt4intf
target.path  = $${PREFIX}/lib$${LIBDIRSUFFIX}
INSTALLS    += target

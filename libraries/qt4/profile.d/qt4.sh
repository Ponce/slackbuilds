#!/bin/sh

# Environment variables for the qt4 package.

# It's a very bad idea to make this script executable. Anything that
# needs to build with qt4 should instead source this script. Failure
# to follow this advice will likely break various builds that use qt5.

QT4DIR=/usr/lib/qt4

if [ ! "$CPLUS_INCLUDE_PATH" = "" ]; then
  CPLUS_INCLUDE_PATH=$QT4DIR/include:$CPLUS_INCLUDE_PATH
else
  CPLUS_INCLUDE_PATH=$QT4DIR/include
fi

# put the qt4 stuff first in $PATH, so running e.g. 'qmake' will
# run the qt4 version, not the qt5 one.
PATH="$QT4DIR/bin:$PATH"

export QT4DIR
export CPLUS_INCLUDE_PATH

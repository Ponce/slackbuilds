#!/bin/csh

# Environment path variables for the Qt package

# It's a very bad idea to make this script executable. Anything that
# needs to build with qt4 should instead source this script. Failure
# to follow this advice will likely break various builds that use qt5.
# I seriously doubt anything will ever source this csh version, either.

setenv QT4DIR /usr/lib/qt4

# put the qt4 stuff first in $PATH, so running e.g. 'qmake' will
# run the qt4 version, not the qt5 one.
set path = ( $QT4DIR/bin $path )

if ( $?CPLUS_INCLUDE_PATH ) then
    setenv CPLUS_INCLUDE_PATH $QT4DIR/include:$CPLUS_INCLUDE_PATH
else
    setenv CPLUS_INCLUDE_PATH $QT4DIR/include
endif

#!/bin/sh
# Environment variables for the Qt package.
#
# It's best to use the generic directory to avoid
# compiling in a version-containing path:
if [ -d /usr/lib@LIBDIRSUFFIX@/qt5 ]; then
  QT5DIR=/usr/lib@LIBDIRSUFFIX@/qt5
else
  # Find the newest Qt directory and set $QT5DIR to that:
  for qtd in /usr/lib@LIBDIRSUFFIX@/qt5-* ; do
    if [ -d $qtd ]; then
      QT5DIR=$qtd
    fi
  done
fi
PATH="$PATH:$QT5DIR/bin"
export QT5DIR

#!/bin/sh
# Environment variables for the Qt package.
#
# It's best to use the generic directory to avoid
# compiling in a version-containing path:
if [ -d /usr/lib@LIBDIRSUFFIX@/qt6 ]; then
  QT6DIR=/usr/lib@LIBDIRSUFFIX@/qt6
else
  # Find the newest Qt directory and set $QT6DIR to that:
  for qtd in /usr/lib@LIBDIRSUFFIX@/qt6-* ; do
    if [ -d $qtd ]; then
      QT6DIR=$qtd
    fi
  done
fi
PATH="$PATH:$QT6DIR/bin"
export QT6DIR

#!/bin/bash

PRGNAM=ds-models
VERSION=15
REPO=http://ds-models.googlecode.com/svn/trunk/

rm -rf $PRGNAM-r$VERSION
svn export -r$VERSION $REPO $PRGNAM-r$VERSION
tar cvfz $PRGNAM-r$VERSION.tar.gz $PRGNAM-r$VERSION

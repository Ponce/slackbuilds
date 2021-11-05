#!/bin/bash

git clone https://code.videolan.org/videolan/x264.git

cd x264
  git checkout stable
  VERSION="git_$(git log --format="%ad_%h" --date=short | head -n 1 | tr -d -)"
  LONGDATE="$(git log -1 --format=%cd --date=format:%c )"
cd ..

mv x264 x264-$VERSION

tar --exclude-vcs -cf x264-$VERSION.tar x264-$VERSION
plzip -9 -v x264-$VERSION.tar
touch -d "$LONGDATE" x264-$VERSION.tar.lz

rm -rf x264-$VERSION

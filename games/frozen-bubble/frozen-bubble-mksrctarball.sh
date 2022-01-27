#!/bin/bash

git clone https://github.com/kthakore/frozen-bubble.git

cd frozen-bubble
  VERSION="git_$(git log --format="%ad_%h" --date=short | head -n 1 | tr -d -)"
  LONGDATE="$(git log -1 --format=%cd --date=format:%c )"
cd ..

mv frozen-bubble frozen-bubble-$VERSION

tar --exclude-vcs -cf frozen-bubble-$VERSION.tar frozen-bubble-$VERSION
plzip -9 -v frozen-bubble-$VERSION.tar
touch -d "$LONGDATE" frozen-bubble-$VERSION.tar.lz

rm -rf frozen-bubble-$VERSION

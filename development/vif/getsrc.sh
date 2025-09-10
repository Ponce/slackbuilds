#!/bin/sh

# the upstream URL's filename never changes, but the contents
# of the tarball do, including the top-level dir.

rm -f vif-current.tar.gz
wget https://jmvdveer.home.xs4all.nl/vif-current.tar.gz
VERSION="$( tar tf vif-current.tar.gz | head -1 | cut -d- -f2 | cut -d/ -f1 )"
mv vif-current.tar.gz vif-$VERSION.tar.gz
echo "$VERSION"
echo "vif-$VERSION.tar.gz"

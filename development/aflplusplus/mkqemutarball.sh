#!/bin/sh

# maintainer script. prepares qemuafl tarball for a given version of
# aflplusplus. requires network access and write permission to current
# directory. qemuafl has a long git history so this takes forever...

set -e

source ./aflplusplus.info

QEMUVER="$( tar xvfO AFLplusplus-$VERSION.tar.gz AFLplusplus-$VERSION/qemu_mode/QEMUAFL_VERSION )"
if [ -z "$QEMUVER" ]; then
  echo "Can't get qemuafl version, missing AFLplusplus tarball?" 1>&2
  exit 1
fi

echo "==> checking out qemuafl commit $QEMUVER"
rm -rf qemuafl qemuafl-$QEMUVER.tar.xz
git clone https://github.com/AFLplusplus/qemuafl
cd qemuafl
git checkout $QEMUVER
git submodule init
git submodule update
find . -name .git\* | xargs rm -rf
cd -
tar cvfJ qemuafl-$QEMUVER.tar.xz qemuafl
md5sum qemuafl-$QEMUVER.tar.xz

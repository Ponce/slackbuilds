#!/bin/bash

# 20211124 bkw: mkvendored.sh, part of libopenraw SBo SlackBuild.
# create libopenraw-vendored-sources-$VERSION-$BUILD.tar.xz
# requires network access, but does not require root privilege.

PRGNAM=libopenraw
CWD=$(pwd)
source ./$PRGNAM.info

set -e
WORKDIR=$( mktemp -d )
cd $WORKDIR

# don't depend on user's ~/.cargo
mkdir -p cargohome
export CARGO_HOME=$(pwd)/cargohome

grep '^BUILD=' $CWD/$PRGNAM.SlackBuild > 1
source ./1

tar xvf $CWD/$PRGNAM-$VERSION.tar.bz2
cd $PRGNAM-$VERSION/lib/mp4

for i in . mp4parse mp4parse_capi; do
  cd $i
    cargo vendor
    find vendor -type f -a -name \*.a -print0 | xargs -0 rm -f
	 mkdir -p .cargo
	 cat <<EOF >.cargo/config.toml
[source.crates-io]
replace-with = "vendored-sources"

[source.vendored-sources]
directory = "vendor"
EOF
  cd -
done

cd $WORKDIR
tar cvfJ $CWD/libopenraw-vendored-sources-$VERSION-$BUILD.tar.xz \
         $PRGNAM-$VERSION/lib/mp4/{,mp4parse/,mp4parse_capi/}{vendor,.cargo}
cd $CWD
rm -rf $WORKDIR

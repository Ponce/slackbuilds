#!/bin/bash

# create maturin-vendored-sources-$VERSION-$BUILD.tar.xz
# requires network access, but does not require root privilege.
# requires that maturin's REQUIRES need to be installed first
# and cargo-vendor-filterer if you want just the linux ones

CWD=$(pwd)
PRGNAM=${CWD##*/} #basename $CWD equivalent
source ./$PRGNAM.info

set -e
WORKDIR=$( mktemp -d )
cd $WORKDIR

# don't depend on user's ~/.cargo
mkdir -p cargohome
export CARGO_HOME=$(pwd)/cargohome

egrep "^BUILD=|^SRCNAM=" $CWD/$PRGNAM.SlackBuild > 1
source ./1

tar xvf $CWD/$SRCNAM-$VERSION.tar.gz
cd $SRCNAM-$VERSION

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i586 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi

if [ "$ARCH" = "i586" ]; then
  SLKCFLAGS="-O2 -march=i586 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
fi

# check if rust16 is installed
if [ ! -d /opt/rust16/bin ]; then
  echo "ERROR: The rust16 slackbuild is required to be installed"
  exit 1
else
  export PATH="/opt/rust16/bin:$PATH"
  if [ -z "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH="/opt/rust16/lib$LIBDIRSUFFIX"
  else
    export LD_LIBRARY_PATH="/opt/rust16/lib$LIBDIRSUFFIX:$LD_LIBRARY_PATH"
  fi
fi

# Configure cargo-vendor-filterer
  cat << EOF >> Cargo.toml
[package.metadata.vendor-filter]
platforms = ["x86_64-unknown-linux-gnu", "i686-unknown-linux-gnu"]
all-features = true
EOF

if [ -f ~/.cargo/bin/cargo-vendor-filterer ] || [ -f /usr/bin/cargo-vendor-filterer ]; then
  echo "INFO: Creating filtered vendor libs tarball..."
  ~/.cargo/bin/cargo-vendor-filterer
else
  echo "WARNING: Creating unfiltered vendor libs tarball!"
  cargo vendor
fi

# build would fail if the .a files were removed
#find vendor -type f -a -name \*.a -print0 | xargs -0 rm -f

mkdir -p .cargo
  cat <<EOF >.cargo/config.toml
[source.crates-io]
replace-with = "vendored-sources"

[source.vendored-sources]
directory = "vendor"
EOF
cd -

cd $WORKDIR
tar cvfJ $CWD/$SRCNAM-vendored-sources-$VERSION-$BUILD.tar.xz \
         $SRCNAM-$VERSION/{vendor,.cargo}
cd $CWD
rm -rf $WORKDIR

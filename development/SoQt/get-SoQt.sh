#!/bin/sh

# We must have a tag to checkout
SoQt_TAG=${SoQt_TAG:-$1}
if [ -z $SoQt_TAG ]; then
  echo "Need a tag/version number. Exiting now ..."
  exit 1
fi

set -e

# Clear download area:
rm -rf soqt

# Clone repository:
git clone https://github.com/coin3d/soqt.git

( cd soqt && \
  git checkout "v${SoQt_TAG}" && \
  git submodule init && \
  git submodule update
)

( cd soqt && find . -name ".git*" -exec rm -rf {} \; 2>/dev/null || true )

# Generate tarball
echo "Generating tarball ..."
mv soqt soqt-$SoQt_TAG
tar cf soqt-$SoQt_TAG.tar soqt-$SoQt_TAG
plzip -9 soqt-$SoQt_TAG.tar
rm -rf soqt-$SoQt_TAG
echo
echo "soqt tarball generated as soqt-$SoQt_TAG.tar.lz"
echo

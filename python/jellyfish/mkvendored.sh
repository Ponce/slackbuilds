#!/bin/bash

# This is a wrapper script for cargo-mkvendored.sh which is
# included in the cargo-vendor-filterer slackbuild and needs to be
# installed.  It is only needed if you are upgrading the version and
# need new vendored rust libs.
#
# create $PRGNAM-vendored-sources-$VERSION-$VSBUILD.tar.xz
# requires network access, but does not require root privilege.
# requires that $PRGNAM's REQUIRES need to be installed first

if [ -f /usr/bin/cargo-mkvendored.sh ]; then
  /usr/bin/cargo-mkvendored.sh
else
  echo " ERROR: cargo-mkvendored.sh script is not available!!
 ERROR: Install the cargo-vendor-filterer slackbuild."
fi

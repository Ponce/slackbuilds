# douninst.sh
#
# uninstall script for Slackware >= 15.0
#
# NOTE: This script is run AFTER package removal, so be careful!
#       Consider it optional, use if it is really needed.

# DESCRIPTION: Cleanly removes GNU info files from the info directory.
# The info directory is what you see when you run "info" with no
# argument. If you don't rebuild the directory on package removal,
# users will see your package's info files in the dir, but trying to
# read them will fail (since they no longer exist).
if [ -x /usr/bin/install-info -a -d usr/info ]; then
  ( cd usr/info
    rm -f dir
    for i in *.info*; do /usr/bin/install-info $i dir 2>/dev/null; done
  )
fi

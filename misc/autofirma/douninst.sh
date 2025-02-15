# douninst.sh
#
# uninstall script for Slackware >= 15.0
#
# NOTE: This script is run AFTER package removal, so be careful!
#       Consider it optional, use if it is really needed.
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q 2>&1
fi

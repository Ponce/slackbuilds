# relative paths here so it'll work when installing to an alternate root.
# should be run as both doinst.sh and douninst.sh.
if [ -x usr/bin/file ]; then
  cd etc/file
  ../../usr/bin/file --compile
fi

#!/bin/sh
# use this script to customize the way the engine should open URLs

for test_browser in firefox seamonkey opera
do
  browser=`which $test_browser`
  if [ "x$browser" != "x" ]
  then
    $browser -remote "openURL($1,new-window)" || $browser "$1"
    exit
  fi
done
# xterm -e lynx "$1"

exit 0

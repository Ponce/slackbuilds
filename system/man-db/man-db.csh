#!/bin/csh

# Set up environment for man-db. This file is part of the slackbuilds.org
# man-db build.

# Author: B. Watson. License: WTFPL

setenv MANPATH /opt/man-db/man:$MANPATH
set path = ( /opt/man-db/bin $path )
if ("`id -u`" == "0") then
   set path = ( /opt/man-db/sbin $path )
endif

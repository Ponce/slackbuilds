#!/bin/sh

# Set up environment for man-db. This file is part of the slackbuilds.org
# man-db build.

# Author: B. Watson. License: WTFPL

MANPATH="/opt/man-db/man:$MANPATH"
PATH="/opt/man-db/bin:$PATH"

if [ "$( id -u )" = "0" ]; then
  PATH="/opt/man-db/sbin:$PATH"
fi

export MANPATH
export PATH

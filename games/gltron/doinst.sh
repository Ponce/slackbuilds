#!/bin/bash

# I borrowed the .desktop file from Debian's repo, might as well
# install it for convenience's sake

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications > /dev/null 2>&1
fi

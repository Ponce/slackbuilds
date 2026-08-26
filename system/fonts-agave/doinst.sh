#!/bin/sh

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f >/dev/null 2>&1
fi

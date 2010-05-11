#!/bin/sh

# Update the X font indexes:
if [ -x usr/bin/fc-cache ]; then
  usr/bin/fc-cache -f
fi


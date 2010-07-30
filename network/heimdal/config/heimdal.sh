#!/bin/sh

MANPATH="$MANPATH:/usr/heimdal/man"
export MANPATH

PATH="${PATH}:/usr/heimdal/bin"
if [ x"${EUID}" == x"0" ]; then
  PATH="${PATH}:/usr/heimdal/sbin"
fi
export PATH

#!/bin/sh

# Set INFOPATH and MANPATH
INFOPATH="/usr/heimdal/info:"
MANPATH="${MANPATH}:/usr/heimdal/man"

PATH="${PATH}:/usr/heimdal/bin"
if [ x"${EUID}" == x"0" ]; then
  PATH="${PATH}:/usr/heimdal/sbin"
fi

export INFOPATH MANPATH PATH

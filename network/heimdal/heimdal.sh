#!/bin/sh

PATH="${PATH}:/usr/heimdal/bin"
if [ x"${EUID}" == x"0" ]; then
  PATH="${PATH}:/usr/heimdal/sbin"
fi
export PATH

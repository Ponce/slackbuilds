#!/bin/sh

if [ $(uname -m) = "x86_64" ]; then
    LIBDIRSUFFIX="64"
else
    LIBDIRSUFFIX=""
fi

export SBCL_HOME=/usr/lib${LIBDIRSUFFIX}/sbcl


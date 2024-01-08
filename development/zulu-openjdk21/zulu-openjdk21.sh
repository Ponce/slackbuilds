#!/bin/sh
export JAVA_HOME=/usr/lib%LIBDIRSUFFIX%/zulu-openjdk21
export MANPATH="${MANPATH}:${JAVA_HOME}/man"
export PATH="${PATH}:${JAVA_HOME}/bin"

if [ -z "$LD_LIBRARY_PATH" ]; then
  export LD_LIBRARY_PATH="${JAVA_HOME}/lib/server"
else
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${JAVA_HOME}/lib/server"
fi

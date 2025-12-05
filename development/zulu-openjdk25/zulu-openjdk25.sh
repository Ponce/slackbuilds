#!/bin/sh
export JAVA_HOME=/usr/lib%LIBDIRSUFFIX%/zulu-openjdk25
export MANPATH="${JAVA_HOME}/man:${MANPATH}"
export PATH="${JAVA_HOME}/bin:${PATH}"

if [ -z "$LD_LIBRARY_PATH" ]; then
  export LD_LIBRARY_PATH="${JAVA_HOME}/lib/server"
else
  export LD_LIBRARY_PATH="${JAVA_HOME}/lib/server:${LD_LIBRARY_PATH}"
fi

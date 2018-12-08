#!/bin/sh
export JAVA_HOME=/usr/lib64/adoptopenjdk@MAJORVER@
export MANPATH="${MANPATH}:${JAVA_HOME}/man"
export PATH="${PATH}:${JAVA_HOME}/bin"

#!/bin/csh
setenv JAVA_HOME /usr/lib64/adoptopenjdk@MAJORVER@
setenv MANPATH ${MANPATH}:${JAVA_HOME}/man
setenv PATH ${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/jre/bin

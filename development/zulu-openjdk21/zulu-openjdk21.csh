#!/bin/csh
setenv JAVA_HOME /usr/lib%LIBDIRSUFFIX%/zulu-openjdk21
setenv MANPATH ${MANPATH}:${JAVA_HOME}/man
setenv PATH ${PATH}:${JAVA_HOME}/bin

if ($?LD_LIBRARY_PATH == 1) then
  setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${JAVA_HOME}/lib/server
else
  setenv LD_LIBRARY_PATH ${JAVA_HOME}/lib/server
endif

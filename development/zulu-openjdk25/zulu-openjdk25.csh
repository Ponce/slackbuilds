#!/bin/csh
setenv JAVA_HOME /usr/lib%LIBDIRSUFFIX%/zulu-openjdk25
setenv MANPATH ${JAVA_HOME}/man:${MANPATH}
setenv PATH ${JAVA_HOME}/bin:${PATH}

if ($?LD_LIBRARY_PATH == 1) then
  setenv LD_LIBRARY_PATH ${JAVA_HOME}/lib/server:${LD_LIBRARY_PATH}
else
  setenv LD_LIBRARY_PATH ${JAVA_HOME}/lib/server
endif

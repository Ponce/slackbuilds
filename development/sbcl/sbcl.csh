#!/bin/csh

if (`uname -m` == "x86_64") then
    set LIBDIRSUFFIX="64"
else
    set LIBDIRSUFFIX=""
endif

setenv SBCL_HOME /usr/lib${LIBDIRSUFFIX}/sbcl


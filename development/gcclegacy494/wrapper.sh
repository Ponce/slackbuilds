#!/bin/sh
export LD_LIBRARY_PATH=%INSTLOC%/lib%LIBDIRSUFFIX%
exec %INSTLOC%/bin/%COMPILER%-4.9.4 "$@"

#!/bin/sh
export LD_LIBRARY_PATH=/usr/lib@LIBDIRSUFFIX@/TeighaFileConverter:$LD_LIBRARY_PATH
exec /usr/lib@LIBDIRSUFFIX@/TeighaFileConverter/TeighaFileConverter "$@"

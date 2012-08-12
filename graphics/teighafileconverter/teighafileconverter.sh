#!/bin/sh
export LD_LIBRARY_PATH=/usr/lib/TeighaFileConverter:$LD_LIBRARY_PATH
exec /usr/lib/TeighaFileConverter/TeighaFileConverter "$@"

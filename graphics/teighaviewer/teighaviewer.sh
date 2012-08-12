#!/bin/sh
export LD_LIBRARY_PATH=/usr/lib/TeighaViewer:$LD_LIBRARY_PATH
exec /usr/lib/TeighaViewer/TeighaViewer "$@"

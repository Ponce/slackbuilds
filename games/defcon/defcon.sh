#!/bin/sh

DEFCONPATH=/usr/lib/defcon
export LD_LIBRARY_PATH="$DEFCONPATH:$LD_LIBRARY_PATH"
$DEFCONPATH/defcon.bin.x86 "$@"

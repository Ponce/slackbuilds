#!/bin/sh

cd $(dirname $(readlink -f $0))
exec mono ./SMathStudio_Desktop.exe "$@"

#!/usr/bin/env bash


LD_LIBRARY_PATH+=:/usr/share/games/epsxe LD_PRELOAD=/usr/lib64/libcurl.so.4 /usr/share/games/epsxe/epsxe "$@"

#!/bin/sh
fl="-std=c99"
CC=${CC:-"gcc"}
for opt; do
  case "$opt" in
    -std=c99|-std=iso9899:1999) fl="";;
    -std=*) echo "`basename $0` called with non ISO C99 option $opt" >&2
	    exit 1;;
  esac
done
exec $CC $fl ${1+"$@"}

#!/bin/sh

SHARE=/usr/share/fujinet-pc
EXE=/usr/libexec/fujinet-pc/fujinet

if [ "$1" = "-help" -o "$1" = "--help" -o "$1" = "-h" ]; then
  echo -n "Usage: $( basename $0 ) "
  $EXE --help 2>&1 | grep '^Usage:' | cut -d' ' -f3-
  exit 0
fi

FUJINET_HOME="${FUJINET_HOME:-$HOME/.fujinet-pc}"
if [ ! -e "$FUJINET_HOME" ]; then
  echo "$FUJINET_HOME does not exist, populating from $SHARE"
  mkdir -p "$FUJINET_HOME" || exit 1
  cp -a $SHARE/* "$FUJINET_HOME" || exit 1
fi

cd "$FUJINET_HOME" || exit 1

echo "Starting FujiNet"
$EXE "$@"
rc=$?

# from sysexits.h
# #define EX_TEMPFAIL     75      /* temp failure; user is invited to retry */
while [ $rc -eq 75 ]; do
    echo "Restarting FujiNet"
    $EXE "$@"
    rc=$?
done

echo "FujiNet ended with exit code $rc"

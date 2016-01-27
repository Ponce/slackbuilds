#!/bin/bash

# Allow users to override command-line options
# Based on Gentoo's chromium package (and by extension, Debian's)
for FILE in /etc/chromium/*.conf ; do
  [[ -f ${FILE} ]] && source "${FILE}"
done

# Prefer user defined CHROMIUM_USER_FLAGS flags (from environment) over
# system default CHROMIUM_FLAGS (from /etc/chromium)/)
CHROMIUM_FLAGS=${CHROMIUM_USER_FLAGS:-$CHROMIUM_FLAGS}

export CHROME_WRAPPER=$(readlink -f "$0")
export CHROME_DESKTOP=chromium.desktop

exec /usr/lib@LIBDIRSUFFIX@/chromium/chromium $CHROMIUM_FLAGS "$@"

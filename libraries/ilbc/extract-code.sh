#!/bin/sh

# Copyright 2008 Mauro Giachero (mauro dot giachero at gmail dot com)
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This script extracts the source code files from rfc3951.txt, which
# should be fed from stdin.
# The first command line parameter, if provided, is used as the
# extraction folder.

set -e

FILENAME=""

# Create the extraction folder
if [ "$1" != "" ] ; then
  mkdir -p "$1"
  cd "$1"
fi

# Jump to appendix A
while :; do
  if ! IFS= read LINE ; then
    echo "Error: file ended prematurely." >&2
    exit 1
  fi

  if [ "$LINE" = "APPENDIX A.  Reference Implementation" ]; then
    break
  fi
done

# Read the source code
while :; do
  if ! IFS= read LINE ; then
    break
  fi

  if [ "${LINE:0:2}" = "A." ]; then             # Source file begin
    FILENAME=`echo ${LINE:6}`
    if [ -e $FILENAME ]; then
      echo "Error: file '$FILENAME' already exists!"
      exit 2
    fi
    echo "$FILENAME"
  elif [ "${LINE:0:8}" = "Andersen" ]; then     # Footer
    continue
  elif [ "${LINE:0:3}" = "RFC" ]; then          # Header
    continue
  elif [ "$LINE" = "Authors' Addresses" ]; then # Appendix end
    break
  elif [ "$FILENAME" != "" ]; then              # File content
    echo "$LINE" >>$FILENAME
  fi
done

# One extra check, just in case
if [ "$FILENAME" = "" ]; then
  echo "Error: no source file found!"
  exit 3
fi

# Apparently everything went ok
exit 0

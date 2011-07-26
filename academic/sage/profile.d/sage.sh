#!/bin/sh
# Add SAGE_ROOT PATH and MANPATH for Sage:
SAGE_ROOT=SAGEROOT
PATH="$PATH:${SAGE_ROOT}"
MANPATH="$MANPATH:${SAGE_ROOT}/local/man:${SAGE_ROOT}/local/share/man"

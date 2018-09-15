#!/bin/sh
# Add SAGE_ROOT PATH and MANPATH for Sage:
export SAGE_ROOT=/opt/SageMath
PATH="$PATH:${SAGE_ROOT}/local/bin"
MANPATH="$MANPATH:${SAGE_ROOT}/local/share/man"

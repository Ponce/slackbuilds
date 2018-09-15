#!/bin/csh
# Add SAGE_ROOT path and MANPATH for Sage:
setenv SAGE_ROOT /opt/SageMath
set path = ( $path ${SAGE_ROOT}/local/bin )
setenv MANPATH ${MANPATH}:${SAGE_ROOT}/local/share/man

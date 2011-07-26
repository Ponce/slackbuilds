#!/bin/csh
# Add SAGE_ROOT path and MANPATH for Sage:
setenv SAGE_ROOT SAGEROOT
set path = ( $path ${SAGE_ROOT} )
setenv MANPATH ${MANPATH}:${SAGE_ROOT}/local/man:${SAGE_ROOT}/local/share/man

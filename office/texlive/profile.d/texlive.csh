#!/bin/csh
# Add path and MANPATH for TeXlive:
set path = ( $path /usr/share/texmf/bin )
setenv MANPATH ${MANPATH}:/usr/share/texmf/doc/man

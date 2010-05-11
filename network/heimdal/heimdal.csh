#!/bin/csh

# Set INFOPATH and MANPATH
setenv INFOPATH "/usr/heimdal/info"
setenv MANPATH "${MANPATH}:/usr/heimdal/man"

setenv PATH "${PATH}:/usr/heimdal/bin"
if ( x"$uid" == x"0" ) then
  setenv PATH "${PATH}:/usr/heimdal/sbin"
endif

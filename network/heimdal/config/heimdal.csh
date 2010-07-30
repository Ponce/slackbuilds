#!/bin/csh

setenv MANPATH ${MANPATH}:/usr/heimdal/man

setenv PATH "${PATH}:/usr/heimdal/bin"
if ( x"$uid" == x"0" ) then
  setenv PATH "${PATH}:/usr/heimdal/sbin"
endif

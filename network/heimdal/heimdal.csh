#!/bin/csh

setenv PATH "${PATH}:/usr/heimdal/bin"
if ( x"$uid" == x"0" ) then
  setenv PATH "${PATH}:/usr/heimdal/sbin"
endif

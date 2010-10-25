#!/bin/csh
# xvnkb.so need to be preloaded for xvnkb to work
if ( $?LD_PRELOAD ) then
  setenv LD_PRELOAD ${LD_PRELOAD}:/usr/lib/xvnkb.so
else
  setenv LD_PRELOAD /usr/lib/xvnkb.so
endif

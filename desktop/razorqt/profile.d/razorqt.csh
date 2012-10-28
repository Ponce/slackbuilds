#!/bin/csh
if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:@RCONFDIR@
else
    setenv XDG_CONFIG_DIRS /etc/xdg:@RCONFDIR@
endif

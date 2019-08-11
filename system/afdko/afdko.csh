#!/bin/csh
set FDK_EXE = /opt/afdko/Tools/linux
if ( $?PATH ) then
  echo :${PATH}: | grep -q :${FDK_EXE}: || setenv PATH ${PATH}:${FDK_EXE}
else
  setenv PATH ${FDK_EXE}
endif
unset FDK_EXE

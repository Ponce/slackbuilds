#!/bin/sh
FDK_EXE="/opt/afdko/Tools/linux"
if [ ! "$PATH" = "" ]; then
  echo :$PATH: | grep -q :$FDK_EXE: || PATH=$PATH:$FDK_EXE
else
  PATH=$FDK_EXE
fi
export PATH
unset FDK_EXE

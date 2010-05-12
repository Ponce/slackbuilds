#!/bin/csh
setenv PATH ${PATH}:/usr/kerberos/bin
setenv MANPATH ${MANPATH}:/usr/kerberosman/
if ( "$uid" == "0") then
  setenv PATH ${PATH}:/usr/kerberos/sbin
endif

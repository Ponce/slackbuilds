#!/bin/csh

setenv AMDAPPSDKROOT /opt/amd-app-sdk
setenv AMDAPPSDKSAMPLESROOT /opt/amd-app-sdk

if ($?CPPFLAGS == 0) then
	setenv CPPFLAGS "-I$AMDAPPSDKROOT/include"
else
	setenv CPPFLAGS "$CPPFLAGS -I$AMDAPPSDKROOT/include"
endif

# For retrocompatibility with the former name of the SDK...
setenv ATISTREAMSDKROOT $AMDAPPSDKROOT

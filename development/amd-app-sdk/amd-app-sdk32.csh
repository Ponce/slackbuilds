#!/bin/sh

setenv AMDAPPSDKROOT /opt/amd-app-sdk
setenv AMDAPPSDKSAMPLESROOT /opt/amd-app-sdk
setenv LD_LIBRARY_PATH ${AMDAPPSDKROOT}/lib/x86:${LD_LIBRARY_PATH}

#!/bin/sh

export AMDAPPSDKROOT=/opt/amd-app-sdk
export AMDAPPSDKSAMPLESROOT=/opt/amd-app-sdk
export CPPFLAGS="$CPPFLAGS -I$AMDAPPSDKROOT/include"

# For retrocompatibility with the former name of the SDK...
export ATISTREAMSDKROOT=$AMDAPPSDKROOT

#!/bin/sh

export AMDAPPSDKROOT=/opt/amd-app-sdk
export AMDAPPSDKSAMPLESROOT=/opt/amd-app-sdk
export LD_LIBRARY_PATH=${AMDAPPSDKROOT}/lib/x86_64:${LD_LIBRARY_PATH}

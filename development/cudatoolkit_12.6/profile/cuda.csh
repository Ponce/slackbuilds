#!/bin/csh
setenv PATH /opt/cuda-@VERSION@/bin:${PATH}
setenv CUDA_PATH /opt/cuda-@VERSION@
setenv MANPATH "/opt/cuda-@VERSION@/gds/man":${MANPATH}
setenv PKG_CONFIG_PATH "/opt/cuda-@VERSION@/usr/lib64/pkgconfig/":${PKG_CONFIG_PATH}

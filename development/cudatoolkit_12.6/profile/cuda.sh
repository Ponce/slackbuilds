export CUDA_PATH=/opt/cuda-@VERSION@
export PATH="/opt/cuda-@VERSION@/bin:/opt/cuda-@VERSION@/nsight_compute:/opt/cuda-@VERSION@/nsight_systems/bin":"$PATH"
export MANPATH="/opt/cuda-@VERSION@/gds/man":"$MANPATH"
export PKG_CONFIG_PATH="/opt/cuda-@VERSION@/usr/lib64/pkgconfig/":"$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="/opt/cuda-@VERSION@/lib64:/opt/cuda-@VERSION@/nvvm/lib64:/opt/cuda-@VERSION@/extras/CUPTI/lib64":"$LD_LIBRARY_PATH"

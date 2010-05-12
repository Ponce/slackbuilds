if [ -x /usr/bin/update-desktop-database ]; then
  ./usr/bin/update-desktop-database -q usr/share/applications
fi

if ! [ -e usr/lib/xorg/modules/libwfb.so ]; then
  ( cd usr/lib/xorg/modules ; ln -s libnvidia-wfb.so.1 libwfb.so )
fi

( cd usr/lib/tls ; rm -rf libnvidia-tls.so.1 )
( cd usr/lib/tls ; ln -sf tls/libnvidia-tls.so.PKGVERSION libnvidia-tls.so.1 )
( cd usr/lib/xorg/modules ; rm -rf libnvidia-wfb.so.1 )
( cd usr/lib/xorg/modules ; ln -sf libnvidia-wfb.so.PKGVERSION libnvidia-wfb.so.1 )
( cd usr/lib ; rm -rf libnvidia-cfg.so.1 )
( cd usr/lib ; ln -sf libnvidia-cfg.so.PKGVERSION libnvidia-cfg.so.1 )
( cd usr/lib ; rm -rf libnvidia-tls.so.1 )
( cd usr/lib ; ln -sf libnvidia-tls.so.PKGVERSION libnvidia-tls.so.1 )
( cd usr/lib ; rm -rf libXvMCNVIDIA_dynamic.so.1 )
( cd usr/lib ; ln -sf libXvMCNVIDIA.so.PKGVERSION libXvMCNVIDIA_dynamic.so.1 )
( cd usr/lib ; rm -rf libvdpau.so )
( cd usr/lib ; ln -sf libvdpau.so.1 libvdpau.so )
( cd usr/lib ; ln -sf libvdpau.so.PKGVERSION libvdpau.so.1 )
( cd usr/lib ; rm -rf libvdpau_nvidia.so )
( cd usr/lib ; ln -sf libvdpau_nvidia.so.PKGVERSION libvdpau_nvidia.so )
( cd usr/lib ; rm -rf libvdpau_trace.so )
( cd usr/lib ; ln -sf libvdpau_trace.so.PKGVERSION libvdpau_trace.so )
( cd usr/lib ; rm -rf libnvidia-cfg.so )
( cd usr/lib ; ln -sf libnvidia-cfg.so.1 libnvidia-cfg.so )
( cd usr/lib ; rm -rf libcuda.so.1 )
( cd usr/lib ; ln -sf libcuda.so.PKGVERSION libcuda.so.1 )
( cd usr/lib ; rm -rf libcuda.so )
( cd usr/lib ; ln -sf libcuda.so.1 libcuda.so )

/usr/sbin/nvidia-switch --install
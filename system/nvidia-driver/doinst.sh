if [ -x /usr/bin/update-desktop-database ]; then
  ./usr/bin/update-desktop-database -q usr/share/applications
fi

if ! [ -e usr/libLIBDIRSUFFIX/xorg/modules/libwfb.so ]; then
  ( cd usr/libLIBDIRSUFFIX/xorg/modules ; ln -s libnvidia-wfb.so.1 libwfb.so )
fi

( cd usr/libLIBDIRSUFFIX/tls ; rm -rf libnvidia-tls.so.1 )
( cd usr/libLIBDIRSUFFIX/tls ; ln -sf libnvidia-tls.so.PKGVERSION libnvidia-tls.so.1 )
( cd usr/libLIBDIRSUFFIX/xorg/modules ; rm -rf libnvidia-wfb.so.1 )
( cd usr/libLIBDIRSUFFIX/xorg/modules ; ln -sf libnvidia-wfb.so.PKGVERSION libnvidia-wfb.so.1 )
( cd usr/libLIBDIRSUFFIX ; rm -rf libnvidia-cfg.so.1 )
( cd usr/libLIBDIRSUFFIX ; ln -sf libnvidia-cfg.so.PKGVERSION libnvidia-cfg.so.1 )
( cd usr/libLIBDIRSUFFIX ; rm -rf libnvidia-tls.so.1 )
( cd usr/libLIBDIRSUFFIX ; ln -sf libnvidia-tls.so.PKGVERSION libnvidia-tls.so.1 )
( cd usr/libLIBDIRSUFFIX ; rm -rf libXvMCNVIDIA_dynamic.so.1 )
( cd usr/libLIBDIRSUFFIX ; ln -sf libXvMCNVIDIA.so.PKGVERSION libXvMCNVIDIA_dynamic.so.1 )
( cd usr/libLIBDIRSUFFIX ; rm -rf libvdpau_nvidia.so )
( cd usr/libLIBDIRSUFFIX ; ln -sf libvdpau_nvidia.so.PKGVERSION libvdpau_nvidia.so )
( cd usr/libLIBDIRSUFFIX ; rm -rf libnvidia-cfg.so )
( cd usr/libLIBDIRSUFFIX ; ln -sf libnvidia-cfg.so.1 libnvidia-cfg.so )
( cd usr/libLIBDIRSUFFIX ; rm -rf libcuda.so.1 )
( cd usr/libLIBDIRSUFFIX ; ln -sf libcuda.so.PKGVERSION libcuda.so.1 )
( cd usr/libLIBDIRSUFFIX ; rm -rf libcuda.so )
( cd usr/libLIBDIRSUFFIX ; ln -sf libcuda.so.1 libcuda.so )

/usr/sbin/nvidia-switch --install

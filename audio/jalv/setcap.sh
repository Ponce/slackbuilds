if [ -x /sbin/setcap ]; then
  for BIN in jalv jalv.gtk jalv.gtk3 jalv.gtkmm jalv.qt; do
    [ -e usr/bin/$BIN ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$BIN
  done
fi

if [ -x /sbin/setcap ]; then
  for i in @BINS@; do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
fi

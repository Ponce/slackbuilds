if [ -x /sbin/setcap ]; then
  /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/jack-rack
fi

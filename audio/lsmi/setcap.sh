if [ -x /sbin/setcap ]; then
  for i in lsmi-joystick lsmi-keyhack lsmi-monterey lsmi-mouse; do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
fi

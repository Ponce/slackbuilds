if [ -x /sbin/setcap ]; then
  for i in jack-dl jack-osc jack-play jack-plumbing jack-record jack-scope jack-transport jack-udp; do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
fi

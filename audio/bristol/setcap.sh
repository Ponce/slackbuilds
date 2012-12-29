if [ -x /sbin/setcap ]; then
  for file in bristol brighton bristoljackstats; do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$file
  done
fi


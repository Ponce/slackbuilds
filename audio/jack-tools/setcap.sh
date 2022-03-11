# 20211128 bkw: lxvst-query doesn't need capabilities.

if [ -x /sbin/setcap ]; then
  for i in rju-data rju-dl rju-level rju-osc rju-play rju-plumbing rju-record rju-scope rju-transport rju-udp
  do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
  [ -x usr/bin/rju-lxvst ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/rju-lxvst
fi

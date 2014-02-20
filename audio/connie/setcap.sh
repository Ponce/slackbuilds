[ -x /sbin/setcap ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/connie
[ -x /sbin/setcap ] && [ -x usr/bin/connie_qt4 ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/connie_qt4

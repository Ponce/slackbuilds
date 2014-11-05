[ -x /sbin/setcap ] && [ -x usr/bin/calf_gtk ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/calf_gtk
[ -x /sbin/setcap ] && [ -x usr/bin/calfjackhost ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/calfjackhost


[ -x /sbin/setcap ] && [ -x usr/bin/ghostess ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/ghostess
[ -x /sbin/setcap ] && [ -x usr/bin/ghostess_universal_gui ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/ghostess_universal_gui


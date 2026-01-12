[ -x /sbin/setcap ] && [ -x usr/bin/jack_mix_box ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/jack_mix_box
[ -x /sbin/setcap ] && [ -x usr/bin/jack_mixer ] && /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/jack_mixer


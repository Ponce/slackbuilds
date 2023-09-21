if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /sbin/setcap ]; then
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep /usr/lib64/zulu-openjdk17/bin/java
fi

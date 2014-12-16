if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
   if [ -x /usr/bin/gtk-update-icon-cache ]; then
     /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
   fi
fi

if [ -x /sbin/setcap ]; then
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/hydrogen
fi


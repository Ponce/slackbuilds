if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/gdk-pixbuf-query-loaders ]; then
  if [ -d /usr/lib/gdk-pixbuf-2.0/2.10.0 ]; then
    /usr/bin/gdk-pixbuf-query-loaders > /usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
  fi
fi

if [ -x /sbin/setcap ] && [ -f usr/bin/PCSX2 ]; then
  /sbin/setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' usr/bin/PCSX2
fi

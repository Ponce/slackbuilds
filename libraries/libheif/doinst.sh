if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -x /usr/bin/update-gdk-pixbuf-loaders ]; then
  /usr/bin/update-gdk-pixbuf-loaders >/dev/null 2>&1
fi


if [ -x /usr/bin/xdg-desktop-menu ]; then
  /usr/bin/xdg-desktop-menu install \
    usr/share/desktop-directories/vice-org-vice-org.directory \
    usr/share/applications/vice-org-*.desktop
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/install-info -a -e usr/info/vice.info.gz ]; then
  /usr/bin/install-info usr/info/vice.info.gz usr/info/dir
fi

if [ -x /usr/bin/xdg-desktop-menu ]; then
  /usr/bin/xdg-desktop-menu install \
    usr/share/desktop-directories/vice-org-vice-org.directory \
    usr/share/applications/vice-org-*.desktop
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/vice.info.gz

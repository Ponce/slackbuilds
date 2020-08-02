if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
fi
if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi

chroot . /usr/bin/install-info --info-dir=/usr/info /usr/info/vice.info.gz

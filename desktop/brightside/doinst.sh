if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
chroot . gconftool-2 --makefile-install-rule \
    /usr/share/gconf/schemas/brightside.schemas \
    1>/dev/null


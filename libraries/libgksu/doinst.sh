GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/gksu.schemas \
    1>/dev/null 2>/dev/null

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database &> /dev/null
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database /usr/share/mime &> /dev/null
fi


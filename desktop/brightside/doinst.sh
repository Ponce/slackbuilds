GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
chroot . gconftool-2 --makefile-install-rule \
    /usr/share/gconf/schemas/brightside.schemas \
    1>/dev/null

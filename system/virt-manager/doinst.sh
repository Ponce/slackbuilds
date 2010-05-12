GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/virt-manager.schemas \
    1>/dev/null 


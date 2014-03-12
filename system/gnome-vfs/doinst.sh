schema_install() {
  SCHEMA="$1"
  GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
  chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/$SCHEMA \
    1>/dev/null 2>/dev/null
}

schema_install desktop_default_applications.schemas
schema_install desktop_gnome_url_handlers.schemas
schema_install system_dns_sd.schemas
schema_install system_http_proxy.schemas
schema_install system_smb.schemas


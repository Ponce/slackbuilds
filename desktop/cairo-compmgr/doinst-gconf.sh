schema_install() {
  SCHEMA="$1"
  GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
  chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/$SCHEMA \
    1>/dev/null
}

schema_install ccm-screen.schemas
schema_install ccm-shadow.schemas
schema_install ccm-window-animation.schemas
schema_install ccm-freeze.schemas
schema_install ccm-vala-window-plugin.schemas
schema_install ccm-fade.schemas
schema_install ccm-menu-animation.schemas
schema_install ccm-perf.schemas
schema_install ccm-snapshot.schemas
schema_install ccm-magnifier.schemas
schema_install ccm-mosaic.schemas
schema_install ccm-automate.schemas
schema_install ccm-opacity.schemas
schema_install ccm-decoration.schemas
schema_install ccm-display.schemas


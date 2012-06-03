schema_install() {
  SCHEMA="$1"
  GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
  chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/$SCHEMA \
    1>/dev/null
}

schema_install awn-applet-calendar.schemas
schema_install awn-applet-battery.schemas
schema_install awn-applet-mount.schemas
schema_install awn-applet-notification-area.schemas
schema_install awn-applet-places.schemas
schema_install awn-applet-sysmon.schemas
schema_install awn-applet-slickswitcher.schemas
schema_install awn-applet-bandwidth-monitor.schemas
schema_install awn-applet-to-do.schemas
schema_install awn-applet-notification-daemon.schemas
schema_install awn-applet-feeds.schemas
schema_install awn-applet-mail.schemas
schema_install awn-applet-media-control.schemas
schema_install awn-applet-cpufreq.schemas
schema_install awn-applet-digital-clock.schemas
schema_install awnsystemmonitor.schemas
schema_install awn-applet-weather.schemas
schema_install awn-applet-shinyswitcher.schemas
schema_install awn-applet-volume-control.schemas
schema_install awn-applet-webapplet.schemas
schema_install awn-applet-garbage.schemas
schema_install awn-applet-cairo-clock.schemas
schema_install awn-applet-quit.schemas
schema_install awn-applet-hardware-sensors.schemas
schema_install awn-applet-file-browser-launcher.schemas
schema_install awn-applet-media-player.schemas
schema_install awn-applet-comics.schemas
schema_install awn-applet-awnterm.schemas
schema_install awn-applet-dialect.schemas

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

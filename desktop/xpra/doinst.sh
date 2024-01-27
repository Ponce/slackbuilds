config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

# this list was made with:
# find /tmp/S?o/package-xpra/etc/xpra/ -type f | cut -d/ -f5-

for i in \
  etc/xpra/html5-client/default-settings.txt.new \
  etc/xpra/content-parent/10_default.conf.new \
  etc/xpra/xpra.conf.new \
  etc/xpra/http-headers/10_content_security_policy.txt.new \
  etc/xpra/http-headers/00_nocache.txt.new \
  etc/xpra/conf.d/42_client_keyboard.conf.new \
  etc/xpra/conf.d/15_file_transfers.conf.new \
  etc/xpra/conf.d/50_server_network.conf.new \
  etc/xpra/conf.d/55_server_x11.conf.new \
  etc/xpra/conf.d/10_network.conf.new \
  etc/xpra/conf.d/30_picture.conf.new \
  etc/xpra/conf.d/12_ssl.conf.new \
  etc/xpra/conf.d/20_audio.conf.new \
  etc/xpra/conf.d/40_client.conf.new \
  etc/xpra/conf.d/16_printing.conf.new \
  etc/xpra/conf.d/05_features.conf.new \
  etc/xpra/conf.d/65_proxy.conf.new \
  etc/xpra/conf.d/35_webcam.conf.new \
  etc/xpra/conf.d/60_server.conf.new \
  etc/xpra/content-categories/10_default.conf.new \
  etc/xpra/content-type/50_class.conf.new \
  etc/xpra/content-type/30_title.conf.new \
  etc/xpra/content-type/10_role.conf.new \
  etc/xpra/content-type/70_commands.conf.new \
  etc/xpra/xorg.conf.new \
  etc/xpra/xorg-uinput.conf.new
do
  config $i
done

# this symlink has to get created *after* the .new file has been config()'ed.
# I'm not sure what it exists for, but upstream's official RPM includes it.
( cd usr/share/xpra/www/ ; rm -rf default-settings.txt )
( cd usr/share/xpra/www/ ; ln -sf ../../../../etc/xpra/html5-client/default-settings.txt default-settings.txt )

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

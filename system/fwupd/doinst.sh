config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/fwupd/fwupd.conf.new
config etc/fwupd/remotes.d/lvfs-testing.conf.new
config etc/fwupd/remotes.d/lvfs.conf.new
config etc/fwupd/remotes.d/vendor-directory.conf.new
config etc/grub.d/35_fwupd.new

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config_blacklist() {
  # package_blacklist changed names to just blacklist in version 2.2, so make a copy
  # of package_blacklist -> blacklist for the user to compare with blacklist.new.
  NEW="etc/sboui/blacklist"
  OLD="etc/sboui/package_blacklist"
  if [[ ! -r $NEW && -r $OLD ]]; then
    cp $OLD $NEW
  fi
}

config etc/sboui/sboui.conf.new
config etc/sboui/sboui-backend.conf.new
config_blacklist
config etc/sboui/blacklist.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

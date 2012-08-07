config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/somefile.conf.new

# Keep same perms on rc.INIT.new:
if [ -e etc/rc.d/rc.INIT ]; then
  cp -a etc/rc.d/rc.INIT etc/rc.d/rc.INIT.new.incoming
  cat etc/rc.d/rc.INIT.new > etc/rc.d/rc.INIT.new.incoming
  mv etc/rc.d/rc.INIT.new.incoming etc/rc.d/rc.INIT.new
fi

config etc/rc.d/rc.INIT.new
config etc/configfile.new

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

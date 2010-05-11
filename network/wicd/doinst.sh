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

# Keep same perms on rc.wicd.new:
if [ -e etc/rc.d/rc.wicd ]; then
  cp -a etc/rc.d/rc.wicd etc/rc.d/rc.wicd.new.incoming
  cat etc/rc.d/rc.wicd.new > etc/rc.d/rc.wicd.new.incoming
  mv etc/rc.d/rc.wicd.new.incoming etc/rc.d/rc.wicd.new
fi

if [ -x usr/bin/update-desktop-database ]; then
  usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi

config etc/rc.d/rc.wicd.new
config etc/dbus-1/system.d/wicd.conf.new


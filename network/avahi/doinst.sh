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

# Keep same perms on rc.avahidaemon.new:
if [ -e etc/rc.d/rc.avahidaemon ]; then
  cp -a etc/rc.d/rc.avahidaemon etc/rc.d/rc.avahidaemon.new.incoming
  cat etc/rc.d/rc.avahidaemon.new > etc/rc.d/rc.avahidaemon.new.incoming
  mv etc/rc.d/rc.avahidaemon.new.incoming etc/rc.d/rc.avahidaemon.new
fi

# Keep same perms on rc.avahidnsconfd.new:
if [ -e etc/rc.d/rc.avahidnsconfd ]; then
  cp -a etc/rc.d/rc.avahidnsconfd etc/rc.d/rc.avahidnsconfd.new.incoming
  cat etc/rc.d/rc.avahidnsconfd.new > etc/rc.d/rc.avahidnsconfd.new.incoming
  mv etc/rc.d/rc.avahidnsconfd.new.incoming etc/rc.d/rc.avahidnsconfd.new
fi

config etc/rc.d/rc.avahidaemon.new
config etc/rc.d/rc.avahidnsconfd.new
config etc/avahi/avahi-daemon.conf.new
config etc/dbus-1/system.d/avahi-dbus.conf.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# Reload messagebus service
if [ -x etc/rc.d/rc.messagebus ]; then
  chroot . /etc/rc.d/rc.messagebus reload
fi


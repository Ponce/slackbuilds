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

# Keep same perms on rc.cdemud.new:
if [ -e etc/rc.d/rc.cdemud ]; then
  cp -a etc/rc.d/rc.cdemud etc/rc.d/rc.cdemud.new.incoming
  cat etc/rc.d/rc.cdemud.new > etc/rc.d/rc.cdemud.new.incoming
  mv etc/rc.d/rc.cdemud.new.incoming etc/rc.d/rc.cdemud.new
fi

config etc/rc.d/rc.cdemud.new
config etc/rc.d/rc.cdemud.conf.new
config etc/dbus-1/system.d/cdemud-dbus.conf.new
config etc/udev/rules.d/99-vhba.rules.new

# Reload dbus configuration
chroot . /etc/rc.d/rc.messagebus reload


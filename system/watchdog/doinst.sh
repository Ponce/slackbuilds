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

# Keep same perms on rc.watchdog:
if [ -e etc/rc.d/rc.watchdog ]; then
  cp -a etc/rc.d/rc.watchdog etc/rc.d/rc.watchdog.new.incoming
  cat etc/rc.d/rc.watchdog.new > etc/rc.d/rc.watchdog.new.incoming
  mv etc/rc.d/rc.watchdog.new.incoming etc/rc.d/rc.watchdog.new
fi

config etc/rc.d/rc.watchdog.new
config etc/watchdog.conf.new


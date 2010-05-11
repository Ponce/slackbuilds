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

# Keep same perms on rc.ulogd.new:
if [ -e etc/rc.d/rc.ulogd ]; then
  cp -a etc/rc.d/rc.ulogd etc/rc.d/rc.ulogd.new.incoming
  cat etc/rc.d/rc.ulogd.new > etc/rc.d/rc.ulogd.new.incoming
  mv etc/rc.d/rc.ulogd.new.incoming etc/rc.d/rc.ulogd.new
fi

config etc/ulogd.conf.new
config etc/logrotate.d/ulogd.new
config etc/rc.d/rc.ulogd.new


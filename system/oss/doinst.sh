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

# Keep same perms on rc.oss.new:
if [ -e etc/rc.d/rc.oss ]; then
  cp -a etc/rc.d/rc.oss etc/rc.d/rc.oss.new.incoming
  cat etc/rc.d/rc.oss.new > etc/rc.d/rc.oss.new.incoming
  mv etc/rc.d/rc.oss.new.incoming etc/rc.d/rc.oss.new
fi

config etc/oss.conf.new
config etc/rc.d/rc.oss.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

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

# Keep same perms on rc.mythbackend.new:
if [ -e etc/rc.d/rc.mythbackend ]; then
  cp -a etc/rc.d/rc.mythbackend etc/rc.d/rc.mythbackend.new.incoming
  cat etc/rc.d/rc.mythbackend.new > etc/rc.d/rc.mythbackend.new.incoming
  mv etc/rc.d/rc.mythbackend.new.incoming etc/rc.d/rc.mythbackend.new
fi

config etc/rc.d/rc.mythbackend.new
config etc/logrotate.d/mythbackend.new
config etc/mythtv/config.xml.new
config etc/mythtv/mysql.txt.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

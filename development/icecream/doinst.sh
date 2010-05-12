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

# Keep same perms on rc.iceccd.new:
if [ -e etc/rc.d/rc.iceccd ]; then
  cp -a etc/rc.d/rc.iceccd etc/rc.d/rc.iceccd.new.incoming
  cat etc/rc.d/rc.iceccd.new > etc/rc.d/rc.iceccd.new.incoming
  mv etc/rc.d/rc.iceccd.new.incoming etc/rc.d/rc.iceccd.new
fi

# Keep same perms on rc.icecc-scheduler.new:
if [ -e etc/rc.d/rc.icecc-scheduler ]; then
  cp -a etc/rc.d/rc.icecc-scheduler etc/rc.d/rc.icecc-scheduler.new.incoming
  cat etc/rc.d/rc.icecc-scheduler.new > etc/rc.d/rc.icecc-scheduler.new.incoming
  mv etc/rc.d/rc.icecc-scheduler.new.incoming etc/rc.d/rc.icecc-scheduler.new
fi

config etc/rc.d/rc.iceccd.new
config etc/rc.d/rc.icecream.conf.new
config etc/rc.d/rc.icecc-scheduler.new


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

# Keep same perms on rc.preload.new:
if [ -e etc/rc.d/rc.preload ]; then
  cp -a etc/rc.d/rc.preload etc/rc.d/rc.preload.new.incoming
  cat etc/rc.d/rc.preload.new > etc/rc.d/rc.preload.new.incoming
  mv etc/rc.d/rc.preload.new.incoming etc/rc.d/rc.preload.new
fi

# Create log file and state file if they are not already there
[ ! -e var/log/preload.log ] && touch var/log/preload.log
[ ! -e var/lib/preload/preload.state ] && touch var/lib/preload/preload.state

config etc/rc.d/rc.preload.new
config etc/preload.conf.new
config etc/logrotate.d/preload.new


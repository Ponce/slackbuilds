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

# Keep same perms on rc.atop.new:
if [ -e etc/rc.d/rc.atop ]; then
  cp -a etc/rc.d/rc.atop etc/rc.d/rc.atop.new.incoming
  cat etc/rc.d/rc.atop.new > etc/rc.d/rc.atop.new.incoming
  mv etc/rc.d/rc.atop.new.incoming etc/rc.d/rc.atop.new
fi

config etc/rc.d/rc.atop.new
config etc/logrotate.d/psacct.new

touch var/log/atop/daily.log


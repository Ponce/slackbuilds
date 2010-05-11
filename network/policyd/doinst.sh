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

# Keep same perms on rc.policyd.new:
if [ -e etc/rc.d/rc.policyd ]; then
  cp -a etc/rc.d/rc.policyd etc/rc.d/rc.policyd.new.incoming
  cat etc/rc.d/rc.policyd.new > etc/rc.d/rc.policyd.new.incoming
  mv etc/rc.d/rc.policyd.new.incoming etc/rc.d/rc.policyd.new
fi

config etc/rc.d/rc.policyd.new
config etc/policyd.conf.new


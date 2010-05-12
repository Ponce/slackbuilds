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

# Keep same perms on rc.radvd.new:
if [ -e etc/rc.d/rc.radvd ]; then
  cp -a etc/rc.d/rc.radvd etc/rc.d/rc.radvd.new.incoming
  cat etc/rc.d/rc.radvd.new > etc/rc.d/rc.radvd.new.incoming
  mv etc/rc.d/rc.radvd.new.incoming etc/rc.d/rc.radvd.new
fi

# Keep same perms on radvd.conf.new:
if [ -e etc/radvd.conf ]; then
  cp -a etc/radvd.conf etc/radvd.conf.new.incoming
  cat etc/radvd.conf.new > etc/radvd.conf.new.incoming
  mv etc/radvd.conf.new.incoming etc/radvd.conf.new
fi

config etc/rc.d/rc.radvd.new
config etc/radvd.conf.new


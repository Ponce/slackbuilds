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

# Keep same perms on rc.pdnsd.new:
if [ -e etc/rc.d/rc.pdnsd ]; then
  cp -a etc/rc.d/rc.pdnsd etc/rc.d/rc.pdnsd.new.incoming
  cat etc/rc.d/rc.pdnsd.new > etc/rc.d/rc.pdnsd.new.incoming
  mv etc/rc.d/rc.pdnsd.new.incoming etc/rc.d/rc.pdnsd.new
fi

config etc/rc.d/rc.pdnsd.new
config etc/pdnsd.conf.new


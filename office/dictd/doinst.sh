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

# Keep same perms on rc.dictd.new:
if [ -e etc/rc.d/rc.dictd ]; then
  cp -a etc/rc.d/rc.dictd etc/rc.d/rc.dictd.new.incoming
  cat etc/rc.d/rc.dictd.new > etc/rc.d/rc.dictd.new.incoming
  mv etc/rc.d/rc.dictd.new.incoming etc/rc.d/rc.dictd.new
fi

config etc/rc.d/rc.dictd.new
config etc/dictd/dict.conf.new
config etc/dictd/dictd.conf.new
config etc/dictd/db.list.new


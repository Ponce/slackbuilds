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

# Keep same perms on rc.openctd.new:
if [ -e etc/rc.d/rc.openctd ]; then
  cp -a etc/rc.d/rc.openctd etc/rc.d/rc.openctd.new.incoming
  cat etc/rc.d/rc.openctd.new > etc/rc.d/rc.openctd.new.incoming
  mv etc/rc.d/rc.openctd.new.incoming etc/rc.d/rc.openctd.new
fi

config etc/rc.d/rc.openctd.new
config etc/openct.conf.new
config etc/reader.conf.d/reader-openct.conf.new


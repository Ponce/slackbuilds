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

# Keep same perms on rc.snort.new:
if [ -e etc/rc.d/rc.snort ]; then
  cp -a etc/rc.d/rc.snort etc/rc.d/rc.snort.new.incoming
  cat etc/rc.d/rc.snort.new > etc/rc.d/rc.snort.new.incoming
  mv etc/rc.d/rc.snort.new.incoming etc/rc.d/rc.snort.new
fi

config etc/rc.d/rc.snort.new
config etc/snort/snort.conf.new
config etc/snort/reference.config.new
config etc/snort/threshold.conf.new
config etc/snort/attribute_table.dtd.new
config etc/snort/classification.config.new
config etc/snort/gen-msg.map.new
config etc/snort/sid-msg.map.new
config etc/snort/unicode.map.new


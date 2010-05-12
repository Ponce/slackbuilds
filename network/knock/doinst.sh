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

# Keep same permissions on rc.knockd.new as an existing rc.knockd:
if [ -e etc/rc.d/rc.knockd ]; then
  cp -a etc/rc.d/rc.knockd etc/rc.d/rc.knockd.new.incoming
  cat etc/rc.d/rc.knockd.new > etc/rc.d/rc.knockd.new.incoming
  mv etc/rc.d/rc.knockd.new.incoming etc/rc.d/rc.knockd.new
else
  # If rc.knockd does not exist, make the new one executable by default,
  # which won't matter unless it's called from rc.local anyway
  chmod 0755 etc/rc.d/rc.knockd.new
fi   

config etc/rc.d/rc.knockd.new
config etc/knockd.conf.new

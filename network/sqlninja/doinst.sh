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

# Keep same perms on sqlninja.conf:
if [ -e etc/sqlninja.conf ]; then
  cp -a etc/sqlninja.conf etc/sqlninja.conf.new.incoming
  cat etc/sqlninja.conf.new > etc/sqlninja.conf.new.incoming
  mv etc/sqlninja.conf.new.incoming etc/sqlninja.conf.new
fi

config etc/sqlninja.conf.new


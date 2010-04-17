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

# Keep same perms on rc.bacula.new:
if [ -e etc/rc.d/rc.bacula ]; then
  cp -a etc/rc.d/rc.bacula etc/rc.d/rc.bacula.new.incoming
  cat etc/rc.d/rc.bacula.new > etc/rc.d/rc.bacula.new.incoming
  mv etc/rc.d/rc.bacula.new.incoming etc/rc.d/rc.bacula.new
fi

config etc/bacula/bacula-fd.conf.new
config etc/bacula/bconsole.conf.new
config etc/rc.d/rc.bacula.new


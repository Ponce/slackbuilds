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

# Keep same permissions on rc.pound.new:
if [ -e etc/rc.d/rc.pound ]; then
  cp -a etc/rc.d/rc.pound etc/rc.d/rc.pound.new.incoming
  cat etc/rc.d/rc.pound.new > etc/rc.d/rc.pound.new.incoming
  mv etc/rc.d/rc.pound.new.incoming etc/rc.d/rc.pound.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.pound.new
fi

config etc/logrotate.d/pound.new
config etc/pound/pound.cfg.new
config etc/rc.d/rc.pound.new


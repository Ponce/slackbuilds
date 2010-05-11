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

# Keep same perms on rc.slimserver.new:
if [ -e etc/rc.d/rc.slimserver ]; then
  cp -a etc/rc.d/rc.slimserver etc/rc.d/rc.slimserver.new.incoming
  cat etc/rc.d/rc.slimserver.new > etc/rc.d/rc.slimserver.new.incoming
  mv etc/rc.d/rc.slimserver.new.incoming etc/rc.d/rc.slimserver.new
fi

config etc/rc.d/rc.slimserver.new

# Create a log file - this won't be removed when the package is uninstalled
# (this is as it should be)
touch var/log/slimserver.log

# If a slimserver.conf file exists, there's no need to install the empty one
# with a .new suffix
if [ -e etc/slimserver.conf ]; then
  rm -f etc/slimserver.conf.new
else
  mv etc/slimserver.conf.new etc/slimserver.conf
fi

# If there's no slimserver user, then bail out now.
if ! grep -q ^slimserver etc/passwd ; then 
  echo
  echo "There is no 'slimserver' user present."
  echo "Add the user and then reinstall the SlimServer package."
  echo "Exiting..."
  exit 1
fi

chroot . /bin/chown slimserver:users /etc/slimserver.conf \
  /var/log/slimserver.log /var/cache/slimserver
chroot . /bin/chown -R slimserver:users /opt/slimserver



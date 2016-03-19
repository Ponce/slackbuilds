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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

if [ -e usr/bin/scp ]; then
  mv usr/bin/scp usr/bin/scp.openssh
fi

config etc/rc.d/rc.dropbear.new
preserve_perms etc/rc.d/rc.dropbear.new

# Create a logfile if one doesn't already exist
if [ ! -e var/log/dropbear.log ]; then
  touch var/log/dropbear.log
  chmod 600 var/log/dropbear.log
fi


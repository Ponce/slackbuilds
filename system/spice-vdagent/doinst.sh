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

preserve_perms etc/rc.d/rc.spice-vdagent.new
config usr/share/X11/xorg.conf.d/06-spice-vdagent.conf.new

# If not already there, start the daemon from /etc/rc.d/rc.local
if [ ! "$(grep rc\.spice-vdagent etc/rc.d/rc.local)" ]; then
  cat << EOF >> etc/rc.d/rc.local

# Start spice-vdagent:
if [ -x /etc/rc.d/rc.spice-vdagent ]; then
  /etc/rc.d/rc.spice-vdagent start
fi
EOF
fi

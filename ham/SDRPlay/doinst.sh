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

preserve_perms etc/rc.d/rc.sdrplay.new



if [ -f etc/rc.d/rc.local ]; then
  if ! grep -q "rc.sdrplay" etc/rc.d/rc.local ; then
    cat << 'EOF' >> etc/rc.d/rc.local

# Start SDRplay API service
if [ -x /etc/rc.d/rc.sdrplay ]; then
  /etc/rc.d/rc.sdrplay start
fi
EOF
  fi
fi


if [ -f etc/rc.d/rc.local_shutdown ]; then
  if ! grep -q "rc.sdrplay" etc/rc.d/rc.local_shutdown ; then
    cat << 'EOF' >> etc/rc.d/rc.local_shutdown

# Stop SDRplay API service
if [ -x /etc/rc.d/rc.sdrplay ]; then
  /etc/rc.d/rc.sdrplay stop
fi
EOF
  fi
fi

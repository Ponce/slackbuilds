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

# Keep same perms on rc.radvd.new:
if [ -e etc/rc.d/rc.radvd ]; then
  cp -a etc/rc.d/rc.radvd etc/rc.d/rc.radvd.new.incoming
  cat etc/rc.d/rc.radvd.new > etc/rc.d/rc.radvd.new.incoming
  mv etc/rc.d/rc.radvd.new.incoming etc/rc.d/rc.radvd.new
fi

config etc/rc.d/rc.radvd.new

if ! grep rc.radvd etc/rc.d/rc.local > /dev/null
then
cat >> etc/rc.d/rc.local <<EOF

# Start radvd
if [ -x /etc/rc.d/rc.radvd ]; then
  . /etc/rc.d/rc.radvd start
fi

EOF
fi

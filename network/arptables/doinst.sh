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

# Keep same permissions on rc files:
if [ -e etc/rc.d/init.d/arptables ]; then
  cp -a etc/rc.d/init.d/arptables etc/rc.d/init.d/arptables.new.incoming
  cat etc/rc.d/init.d/arptables.new > etc/rc.d/init.d/arptables.new.incoming
  mv etc/rc.d/init.d/arptables.new.incoming etc/rc.d/init.d/arptables.new
fi
config etc/rc.d/init.d/arptables.new

# Make sure we have the sysv-style configs
if [ ! -e etc/sysconfig/network ]; then
  touch etc/sysconfig/network
fi
if [ ! -e etc/sysconfig/arptables ]; then
  touch etc/sysconfig/arptables
fi


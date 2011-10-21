config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.activemq.new:
if [ -e etc/rc.d/rc.activemq ]; then
  cp -a etc/rc.d/rc.activemq etc/rc.d/rc.activemq.new.incoming
  cat etc/rc.d/rc.activemq.new > etc/rc.d/rc.activemq.new.incoming
  mv etc/rc.d/rc.activemq.new.incoming etc/rc.d/rc.activemq.new
fi

config etc/default/activemq.new
config etc/rc.d/rc.activemq.new
for F in `find etc/activemq -name '*.new'`; do
  config $F
done


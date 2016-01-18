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
# Keep same perms on rc.hhvm.new:
if [ -e etc/rc.d/rc.hhvm ]; then
  cp -a etc/rc.d/rc.hhvm etc/rc.d/rc.hhvm.new.incoming
  cat etc/rc.d/rc.hhvm.new > etc/rc.d/rc.hhvm.new.incoming
  mv etc/rc.d/rc.hhvm.new.incoming etc/rc.d/rc.hhvm.new
fi
config etc/rc.d/rc.hhvm.new
config etc/hhvm/server.ini.new
config etc/hhvm/php.ini.new

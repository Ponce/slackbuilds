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

# Keep same perms on rc.lighttpd.new:
if [ -e etc/rc.d/rc.lighttpd ]; then
  cp -a etc/rc.d/rc.lighttpd etc/rc.d/rc.lighttpd.new.incoming
  cat etc/rc.d/rc.lighttpd.new > etc/rc.d/rc.lighttpd.new.incoming
  mv etc/rc.d/rc.lighttpd.new.incoming etc/rc.d/rc.lighttpd.new
fi

# Create dummy logfiles, but throw them away if logfiles are already here:
for i in access error ; do 
  if [ -e var/log/lighttpd/${i}.log ]; then
    rm -f var/log/lighttpd/${i}.log.new
  else 
    mv var/log/lighttpd/${i}.log.new var/log/lighttpd/${i}.log
  fi
done

config etc/logrotate.d/lighttpd.new
config etc/rc.d/rc.lighttpd.new
config etc/lighttpd/lighttpd.conf.new
config etc/lighttpd/modules.conf.new

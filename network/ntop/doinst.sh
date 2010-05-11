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

# Keep same perms on rc.ntop.new:
if [ -e etc/rc.d/rc.ntop ]; then
  cp -a etc/rc.d/rc.ntop etc/rc.d/rc.ntop.new.incoming
  cat etc/rc.d/rc.ntop.new > etc/rc.d/rc.ntop.new.incoming
  mv etc/rc.d/rc.ntop.new.incoming etc/rc.d/rc.ntop.new
fi

config etc/rc.d/rc.ntop.new
config etc/logrotate.d/ntop.new

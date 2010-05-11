config()
{
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

PRGNAM=watchdog

# Keep same perms on the rc.$PRGNAM.new
if [ -e etc/rc.d/rc.$PRGNAM ]; then
  cp -a etc/rc.d/rc.$PRGNAM etc/rc.d/rc.$PRGNAM.new.incoming
  cat etc/rc.d/rc.$PRGNAM.new > etc/rc.d/rc.$PRGNAM.new.incoming
  mv etc/rc.d/rc.$PRGNAM.new.incoming etc/rc.d/rc.$PRGNAM.new
else
  # Default to executable
  chmod 0755 etc/rc.d/rc.$PRGNAM.new
fi

config etc/rc.d/rc.$PRGNAM.new
config etc/$PRGNAM.conf.new


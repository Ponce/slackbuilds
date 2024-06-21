#! /bin/sh
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

config etc/pound.cfg.new
config etc/rc.d/rc.pound.new

if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=/usr/info /usr/info/pound.info.gz 2>/dev/null
fi


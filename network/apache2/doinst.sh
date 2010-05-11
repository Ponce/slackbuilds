#!/bin/sh

copy_config() {
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

copy_config etc/rc.d/rc.httpd.new
copy_config etc/apache2/httpd.conf.new

for conf_file in etc/apache2/extra/*.new; do
	copy_config $conf_file
done

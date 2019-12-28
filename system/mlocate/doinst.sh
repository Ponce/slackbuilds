#!/bin/sh

# doinst.sh copied from Pat's, got rid of the stuff that creates the
# slocate group.

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
config etc/updatedb.conf.new

if [ ! -r var/lib/mlocate/mlocate.db ]; then
  touch var/lib/mlocate/mlocate.db
  chown root:slocate var/lib/mlocate/mlocate.db
  chmod 640 var/lib/mlocate/mlocate.db
fi


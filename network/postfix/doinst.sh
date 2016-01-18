#!/bin/sh

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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

find etc/postfix -type f -name '*.new' \
  | while read new ; do config $new ; done

preserve_perms etc/rc.d/rc.postfix.new

# This is an incompatability with the sendmail package
( cd usr/lib; rm -f sendmail )
( cd usr/lib; ln -s /usr/sbin/sendmail sendmail)

# This will set the permissions on all postfix files correctly
postfix set-permissions

# Symlinks added by makepkg(8)


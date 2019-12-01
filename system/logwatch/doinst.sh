#!/bin/bash

config() {
  NEW="$1"
  OLD="${NEW%*.new}"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/logwatch/conf/logwatch.conf.new
config etc/logwatch/conf/ignore.conf.new
config etc/logwatch/conf/override.conf.new


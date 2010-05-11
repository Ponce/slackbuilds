config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Try not to mess over any costum settings
config etc/tiger/cronrc.new
config etc/tiger/tigerrc.new
config usr/share/tiger/initdefs.new
config usr/share/tiger/check.tbl.new
config usr/share/tiger/syslist.new
config usr/share/tiger/config.new

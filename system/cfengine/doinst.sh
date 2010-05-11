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

# Add a sample rc file for the admin to consider
config etc/rc.d/rc.cfengine.new

config var/cfengine/inputs/update.conf.new
config var/cfengine/inputs/cfagent.conf.new
config var/cfengine/inputs/cfservd.conf.new
config var/cfengine/inputs/cfrun.hosts.new


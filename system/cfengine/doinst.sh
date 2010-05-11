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

# Keep same perms on rc.cfengine:
if [ -e etc/rc.d/rc.cfengine ]; then
  cp -a etc/rc.d/rc.cfengine etc/rc.d/rc.cfengine.new.incoming
  cat etc/rc.d/rc.cfengine.new > etc/rc.d/rc.cfengine.new.incoming
  mv etc/rc.d/rc.cfengine.new.incoming etc/rc.d/rc.cfengine.new
fi

config etc/rc.d/rc.cfengine.new
config var/cfengine/inputs/update.conf.new
config var/cfengine/inputs/cfagent.conf.new
config var/cfengine/inputs/cfservd.conf.new
config var/cfengine/inputs/cfrun.hosts.new


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

# Keep same permissions on rc files:
for PRGNAM in cfengine cfenvd cfservd ; do
  if [ -e etc/rc.d/rc.$PRGNAM ]; then
    cp -a etc/rc.d/rc.$PRGNAM etc/rc.d/rc.$PRGNAM.new.incoming
    cat etc/rc.d/rc.$PRGNAM.new > etc/rc.d/rc.$PRGNAM.new.incoming
    mv etc/rc.d/rc.$PRGNAM.new.incoming etc/rc.d/rc.$PRGNAM.new
  fi
  config etc/rc.d/rc.$PRGNAM.new
done

config var/cfengine/inputs/update.conf.new
config var/cfengine/inputs/cfagent.conf.new
config var/cfengine/inputs/cfservd.conf.new
config var/cfengine/inputs/cfrun.hosts.new

# Following link is for some backwards compatibility
if [ ! -d var/cfengine/bin ]; then mkdir -p var/$PRGNAM/bin ; fi
( cd var/cfengine/bin ; ln -sf ../../../usr/sbin/cfagent . )


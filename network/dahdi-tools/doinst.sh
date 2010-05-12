config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/dahdi/init.conf.new
config etc/dahdi/modules.new
config etc/dahdi/system.conf.new
config etc/modprobe.d/dahdi.conf.new
config etc/modprobe.d/dahdi.blacklist.conf.new
config etc/dahdi/genconf_parameters.new


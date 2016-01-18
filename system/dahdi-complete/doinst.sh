# Post-install configuration scripts, borrowed from the fail2ban
# Slackbuild: 

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

preserve_perms etc/rc.d/rc.dahdi.new

config etc/udev/rules.d/xpp.rules.new
config etc/udev/rules.d/dahdi.rules.new
config etc/hotplug/usb/xpp_fxloader.usermap.new
config etc/dahdi/system.conf.new
config etc/dahdi/assigned-spans.conf.sample.new
config etc/dahdi/span-types.conf.sample.new
config etc/dahdi/init.conf.new
config etc/dahdi/modules.new
config etc/dahdi/genconf_parameters.new
config etc/bash_completion.d/dahdi.new
config etc/modprobe.d/dahdi.conf.new
config etc/modprobe.d/dahdi.blacklist.conf.new

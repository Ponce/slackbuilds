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

config etc/svxlink/svxlink.conf.new
config etc/svxlink/TclVoiceMail.conf.new
config etc/svxlink/gpio.conf.new
config etc/svxlink/remotetrx.conf.new
config etc/svxlink/svxreflector.conf.new
config etc/svxlink/svxlink.d/ModuleFrn.conf.new
config etc/svxlink/svxlink.d/ModuleHelp.conf.new
config etc/svxlink/svxlink.d/ModuleEchoLink.conf.new
config etc/svxlink/svxlink.d/ModuleDtmfRepeater.conf.new
config etc/svxlink/svxlink.d/ModuleTclVoiceMail.conf.new
config etc/svxlink/svxlink.d/ModuleSelCallEnc.conf.new
config etc/svxlink/svxlink.d/ModulePropagationMonitor.conf.new
config etc/svxlink/svxlink.d/ModuleMetarInfo.conf.new
config etc/svxlink/svxlink.d/ModuleParrot.conf.new
preserve_perms etc/rc.d/rc.svxlink.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

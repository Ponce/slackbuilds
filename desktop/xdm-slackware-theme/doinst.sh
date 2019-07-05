# Handle the incoming configuration file
#
config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"

  # If there's no config file by that name, mv it over:
  #
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# backup /etc/X11/xdm/xdm-config, if required
#
XDM_CONFIG=/etc/X11/xdm/xdm-config
CDATE=$(date +%Y%m%d)

if [ -e ${XDM_CONFIG} ] && [ ! -L ${XDM_CONFIG} ] ; then
  cat ${XDM_CONFIG} > ${XDM_CONFIG}.orig_${CDATE}
fi

config etc/X11/xdm/slackware/Xbuttons_bar.conf.new
config etc/X11/xdm/slackware/Xresources.new
config etc/X11/xdm/slackware/Xservers.new
config etc/X11/xdm/slackware/Xsession.conf.new
config etc/X11/xdm/slackware/Xsetup.conf.new

config etc/X11/xdm/slackware/xdm-config.new

config etc/X11/xdm/slackware/extensions.d/analog-clock.conf.new
config etc/X11/xdm/slackware/extensions.d/conky-pseudo-transparent.conf.new
config etc/X11/xdm/slackware/extensions.d/conky-real-transparent.conf.new
config etc/X11/xdm/slackware/extensions.d/sysmon-conky.conf.new
config etc/X11/xdm/slackware/extensions.d/xdm-screensaver.conf.new

# Replaces /etc/X11/xdm/xdm-config by a symlink to
# /etc/X11/xdm/slackware/xdm-config to enable the XDM theme...
#
(
  cd etc/X11/xdm
  ln -sf slackware/xdm-config xdm-config
)

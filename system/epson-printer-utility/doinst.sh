#!/bin/sh
#fix rc file on install, and register .desktop file
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

config etc/rc.d/rc.ecbd.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -x /usr/bin/kbuildsycoca4 ]; then
  /usr/bin/kbuildsycoca4 >/dev/null 2>&1
fi

echo
echo "************************* NOTICE *********************************"
echo "ecbd needs to be running for the printer monitor to be usable. run"
echo "/etc/rc.d/rc.ecbd restart"
if [ x`grep "rc.ecbd start" /etc/rc.d/rc.local|wc -l` = "x0" ]; then
  echo "to get it to run automatically at startup, add the following"
  echo "to /etc/rc.d/rc.local"
  echo "if [ -x /etc/rc.d/rc.ecbd ]; then"
  echo "  /etc/rc.d/rc.ecbd start"
  echo "fi"
fi
echo "******************************************************************"
echo

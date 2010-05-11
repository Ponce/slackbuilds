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

# Keep same perms on rc.wicd.new:
if [ -e etc/rc.d/rc.wicd ]; then
  cp -a etc/rc.d/rc.wicd etc/rc.d/rc.wicd.new.incoming
  cat etc/rc.d/rc.wicd.new > etc/rc.d/rc.wicd.new.incoming
  mv etc/rc.d/rc.wicd.new.incoming etc/rc.d/rc.wicd.new
 else 
  chmod 0755 etc/rc.d/rc.wicd.new
fi

# Reload messagebus service
if [ -x etc/rc.d/rc.messagebus ]; then
  chroot . /etc/rc.d/rc.messagebus reload
fi

# Update desktop menu
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# Update icon cache if one exists
if [ -r usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -t -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

config etc/rc.d/rc.wicd.new
config etc/wicd/manager-settings.conf.new

rm -f usr/lib/python2.5/site-packages/wicd/*.pyc 2>/dev/null 

echo
echo "You need to kill the wicd client (tray icon),"
echo "then restart the wicd daemon (run '/etc/rc.d/rc.wicd restart'),"
echo "then restart the tray icon (run 'wicd-client &' as normal user)."
echo


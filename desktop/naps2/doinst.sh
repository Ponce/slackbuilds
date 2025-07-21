
# Update desktop-database, mime-database, icon-cache
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# doinst.sh for naps2 package 
( cd usr/bin ; rm -rf naps2 )
( cd usr/bin ; ln -sf /opt/naps2/naps2 naps2 )
( cd usr/doc/naps2-8.2.0 ; rm -rf LICENSE.txt )
( cd usr/doc/naps2-8.2.0 ; ln -sf /opt/naps2/LICENSE.txt LICENSE.txt )

( cd usr/bin ; rm -rf zoom-linux )
( cd usr/bin ; ln -sf /opt/zoom-linux/ZoomLauncher zoom-linux )

if [ -x /usr/bin/xdg-mime ]; then
    /usr/bin/xdg-mime install /usr/share/mime/packages/zoom-linux.xml
fi

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

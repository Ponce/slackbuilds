set -e

# create links.
ln -sf /opt/vivaldi-snapshot/vivaldi-snapshot /usr/bin/vivaldi-snapshot
ln -sf /opt/vivaldi-snapshot/vivaldi-snapshot /opt/vivaldi-snapshot/vivaldi

# define owner and permission.
chown root:root /opt/vivaldi-snapshot/vivaldi-sandbox
chmod 4755 /opt/vivaldi-snapshot/vivaldi-sandbox

# begin SlackBuilds options.
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
# end SlackBuilds options.

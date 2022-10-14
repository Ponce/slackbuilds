if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

ln -s /opt/armcord-3.0.8/armcord /usr/local/bin/

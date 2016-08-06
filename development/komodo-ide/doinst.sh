( cd usr/bin; ln -sf /opt/komodo-ide/bin/komodo komodo-ide )
( cd usr/share/applications; ln -sf /opt/komodo-ide/share/desktop/komodo-ide-*.desktop komodo-ide.desktop )

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

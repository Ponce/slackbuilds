( cd usr/bin; ln -sf /opt/komodo-edit/bin/komodo komodo-edit )
( cd usr/share/applications; ln -sf /opt/komodo-edit/share/desktop/komodo-edit-*.desktop komodo-edit.desktop )

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

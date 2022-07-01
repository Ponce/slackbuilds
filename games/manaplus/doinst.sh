if [ -x /usr/bin/update-desktop-database ]; then
    /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
fi

# Fix sbopkglint
#--- usr/share/icons should not contain files with executable permission:
#-rwxr-xr-x 1 root root 8075 Jun 24 14:01 usr/share/icons/hicolor/scalable/apps/manaplus.svg
chmod 744 $CWD/usr/share/icons/hicolor/scalable/apps/manaplus.svg

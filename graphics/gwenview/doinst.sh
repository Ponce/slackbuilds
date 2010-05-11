if [ -x usr/bin/update-desktop-database ]; then
    usr/bin/update-desktop-database -q usr/share/applications/kde > /dev/null 2>&1
fi


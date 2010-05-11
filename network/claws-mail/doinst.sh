
if [ -x usr/bin/update-desktop-database ]; then
	usr/bin/update-desktop-database &> /dev/null
fi

if [ -x usr/bin/gtk-update-icon-cache ]; then
	gtk-update-icon-cache -f -t usr/share/icons/hicolor &> /dev/null
fi


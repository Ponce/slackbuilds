#!/bin/sh

gtk-update-icon-cache -q -t -f usr/share/icons/hicolor
rm -f '/usr/bin/synochat'
update-desktop-database -q

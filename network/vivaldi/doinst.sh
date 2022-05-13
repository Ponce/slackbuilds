if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# Adding a suitable libffmpeg.so with support for H.264 & AAC directly into
# the package makes redistribution of the output package difficult.
# The following is used in postinstall for the official rpm and debs.
# (Cleanup on uninstall will be handled by douninst.sh)
nohup /opt/vivaldi/update-ffmpeg > /dev/null 2>&1 &


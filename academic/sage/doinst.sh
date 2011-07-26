# update texmf to recognize the newly installed sagetex
if [ -x usr/share/texmf/bin/texhash ]; then
  /usr/share/texmf/bin/texhash /usr/share/texmf >/dev/null 2>&1
fi

# run sage at least once as root after moving it to a new location
echo "exit" | SAGEROOT/sage

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

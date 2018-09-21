if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

NEW="var/games/xlennart.scores.new"
OLD="$(dirname $NEW)/$(basename $NEW .new)"
if [ -r $NEW ] && [ ! -r $OLD ]; then
  mv $NEW $OLD
else
  rm -f $NEW
fi

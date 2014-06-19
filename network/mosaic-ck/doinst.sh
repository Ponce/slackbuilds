if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# If there's no Mosaic link, take over:
if [ ! -r usr/bin/Mosaic ]; then
  ( cd usr/bin ; ln -sf mosaic-ck Mosaic )
  ( cd usr/man/man1 ; ln -sf mosaic-ck.1.gz Mosaic.1.gz )
fi


# create empty high score file only if there isn't one
if [ ! -e var/games/hydrascores.sav ]; then
  touch var/games/hydrascores.sav
fi

# always reset perms/ownership
chmod 660 var/games/hydrascores.sav
chown root:games var/games/hydrascores.sav

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

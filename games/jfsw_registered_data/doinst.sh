# If there's no sw.grp link, take over:
if [ ! -r usr/share/games/jfsw/sw.grp ]; then
  ( cd usr/share/games/jfsw/ ; ln -sf sw_registered.grp sw.grp )
fi

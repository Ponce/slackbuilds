if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config usr/share/games/mangband/lib/data/scores.raw.new
config usr/share/games/mangband/lib/edit/artifact.txt.new
config usr/share/games/mangband/lib/edit/ego_item.txt.new
config usr/share/games/mangband/lib/edit/flavor.txt.new
config usr/share/games/mangband/lib/edit/limits.txt.new
config usr/share/games/mangband/lib/edit/monster.txt.new
config usr/share/games/mangband/lib/edit/object.txt.new
config usr/share/games/mangband/lib/edit/p_class.txt.new
config usr/share/games/mangband/lib/edit/p_hist.txt.new
config usr/share/games/mangband/lib/edit/p_race.txt.new
config usr/share/games/mangband/lib/edit/terrain.txt.new
config usr/share/games/mangband/lib/edit/vault.txt.new

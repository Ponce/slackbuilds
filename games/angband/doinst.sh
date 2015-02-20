config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  [ ! -r $OLD ] && mv $NEW $OLD
  rm -f $NEW
}

config etc/angband/edit/artifact.txt.new
config etc/angband/edit/ego_item.txt.new
config etc/angband/edit/flavor.txt.new
config etc/angband/edit/hints.txt.new
config etc/angband/edit/limits.txt.new
config etc/angband/edit/monster.txt.new
config etc/angband/edit/monster_base.txt.new
config etc/angband/edit/names.txt.new
config etc/angband/edit/object.txt.new
config etc/angband/edit/object_base.txt.new
config etc/angband/edit/p_class.txt.new
config etc/angband/edit/p_hist.txt.new
config etc/angband/edit/p_race.txt.new
config etc/angband/edit/pain.txt.new
config etc/angband/edit/pit.txt.new
config etc/angband/edit/room_template.txt.new
config etc/angband/edit/spell.txt.new
config etc/angband/edit/store.txt.new
config etc/angband/edit/terrain.txt.new
config etc/angband/edit/vault.txt.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

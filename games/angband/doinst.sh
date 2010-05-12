config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  [ ! -r $OLD ] && mv $NEW $OLD
  rm -f $NEW
}

config var/games/angband/apex/scores.raw.new
config var/games/angband/data/artifact.raw.new
config var/games/angband/data/ego_item.raw.new
config var/games/angband/data/flavor.raw.new
config var/games/angband/data/limits.raw.new
config var/games/angband/data/monster.raw.new
config var/games/angband/data/object.raw.new
config var/games/angband/data/p_class.raw.new
config var/games/angband/data/p_hist.raw.new
config var/games/angband/data/p_race.raw.new
config var/games/angband/data/prices.raw.new
config var/games/angband/data/shop_own.raw.new
config var/games/angband/data/spells.raw.new
config var/games/angband/data/terrain.raw.new
config var/games/angband/data/vault.raw.new


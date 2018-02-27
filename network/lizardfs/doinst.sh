config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/mfs/mfschunkserver.cfg.new
config etc/mfs/mfshdd.cfg.new
config etc/mfs/mfsmetalogger.cfg.new
config etc/mfs/mfsmaster.cfg.new
config etc/mfs/mfsexports.cfg.new
config etc/mfs/mfstopology.cfg.new
config etc/mfs/mfsmount.cfg.new
config etc/mfs/globaliolimits.cfg.new
config etc/mfs/iolimits.cfg.new
config etc/mfs/mfsgoals.cfg.new

config etc/rc.d/rc.lizardfs.new
config etc/rc.d/rc.lizardfs-chunkserver.new
config etc/rc.d/rc.lizardfs-cgiserv.new
config etc/rc.d/rc.lizardfs-master.new
config etc/rc.d/rc.lizardfs-metalogger.new

config var/log/setup/setup.lizardfs-services.new

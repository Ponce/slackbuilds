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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

config etc/glusterfs/eventsconfig.json.new
config etc/glusterfs/glusterd.vol.new
config etc/glusterfs/group-gluster-block.new
config etc/glusterfs/group-metadata-cache.new
config etc/glusterfs/group-nl-cache.new
config etc/glusterfs/group-virt.example.new
config etc/glusterfs/gsyncd.conf.new
config etc/glusterfs/logger.conf.example.new
config etc/logrotate.d/glusterfs-georep.new
config etc/logrotate.d/glusterfs.new
preserve_perms etc/rc.d/rc.glusterd.new

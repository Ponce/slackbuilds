
config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
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

preserve_perms etc/rc.d/rc.ipxnet.new
config etc/rc.d/rc.ipxnet.conf.new

# create log if missing, make sure ownership is correct. log
# will not be removed on package removal.
touch var/log/ipxnet.log
chown @IPXUSER@:@IPXGROUP@ var/log/ipxnet.log

# 14.2 uses tar-1.15 for makepkg, can't handle capabilities, so:
[ -e /sbin/setcap] && /sbin/setcap cap_net_bind_service=epi usr/sbin/ipxnet-system

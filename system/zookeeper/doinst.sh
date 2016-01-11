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

preserve_perms etc/rc.d/rc.zookeeper.new
preserve_perms etc/zookeeper/configuration.xsl.new
preserve_perms etc/zookeeper/log4j.properties.new
preserve_perms etc/zookeeper/zoo_sample.cfg.new
preserve_perms etc/zookeeper/zoo.cfg.new
preserve_perms etc/zookeeper/java.env.new
preserve_perms etc/zookeeper/zookeeper-env.sh.new

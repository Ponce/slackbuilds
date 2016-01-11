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

preserve_perms etc/rc.d/rc.kafka.new
preserve_perms etc/kafka/server.properties.new
preserve_perms etc/kafka/consumer.properties.new
preserve_perms etc/kafka/producer.properties.new
preserve_perms etc/kafka/log4j.properties.new
preserve_perms etc/kafka/test-log4j.properties.new
preserve_perms etc/kafka/tools-log4j.properties.new
preserve_perms etc/kafka/kafka-env.sh.new

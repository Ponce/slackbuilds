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
config etc/xinetd.conf.new
config etc/xinetd.d/chargen-dgram.new 
config etc/xinetd.d/chargen-stream.new
config etc/xinetd.d/daytime-dgram.new
config etc/xinetd.d/daytime-stream.new
config etc/xinetd.d/discard-dgram.new
config etc/xinetd.d/discard-stream.new
config etc/xinetd.d/echo-dgram.new
config etc/xinetd.d/echo-stream.new
config etc/xinetd.d/ftp-sensor.new
config etc/xinetd.d/tcpmux-server.new
config etc/xinetd.d/time-dgram.new
config etc/xinetd.d/time-stream.new
preserve_perms etc/rc.d/rc.xinetd.new


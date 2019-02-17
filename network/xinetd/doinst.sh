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
config etc/xinetd.d/chargen.new
config etc/xinetd.d/chargen-udp.new
config etc/xinetd.d/daytime.new
config etc/xinetd.d/daytime-udp.new
config etc/xinetd.d/discard.new
config etc/xinetd.d/discard-udp.new
config etc/xinetd.d/echo.new
config etc/xinetd.d/echo-udp.new
config etc/xinetd.d/servers.new
config etc/xinetd.d/services.new
config etc/xinetd.d/time.new
config etc/xinetd.d/time-udp.new

preserve_perms etc/rc.d/rc.xinetd.new

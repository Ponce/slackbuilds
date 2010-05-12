config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then 
    rm $NEW
  fi
}

config etc/lircd.conf.new
config etc/lircmd.conf.new
config etc/lircrc.new
config etc/logrotate.d/lirc.new

if [ -x sbin/depmod ]; then
  chroot . /sbin/depmod -ae @KERNEL@ 1> /dev/null 2> /dev/null
fi

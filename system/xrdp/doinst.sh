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

# Keep same perms on rc.xrdp.new:
if [ -e etc/rc.d/rc.xrdp ]; then
  cp -a etc/rc.d/rc.xrdp etc/rc.d/rc.xrdp.new.incoming
  cat etc/rc.d/rc.xrdp.new > etc/rc.d/rc.xrdp.new.incoming
  mv etc/rc.d/rc.xrdp.new.incoming etc/rc.d/rc.xrdp.new
fi

config etc/rc.d/rc.xrdp.new
config etc/xrdp/xrdp-xinitrc.new
config etc/xrdp/reconnectwm.sh.new
config etc/xrdp/rsakeys.ini.new
config etc/xrdp/sesman.ini.new
config etc/xrdp/xrdp.ini.new
config etc/xrdp/xrdp_keyboard.ini.new
config etc/xrdp/km-00000406.ini.new
config etc/xrdp/km-00000407.ini.new
config etc/xrdp/km-00000409.ini.new
config etc/xrdp/km-0000040a.ini.new
config etc/xrdp/km-0000040b.ini.new
config etc/xrdp/km-0000040c.ini.new
config etc/xrdp/km-00000410.ini.new
config etc/xrdp/km-00000411.ini.new
config etc/xrdp/km-00000412.ini.new
config etc/xrdp/km-00000414.ini.new
config etc/xrdp/km-00000415.ini.new
config etc/xrdp/km-00000416.ini.new
config etc/xrdp/km-00000419.ini.new
config etc/xrdp/km-0000041d.ini.new
config etc/xrdp/km-00000807.ini.new
config etc/xrdp/km-00000809.ini.new
config etc/xrdp/km-0000080a.ini.new
config etc/xrdp/km-0000080c.ini.new
config etc/xrdp/km-00000813.ini.new
config etc/xrdp/km-00000816.ini.new
config etc/xrdp/km-0000100c.ini.new
config etc/xrdp/km-00010409.ini.new
config etc/logrotate.d/xrdp-sesman.new
config etc/logrotate.d/xrdp.new

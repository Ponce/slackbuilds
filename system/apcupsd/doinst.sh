config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

for i in \
  apccontrol.new \
  apcupsd.conf.new \
  apcupsd.css.new \
  changeme.new \
  commfailure.new \
  commok.new \
  hosts.conf.new \
  multimon.cgi.new \
  multimon.conf.new \
  offbattery.new \
  onbattery.new \
  upsfstats.cgi.new \
  upsimage.cgi.new \
  upsstats.cgi.new; 
do \
  config etc/apcupsd/$i; 
done

config etc/rc.d/rc.apcupsd.new


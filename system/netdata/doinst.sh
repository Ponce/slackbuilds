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

config etc/netdata/netdata.conf.new
config etc/netdata/netdata-updater.conf.new

for L in `ls usr/lib/netdata/conf.d/*.new`
do
config $L
done

for L in `ls usr/lib/netdata/conf.d/python.d/*.new`
do
config $L
done

for L in `ls usr/lib/netdata/conf.d/charts.d/*.new`
do
config $L
done

for L in `ls usr/lib/netdata/conf.d/health.d/*.new`
do
config $L
done

for L in `ls usr/lib/netdata/conf.d/statsd.d/*.new`
do
config $L
done

if [ -x /usr/libexec/netdata/plugins.d/apps.plugin ] ; then
  setcap cap_dac_read_search,cap_sys_ptrace+ep /usr/libexec/netdata/plugins.d/apps.plugin
fi

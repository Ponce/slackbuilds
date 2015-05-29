
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

BACKUP=(etc/inittab
        etc/rc.conf
	etc/conf.d/{bootmisc,consolefont,devfs,dmesg,fsck,hostname,hwclock,keymaps}
	etc/conf.d/{killprocs,localmount,modules,netmount,network,staticroute}
	etc/conf.d/{tmpfiles,urandom}
	etc/logrotate.d/openrc)
for file in "${BACKUP[@]}"; do
  config ${file}.new
done


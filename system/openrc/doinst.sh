
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

BACKUP_FILE=(inittab rc.conf logrotate.d/openrc)
BACKUP_CONF=(bootmisc consolefont devfs dmesg fsck hostname hwclock keymaps killprocs localmount modules mtab net-online netmount network staticroute tmpfiles urandom)

for file in "${BACKUP_FILE[@]}"; do
  config "etc/${file}.new"
done

for file in "${BACKUP_CONF[@]}"; do
  config "etc/conf.d/${file}.new"
done

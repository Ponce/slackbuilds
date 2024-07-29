
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

BACKUP_FILE=(openrc/rc.conf logrotate.d/openrc)
BACKUP_CONF=(agetty bootmisc consolefont devfs dmesg fsck hostname hwclock keymaps killprocs localmount modules mtab net-online netmount network seedrng staticroute swap swclock)

for file in "${BACKUP_FILE[@]}"; do
  config "etc/${file}.new"
done

for file in "${BACKUP_CONF[@]}"; do
  config "etc/openrc/conf.d/${file}.new"
done

# enable cgroups service as required by openrc 0.35+
[ ! -e etc/openrc/runlevels/sysinit/cgroups ] && ln -s /etc/openrc/init.d/cgroups etc/openrc/runlevels/sysinit/cgroups

# enable save keymaps and termencoding services as needed by openrc 0.40+
[ ! -e etc/openrc/runlevels/boot/save-keymaps ] && ln -s /etc/openrc/init.d/save-keymaps etc/openrc/runlevels/boot/save-keymaps
[ ! -e etc/openrc/runlevels/boot/save-termencoding ] && ln -s /etc/openrc/init.d/save-termencoding etc/openrc/runlevels/boot/save-termencoding

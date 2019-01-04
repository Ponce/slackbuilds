config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/fwupd/daemon.conf.new
if [ -e etc/fwupd/uefi.conf ] ; then
  config etc/fwupd/uefi.conf.new
fi
config etc/fwupd/remotes.d/fwupd.conf.new
config etc/fwupd/remotes.d/fwupd-tests.conf.new
config etc/fwupd/remotes.d/lvfs-testing.conf.new
config etc/fwupd/remotes.d/lvfs.conf.new
config etc/fwupd/remotes.d/vendor.conf.new

config etc/pki/fwupd-metadata/GPG-KEY-Linux-Vendor-Firmware-Service.new
config etc/pki/fwupd-metadata/LVFS-CA.pem.new
config etc/pki/fwupd/GPG-KEY-Hughski-Limited.new
config etc/pki/fwupd/GPG-KEY-Linux-Vendor-Firmware-Service.new
config etc/pki/fwupd/LVFS-CA.pem.new

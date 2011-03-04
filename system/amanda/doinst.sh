config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"

  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/amanda/3hole.ps.new
config etc/amanda/8.5x11.ps.new
config etc/amanda/DIN-A4.ps.new
config etc/amanda/DLT-A4.ps.new
config etc/amanda/DLT.ps.new
config etc/amanda/EXB-8500.ps.new
config etc/amanda/HP-DAT.ps.new
config etc/amanda/amanda-client-postgresql.conf.new
config etc/amanda/amanda-client.conf.new
config etc/amanda/amanda.conf.new
config etc/amanda/chg-multi.conf.new
config etc/amanda/chg-scsi.conf.new
config etc/amanda/disklist.new


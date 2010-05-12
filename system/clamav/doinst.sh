config() {
  for infile in $1; do
    NEW="$infile"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
      mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
      # toss the redundant copy
      rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
  done
}

config etc/freshclam.conf.new
config etc/clamd.conf.new
config etc/rc.d/rc.clamav.new
config var/log/clamd.log.new ; rm -f var/log/clamd.log.new
config var/log/freshclam.log.new ; rm -f var/log/freshclam.log.new


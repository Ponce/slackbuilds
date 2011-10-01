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

preserve_perms etc/rc.d/rc.ntop.new
config etc/logrotate.d/ntop.new
config etc/ntop/specialMAC.txt.gz.new
config etc/ntop/ntop-cert.pem.new
config etc/ntop/GeoIPASNum.dat.new
config etc/ntop/GeoLiteCity.dat.new
config etc/ntop/etter.finger.os.gz.new
config etc/ntop/oui.txt.gz.new

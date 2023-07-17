# $RCSfile: doinst.sh,v $
# $Revision: 1.9 $
# $Date: 2023-05-11 07:58:15+01 $
# DW

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/asus_fanmode.conf.new

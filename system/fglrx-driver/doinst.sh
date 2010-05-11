#! /bin/sh

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  [ ! -f $NEW ] && return

  # If there's no config file by that name, mv it over:
  if [ ! -f $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/ati/atiogl.xml.new;
config etc/ati/authatieventsd.sh.new;

( cd usr/lib ; rm -rf libfglrx_pp.so.1 )
( cd usr/lib ; ln -sf libfglrx_pp.so.1.0 libfglrx_pp.so.1 )
( cd usr/lib ; rm -rf libfglrx_gamma.so.1 )
( cd usr/lib ; ln -sf libfglrx_gamma.so.1.0 libfglrx_gamma.so.1 )
( cd usr/lib ; rm -rf libfglrx_gamma.so )
( cd usr/lib ; ln -sf libfglrx_gamma.so.1.0 libfglrx_gamma.so )
( cd usr/lib ; rm -rf libGL.so )
( cd usr/lib ; ln -sf libGL.so.1.2 libGL.so )
( cd usr/lib ; rm -rf libfglrx_dm.so )
( cd usr/lib ; ln -sf libfglrx_dm.so.1.0 libfglrx_dm.so )
( cd usr/lib ; rm -rf libfglrx_pp.so )
( cd usr/lib ; ln -sf libfglrx_pp.so.1.0 libfglrx_pp.so )
( cd usr/lib ; rm -rf libfglrx_dm.so.1 )
( cd usr/lib ; ln -sf libfglrx_dm.so.1.0 libfglrx_dm.so.1 )
( cd usr/lib ; rm -rf libfglrx_tvout.so )
( cd usr/lib ; ln -sf libfglrx_tvout.so.1.0 libfglrx_tvout.so )
( cd usr/lib ; rm -rf libGL.so.1 )
( cd usr/lib ; ln -sf libGL.so.1.2 libGL.so.1 )
( cd usr/lib ; rm -rf libfglrx_tvout.so.1 )
( cd usr/lib ; ln -sf libfglrx_tvout.so.1.0 libfglrx_tvout.so.1 )

# Correct mesa symlinks.
ROOTLIBDIR='usr/lib' usr/sbin/fglrx-switch -mesa

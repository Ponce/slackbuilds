###############
# Config file #
###############
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

config opt/brother/scanner/brscan4/brsanenetdevice4.cfg.new

########################
# Add library symlinks #
########################
case "$( uname -m )" in
  x86_64) LIBDIRSUFFIX="64" ;;
  *) LIBDIRSUFFIX="" ;;
esac

( cd /usr/lib${LIBDIRSUFFIX}/sane && rm -rf libsane-brother4.so.1 )
( cd /usr/lib${LIBDIRSUFFIX}/sane && ln -sf libsane-brother4.so.1.0.7 libsane-brother4.so.1 )

( cd /usr/lib${LIBDIRSUFFIX}/sane && rm -rf libsane-brother4.so )
( cd /usr/lib${LIBDIRSUFFIX}/sane && ln -sf libsane-brother4.so.1.0.7 libsane-brother4.so )

##################
# Other symlinks #
##################
( cd etc/opt/brother/scanner/brscan4 ; rm -rf Brsane4.ini )
( cd etc/opt/brother/scanner/brscan4 ; ln -sf /opt/brother/scanner/brscan4/Brsane4.ini Brsane4.ini )
( cd etc/opt/brother/scanner/brscan4 ; rm -rf brsanenetdevice4.cfg )
( cd etc/opt/brother/scanner/brscan4 ; ln -sf /opt/brother/scanner/brscan4/brsanenetdevice4.cfg brsanenetdevice4.cfg )
( cd etc/opt/brother/scanner/brscan4 ; rm -rf models4 )
( cd etc/opt/brother/scanner/brscan4 ; ln -sf /opt/brother/scanner/brscan4/models4 models4 )
( cd usr/bin ; rm -rf brsaneconfig4 )
( cd usr/bin ; ln -sf /opt/brother/scanner/brscan4/brsaneconfig4 brsaneconfig4 )

###########################################
# Add "brother4" entry to SANE's dll.conf #
###########################################
# inspired by Void Linux's brother-brscan4/INSTALL
readonly _SANE_CONF=/etc/sane.d/dll.conf
readonly _ENTRY=brother4
if [ -f "${_SANE_CONF}" -a "$(grep ${_ENTRY} ${_SANE_CONF} 2>/dev/null)" = "" ]
then
  echo "${_ENTRY}" >> "${_SANE_CONF}"
fi

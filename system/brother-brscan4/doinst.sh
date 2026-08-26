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

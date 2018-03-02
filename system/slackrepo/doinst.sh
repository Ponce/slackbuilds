config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/slackrepo/slackrepo_SBo.conf.new
config etc/slackrepo/slackrepo_csb.conf.new
config etc/slackrepo/slackrepo_msb.conf.new
config etc/slackrepo/slackrepo_ponce.conf.new
config etc/sudoers.d/slackrepo.new

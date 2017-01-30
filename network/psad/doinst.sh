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

preserve_perms etc/rc.d/rc.psad.new
config etc/psad/auto_dl.new
config etc/psad/icmp6_types.new
config etc/psad/icmp_types.new
config etc/psad/ip_options.new
config etc/psad/pf.os.new
config etc/psad/posf.new
config etc/psad/protocols.new
config etc/psad/psad.conf.new
config etc/psad/signatures.new
config etc/psad/snort_rule_dl.new

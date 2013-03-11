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
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

preserve_perms etc/rc.d/rc.auditd.new
preserve_perms etc/rc.d/rc.auditd.conf.new
config etc/audit/audit.rules.new
config etc/audit/auditd.conf.new
config etc/audisp/audispd.conf.new
config etc/audisp/zos-remote.conf.new
config etc/audisp/plugins.d/af_unix.conf.new
config etc/audisp/plugins.d/au-remote.conf.new
config etc/audisp/plugins.d/audispd-zos-remote.conf.new
config etc/audisp/plugins.d/syslog.conf.new
config etc/audisp/audisp-remote.conf.new
config etc/libaudit.conf.new

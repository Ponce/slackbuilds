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

preserve_perms etc/rc.d/rc.unbound.new
config etc/unbound/unbound.conf.new
config etc/logrotate.d/unbound.new

if [ -r /etc/logrotate.d/unbound ] && [ $(stat -c "%U:%G" "/etc/logrotate.d/unbound") != "root:root" ]; then
 echo "Incorrect permissions detected on /etc/logrotate.d/unbound !"
 echo "This will prevent Unbound logrotate script from working."
 echo ""
 echo "Previous Unbound SlackBuild scripts didn't set this correctly."
 echo ""
 echo "To fix it, simply run:"
 echo "# chown root:root /etc/logrotate.d/unbound"
fi

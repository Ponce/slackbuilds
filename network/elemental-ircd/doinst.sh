
IRCD_UNAME="@UNAME@"
IRCD_UID="@UID@"
IRCD_GID="@GID@"

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

preserve_perms etc/rc.d/rc.elemental-ircd.new
config etc/logrotate.d/elemental-ircd.new
config etc/elemental-ircd/ircd.motd.new

# Set up user/group permissions
groupadd -g $IRCD_GID $IRCD_UNAME 2>/dev/null
useradd -u $IRCD_UID -g $IRCD_GID -d /var/lib/elemental-ircd $IRCD_UNAME 2>/dev/null
chown $IRCD_UID:$IRCD_GID /var/run/elemental-ircd
chown $IRCD_UID:$IRCD_GID /var/log/elemental-ircd
chown $IRCD_UID:$IRCD_GID /var/lib/elemental-ircd
chown $IRCD_UID:$IRCD_GID /var/state/elemental-ircd

config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"

  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.hylafax.new:
if [ -e etc/rc.d/rc.hylafax ]; then
  cp -a etc/rc.d/rc.hylafax etc/rc.d/rc.hylafax.new.incoming
  cat etc/rc.d/rc.hylafax.new > etc/rc.d/rc.hylafax.new.incoming
  mv etc/rc.d/rc.hylafax.new.incoming etc/rc.d/rc.hylafax.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.hylafax.new
fi

config etc/rc.d/rc.hylafax.new
config var/spool/hylafax/etc/dialrules.new
config var/spool/hylafax/etc/dialrules.europe.new
config var/spool/hylafax/etc/dialrules.sf-ba.new
config var/spool/hylafax/etc/dpsprinter.ps.new
config var/spool/hylafax/etc/hosts.hfaxd.new

# We warn about needed configuration to the /etc/inittab file.
printf "\nThe following line will need be added to your /etc/inittab:
please check if it is the correct tty device for the modem,
and if not, change it to the correct one.
  m0:23:respawn:/usr/libexec/hylafax/faxgetty ttyS0\n\n"
# Hylafax faxgetty activation


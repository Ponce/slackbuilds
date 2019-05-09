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

preserve_perms etc/rc.d/rc.hylafax.new

config var/spool/hylafax/etc/dialrules.new
config var/spool/hylafax/etc/dialrules.europe.new
config var/spool/hylafax/etc/dialrules.sf-ba.new
config var/spool/hylafax/etc/dpsprinter.ps.new
config var/spool/hylafax/etc/hosts.hfaxd.new
config var/spool/hylafax/etc/cover.templ.new
config var/spool/hylafax/etc/dialrules-pabx.be.new
config var/spool/hylafax/etc/dialrules.ext.new
config var/spool/hylafax/etc/dialrules.uk.new
config var/spool/hylafax/etc/dialrules.world.new

if [ -d usr/lib64 ]; then
  config usr/lib64/hylafax/faxcover.ps.new
  config usr/lib64/hylafax/faxmail.ps.new
  config usr/lib64/hylafax/hfaxd.conf.new
  config usr/lib64/hylafax/pagesizes.new
  config usr/lib64/hylafax/typerules.new
else
  config usr/lib/hylafax/faxcover.ps.new
  config usr/lib/hylafax/faxmail.ps.new
  config usr/lib/hylafax/hfaxd.conf.new
  config usr/lib/hylafax/pagesizes.new
  config usr/lib/hylafax/typerules.new
fi

# We warn about needed configuration to the /etc/inittab file.
printf "\nThe following line will need be added to your /etc/inittab:
please check if it is the correct tty device for the modem,
and if not, change it to the correct one.
  m0:23:respawn:/usr/libexec/hylafax/faxgetty ttyS0\n\n"
# Hylafax faxgetty activation


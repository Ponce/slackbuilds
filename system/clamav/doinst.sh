# Read "README.slackware" for compatibility with amavisd-new

# These values are set in the build script and sed'ed into this
CLAMUSR=_SUB_CLAMUSR
CLAMGRP=_SUB_CLAMGRP
CLAMUID=_SUB_CLAMUID
CLAMGID=_SUB_CLAMGID

# Handle the incoming configuration files:
config() {
  for infile in $1; do
    NEW="$infile"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
      mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
      # toss the redundant copy
      rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
  done
}

config etc/freshclam.conf.new
config etc/clamd.conf.new
config etc/rc.d/rc.clamav.new

# Create log files
# We don't do this inside the package because we don't want the package 
# to remove them if clamav is uninstalled
touch var/log/clamd.log
touch var/log/freshclam.log

# Check for presence of $CLAMUSR and $CLAMGRP on target system
DO_EXIT=0
if ! grep ^${CLAMGRP}: etc/group 2>&1 > /dev/null; then
  cat << EOF

  You must have a ${CLAMGRP} group present for this post-installation
  script to complete.  First, do this:

  # groupadd -g ${CLAMGID} ${CLAMGRP}

  Then, do *one* of the following:
  (1) Run "upgradepkg --reinstall clamav-*tgz" or
  (2) Change to the directory '/' (using "cd /") and run the script /var/log/scripts/clamav-* manually.
EOF
  DO_EXIT=1
elif ! grep ^${CLAMUSR}: etc/passwd 2>&1 > /dev/null; then
  cat << EOF

  You must have a ${CLAMUSR} user present for this post-installation
  script to complete.  First, do this:

  # useradd -u ${CLAMUID} -d /dev/null -s /bin/false -g ${CLAMGRP} ${CLAMUSR}

  Then, do *one* of the following:
  (1) Run "upgradepkg --reinstall clamav-*tgz" or
  (2) Change to the directory '/' (using "cd /") and run the script /var/log/scripts/clamav-* manually.
EOF
  DO_EXIT=1
fi
[ $DO_EXIT -eq 1 ] && exit
# Only way to create and use the correct uid and gid on the target system,
# is to use chroot:
chroot . <<EOR 2>/dev/null

# Restore the correct permissions
chown ${CLAMUSR} usr/sbin/clamav-milter
chmod 4700 usr/sbin/clamav-milter
chown -R ${CLAMUSR}:${CLAMGRP} var/run/clamav
chmod 771 var/run/clamav
chown ${CLAMUSR}:${CLAMGRP} var/log/clamd.log
chmod 660 var/log/clamd.log
chown ${CLAMUSR}:${CLAMGRP} var/log/freshclam.log
chmod 660 var/log/freshclam.log
chown -R ${CLAMUSR}:${CLAMGRP} usr/share/clamav
chmod -R 770 usr/share/clamav
EOR


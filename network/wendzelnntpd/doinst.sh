#!/bin/sh

UDBFILE=/var/spool/news/wendzelnntpd/usenet.db

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
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

# Keep same perms when installing rc.httpd.new:
preserve_perms etc/rc.d/rc.wendzelnntpd.new

# Backup old Usenet DB file if existent; if necessary, this allows to provide multiple copies; because after 2x replacing an existing with a .new file, we would lose all postings! However, replacing an existing usenet.db file is necessary since the database format might change and an old file might become incompatible with a newer one.
if [ -f $UDBFILE ]; then mv $UDBFILE ${UDBFILE}.`date +"%m-%d-%y-%H:%M"`.bkp; chmod 0600 ${UDBFILE}.`date +"%m-%d-%y-%H:%M"`.bkp; echo "***Your old usenet database was backuped!***"; fi

# install config file
config var/spool/news/wendzelnntpd/usenet.db.new

# Handle config files.  Unless this is a fresh installation, the
# admin will have to move the .new files into place to complete
# the package installation, as we don't want to clobber files that
# may contain local customizations.
config etc/wendzelnntpd.conf.new

# create a first standard newsgroup so that server is directly usable after install
/usr/sbin/wendzelnntpadm addgroup alt.wendzelnntpd.test y

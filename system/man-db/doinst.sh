
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

config etc/man_db.conf.new

# In English, the if/find below means "only run the database creation if
# it was last done over an hour ago". This is needed because upgradepkg
# runs doinst.sh twice, but I don't want the 10+ minute long database
# creation to happen twice on upgrade (or at all, when I'm repeatedly
# reinstalling man-db for testing purposes).

if  \
  [ ! -e /var/cache/man/man-db ] || \
  [ -n "$( find var/cache/man/ -type d -a -name man-db -a -mmin +60 )" ]
then
# Generate the initial man database (or rebuild it if it exists).
# We want to skip this step if installing somewhere besides / (e.g. with
# the -root option or ROOT env variable set for installpkg), hence the
# readlink silliness.

# The -c option means it blows away any existing db. I thought about
# leaving it off (it will still create the db if it doesn't exist),
# but decided it's better to build it fresh if the package gets
# reinstalled (in case the db format has changed, or in case the
# db is corrupted and the user is trying to fix it by reinstalling
# this package).

# the 2>/dev/null was added for 2.7.6 because it complains about
# missing CACHEDIR.TAG files... which don't matter, because we've
# got NOCACHE in the config file.
  ( \
    [ -x /bin/readlink ] && \
    [ "$( /bin/readlink -f $( pwd ) )" = "/" ] && \
    ( [ -x /opt/man-db/bin/mandb ] && /opt/man-db/bin/mandb -c -q ) || \
    ( [ -x /usr/bin/mandb ] && /usr/bin/mandb -c -q ) \
  ) 2>/dev/null
fi


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

[ -x /bin/readlink ] && \
[ "$( /bin/readlink -f $( pwd ) )" = "/" ] && \
( [ -x /opt/man-db/bin/mandb ] && /opt/man-db/bin/mandb -c -q ) || \
( [ -x /usr/bin/mandb ] && /usr/bin/mandb -c -q )

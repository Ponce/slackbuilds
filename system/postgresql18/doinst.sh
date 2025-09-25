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

preserve_perms etc/rc.d/rc.postgresql18.new
config etc/logrotate.d/postgresql18.new

# Create default program symlinks in /usr/bin
(
  cd usr/bin
  for pg_binary in ../lib@LIBDIRSUFFIX@/@PRGNAM@/@PG_VERSION@/bin/*; do
    pg_prog=$(basename $pg_binary)
    if [ -L $pg_prog ]; then
      ln -sf $pg_binary
    elif [ ! -e $pg_prog ]; then
      # make sure we don't overwrite actual binaries
      ln -s $pg_binary
    fi
  done
)


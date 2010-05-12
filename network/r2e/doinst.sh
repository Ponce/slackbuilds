config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  [ ! -r $OLD ] && mv $NEW $OLD
  rm -f $NEW
}

config etc/r2e/config.py.new


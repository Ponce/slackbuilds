config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
}
config etc/findlib.conf.new

destdir=$(chroot . /usr/bin/ocamlfind printconf destdir)/stublibs
ldconf=$(chroot . /usr/bin/ocamlfind printconf ldconf)
if ! grep -q -s "${destdir##/}" "$ldconf"; then
  echo "$destdir" >> "${ldconf##/}"
fi

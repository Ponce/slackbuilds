#!/bin/sh
config() {
  old="$1"
  new="$old.new"
  if [ ! -r $old ]; then
    mv $new $old
  elif [ "$(cat $old | md5sum)" = "$(cat $new | md5sum)" ]; then
    rm $new
  fi
}
config etc/findlib.conf

destdir=$(chroot . /usr/bin/ocamlfind printconf destdir)/stublibs
ldconf=$(chroot . /usr/bin/ocamlfind printconf ldconf)
if ! grep -q -s "${destdir##/}" "$ldconf"; then
  echo "$destdir" >> "${ldconf##/}"
fi

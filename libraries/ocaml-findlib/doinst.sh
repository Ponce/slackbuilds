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

destdir=$(ocamlfind printconf destdir)/stublibs
ldconf=$(ocamlfind printconf ldconf)
if ! grep -q $destdir $ldconf; then
  echo $destdir >> $ldconf
fi

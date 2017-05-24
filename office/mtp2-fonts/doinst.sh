if [ -x /usr/bin/mktexlsr ]; then
  if ! grep -qFs " mtpro2.map" /usr/share/texmf-local/web2c/updmap.cfg ; then
    mkdir -p /usr/share/texmf-local/web2c
    echo "Map mtpro2.map" >> /usr/share/texmf-local/web2c/updmap.cfg
  fi
  chroot . /usr/bin/mktexlsr >/dev/null 2>&1
  if [ -x /usr/bin/updmap-sys ]; then
    chroot . /usr/bin/updmap-sys >/dev/null 2>&1
  fi
else
  if [ -x /usr/share/texmf/bin/mktexlsr ]; then
    chroot . /usr/share/texmf/bin/mktexlsr >/dev/null 2>&1
  fi
  if [ -x /usr/share/texmf/bin/updmap-sys ]; then
    chroot . /usr/share/texmf/bin/updmap-sys --enable Map mtpro2.map \
      >/dev/null 2>&1
  fi
fi

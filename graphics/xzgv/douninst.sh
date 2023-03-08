if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

# How to cleanly remove a GNU info file from the index:
# Rebuild the info dir after our info file was removed. With modern versions
# of install-info, it's OK if our wildcard includes e.g. gcc.info.gz and
# gcc-1.info.gz (it won't create duplicate index entries). We have at least
# one package that does NOT compress its info files, for a good reason, so
# we can't say *.info.gz here.
if [ -x /usr/bin/install-info -a -d usr/info ]; then
  ( cd usr/info
    rm -f dir
    for i in *.info*; do /usr/bin/install-info $i dir 2>/dev/null; done
  )
fi

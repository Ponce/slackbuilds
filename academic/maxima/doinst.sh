
# As featured in many Slackbuilds:

if [ -x /usr/bin/install-info -a -d usr/info ]; then
  ( cd usr/info
    rm -f dir
    for i in *.info*; do /usr/bin/install-info $i dir 2>/dev/null; done
  )
fi

echo << END
Note: don't compress the info files because maxima uses them as
internal help files and currently isn't able to decompress them on
the fly. "info" can handle uncompressed files.
END

echo << END
Note: lisp files were added to /usr/info because maxima needs them
END

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q /usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database /usr/share/mime >/dev/null 2>&1
fi


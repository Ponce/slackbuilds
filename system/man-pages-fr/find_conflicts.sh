#!/bin/sh

# Run this in a *clean* install of Slackware, with no SBo or other
# 3rd-party packages installed!

# Output is a list of files under $PKG/usr/man that should be removed.
# For the SlackBuild, redirect this into 'conflicts.pages', and the
# script will use that at build time.

# The file "overrides.pages" contains conflicts that we're going to
# allow, because the new page is entirely in French, whereas the old
# one was only partially translated and still has English. This file
# was created manually (not by a script), by eyeballing the old and
# new man pages, and noting which ones weren't completely translated.

TMP=${TMP:-/tmp/SBo}
PKG=${1:-$TMP/package-man-pages-fr}

if [ ! -d $PKG/usr/man/fr ]; then
  echo "Run the SlackBuild first." ; exit 1
fi

find /usr/man/fr* -type f | while read i; do
  # get last dir and filename, e.g. man1/ls.1.xz
  i=$( echo $i | rev | cut -d/ -f1,2 | rev )

  # remove .gz or .xz suffix, now man1/ls.1
  i=$( echo $i | sed 's,\..z$,,' )

  grep -qx $i overrides.pages && continue

  # all the new man pages are .xz. if there's a new man
  # page matching the Slackware man page in $i, let the user know.
  [ -e $PKG/usr/man/fr/$i.xz ] && echo $i.xz
done

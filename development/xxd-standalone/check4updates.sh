#!/bin/sh

# xxd-standalone doesn't exist as its own tarball or git repo.
# It's made of just a few files from the vim git tree.  Every time vim
# get a minor release (pretty often), this gets marked as outdated
# by repology. But e.g. the xxd stuff from vim 9.2.0658 didn't get
# changed for the 9.2.1202 vim release.

# So this script exists to (a) get the latest git tag for the vim repo
# and (b) compare the xxd-standalone files and see if they've actually
# changed.

ATOMURL=https://github.com/vim/vim/tags.atom
RAWBASE=https://raw.githubusercontent.com/vim/vim

set -e

source ./xxd-standalone.info

# scrape latest release from atom feed
NEW="$(
wget -qO- $ATOMURL | \
  perl -nle 'if(m{<title>v([^<]+)<\/title>}) { print $1; last }'
)"

# do we have a new release?
if [ "$VERSION" = "$NEW" ]; then
  # nope, exit
  echo "$VERSION is the latest vim release, no update needed"
  exit 0
fi

for i in $DOWNLOAD; do
  # get the last 2 dirs + the filename, make full URL
  i="$( echo $i | rev | cut -d/ -f1-3 | rev )"
  OLDURL="$RAWBASE/v$VERSION/$i "
  NEWURL="$RAWBASE/v$NEW/$i "

  #echo "old: $OLDURL"
  #echo "new: $NEWURL"

  wget -qO1 $OLDURL
  wget -qO2 $NEWURL
  OK=yes
  if ! cmp -s 1 2; then
    OK=no
    break
  fi
done

rm -f 1 2

if [ "$OK" = "no" ]; then
  echo "$NEW has xxd-standalone changes, update needed"
  exit 1
else
  echo "$VERSION doesn't need an update to $NEW (no xxd-standalone changes)"
  exit 0
fi

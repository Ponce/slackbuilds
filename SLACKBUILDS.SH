#!/bin/bash
set -e

for sb in $(find . -name '*.SlackBuild' | sort)
do
  name=$(basename $sb | sed -re 's/\.SlackBuild$//')
  location=$(dirname $sb)
  if [ -f $location/$name.info ]; then
    echo "SLACKBUILD NAME: $name"
    echo "SLACKBUILD LOCATION: $location"
    files=$(cd $location && find .  -type f -printf '%P\n' | sort | xargs)
    echo "SLACKBUILD FILES: $files"

    # remove those pesky multi line listings for each interesting field
    TMP=$(mktemp)
    sed ':a;N;$!ba;s/\\\n*\s*//g' $location/$name.info > $TMP

    DOWNLOAD=$(grep ^DOWNLOAD= $TMP | cut -f2 -d\" )
    DOWNLOAD_x86_64=$(grep ^DOWNLOAD_x86_64= $TMP | cut -f2 -d\" )
    MD5SUM=$(grep ^MD5SUM= $TMP | cut -f2 -d\" )
    MD5SUM_x86_64=$(grep ^MD5SUM_x86_64= $TMP | cut -f2 -d\" )
    VERSION=$(grep ^VERSION= $TMP | cut -f2 -d\" )

    echo "SLACKBUILD VERSION: $VERSION"
    echo "SLACKBUILD DOWNLOAD: $DOWNLOAD"
    echo "SLACKBUILD DOWNLOAD_x86_64: $DOWNLOAD_x86_64"
    echo "SLACKBUILD MD5SUM: $MD5SUM"
    echo "SLACKBUILD MD5SUM_x86_64: $MD5SUM_x86_64"

    if [ -f $location/slack-desc ]; then
      SHORTDESC=$(grep ^$name: $location/slack-desc | head -n 1 | sed -re "s/^$name://")
      echo "SLACKBUILD SHORT DESCRIPTION: $SHORTDESC"
    else
      echo "SLACKBUILD SHORT DESCRIPTION: "
    fi

    echo
    rm -f $TMP
  fi

done > SLACKBUILDS.TXT
gzip -9 SLACKBUILDS.TXT -c > SLACKBUILDS.TXT.gz

# END


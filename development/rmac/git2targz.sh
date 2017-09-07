#!/bin/sh

# Create source tarball from git repo, with generated version
# number. We don't want to include the whole git history in the tarball,
# but we do want to build the git hash into slack-desc, so there's a bit
# of extra stuff here.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

PRGNAM=rmac
CLONE_URL=http://shamusworld.gotdns.org/git/$PRGNAM

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

# get upstream's version number from version.h. easier to do in C than bash.
cat <<EOF >v.c
#include <stdio.h>
#include "version.h"
int main(int argc, char **argv) {
  printf("%d.%d.%d\n", MAJOR, MINOR, PATCH);
  return 0;
}
EOF

gcc -o v v.c
VERSION="$( ./v )"
rm -f v v.c

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )
VERSION=${VERSION}_$DATE

# git revision stored in gitrev, the SlackBuild seds it into the slack-desc.
git rev-parse --short HEAD > $PRGNAM.gitrev

# tarball won't contain git history.
rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

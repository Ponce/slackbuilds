#!/bin/sh

# Create source tarball from git repo, with generated version
# number. We don't include the git history in the tarball.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

PRGNAM=ipxnet
CLONE_URL=https://github.com/intangir/$PRGNAM.git

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

VERSION=$( git log --date=format:%Y%m%d --pretty=format:%cd.%h -n1 )

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

cat <<EOF

Archive created: $PRGNAM-$VERSION.tar.xz

Update $PRGNAM.info with:

VERSION="$VERSION"
DOWNLOAD="http://urchlay.naptime.net/~urchlay/src/$PRGNAM-$VERSION.tar.xz"
MD5SUM="$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )"

Don't forget to upload the new source!
EOF

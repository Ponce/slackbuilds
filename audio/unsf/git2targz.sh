#!/bin/sh

# Create source tarball from unsf git repo, with generated version
# number. We don't include the git history in the tarball.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

PRGNAM=unsf
CLONE_URL=https://github.com/psi29a/$PRGNAM.git

# Last released version. Normally we'd use a git tag for this, but
# upstream mentions a version 1.1 in their README... and there's no
# 1.1 release tag!
RELVER=1.1

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

# Extract date from last entry in git log. git has so many useful
# options that it's a PITA to find the one you need...
DATE=$( git log --date=format:%Y%m%d --pretty=format:%cd -n1 )

VERSION=${RELVER}+git$DATE

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

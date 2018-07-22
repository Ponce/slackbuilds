#!/bin/sh

# Create source tarball from git repo, with generated version
# number. We don't include the git history in the tarball.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

PRGNAM=gophernicus
CLONE_URL=https://github.com/kimholviala/$PRGNAM.git

# Upstream stopped doing release tarballs, and switched to 'rolling
# release', which seems to be a euphemism for 'no releases, we are in
# perpetual alpha'. RELVER is the last release tarball.
RELVER=2.5

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

# The 'rolling release' version numbers seem to increment with
# every commit. Upstream's got this script to generate them, so
# use it.
./git2changelog > ChangeLog
V=$( sed -n 's,.*\* (\(v[^)]*\).*,\1,p' ChangeLog | head -1 )

VERSION=${RELVER}${V}

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

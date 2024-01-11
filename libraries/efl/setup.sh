PRGNAM=efl
VERSION=${VERSION:-1.21.1}
ARCH=$( uname -m )
TMP=${TMP:-/tmp/SBo}
PKG=$TMP/package-$PRGNAM
SLKCFLAGS="-O2 -fPIC"
LIBDIRSUFFIX="64"


tar xvf /mnt/mysbo/efl/$PRGNAM-$VERSION.tar.?z*

cd $PRGNAM-$VERSION
chown -R root:root .
find -L . \
 \( -perm 777 -o -perm 775 -o -perm 750 -o -perm 711 -o -perm 555 \
  -o -perm 511 \) -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 640 -o -perm 600 -o -perm 444 \
  -o -perm 440 -o -perm 400 \) -exec chmod 644 {} \;

CFLAGS="$SLKCFLAGS" \
CXXFLAGS="$SLKCFLAGS" \
./configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --libdir=/usr/lib${LIBDIRSUFFIX} \
  --mandir=/usr/man \
  --docdir=/usr/doc/$PRGNAM-$VERSION \
  --disable-systemd \
  --build=$ARCH-slackware-linux

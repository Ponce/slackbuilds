
 VERSION="1.8.2"
 MODULE="v4l2loopback-dc"

dkms remove -m $MODULE/$VERSION --all >/dev/null 2>&1
rm -rf /usr/src/$MODULE-$VERSION >/dev/null 2>&1
rmmod -f v4l2loopback-dc >/dev/null 2>&1

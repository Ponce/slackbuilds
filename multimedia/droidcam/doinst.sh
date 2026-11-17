VERSION="2.1.7"
MODULE="v4l2loopback-dc"

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

_installModule(){

if [ -d usr/share/droidcam/$MODULE ]; then
    cp usr/share/droidcam/$MODULE/* usr/src/$MODULE-$VERSION
    dkms add -m $MODULE -v $VERSION
    dkms build -m $MODULE -v $VERSION
    dkms install -m $MODULE -v $VERSION
    /sbin/modprobe $MODULE
    /sbin/modprobe snd-aloop
else
    echo "Can't copy usr/share/droidcam/v4l2loopback"
fi
}

if [ "lsmod | grep v4l2loopback_dc" ]; then

    _installModule

else

    echo "Module v4l2loopback_dc installed"

fi

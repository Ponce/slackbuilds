VERSION="1.8.2"
MODULE="v4l2loopback-dc"

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

_installModule(){

    cp -r /tmp/SBo/$MODULE-$VERSION /usr/src/
    dkms add -m $MODULE -v $VERSION
    dkms build -m $MODULE -v $VERSION
    dkms install -m $MODULE -v $VERSION
    /sbin/modprobe $MODULE
    /sbin/modprobe snd-aloop
}

if [ "lsmod | grep v4l2loopback_dc" ]; then

    _installModule

else

    echo "Module v4l2loopback_dc installed"

fi

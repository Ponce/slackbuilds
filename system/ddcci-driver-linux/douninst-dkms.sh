VER=@VERSION@
CONF=etc/dkms/ddcci-$VER.conf
if [ -r $CONF ]; then
    dkms remove ddcci/$VER --all -c $CONF
    rm $CONF
fi

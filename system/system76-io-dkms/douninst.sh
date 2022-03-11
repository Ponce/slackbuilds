VER=@MODULE_VERSION@
CONF=etc/dkms/system76-io-$VER.conf
if [ -r $CONF ]; then
    dkms remove system76-io/$VER --all -c $CONF
    rm $CONF
fi

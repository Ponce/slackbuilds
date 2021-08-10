VER=@MODULE_VERSION@
dkms install system76-io/$VER

# Copy a backup of dkms.conf for module removal by douninst.sh.
cp usr/src/system76-io-$VER/dkms.conf etc/dkms/system76-io-$VER.conf

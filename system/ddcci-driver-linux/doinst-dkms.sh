VER=@VERSION@
dkms install ddcci/$VER

# Copy a backup of dkms.conf for module removal by douninst.sh.
cp usr/src/ddcci-$VER/dkms.conf etc/dkms/ddcci-$VER.conf

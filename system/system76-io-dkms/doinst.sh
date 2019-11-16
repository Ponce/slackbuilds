VER=#MODULE_VERSION#
dkms install system76-io/$VER

# Before removing the system76-io package, the following command should
# be run to unregister the module from dkms:
#
# dkms remove system76-io/$VER --all

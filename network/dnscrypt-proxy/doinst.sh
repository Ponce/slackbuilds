#!/bin/bash

# dnscrypt-proxy writes files to its data directories after
# dropping privileges. This ensures $DNSCRYPT_USER can write
# files to these directories, without having to change default
# root:root in slackware.
#
# This is a workaround, might not be a elegant solution.

PRGNAM=dnscrypt-proxy
DNSCRYPT_UID=293
DNSCRYPT_GID=293

chown $DNSCRYPT_UID:$DNSCRYPT_GID etc/$PRGNAM/*

setfacl -m u:$DNSCRYPT_UID:rwx etc/$PRGNAM
setfacl -m u:$DNSCRYPT_UID:rwx var/run/$PRGNAM
setfacl -m u:$DNSCRYPT_UID:rwx var/log/$PRGNAM

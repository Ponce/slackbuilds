#!/bin/bash

# Setting up permissions for elects's data directories.

PRGNAM=electrs
ELECTRS_UID=386
ELECTRS_GID=386

chown $ELECTRS_UID:$ELECTRS_GID etc/$PRGNAM/*

setfacl -R -m u:$ELECTRS_UID:rwx etc/$PRGNAM
setfacl -R -m u:$ELECTRS_UID:rwx var/run/$PRGNAM
setfacl -R -m u:$ELECTRS_UID:rwx var/log/$PRGNAM

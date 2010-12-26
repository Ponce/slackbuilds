#!/bin/sh

# armagetronad default user to use with Master server creation script.

AUSER=armagetronad
AUID=244
AGID=20

if test -w /etc/passwd; then
    echo "Creating user ${AUSER} with UID:${AUID} GID:${AGID}"
    if which useradd > /dev/null 2>&1; then
        useradd -u ${AUID} -g ${AGID} ${AUSER} || echo -e "\nWarning: unable to create user with 'useradd'. Giving up.\n"
    else
        echo -e "\nWarning: unable to find suitable program to add user.\n"
    fi

    else # no write acces to /etc/passwd
    echo -e "\nWarning: no write access to /etc/passwd, can't add user. Try as root.\n"
fi

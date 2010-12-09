#!/usr/bin/bash
# freenx preinstall script
# excerpted from alien bob's doinst.sh
# mixed by ponce <matteo.bernardini@sns.it>

set -e

if ! /sbin/pidof sshd >/dev/null ; then
  echo ""
  echo "WARNING: The SSH daemon is not running, but without SSH, NX will not work."
fi

if ! which nc 1>/dev/null 2>/dev/null ; then
  echo ""
  echo "WARNING: FreeNX needs the 'netcat' program to be installed."
fi

if ! which expect 1>/dev/null 2>/dev/null ; then
  echo ""
  echo "WARNING: FreeNX needs the 'expect' program to be installed."
fi

# create the $HOME/.ssh directory for the nx user and give it 700 permission.
mkdir -p /var/lib/nxserver/home/.ssh
chmod 700 /var/lib/nxserver/home/.ssh

# create the nx user and group
groupadd -g 243 nx
useradd -m -d /var/lib/nxserver/home -s /usr/bin/nxserver -u 243 -g 243 nx

# assign the nx user a random password of 30 alphanumeric chars to avoid problems
# with unlocking: http://alien.slackbook.org/dokuwiki/doku.php?id=slackware:nx
usermod -p $(echo $RANDOM$(date)$RANDOM | md5sum | cut -b 2-32) nx
passwd -u nx 1>/dev/null

echo "nx user/group added."

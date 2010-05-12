#!/bin/sh
PATH="$PATH:/usr/kerberos/bin"
MANPATH="$MANPATH:/usr/kerberos/man"
[ "$(id -u)" = "0" ] && PATH="$PATH:/usr/kerberos/sbin"

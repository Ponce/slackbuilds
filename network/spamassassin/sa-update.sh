#!/bin/sh

/usr/bin/sa-update > /dev/null
if [ $? -eq 0 ]; then
    [ -x /etc/rc.d/rc.spamd ] && /etc/rc.d/rc.spamd restart > /dev/null
fi


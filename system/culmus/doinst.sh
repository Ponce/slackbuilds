#!/bin/sh

fc-cache -f
cd /usr/share/fonts/TTF
/usr/bin/mkfontscale
/usr/bin/mkfontdir

cd /usr/share/fonts/Type1
/usr/bin/mkfontscale
/usr/bin/mkfontdir

( cd /etc/fonts/conf.d ; ln -sf ../conf.avail/61-culmus.conf 61-culmus.conf )

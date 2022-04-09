#if [ -x /usr/bin/update-desktop-database ]; then
#  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
#fi
#
#if [ -x /usr/bin/update-mime-database ]; then
#  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
#fi
#
#if [ -e usr/share/icons/gnome/icon-theme.cache ]; then
#  if [ -x /usr/bin/gtk-update-icon-cache ]; then
#    /usr/bin/gtk-update-icon-cache -f usr/share/icons/gnome >/dev/null 2>&1
#  fi
#fi

( cd /usr/local/bin ; rm -rf simh-classic-altair )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/altair simh-classic-altair )

( cd /usr/local/bin ; rm -rf simh-classic-eclipse )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/eclipse simh-classic-eclipse )

( cd /usr/local/bin ; rm -rf simh-classic-gri )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/gri simh-classic-gri )

( cd /usr/local/bin ; rm -rf simh-classic-h316 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/h316 simh-classic-h316 )

( cd /usr/local/bin ; rm -rf simh-classic-i1401 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/i1401 simh-classic-i1401 )

( cd /usr/local/bin ; rm -rf simh-classic-i1620 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/i1620 simh-classic-i1620 )

( cd /usr/local/bin ; rm -rf simh-classic-i7094 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/i7094 simh-classic-i7094 )

( cd /usr/local/bin ; rm -rf simh-classic-id16 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/id16 simh-classic-id16 )

( cd /usr/local/bin ; rm -rf simh-classic-id32 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/id32 simh-classic-id32 )

( cd /usr/local/bin ; rm -rf simh-classic-lgp )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/lgp simh-classic-lgp )

( cd /usr/local/bin ; rm -rf simh-classic-nova )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/nova simh-classic-nova )

( cd /usr/local/bin ; rm -rf simh-classic-pdp1 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp1 simh-classic-pdp1 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp10 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp10 simh-classic-pdp10 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp11 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp11 simh-classic-pdp11 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp15 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp15 simh-classic-pdp15 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp4 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp4 simh-classic-pdp4 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp7 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp7 simh-classic-pdp7 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp8 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp8 simh-classic-pdp8 )

( cd /usr/local/bin ; rm -rf simh-classic-pdp9 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/pdp9 simh-classic-pdp9 )

( cd /usr/local/bin ; rm -rf simh-classic-s3 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/s3 simh-classic-s3 )

( cd /usr/local/bin ; rm -rf simh-classic-sds )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/sds simh-classic-sds )

( cd /usr/local/bin ; rm -rf simh-classic-sigma )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/sigma simh-classic-sigma )

( cd /usr/local/bin ; rm -rf simh-classic-uc15 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/uc15 simh-classic-uc15 )

( cd /usr/local/bin ; rm -rf simh-classic-vax )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/vax simh-classic-vax )

( cd /usr/local/bin ; rm -rf simh-classic-vax780 )
( cd /usr/local/bin ; ln -sf /opt/simh-classic/bin/vax780 simh-classic-vax780 )



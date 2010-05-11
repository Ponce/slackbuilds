#!/bin/sh

WICD14=${WICD14:-/opt/wicd}
WICD15_etc=${WICD15:-/etc/wicd}
WICD15_var=${WICD15:-/var/lib/wicd}

for config in \
  manager-settings.conf \
  wired-settings.conf \
  wireless-settings.conf ;
 do \
  if [ -e ${WICD14}/data/$config ]; then
    cp -a ${WICD14}/data/$config ${WICD15_etc}/$config 
  fi ;
done

if [ "$(ls ${WICD14}/encryption/configurations/ | wc -l)" -gt 0 ]; then 
  for config in \
    ${WICD14}/encryption/configurations/* ;
   do \
    cp -a $config ${WICD15_var}/configurations ;
  done
fi


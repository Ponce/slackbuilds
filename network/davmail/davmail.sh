#!/bin/sh
BASE=/usr/share/davmail
for i in $BASE/lib/*; do export CLASSPATH=$CLASSPATH:$i; done
exec java -Xmx512M -Dsun.net.inetaddr.ttl=60 -cp $BASE/davmail.jar:$CLASSPATH davmail.DavGateway $1

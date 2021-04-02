#!/bin/sh

BASE=/usr/share/davmail

if [ -n "$JAVA_HOME" ]; then
  JAVA_CMD="$JAVA_HOME/bin/java"
else
  JAVA_CMD="$(which java)"
fi

for i in $BASE/lib/*; do
  export CLASSPATH=$CLASSPATH:$i;
done

exec $JAVA_CMD -Xmx512M -Dsun.net.inetaddr.ttl=60 -cp $BASE/davmail.jar:$CLASSPATH davmail.DavGateway $1

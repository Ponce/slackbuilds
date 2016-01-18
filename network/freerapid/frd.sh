#!/bin/sh

# default option.
if [ -x "`which java`" ]; then
  cd /usr/share/freerapid-0.9.4/ && exec java -jar frd.jar "$@"
fi

# less CPU usage.
#if [ -x "`which java`" ]; then
#  cd /usr/share/freerapid-0.9.4/ && exec java -Dsun.java2d.opengl=true -jar frd.jar "$@"
#fi

# needed for some distros.
#if [ -x "`which java`" ]; then
#  cd /usr/share/freerapid-0.9.4/ && exec java -Djava.net.preferIPv4Stack=true -Xmx160m -jar frd.jar "$@"
#fi

# better fonts appearance (smooth fonts).
#if [ -x "`which java`" ]; then
#  cd /usr/share/freerapid-0.9.4/ && exec java -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.net.preferIPv4Stack=true -Xmx160m -jar frd.jar "$@"
#fi

# all options combined.
#if [ -x "`which java`" ]; then
#  cd /usr/share/freerapid-0.9.4/ && exec java -Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.net.preferIPv4Stack=true -Xmx160m -jar frd.jar "$@"
#fi

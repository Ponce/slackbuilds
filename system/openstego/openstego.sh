#!/bin/sh
exec java -Dawt.useSystemAAFontSettings=on -Xmx1024m -jar /usr/share/openstego/openstego.jar "$@"

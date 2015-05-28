#!/bin/sh
# FRD requires Sun Java 6, NO Shity GCJ, NO buggy OpenJDK, but Sun Java 6!
# some crappy distros needed to add switch -Djava.net.preferIPv4Stack=true
# Look for java in these directories
LOOKUP_JRE_DIRS="/usr/lib/jvm/* /opt/java* /opt/jre*"
#Created by Petris 2009 -> Many thanks!
# Required version
REQ_JVER1=1
REQ_JVER2=6
REQ_JVER3=0
REQ_JVER4=5

check_java_version () {
	JVER1=`echo $JAVA_VERSION_OUTPUT | sed 's/java version "\([0-9]*\)\.[0-9]*\.[0-9]*_[0-9]*".*/\1/'`
	JVER2=`echo $JAVA_VERSION_OUTPUT | sed 's/java version "[0-9]*\.\([0-9]*\)\.[0-9]*_[0-9]*".*/\1/'`
	JVER3=`echo $JAVA_VERSION_OUTPUT | sed 's/java version "[0-9]*\.[0-9]*\.\([0-9]*\)_[0-9]*".*/\1/'`
	JVER4=`echo $JAVA_VERSION_OUTPUT | sed 's/java version "[0-9]*\.[0-9]*\.[0-9]*_\([0-9]*\)".*/\1/'`

	if [ $JVER1 -gt $REQ_JVER1 ]; then
		return 0
	elif [ $JVER1 -lt $REQ_JVER1 ]; then
		return 1
	fi

	if [ $JVER2 -gt $REQ_JVER2 ]; then
		return 0
	elif [ $JVER2 -lt $REQ_JVER2 ]; then
		return 1
	fi

	if [ $JVER3 -gt $REQ_JVER3 ]; then
		return 0
	elif [ $JVER3 -lt $REQ_JVER3 ]; then
		return 1
	fi

	if [ $JVER4 -lt $REQ_JVER4 ]; then
		return 1
	fi

	return 0
}

# Handle symlinks
PROGRAM="$0"
while [ -L "$PROGRAM" ]; do
	PROGRAM=`readlink -f "$PROGRAM"`
done
cd "`dirname \"$PROGRAM\"`"

# Check default java
if [ -x "`which java`" ]; then
	JAVA_VERSION_OUTPUT=`java -version 2>&1`
	check_java_version && cd /usr/share/freerapid-0.9.4/ && exec java -Djava.net.preferIPv4Stack=true -Xmx160m -jar frd.jar "$@"
fi

# Test other possible Java locations
for JRE_PATH in $LOOKUP_JRE_DIRS; do
	if [ -x "$JRE_PATH/bin/java" ]; then
		JAVA_VERSION_OUTPUT=`"$JRE_PATH/bin/java" -version 2>&1`
		check_java_version && {
			export JRE_PATH
			cd /usr/share/freerapid-0.94/ && exec $JRE_PATH/bin/java -Djava.net.preferIPv4Stack=true -Xmx160m -jar frd.jar "$@"
		}
	fi
done

# Failed
if [ -x "`which xmessage`" ]; then
	xmessage -nearmouse -file - <<EOF
Failed to find a suitable java version.
Required: $REQ_JVER1.$REQ_JVER2.$REQ_JVER3_$REQ_JVER4 or newer.
EOF
else
	echo Failed to find a suitable java version.
	echo Required: $REQ_JVER1.$REQ_JVER2.$REQ_JVER3_$REQ_JVER4 or newer.
fi

exit 1

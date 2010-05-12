#!/bin/sh

# Java heap size, in megabytes
# Increase if you experience OutOfMemory errors (see quickstart.html)
JAVA_HEAP_SIZE=96

exec /usr/lib/java/bin/java \
  -Xmx${JAVA_HEAP_SIZE}m ${JPICEDT} \
  -classpath "${CLASSPATH}:/opt/jpicedt:/opt/jpicedt/lib/jpicedt.jar" \
  jpicedt.JPicEdt $@


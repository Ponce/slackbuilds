#!/bin/sh

# Use the declared SBo dependency even in desktop sessions without profile.d.
# An explicitly supplied JAVA_HOME takes precedence.
if [ -z "$JAVA_HOME" ]; then
  JAVA_HOME=/usr/lib@LIBDIRSUFFIX@/zulu-openjdk21
  export JAVA_HOME
fi

exec /usr/lib@LIBDIRSUFFIX@/jsignpdf/bin/jsignpdf.sh "$@"

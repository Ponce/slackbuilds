#!/bin/sh

CLASSPATH=@JAVADIR@/ecj.jar${CLASSPATH:+:}$CLASSPATH \
  java org.eclipse.jdt.internal.compiler.batch.Main "$@"


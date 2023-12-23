#!/bin/sh
CP='/usr/share/java/pdftk/pdftk-all.jar'
exec java -cp "$CP" com.gitlab.pdftk_java.pdftk "$@"


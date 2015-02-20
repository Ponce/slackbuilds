#!/bin/sh

# fixman.sh - part of SBo adl build. B Watson (yalhcru@gmail.com), WTFPL.

# needs polyglotman.

# have to install man pages manually. Unfortunately they're preformatted,
# and look like crap with Slackware's man command, so I wrote this little
# script to clean them up.

# If ever needed again, the commands to clean up the man pages:
# tar xvf adl.tar.Z
# mkdir -p man
# for i in adl/man/*.6; do sh fixman.sh $i > man/`basename $i`; done
# rm -rf adl

# This script needs polyglotman installed, and I don't want to list that
# in REQUIRES, so I include the results of fixman.sh instead of running
# it in the SlackBuild.

# in English: each file is converted to perl POD format using rman, then
# rman's output is cleaned up and piped to pod2man, which produces roff
# man page source on stdout.

VERSION=${VERSION:-19930322}

[ -z "$1" ] && echo "$0 requires a filename argument" 2>&1 && exit 1

name=$( echo $1 | sed 's,\..*,,' | tr a-z A-Z )
rman -f pod $1 | \
	perl -ple 's,\s+, ,g; s,^\s*,,; s,^(=head1)\s+(.*)$,$1." ".uc($2),e' |
	pod2man -s6 -r$VERSION --stderr -n$name -cSlackBuilds.org

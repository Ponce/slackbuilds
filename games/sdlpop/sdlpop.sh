#!/bin/sh

# 20160812 bkw:
# wrapper script for sdlpop, for slackbuilds.org

EXE=/usr/libexec/sdlpop/prince
USERDIR=$HOME/.sdlpop
SHAREDIR=/usr/share/games/sdlpop
INI=SDLPoP.ini

[ ! -e $USERDIR ] && mkdir -p $USERDIR
cd $USERDIR || exit 1

for file in $SHAREDIR/*; do
	base="$( basename "$file" )"
	[ -e "$base" ] || ln -s "$file" "$base"
done

[ -L $INI ] && ( rm -f $INI ; cp $SHAREDIR/$INI . )

exec $EXE "$@"

#!/bin/sh

# 20160812 bkw:
# wrapper script for sdlpop, for slackbuilds.org

# 20170317 bkw: updated for v1.17, mods dir has to be writable by users,
# so we can't just symlink it from /usr/share. however, if any mods are
# in /usr/share, we copy them (again, need to be writable)

EXE=/usr/libexec/sdlpop/prince
USERDIR=$HOME/.sdlpop
SHAREDIR=/usr/share/games/sdlpop
INI=SDLPoP.ini

[ ! -e $USERDIR ] && mkdir -p $USERDIR
cd $USERDIR || exit 1

[ -e data ] || ln -s $SHAREDIR/data data

mkdir -p mods
for file in $SHAREDIR/mods/*; do
	base="$( basename "$file" )"
	[ -e mods/"$base" ] || cp -a "$file" mods/"$base"
done

[ -e $INI ] || cp $SHAREDIR/$INI .

exec $EXE "$@"

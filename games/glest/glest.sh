#!/bin/sh
# Wrapper script taken from the Ubuntu guys.
# I guess they're good for something. :-)
# Modified for the accompanying glest.SlackBuild.

MAINDIR=/usr/share/glest
BASEDIR="$XDG_CONFIG_HOME"
if [ -z "$BASEDIR" ]; then
    BASEDIR="$HOME/.config"
fi
DIR="$BASEDIR/glest"
if [ ! -d "$DIR" ]; then
    if [ -d "$HOME/.glest" ]; then
        # Move the configuration directory to ~/.config
        mkdir -p $BASEDIR
        mv "$HOME/.glest" "$DIR"
    else
        mkdir $DIR
    fi
fi
cd $DIR

if [ -f glest.ini ]; then
    # Update for Glest 3.2.1
    sed -i 's/\.lng//' glest.ini
    language=$(cat glest.ini | grep Lang | cut -d'=' -f2)
    [ -f /usr/share/glest/data/lang/${language}.lng ] || \
        sed -i "s/${language}/english/" glest.ini
    # If the configuration file is too old, replace it
    grep AutoTest glest.ini >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        mv glest.ini glest.ini.bck
        cp /etc/glest/glest.ini .
        [ -h docs ] || unlink docs
    fi
else
    cp /etc/glest/glest.ini .
    sed -i 's/\.lng//' glest.ini
fi
[ -h glest ] || ln -s /usr/lib/glest/glest .
[ -f servers.ini ] || cp $MAINDIR/servers.ini .
for i in data scenarios techs tilesets; do
      [ -h $i ] || ln -s $MAINDIR/$i .
done
[ -d maps ] || mkdir maps
[ -d screens ] || mkdir screens
cd maps
for i in $MAINDIR/maps/*; do
      [ -h `basename $i` ] || ln -s $i .
done
cd ..

exec ./glest

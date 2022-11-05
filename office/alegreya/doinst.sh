## Add the font to LaTeX' font map if necessary
## and update the path caches.

UPDMAP=/usr/share/texmf-var/web2c/updmap.cfg
if test ! -f $UPDMAP; then touch $UPDMAP; fi
if ! grep -q '^Alegreya.map$' < $UPDMAP; then
    echo "Map Alegreya.map" >> $UPDMAP
fi
updmap-sys
texhash

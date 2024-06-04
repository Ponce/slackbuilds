echo "Deleting generated images..."
[ -f usr/lib64/chibi/chibi.img ] && rm usr/lib64/chibi/chibi.img
[ -f usr/lib64/chibi/red.img ] && rm usr/lib64/chibi/red.img
[ -f usr/lib64/chibi/snow.img ] && rm usr/lib64/chibi/snow.img

if [ -e usr/lib64/chibi ]; then
    rmdir usr/lib64/chibi && echo "Removed empty directory usr/lib64/chibi"
fi

#!/bin/sh

src="$1"
shift
if [ -z "$src" -o ! -e "$src" -o "$*" ]; then
  cat 1>&2 <<EOF
Usage: $0 /path/to/icon.png
EOF
fi

set -e

mkdir -p icons/
cat "$src" > icons/160.png

for i in 16 22 32 48 64 128; do
  convert -resize ${i}x${i} "$src" icons/$i.png
done

exit 0

#!/bin/sh

# NOTE: Don't run this script unless you're also updating the build
# for a new version. The xz files will change even if the docs haven't.

FILES="
CONTRIBUTING.md
Changelog.md
LICENSE
supportedsites.md
"

source ./yt-dlp-bin.info

for i in $FILES; do
  wget -O docs/$i https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/tags/$VERSION/$i
  rm -f docs/$i.xz
  xz -9 docs/$i
done

echo 'git add docs/*'

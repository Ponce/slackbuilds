#!/bin/sh

FILES="
CONTRIBUTING.md
Changelog.md
Collaborators.md
LICENSE
supportedsites.md
"

source ./yt-dlp-bin.info

for i in $FILES; do
  wget -O docs/$i https://raw.githubusercontent.com/yt-dlp/yt-dlp/refs/tags/$VERSION/$i
done

echo 'git add docs/*'

#!/bin/bash

# mkgroovy.sh - create a groovymame diff, if possible.

# Since the groovymame author switched to github, there are no more
# groovymame diffs to download (the ones that used to be hosted on
# google drive). This rather ugly script just uses the github API to
# get a diff we can apply.

# Note: in my testing, requesting the same diff repeatedly from
# the API results in identical files, but I'm not sure this is
# guaranteed. It only matters if you're repeatedly test-running
# this script, really.

# The github 'compare' API is basically just a wrapper for the git
# command, run on a remote repo. We can use it to download a diff
# between 2 tags, without having to clone the repo (save a ton of
# time and bandwidth).

# To understand this, see the github API docs: https://docs.github.com/en/rest/

# to see info on the repo:
# curl -H "Accept: application/vnd.github.v3+json" 'https://api.github.com/users/antonioginer/repos'

# to get a list of releases:
# curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/antonioginer/GroovyMAME/releases
# looks like these are in chronological order, newest first.

# DIFFURL should end up looking like this:
# curl -H "Accept: application/vnd.github.v3.diff" 'https://api.github.com/repos/antonioginer/GroovyMAME/compare/{mame0237}...{gm0237sr002e}'

# Note: 'git diff' doesn't include timestamps in its output,
# and there's no way to make the gh API include them. To
# get ccache to play nice, I have to add the timestamps to
# the context headers in the diff myself. AFAICT, that's the
# only way to get ccache to play nice with this patch. Even with
# CCACHE_SLOPPINESS=include_file_mtime, it complains that the headers
# have a different modification time than what was expected, on the
# 2nd (cached) build. I'm pretty sure this only happens because mame
# uses a precompiled header, and ccache's precompiled header support
# isn't quite perfect yet. The timestamps I put in the patch are just
# the release date of the tag. They're not quite in the same format
# 'diff' produces, but 'patch' accepts them just fine.

if [ -n "$1" ]; then
  MAMEVER="$1"
else
  if [ -e mame.info ]; then
    source ./mame.info
    MAMEVER="$VERSION"
  else
    echo "No MAME version argument and no mame.info in current dir."
  fi
fi

MAMEVER=${MAMEVER/./}

RELEASEURL="https://api.github.com/repos/antonioginer/GroovyMAME/releases"
CMPURL="https://api.github.com/repos/antonioginer/GroovyMAME/compare/"
JSONHDR="Accept: application/vnd.github.v3+json"
DIFFHDR="Accept: application/vnd.github.v3.diff"

JSON="$( mktemp -t mkgroovy.XXXXXXXXXX.json )"
curl -sS -H "$HEADER" "$RELEASEURL" >> "$JSON"

GMTAG="$(
  grep '"tag_name.*"'".*$MAMEVER" "$JSON" \
  | head -1 \
  | sed 's,.*"\(gm'"$MAMEVER"'[^"]*\)".*,\1,'\
  )"

GMDATE="$(
  grep '"created_at"' "$JSON" \
  | head -1 \
  | cut -d'"' -f4
  )"

rm "$JSON"

case "$GMTAG" in
  gm$MAMEVER*) ;; # OK
  "") cat <<EOF
!!! Can't find a GroovyMAME release for MAME $MAMEVER, try again tomorrow?
EOF
      exit 1 ;;
  *) cat <<EOF
!!! GMTAG is "$GMTAG", which doesn't look right. Investigate.
EOF
     exit 1 ;;
esac

MAMETAG="mame$MAMEVER"
DIFFURL="$CMPURL{$MAMETAG}...{$GMTAG}"

echo "=== GMTAG='$GMTAG' MAMETAG='$MAMETAG'"
echo "=== DIFFURL='$DIFFURL'"

OUTPUT="$GMTAG.diff"
if [ -e "$OUTPUT" -o -e "$OUTPUT.xz" ]; then
  echo "=== $OUTPUT(.xz)? already exists and is the latest version for mame $MAMEVER, nothing to do."
  exit 0 # not an error!
fi

echo "=== Downloading diff."
curl -sS -H "$DIFFHDR" "$DIFFURL" > "$OUTPUT"

echo "=== Fudging timestamps to $GMDATE"
sed -i '/^\(+++\|---\)/s,$,\t'"$GMDATE," "$OUTPUT"

echo -n "=== Output is '$OUTPUT', type "
file -b --mime "$OUTPUT"

xz -9 "$OUTPUT"
echo "=== Compressed to $OUTPUT.xz"

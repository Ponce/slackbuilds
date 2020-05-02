#!/bin/bash

# extract-blood-data.sh - extract the game data from a mounted Blood
# CD-ROM or (not mounted) .iso file in the current directory.

# By B. Watson <yalhcru@gmail.com>, released under the WTPL: Do WTF you
# want with this.

if [ "$( id -u )" != "0" ]; then
  echo "$(basename $0) has to run as root because it needs to mount ISO images"
  exit 1
fi

# Copy the game data here
DEST=${1:-./blood}
DEST="$( readlink -f "$DEST" )"

# Deal with filenames case-insensitively
shopt -s nocaseglob

# Return true if directory $1 is a valid copy of the game.
contents_ok() {
  local mntpnt="$1"

  [ -e "$mntpnt/blood.ini"* ] && \
  [ -e "$mntpnt/data.z"* ] && \
  [ -e "$mntpnt/readme.txt"* ] && \
  head -n1 "$mntpnt/readme.txt"* | grep -q '^One Unit: WHOLE BLOOD(TM) v 1.21'

  return $?
}

# Try to find and mount a Blood ISO image, in the current directory.
find_iso() {
  local mntpnt="$1"
  local iso

  mkdir -p "$mntpnt"

  for iso in *; do
    [ -e "$iso" ] || continue
    file -L --mime -b "$iso" | grep -qi 'iso.*9660' || continue

    echo -n "Trying '$iso'... "
    if /sbin/mount -o ro,loop -t iso9660 "$iso" "$mntpnt"; then
      if contents_ok "$mntpnt"; then
        echo "found One Unit Whole Blood ISO."
        return 0
      fi
      echo "mounted, but not a Blood ISO."
      /sbin/umount "$mntpnt"
    else
      echo "couldn't mount."
    fi
  done

  /sbin/umount "$mntpnt" &> /dev/null
  echo "Couldn't find One Unit Whole Blood ISO in $( pwd )"
  return 1
}

# Extract the data we need. We might be including a little more
# that necessary here.
extract_data() {
  local src="$1"
  local dst="$2"
  local tmpdir

  echo "Extracting and copying data from $src to $dst"

  mkdir -p "$dst"
  tmpdir="$( mktemp -d ${TMP:-/tmp}/bloodtmp.XXXXXX )"

  # most of the stuff we need is in data.z
  isextract x "$src/data.z"* "$tmpdir"
  cd "$tmpdir"
    cp -a *.rff* \
          *.dem* \
          *.art* \
          *.dat* \
          "$dst"
  cd -

  # ...but not all of it
  cp -a "$src/movie"* "$src/cryptic/"* "$src/blood.ini"* "$src/readme.txt"* "$dst"

  # get rid of unnecessary cruft not used by nblood
  rm -rf "$dst"/cryptic.exe*   \
         "$dst"/movie/directx* \
         "$dst"/movie/amovie* \
         "$dst"/movie/_* \
         "$dst"/movie/*.exe* \
         "$dst"/movie/*.ins*

  find "$dst" -type f -exec chmod 644 {} \+
  chmod 755 "$dst/movie"*

  rm -rf "$tmpdir"
}

# main()
if ! which isextract &>/dev/null; then
  echo "Can't find isextract on PATH. Please install it and re-run this script."
  exit 1
fi

# Try to find a mounted CD
CDROM=""
cat /proc/mounts | while read line; do
  t="$( echo "$line" | cut -d' ' -f3 )"
  m="$( echo "$line" | cut -d' ' -f2 )"
  if [ "$t" = "iso9660" ]; then
    echo -n "Trying mount point '$m'..."
    if contents_ok "$m"; then
      echo OK
      CDROM="$m"
      break
    fi
    echo "not a Blood CD"
  fi
done

if [ -n "$CDROM" ]; then
  echo "Found One Unit Whole Blood CD-ROM mounted on $CDROM"
else
  CDROM="$( mktemp -d ${TMP:-/tmp}/bloodcd.XXXXXX )"
  RMTMP="$CDROM"
  if ! find_iso "$CDROM"; then
    echo "Couldn't find any game data"
    exit 1
  fi
fi

extract_data "$CDROM" "$DEST"

if [ -n "$RMTMP" ]; then
  umount "$RMTMP" &>/dev/null
  rmdir "$RMTMP"
fi

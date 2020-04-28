#!/bin/sh

# extract-shadow-warrior.sh, by B. Watson (yalhcru@gmail.com).

# Licensed under the WTFPL: Do WTF you want with this. See
# http://www.wtfpl.net/txt/copying/ for details.

# This file is part of the SlackBuilds.org jfsw_registered_data build,
# but you're welcome to use it for any other purpose (that's why I made
# it a standalone script).

# Extracts the game data from bin/cue of Shadow Warrior for DOS, as found
# in the zip file from https://archive.org/details/ShadowWarriorUSA. The
# tool that handles bin/cue files is bchunk, but sadly it doesn't properly
# handle bin/cue where each track is in a separate bin file... so we
# help it along by chopping up the .cue file.

# We expect a single argument: the name of the .cue file. Output will be
# a set of .iso and .wav files in the current directory, named track01.iso
# and track02.wav through track14.wav, plus a set of converted track02.ogg
# through track14.ogg, if the oggenc command is found on $PATH.

# When we're finished, the files will take up around 900MB of space,
# so plan accordingly.

# Note: converting the same wav file to ogg with oggenc multiple times,
# does not give identical ogg files. It *does* however give the same
# sized file every time (down to the byte). Really only matters if you're
# debugging this script, I guess.

if [ "$*" = "" ] || [ ! -e "$1" ]; then
  echo "Usage: $( basename $0 ) cue-file.cue" 1>&2
  exit 1
fi

# need this to let "read" read the initial spaces in the .cue file lines
IFS=""

# save old stdout
exec 3>&1

# clean up any turds from previous runs
rm -f tmpcue??.cue

# split up each track entry in the input .cue file into a separate .cue
# file containing only that track.
count=1
cat "$1" | while read line; do
  case "$line" in
    FILE*) cue_out="tmpcue$( printf '%02d' $count ).cue"
           exec > "$cue_out"
           count="$( expr $count + 1 )"
           ;;
  esac
  echo "$line"
done

# restore old stdout
exec 1>&3

# now convert each file to .iso or .wav (bchunk is smart enough
# to know which is which). if a file is a .wav, we'll convert it
# to .ogg and delete it, so we don't end up chewing up 1.3GB of
# disk space all at once.
for cue_out in tmpcue??.cue; do
  rm -f track??.wav
  binfile="$( head -1 "$cue_out" | cut -d\" -f2 )"
  bchunk -w "$binfile" "$cue_out" track
  [ -e track??.wav ] && oggenc -q 7 track??.wav && rm -f track??.wav
  rm -f $cue_out
done

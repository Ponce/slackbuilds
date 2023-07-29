#!/bin/sh

# 20230728 bkw: Extract PNG icons from a mac .icns file, for use
# with a SlackBuilds.org script.

# They get written to a directory called icons/, with filenames like
# 32.png, 64.png, etc (the pixel size). After extracting them, you
# should 'git add icons/*' if you're using git (otherwise, include
# icons/ in your submission tarball).

# The SlackBuild should include code to install them; see
# syncterm.SlackBuild for an example. Don't forget to include a
# doinst.sh.

# Licensed under the WTFPL. See http://www.wtfpl.net/txt/copying/ for details.
# Feel free to use this as part of your own SlackBuild.

# Note that this script shouldn't be included in the package!

die() {
  echo "$( basename $0 ): $@" 1>&2
  exit 1
}

if [ "$1" = "" -o "$2" != "" ]; then
  die "one argument required, path to *.icns file."
fi

if ! which icns2png &>/dev/null; then
  die "icns2png not found in \$PATH. Install libicns."
fi

if [ -e icons ]; then
  die "icons/ already exists, not overwriting."
fi

mkdir -p icons
cd icons || die "can't create or cd to icons/ dir."

icns2png -x -d 32 "$1" || die "can't extract any icons."
count=0
for png in *x32.png; do
  [ -e $png ] || break
  size="$( echo $png | cut -d_ -f2 | cut -dx -f1 )"
  mv $png $size.png
  : $(( count++ ))
done

if [ "$count" = "0" ]; then
  rm -rf ../icons
  die "failed to extract any icons."
fi

echo "extracted $count icons:"
ls

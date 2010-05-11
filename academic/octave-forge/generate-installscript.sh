#!/bin/sh

# Generate Octave script to install Octave-Forge packages respecting
# dependency constraints.
# The generated script must be run after setting:
# - main,extra,language,nonfree flags of enabled repositories to 1
# - pkg_prefix=$PKG

# Copyright 2008  Mauro Giachero
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PRGNAM=octave-forge
VERSION=bundle-20080507
TMP=${TMP:-/tmp/SBo}
CWD=$(pwd)
INSTALLSCRIPT=${INSTALLSCRIPT:-installscript.m}

set -e

mkdir -p $TMP
cd $TMP
rm -rf $PRGNAM-$VERSION
tar xf $CWD/$PRGNAM-$VERSION.tar.gz
cd $PRGNAM-$VERSION

EXIT_STATUS=0
REPOS=$(ls --indicator-style=none)

# Build packages list
pkgs_path=$(find . -name \*.gz)
pkgs_count=$(echo $pkgs_path |tr " " "\n" |wc -l)
pkgs_sort_path=
pkgs_sort_count=0

# Extract dependency information from packages
for pkg_path in $pkgs_path; do
  pkg_name=$(basename $pkg_path |cut -d "-" -f 1)
  tar xfO $pkg_path --wildcards \*/DESCRIPTION |grep "Depends:" |tr "," "\n" |grep -v "Depends:" |cut -d " " -f 2 >DEPS-$pkg_name
done

# Generate Octave installation script
# Heading
for repo in $REPOS; do
  # For each repository set the default value for the selection flag
  echo "try $repo; catch $repo=0; end" >>$INSTALLSCRIPT
done
for pkg_path in $pkgs_path; do
  # For each package, define an homonym flag to keep track of the
  # successfully installed (built) packages.
  echo $(basename $pkg_path |cut -d "-" -f 1)=0";" >>$INSTALLSCRIPT
done
# Create 3 files with the build results for the packages:
# - installed.tmp tracks successfully built packages;
# - broken.tmp tracks packages with build errors;
# - skipped.tmp tracks packages skipped due to missing prerequisites.
cat <<EOF >>$INSTALLSCRIPT
installed=fopen('installed.tmp','w');
skipped=fopen('skipped.tmp','w');
broken=fopen('broken.tmp','w');
EOF
# Set the packages files/folders properly.
cat <<EOF >>$INSTALLSCRIPT
oldcwd=pwd;
cd(pkg_prefix);
pkg prefix ./usr/share/octave/packages ./usr/libexec/octave/packages ;
pkg local_list ./ll
pkg global_list ./gl
cd(oldcwd);
EOF
# Resolve dependencies.
BROKEN=0 # Detect broken dependency tree
while [ $pkgs_sort_count -ne $pkgs_count ] ; do # Some packages still to sort
  BROKEN=1
  for pkg_path in $pkgs_path; do
    if echo $pkgs_sort_path | grep -qvw $pkg_path; then # Not already in the sorted list
      RESOLVED=1
      pkg_name=$(basename $pkg_path |cut -d "-" -f 1)
      # "ifclause" is the install condition, to avoid trying to
      # install packages when their prerequisites fail.
      ifclause=
      for dep in $(cat DEPS-$pkg_name); do
        ifclause="$dep==1 && $ifclause"
        if echo $pkgs_sort_path | grep -qvw $dep; then
          # Still missing some dependency
          RESOLVED=0
        fi
      done

      if [ $RESOLVED -eq 1 ]; then
        pkg_repository=$(echo $pkg_path |cut -d "/" -f 2)
        ifclause="$ifclause $pkg_repository==1"
        pkgs_sort_path="$pkgs_sort_path $pkg_path"
        pkgs_sort_count=$(($pkgs_sort_count+1))
        #Output install command
cat <<EOF >>$INSTALLSCRIPT
if $ifclause
  fprintf('%s','Building $pkg_name ($pkg_repository) [$pkgs_sort_count/$pkgs_count]... ')
  try
    pkg install $pkg_path
    $pkg_name=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of $pkg_name aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping $pkg_name ($pkg_repository) [$pkgs_sort_count/$pkgs_count].')
  fid=skipped;
end
fprintf(fid,'%s\n','$pkg_name');
EOF
        # New dependency resolved, so the repository (still) looks ok
        BROKEN=0
      fi
    fi
  done

  if [ $BROKEN -eq 1 ]; then
    #A whole loop completed without resolving any dependency
    echo "Error: broken dependency tree (some dependencies could not be resolved)" >&2
    EXIT_STATUS=1
    break
  fi
done

# Script tail
cat <<EOF >>$INSTALLSCRIPT
fclose(installed);
fclose(skipped);
fclose(broken);
EOF
mv $INSTALLSCRIPT $CWD

# Remove temporary files
rm -f DEPS-*

exit $EXIT_STATUS

#! /bin/bash

# Written by Andre Barboza <bmg.andre@gmail.com>

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

PRGNAM=monodevelop
VERSION=${VERSION:-6.0.2.73}

CWD=$(pwd)
TMP=${TMP:-/tmp/SBo/sources}
OUTPUT=${OUTPUT:-/tmp}

set -e

mkdir -p $TMP
cd $TMP
  
if [ ! -d "$PRGNAM" ]; then
  git clone https://github.com/mono/monodevelop.git
else
  pushd $PRGNAM
    git clean -dfx
    git reset --hard
    git submodule foreach --recursive git reset --hard
    git submodule foreach --recursive git clean -dfx
    git fetch
  popd #$PRGNAM
fi

cd $PRGNAM
git submodule update --init --recursive
git checkout tags/${PRGNAM}-${VERSION}
scripts/configure.sh gen-buildinfo main

./configure \
  --profile=stable \
  --enable-release \
  --prefix=/usr 

pushd main
  nuget restore

  for top_dir in external contrib src/addins src/core 
  do 
    pushd $top_dir
      find . -type d -maxdepth 1 | 
      while read dir 
      do 
        pushd $dir
          nuget restore || :
        popd #$dir
      done
    popd #$top_dir
  done
popd #main

cd $TMP
tar -cvjf $OUTPUT/$PRGNAM-$VERSION.tar.bz2 \
  --exclude $PRGNAM/.git \
  --exclude $PRGNAM/*.gitted \
  --ignore-case --exclude $PRGNAM/*/resources/*.git \
  --ignore-case --exclude $PRGNAM/*/resources/*dot_git \
  $PRGNAM

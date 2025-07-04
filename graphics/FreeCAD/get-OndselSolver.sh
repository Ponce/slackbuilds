#!/bin/sh

# Copyright 2020  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#  Adapted for OndselSolver 2025 Christoph Willing, Sydney Australia
PRGNAM=OndselSolver

# Clear download area:
rm -rf $PRGNAM

# Clone repository:
git clone https://github.com/FreeCAD/$PRGNAM.git
# This is the commit in the OndselSolver repo at time of FreeCAD release 1.0.1)
(cd $PRGNAM && git checkout 09d6175a2ba69e7016fcecc4f384946a2f84f92d)

HEADISAT="$( cd $PRGNAM && git log -1 --format=%h )"
DATE="$( cd $PRGNAM && git log -1 --format=%cd --date=format:%Y%m%d )"

# Cleanup.  We're not packing up the whole git repo.
( cd $PRGNAM && find . -type d -name ".git*" -exec rm -rf {} \; 2> /dev/null )
mv $PRGNAM $PRGNAM-${DATE}_${HEADISAT}
tar cf $PRGNAM-${DATE}_${HEADISAT}.tar $PRGNAM-${DATE}_${HEADISAT}
plzip -9 $PRGNAM-${DATE}_${HEADISAT}.tar
rm -rf $PRGNAM-${DATE}_${HEADISAT}
touch -d "$DATE" $PRGNAM-${DATE}_${HEADISAT}.tar.lz
echo
echo "$PRGNAM branch $BRANCH with HEAD at $HEADISAT packaged as $PRGNAM-${DATE}_${HEADISAT}.tar.lz"
echo

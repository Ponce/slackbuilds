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
#  Adapted for pyside2-tools 2025 Christoph Willing, Sydney Australia

# Clear download area:
rm -rf pyside2-tools

# Clone repository:
git clone https://github.com/pyside/pyside2-tools.git

HEADISAT="$( cd pyside2-tools && git log -1 --format=%h )"
DATE="$( cd pyside2-tools && git log -1 --format=%cd --date=format:%Y%m%d )"

# Cleanup.  We're not packing up the whole git repo.
( cd pyside2-tools && find . -type d -name ".git*" -exec rm -rf {} \; 2> /dev/null )
mv pyside2-tools pyside2-tools-${DATE}_${HEADISAT}
tar cf pyside2-tools-${DATE}_${HEADISAT}.tar pyside2-tools-${DATE}_${HEADISAT}
plzip -9 pyside2-tools-${DATE}_${HEADISAT}.tar
rm -rf pyside2-tools-${DATE}_${HEADISAT}
touch -d "$DATE" pyside2-tools-${DATE}_${HEADISAT}.tar.lz
echo
echo "pyside2-tools branch $BRANCH with HEAD at $HEADISAT packaged as pyside2-tools-${DATE}_${HEADISAT}.tar.lz"
echo

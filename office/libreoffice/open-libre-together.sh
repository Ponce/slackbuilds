#!/bin/sh

# open-libre-together.sh
#
# Script to patch .desktop files from OpenOffice.org so that it can
# coexist with LibreOffice

# v1.00 - 2011/01/03 - Niels Horn <niels.horn@gmail.com>

set -e

if [ $(id -u) -ne 0 ]; then
    echo "Sorry, need to be root to run this..."
    exit 1
fi

cd /usr/share/applications

for dt in base calc draw impress math writer; do
    echo "Changing .desktop file for '$dt' ..."
    sed -i "s|^Exec=s$cmd|Exec=/opt/openoffice.org3/program/s$cmd|" openoffice.org3-$dt.desktop
done

echo "All done..."


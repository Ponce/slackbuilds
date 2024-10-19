#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

set -e
clear
cd ..
PKGNAME=${PWD##*/}
source *.info

echo "--------------------------------------------------------------------------------"
cat *.info
echo

echo "--------------------------------------------------------------------------------"
echo
read -p "WGET DOWNLOAD_x86_64? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    for s in $DOWNLOAD_x86_64
    do
        echo "Downloading: $s"
        wget -nc $s
        TARBALL=`echo $s | rev | cut -d"/" -f1 | rev`
        md5sum $TARBALL
        echo
    done
fi
echo

echo "--------------------------------------------------------------------------------"
echo
read -p "WGET DOWNLOAD? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    for s in $DOWNLOAD
    do
        echo "Downloading: $s"
        wget -nc $s
        TARBALL=`echo $s | rev | cut -d"/" -f1 | rev`
        md5sum $TARBALL
        echo
    done
fi

echo
echo "Done."

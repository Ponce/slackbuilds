#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

set -e
clear
cd ..
PKGNAME=${PWD##*/}
echo "Building Package $PKGNAME:"
echo

echo "--------------------------------------------------------------------------------"
echo
read -p "Run sbolint? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sbolint .
fi

echo "--------------------------------------------------------------------------------"
echo
read -p "Run SlackBuild for Package $PKGNAME? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sudo sh ./$PKGNAME.SlackBuild
fi

echo "--------------------------------------------------------------------------------"
echo
VERSION=`cat *.info | grep VERSION | cut -d"\"" -f2`
echo "Tarballs available at /tmp:"
ls /tmp/$PKGNAME-$VERSION* -lasth
TARBALL=`ls /tmp/$PKGNAME-$VERSION* -1t | head -n1`


echo "--------------------------------------------------------------------------------"
echo
read -p "Run sbopkglint $TARBALL ? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sbopkglint $TARBALL
fi

echo "--------------------------------------------------------------------------------"
echo
read -p "Install $TARBALL ? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    sudo /sbin/upgradepkg --install-new --reinstall $TARBALL
fi


echo "--------------------------------------------------------------------------------"
echo
read -p "Create SlackBuild package by running tar.sh? (y/n) " op
if [ "$op" = "y" ] || [ "$op" = "Y" ]; then
    ./updater/tar.sh
fi

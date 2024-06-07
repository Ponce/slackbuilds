#!/bin/bash

cd ..
sboname=${PWD##*/}
echo $sboname
cd updater/slackbuild

tar -z -c -f $sboname.tar.gz -v \
    --exclude='updater'     \
    --exclude='*.tar.gz'    \
    --exclude='*.tar'       \
    --exclude='*.zip'       \
    --exclude='*.md'        \
    --exclude='*.sf3'       \
    --exclude='*.deb'       \
    --exclude='*.rpm'       \
    ../../../$sboname

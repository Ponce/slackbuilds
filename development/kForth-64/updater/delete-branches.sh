#!/bin/bash

set -e
clear

cd ~/slackware-builds/antonioleal/slackbuilds
git checkout master
echo
for b in `git branch | grep -v "master"`
do
    echo "deleting $b"
    git branch -D $b
    git push origin -d $b
    git fetch --prune
    echo
done


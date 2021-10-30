#!/bin/bash

# wrapper script for kenbuild, part of jfsw SlackBuild on SBo.

set -e
mkdir -p ~/.kenbuild
cd ~/.kenbuild
for i in /usr/share/games/kenbuild/*; do
  [ -e "$( basename $i )" ] || ln -s $i .
done

exec /usr/libexec/jfsw/kenbuild "$@"

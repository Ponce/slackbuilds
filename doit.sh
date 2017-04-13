#!/bin/sh
for FILE in `cat ~/FOOME.txt`; do \
  sed -i "s/Ryan P\.C\. McQuen/orphaned - no maintainer/" "$FILE"
  sed -i "s/ryanpcmcquen@member\.fsf\.org/nobody@nowhere/" "$FILE"
  git add -A :/
  git commit -sm "$(echo $FILE | cut -d'/' -f1-2): Orphan build."
done


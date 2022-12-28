#!/bin/sh

cd man
for i in *.rst; do
  rst2man.py $i > $( basename $i .rst ).1
done

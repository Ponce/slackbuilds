#!/bin/bash
# Helper for maintainer when updating textadept.info, and textadept.SlackBuild
# for third party sources files used when building.
VERSION=$(grep VERSION textadept.info | cut -d\" -f2)
url=$(grep DOWNLOAD textadept.info | cut -d\" -f2 | tr -d ' \\\"')
md5_=$(curl -Ls $url | md5sum | cut -d\  -f1)
echo -ne "DOWNLOAD=\"$url"
curl -s https://raw.githubusercontent.com/orbitalquark/textadept/textadept_${VERSION}/CMakeLists.txt > CMakeLists.txt
md5=()
files=()
for url in $(grep '^fetch(' CMakeLists.txt | cut -d\  -f2 | tr -d \) | sort -u); do
	file=$(rev <<<$url | cut -d/ -f1 | rev)
	md5=( "${md5[@]}" $(curl -Ls $url | md5sum | cut -d\  -f1))
	files=( "${files[@]}" $file)
	echo -ne " \\\\\\n          $url"
done
echo '"'
echo -ne "MD5SUM=\"$md5_"
for m in ${md5[@]}; do
	echo -ne " \\\\\\n        $m"
done
echo '"'
for f in ${files[@]}; do
	echo "ln -s \$CWD/*${f#v*} build/_deps/$f"
done

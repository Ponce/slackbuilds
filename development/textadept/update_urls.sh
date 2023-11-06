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
for pkg in $(grep "_url " CMakeLists.txt | cut -d\( -f2| cut -d_ -f1 | sort -u); do
	ext=tgz
	file=$(grep "(${pkg}_${ext} " CMakeLists.txt | head -1 | sed "s#.*${pkg}_${ext} \(.*\)[)]#\1#")
	[ -z "$file" ] && ext=zip && file=$(grep "(${pkg}_${ext} " CMakeLists.txt | head -1 | sed "s#.*${pkg}_${ext} \(.*\)[)]#\1#")
	url=$(grep "(${pkg}_url https" CMakeLists.txt | sed "s#.*${pkg}_url \(.*\)..${pkg}_${ext}..#\1${file}#")
	[ -z "$url" ] && url=$(grep -Pzo "(?s)\(${pkg}_url\s*https\N*" CMakeLists.txt | tr -d '\n' | sed "s#.*${pkg}_url.*\(https.*\)..${pkg}_${ext}.*#\1${file}#")
	#echo "$pkg.$ext[$file]: $url"
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

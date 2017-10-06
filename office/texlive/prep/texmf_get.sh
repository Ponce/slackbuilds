#!/bin/bash

# texmf_get.sh (c) 2016-2017 Johannes Schoepfer, Germany, slackbuilds[at]schoepfer[dot]info
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#  V 0.9
#
#  Prepare xz-compressed tarballs of texlive-texmf-trees based on texlive.tlpdb
#  This script takes care of dependencies(as far as these are present in texlive.tlpdb) of collections and packages,
#  and that every texlive-package is included only once.
#
#  Policy from texlive-netarchive: Every package is included as dependency in exactly one collection. A package may have dependecies on other packages from any collection.

# packages source: http://mirror.ctan.org/systems/texlive/tlnet/archive/

#set -e
MAJORVERSION=2017
# release mirror
mirror="http://mirror.ctan.org/systems/texlive/tlnet/"
# pre-test mirror 2016
# mirror="http://ftp.cstug.cz/pub/tex/local/tlpretest/"
LANG=C
TMP=$PWD/tmp
output=$TMP/texlive.packages
output_doc=$TMP/texlive.doc.packages
errorlog=$TMP/error.log
texmf=$TMP/texmf
db=texlive.tlpdb
tmpfile=$(mktemp)
collections_done=$TMP/done
collections_tobedone=$TMP/tobedone

packages () {
# fonts-package first to make sure that big fonts like cm-super are not included elsewhere as dependency
  PACKAGES="
    cm-super
    cbfonts
    sanskrit-t1
    uhc
    fonts-tlwg
    ethiop-t1
    ipaex
    wadalab
    fandol
    arphic
    mxedruli
    skaknew
    padauk
    japanese-otf
    musixtex-fonts
    unfonts-extra
    baekmuk
    arphic-ttf
    unfonts-core
    nanumtype1
    " texmfget fonts

# put some stuff in "extra" to before it makes its way into base
PACKAGES="
    arara
    latex2nemeth
    montex
    " \
  texmfget extra

# The base. some notes:
#  cs needed by fmtutil-sys --all, 2017-06-24
  PACKAGES="
    $(cat $TMP/corepackages)
    collection-basic
    collection-latex
    collection-latexrecommended
    collection-xetex
    collection-metapost
    collection-fontutils
    collection-luatex
    collection-fontsrecommended
    collection-humanities
    collection-context
    collection-mathscience
    collection-plaingeneric
    collection-binextra
    yfonts
    doublestroke
    was
    xypic
    xindy
    barcodes
    qrcode
    lastpage
    datetime2
    texdoc
    appendix
    changebar
    footmisc
    multirow
    overpic
    stmaryrd
    subfigure
    titlesec
    siunitx
    combelow
    csquotes
    etoolbox
    etextools
    glossaries
    imakeidx
    idxlayout
    bidi
    filecontents
    eplain
    texsis
    mltex
    lollipop
    moreverb
    collection-langcyrillic
    collection-langeuropean
    collection-langenglish
    collection-langfrench
    collection-langgerman
    collection-langgreek
    collection-langitalian
    collection-langpolish
    collection-langportuguese
    collection-langspanish
    " texmfget base

# Call "fonts"-tarball again to add remaining fonts
PACKAGES="
    collection-fontsextra
    " texmfget fonts

# Put all remaining stuff in the "extra" tarball
  PACKAGES="
    biber.x86_64-linux
    biber.i386-linux
    collection-formatsextra
    collection-latexextra
    collection-pictures
    collection-games
    collection-publishers
    collection-bibtexextra
    collection-music
    collection-pstricks
    collection-texworks
    collection-wintools
    collection-langczechslovak
    collection-langjapanese
    collection-langkorean
    collection-langarabic
    collection-langchinese
    collection-langcjk
    collection-langother
    " texmfget extra

# The docs-tarball - very big (about 1300 MB)
  texmfget docs

  if [ "$TARBALL" != docs ]
  then
	echo "Packages-list: $output.meta.$TARBALL"
	while read collection
	do
		grep -w "$collection" $collections_done &> /dev/null
		[ $? != 0 ] && echo "WARNING: $collection was not processed, please edit packages-function."
	done < $TMP/allcollections
  fi

}

# ==== Nothing to edit beyond this line (hopefully) ====

usage () {
	echo "Prepare texmf trees based on collections and packages and their dependencies."
	echo "./texmf_get.sh [base|docs|extra|fonts]"
	exit
}

package_meta () {
	echo "collection/package $collection"
	# collection start linenumer
	start_n="$(grep -n ^"name ${collection}$" $TMP/$db | cut -d':' -f1)"
	[ -z "$start_n" ] && echo "$collection was not found in $TMP/$db, bye." && exit 1

	# find end of package/collection
	for emptyline in $emptylines
	do
		if [ "$emptyline" -gt "$start_n" ]
		then
			end_n=$emptyline
			break
		fi
	done

	sed "${start_n},${end_n}!d" $TMP/$db > $tmpfile
}

package_list () {

# Remove outputfile if already present
[ -s "$output" ] && rm $output

# Only do something if $collection wasn't already done before
while [ -s $collections_tobedone ]
do
	collection=$(tail -n1 $collections_tobedone)
	# continue with next collection if collection was already done
	if [ -s "$collections_done" ]
	then
		grep -w "^${collection}$" $collections_done &> /dev/null
		if [ $? = 0 ]
		then
			sed -i "/^$collection$/d" $collections_tobedone
			continue
		fi
	fi

	if [ -s "$texmf/$collection.meta" ]
	then
		cp $texmf/$collection.meta $tmpfile
	else
		package_meta
	fi

	# Don't handle collections as dependency of other collections, as this adds far too much and therefore reduces controll over what packages to be added
	sed -i "/^depend collection/d" $tmpfile
	# If $collection is a singel package, add it here
	if [ -n "$(head -n1 $tmpfile | fgrep -v "name collection" )" ]
	then
		packagelist="$TMP/run.tlpkg"
		if [ -z "$(grep -w "^${collection}$" $packagelist)" ]
		then
			sed -i "/^$collection$/d" $collections_tobedone
			echo "$collection" >> $collections_done
			continue
		fi
		echo "$collection" >> $output
	fi
	# add dependend packages
	grep ^"depend " $tmpfile | grep -v "ARCH$" | cut -d' ' -f2- >> $collections_tobedone
	echo "$collection" >> $collections_done
	sed -i "/^${collection}$/d" $collections_tobedone
done

}

untar () {
	# Download packages, if not already available. Not every packages has a corresponding .doc package.
	[ -f $output.meta ] && rm $output.meta
	while read package
	do
		# untar all packages, check for relocation, "relocate 1" -> untar in texmf-dist
		if [ "$flavour" = ".doc" ]
		then
			sha512="$(grep ^doccontainerchecksum $texmf/$package.meta | cut -d' ' -f2 )"
		else
			sha512="$(grep ^containerchecksum $texmf/$package.meta | cut -d' ' -f2 )"
		fi
		# try two times if package isn't present, with -t1 to get another mirror the second time
		[ ! -s ${package}${flavour}.tar.xz ] && wget -t1 -c ${mirror}archive/${package}${flavour}.tar.xz
		[ ! -s ${package}${flavour}.tar.xz ] && wget -t1 -c ${mirror}archive/${package}${flavour}.tar.xz
		[ ! -s ${package}${flavour}.tar.xz ] && echo "Downloading ${package}${flavour}.tar.xz did not work, writing to $errorlog" && echo "Error downloading ${package}${flavour}.tar.xz" >> $errorlog && exit 1
		# check sha512, give three tries for downloading aggain(diffrent mirrors are used automatically)
		for tillthree in 1 2 3
		do
			if [ "$(sha512sum ${package}${flavour}.tar.xz | cut -d' ' -f1 )" != "$sha512" ]
			then
				# Download (hopefully) newer file
				rm ${package}${flavour}.tar.xz
				wget -t1 -c ${mirror}archive/${package}${flavour}.tar.xz
			else
				break
			fi
		done
		# check sha512 again, exit if it fails
		if [ "$(sha512sum ${package}${flavour}.tar.xz | cut -d' ' -f1 )" != "$sha512" ]
		then
			echo "sha512sum $(sha512sum ${package}${flavour}.tar.xz | cut -d' ' -f1 ) of"
			echo "${package}${flavour}.tar.xz doesn't match with $TMP/$db"
			echo "sha512sum $sha512"
			echo "Delete $TMP/${db}* and try again."
			exit 1
		fi

		# Exclude the tlpkg-stuff, TLUtils.pm(needed tu run texlive) is provided by texlive-source
		grep -w ^"relocated 1" $texmf/$package.meta &>/dev/null
		if [ $? = 0 ]
		then
			tar vxf ${package}${flavour}.tar.xz --exclude tlpkg -C texmf-dist || exit 1
		else
			tar vxf ${package}${flavour}.tar.xz --exclude tlpkg  || exit 1
		fi
		# In case a binary package was decompressed, put it in texmf-dist
		[ -d bin ] && cp -a bin texmf-dist && rm -rf bin
		if [ "$flavour" = ".doc" ]
		then
			size=$(( $(grep ^doccontainersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
		else
			size=$(( $(grep ^containersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
		fi
		shortdesc="$(grep ^shortdesc $texmf/$package.meta | cut -d' ' -f2- )"
		echo "$size Kb, $package: $shortdesc" >> $output.meta
	done < $1
	# Copy packages-list to texmf-dist, so included packages are known in later installation
	sort -n $output.meta > $output.meta.$TARBALL
	cp $output.meta.$TARBALL texmf-dist/
	rm $output.meta

}

remove_cruft () {
	# Remove m$-stuff, ConTeXt single-user-system stuff, source leftovers and pdf-versions of manpages
	rm -rf texmf-dist/source
	rm -rf texmf-dist/scripts/context/stubs/source/
	find texmf-dist/ -type d -name 'win32'		-exec rm -rf {} +
	find texmf-dist/ -type d -name 'win64'		-exec rm -rf {} +
	find texmf-dist/ -type d -name 'mswin'		-exec rm -rf {} +
	find texmf-dist/ -type d -name 'win'		-exec rm -rf {} +
	find texmf-dist/ -type d -name 'setup'		-exec rm -rf {} +
	find texmf-dist/ -type d -name 'install'	-exec rm -rf {} +
	find texmf-dist/ -type f -name '*.bat'		-delete
	find texmf-dist/ -type f -name '*win32*'	-delete
	find texmf-dist/ -type f -name 'winansi*'	-delete
	find texmf-dist/ -type f -name '*-man.pdf'	-delete
	# Remove zero-length files, as these appear e.g. in hyph-utf8 tex-package.
	find . -type f -size 0c -delete
}

texmfget () {

# Check all content to make sure no package is added more than once. Docs contain every docfile
if [ $TARBALL != docs ]
then
	echo "Preparing list of packages to be added to ${1}-tarball ..."
	echo "$PACKAGES" | sed "s/[[:space:]]//g;/^$/d" >> $collections_tobedone
	package_list
fi

# Process only the one named($1) tarball
if [ "$1" = $TARBALL ]
then

cd $texmf

# Cleanup tar-directory, just in case
[ -d texmf-dist ] && rm -rf texmf-dist
mkdir texmf-dist &> /dev/null

# Make tarball/checksum reproducible by setting mtime(clamp-mtime), owner, group and sort content
# Doesn't work with tar 1.13, when makepkg creates the tarball:
# tar-1.13: time_t value 9223372036854775808 too large (max=68719476735)
VERSION=$(cat $TMP/VERSION)
case $TARBALL in
	docs)
		export flavour=".doc"
		untar $output_doc
		remove_cruft
		#tar vrf $TMP/texlive-$TARBALL-$VERSION.tar --clamp-mtime --mtime --owner=0 --group=0 --sort=name texmf-dist || exit 1
		tar vrf $TMP/texlive-$TARBALL-$VERSION.tar --owner=0 --group=0 --sort=name texmf-dist || exit 1
		echo "Packages-list: $output_doc"
		rm -rf texmf-dist
	;;
	base|extra|fonts)
		untar $output
		remove_cruft
		#tar vrf $TMP/texlive-$TARBALL-$VERSION.tar --clamp-mtime --mtime --owner=0 --group=0 --sort=name texmf-dist || exit 1
		tar vrf $TMP/texlive-$TARBALL-$VERSION.tar --owner=0 --group=0 --sort=name texmf-dist || exit 1
		rm -rf texmf-dist
	;;
esac

fi

}

# Main

case "$1" in
	base|docs|extra|fonts) TARBALL=$1; echo "Building $TARBALL tarball ..." ;;
	*) usage ;;
esac

mkdir -p $texmf
cd $TMP

# Create run.tlpkg and doc.tlpkg only if $db.orig isn't there yet/was deleted
if [ ! -s $TMP/${db}.orig -o ! -s $TMP/${db} ]
then
	echo $MAJORVERSION.$(date +%y%m%d) > VERSION
	wget -c -O $TMP/${db}.orig -c ${mirror}tlpkg/$db 
	# shrink db to be faster on later processing
	sed "/^ \+./d;/^longdesc \+./d;/^rev\+./d;/^exe\+./d;/^bin\+./d;/^src\+./d" $TMP/${db}.orig > $TMP/$db

	# As $db (might be)is new, remove the meta-files, might created again with (pontentionally) new content
	rm -rf $texmf/*.meta
	rm $TMP/run.tlpkg
	[ -f "$output_doc" ] && rm "$output_doc"

	# Make a list of all packages available, but exclude binary and installer/configuration packages.
	# It turns out that packagenames without '.' are what we want. Packages with '.' are all binarie-packages, which are build from source.
	grep ^name $TMP/$db | grep -v ^"name collection-" | grep -v ^"name scheme-" | grep -v '\.' | cut -d' ' -f2 > $TMP/allpackages

	# Make a list of all collections
	grep ^"name collection-" $TMP/$db | cut -d' ' -f2 > $TMP/allcollections
	
	# Provide TLCore packages for the base-tarball, as these packages(and their dependencies) should be present in any case. 
	grep -B1 ^'category TLCore' $TMP/$db | grep -v ^'category TLCore' |  grep -v ^-- | grep -v '\.' | cut -d' ' -f2 > $TMP/corepackages

	# add biber (perl)binaries as special exception as it is not fun to build
	cat <<- EOF >> $TMP/allpackages
	biber.x86_64-linux
	biber.i386-linux
	EOF

fi

# globaly excluded packages, which does not make sense without tlpkg-installer, or are non-linux specific, or are already covered by the sourcebuild,
# or are covered by an external package(asymptote), or obsolete packages(datetime replaced by datetime2, anysize replaced by geometry)

cat << EOF > $TMP/global_exclude
tlcockpit
tlshell
texosquery
asymptote
asymptote-by-example-zh-cn
asymptote-faq-zh-cn
asymptote-manual-zh-cn
EOF

while read exlude
do
	sed -i "/^${i}$/d" $TMP/allpackages
	[ -s $TMP/run.tlpkg ] && sed -i "/^${exclude}$/d" $TMP/run.tlpkg
	[ -s $output_doc ] && sed -i "/^${exclude}$/d" $output_doc
done < $TMP/global_exclude

# Get linenumbers of empty lines
[ -z "$emptylines" ] && emptylines="$(grep -n ^$ $TMP/$db | cut -d':' -f1)"
# Sort doc- and run- packages out to avoid binfiles and sourcfile in the texmf-tree
while read collection
do
	if [ ! -s $texmf/$collection.meta ]
	then
		package_meta
		grep ^runfiles $tmpfile &>/dev/null
	       	if [ $? = 0 ]
		then
			echo $collection >> $TMP/run.tlpkg
		fi
		grep ^docfiles $tmpfile &>/dev/null && echo $collection >> $output_doc
		mv $tmpfile $texmf/$collection.meta
	fi
done < $TMP/allpackages

# Handle biber binaries to be add-able
cat << EOF >> $TMP/run.tlpkg
biber.x86_64-linux
biber.i386-linux
EOF

[ -f "$collections_done" ] && rm "$collections_done"
[ -f "$collections_tobedone" ] && rm "$collections_tobedone"

packages

# Now the demanded packages are in the tarball, compress it.
echo "Compressing $TMP/texlive-$TARBALL-$VERSION.tar ..."
if [ -s $TMP/texlive-$TARBALL-$VERSION.tar ]
then
	[ -f $TMP/texlive-$TARBALL-$VERSION.tar.xz ] && rm $TMP/texlive-$TARBALL-$VERSION.tar.xz
	xz -9 -T0 $TMP/texlive-$TARBALL-$VERSION.tar || exit 1
	md5sum $TMP/texlive-$TARBALL-$VERSION.tar.xz
	ls -lah $TMP/texlive-$TARBALL-$VERSION.tar.xz
fi

# cleanup
rm $tmpfile

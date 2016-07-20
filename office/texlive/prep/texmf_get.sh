#!/bin/bash

# texmf_get.sh (c) 2016 Johannes Schoepfer, slackbuilds@schoepfer.info
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
#  V 0.3
#
# get texlive-packages/texmf-tree based on texlive.tlpdb, create a tar.xz tarball out of it.
#
# usage:
# ./texmf_get.sh [extra|docs] 

# available packages http://mirror.ctan.org/systems/texlive/tlnet/archive/

#set -e
# release mirror
mirror="http://mirror.ctan.org/systems/texlive/tlnet/"
# pre-test mirror 2016
# mirror="http://ftp.cstug.cz/pub/tex/local/tlpretest/"
LANG=C 
TMP=$PWD/tmp
output=$TMP/texlive.packages
output_remainder=$TMP/texlive.remainder.packages
output_doc=$TMP/texlive.doc.packages
errorlog=$TMP/error.log
texmf=$TMP/texmf
db=texlive.tlpdb
mkdir -p $texmf

#mkjobtexmf
#texinfo
#echo $PACKAGES
#read
maxsize[100000]="$PACKAGES"
[ -z "$PACKAGES" ] && \
maxsize[100000]="
collection-metapost
collection-xetex
ec
eurosym
lualibs
luaotfload
luatexbase
revtex
synctex
times
tipa
ulem
upquote
zapfding




collection-basic
collection-latex
collection-genericrecommended
collection-latexrecommended
collection-langeuropean
lm
beamer
hyphen-ancientgreek
hyphen-greek
hyphen-indic
hyphen-sanskrit
hyphen-czech
hyphen-slovak
hyphen-armenian
hyphen-bulgarian
hyphen-churchslavonic
hyphen-mongolian
hyphen-russian
hyphen-serbian
hyphen-ukrainian
hyphen-catalan
hyphen-galician
hyphen-spanish
hyphen-chinese
hyphen-afrikaans
hyphen-coptic
hyphen-esperanto
hyphen-georgian
hyphen-indonesian
hyphen-interlingua
hyphen-thai
hyphen-turkmen
hyphen-ethiopic
hyphen-arabic
hyphen-farsi

babel-basque
hyphen-basque
babel-czech
hyphen-czech
babel-danish
hyphen-danish
babel-dutch
hyphen-dutch
babel-english
hyphen-english
babel-finnish
hyphen-finnish
babel-french
hyphen-french
babel-german
hyphen-german
dehyph-exptl
babel-hungarian
hyphen-hungarian
babel-italian
hyphen-italian
babel-norsk
hyphen-norwegian
babel-polish
hyphen-polish
babel-portuges
hyphen-portuguese
babel-spanish
hyphen-spanish
babel-swedish
hyphen-swedish
"
#maxsize[530]="collection-fontsrecommended" # max package helvetic 530kb
#maxsize[110]="collection-fontsextra" # max packafe cmbright(scheme-tetex) 109kb
#maxsize[99]="collection-plainextra" # max package texinfo 98kb
#maxsize[5]="collection-latexextra" 
#collection-langenglish
#collection-langeuropean
#collection-langfrench
#collection-langgerman
#collection-langitalian
#collection-langpolish
#collection-langspanish

#collection-genericextra
#collection-formatsextra
#maxsize[1700]="collection-langgreek" # max package kerkis(1700kb), cbfonts are very(too) big(65mb), todo: split-packge pfb-fonts, provding also "./texmf-get.sh" extra"
#maxsize[500]="collection-langcyrillic" # prevent montex(1600kb) as it depends on cbfonts(65mb), see package split
#maxsize[100]="collection-binextra" # max package asymptote 277kb, xindy 183kb
#maxsize[180]="collection-bibtexextra" # max package jurabib, biblatex 180kb

#maxsize[kb]="collection-name package ..."
# These are arrays, every index(kb) can only appear once, otherwise it will be overwritten.
# Add packages of collections only if under max $kb per package size, to ease maintenance by reducing singel-picking packages.
# There are many small packages which give better overall support at low price in size, it's kind of random whats added though. Maybe maintain a reference list what has to be in the texmf-tree?
# Into maxsize[100000] (100mb, there is no bigger package) come collections to be completely added, or single packages(not schemes, as depend collections are not added automatically)


# ==== Nothing to edit beyond this line (hopefully) ====

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

	if [ -s $texmf/$collection.meta ]
	then
		cp $texmf/$collection.meta $tmpfile
	else
		package_meta 
	fi

	# ignore dependend collections generally, as this adds far too much and therefore reduces controll over what packages to be added
	sed -i "/^depend collection/d" $tmpfile 
	# If $collection is a singel package, add it here
	if [ -n "$(head -n1 $tmpfile | fgrep -v "name collection" )" ]
	then
		# Add only run packages (collection = package)
		#if [ -z "$(grep -w "^${collection}$" $TMP/run.tlpkg)" ]
		#if [ "$1" = docs ]
		#then
		#	packagelist="$output_doc"
		#else
			packagelist="$TMP/run.tlpkg"
		#fi
		if [ -z "$(grep -w "^${collection}$" $packagelist)" ]
		then
			sed -i "/^$collection$/d" $collections_tobedone
			echo "$collection" >> $collections_done
			continue
		fi
		# filter for max containersize to be added.
		[ $(grep ^containersize $tmpfile | cut -d' ' -f2 ) -lt $(($kb * 1024)) ] && echo "$collection" >> $output
	fi
	# add dependend packages
	grep ^"depend " $tmpfile | grep -v "ARCH$" | cut -d' ' -f2- >> $collections_tobedone
	echo "$collection" >> $collections_done
	sed -i "/^${collection}$/d" $collections_tobedone
done

}


untar () {
	# download packages, if not already available. Not for all packages a corresponding .doc package exists
	rm $1.meta
	while read package
	do
		# untar all packages, check for relocation, "relocate 1" -> untar in texmf-dist
		if [ "$flavour" = ".doc" ]
		then
			sha512="$(grep ^doccontainerchecksum $texmf/$package.meta | cut -d' ' -f2 )"
		else
			sha512="$(grep ^containerchecksum $texmf/$package.meta | cut -d' ' -f2 )"
		fi
		[ ! -s ${package}${flavour}.tar.xz ] && wget ${mirror}archive/${package}${flavour}.tar.xz
		[ ! -s ${package}${flavour}.tar.xz ] && echo "Downloading ${package}${flavour}.tar.xz did not work, writting to $errorlog" && echo "Error downloading ${package}${flavour}.tar.xz" >> $errorlog && exit 1
		# check sha512, give three tries for downloading aggain(diffrent mirrors are used automatically)
		for tillthree in 1 2 3
		do
			if [ "$(sha512sum ${package}${flavour}.tar.xz | cut -d' ' -f1 )" != "$sha512" ]
			then
				# Download (hopefully) newer file
				rm ${package}${flavour}.tar.xz 
				wget ${mirror}archive/${package}${flavour}.tar.xz
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

		# exclude the tlpkg-stuff, TLUtils.pm(needed tu run texlive) comes from source installation
		grep -w ^"relocated 1" $texmf/$package.meta &>/dev/null
		if [ $? = 0 ] 
		then
			tar vxf ${package}${flavour}.tar.xz --exclude tlpkg -C texmf-dist || exit 1
		else
			tar vxf ${package}${flavour}.tar.xz --exclude tlpkg  || exit 1
		fi
		if [ "$flavour" = ".doc" ]
		then
			size=$(( $(grep ^doccontainersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
		else
			size=$(( $(grep ^containersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
		fi
		shortdesc="$(grep ^shortdesc $texmf/$package.meta | cut -d' ' -f2- )"
		#echo "$package: $shortdesc, Kb $size" >> $1.meta
		echo "$size Kb, $package: $shortdesc" >> $1.meta
	done < $1
	# copy packages-list to texmf-dist, so included packages are known in later installation
	sort -n $1.meta > TMPFILE
	mv TMPFILE $1.meta
	cp $1.meta texmf-dist/ 

	# remove uneeded sources
	rm -rf texmf-dist/scripts/context/stubs/source/
	rm -rf texmf-dist/source
	# Remove m$-stuff
	find . -type d -name 'win32' -exec rm -rf {} +
	find . -type d -name 'win64' -exec rm -rf {} +
	find . -type d -name 'mswin' -exec rm -rf {} + 
	find . -type d -name 'win'   -exec rm -rf {} + 
	find . -type f -name '*.bat' -delete 
	find . -type f -name '*win32*' -delete
	find . -type f -name 'winansi*' -delete
	# remove zero-length files, as these appear e.g. in hyph-utf8 tex-package. 
	find . -type f -size 0c -delete
}

tmpfile=$(mktemp)

cd $TMP

# create run.tlpkg and doc.tlpkg only if $db.orig isn't there yet/was deletet
if [ ! -s $TMP/${db}.orig ]
then
	# Set date manually upload date from $mirror/tlpkg/texlive.tlpdb. Looking a better way for auto-detect date/get reviosn in some way
	#echo 20160405 > VERSION
	date +%Y%m%d > VERSION
	# get VERSION from texlive.tlpdb upload date. Not the best approach ...
#	date -d $(curl -L -s ${mirror}/tlpkg/ | grep -w texlive.tlpdb | head -n1 | rev | cut -d':' -f2 | cut -d' ' -f2 | cut -d'>' -f1 | rev ) | date -f - +%Y%m%d > VERSION

	
	wget -O $TMP/${db}.orig -c ${mirror}tlpkg/$db 
	# shrink db to be faster on later processing
	#sed "/^ \+./d;/^longdesc \+./d" $TMP/${db}.orig > $TMP/$db
	#sed "/^ \+./d;/^longdesc \+./d;/^doc\+./d;/^cat\+./d;/^rev\+./d;/^short\+./d;/^rel\+./d" $TMP/${db}.orig > $TMP/$db
	sed "/^ \+./d;/^longdesc \+./d;/^cat\+./d;/^rev\+./d;/^exe\+./d;/^bin\+./d;/^src\+./d" $TMP/${db}.orig > $TMP/$db


	# as $db(might be) is new, remove the meta-files, be created again with pontentionally new content
	rm -rf $texmf/*.meta
	rm $TMP/run.tlpkg
	[ -f $output_doc ] && rm $output_doc
fi
	
# Make a list of all packages available, but exclude binary and installer/configuration packages.
# It turns out that packagenames without '.' are what we want. Packages with '.' are all binarie-packages, which we biuld from source.
grep ^name $TMP/$db | grep -v ^"name collection-" | grep -v ^"name scheme-" | grep -v '\.' | cut -d' ' -f2 > $TMP/allpackages
	
	# further globaly excluded packages, which does not make sense without tlpkg-installer, or are non-linux specific, or are already covered by the sourcebuild.

global_exclude="
texworks
"
zglobal_exclude="
bibtex8  
bibtexu  
chktex   
cjkutils 
detex    
dtl      
dvi2tty  
dvidvi   
dviljk   
dvipdfmx 
dvipng 
dvipos
dvisvgm
gsftopk
pdftools
synctex  
texconfig
texlive-docindex
texlive-msg-translations
texlive-scripts
texworks

l3kernel
l3packages
l3experimental
fontspec
ocgx
luatex
"

for i in $global_exclude
do
	if [ -z "$(grep -w ^"$i"$ $TMP/allpackages)" ] 
	then
		echo "\"$i\" seems not to be a tex-package listet in $db, correct the"
		echo "global_exclude variable in this script, bye."
		exit 1
	else
		sed -i "/^${i}$/d" $TMP/allpackages
		[ -s $TMP/run.tlpkg ] && sed -i "/^${i}$/d" $TMP/run.tlpkg
		[ -s $output_doc ] && sed -i "/^${i}$/d" $output_doc
	fi
done
	
# get linenumbers of empty lines
[ -z "$emptylines" ] && emptylines="$(grep -n ^$ $TMP/$db | cut -d':' -f1)"
# sort doc- and run- packages out to avaoid binfiles and sourcfile in the texmf-tree
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
		
VERSION=$(cat VERSION)

# remove outputfile if already present
[ -s "$output" ] && rm $output

collections_done=$TMP/done
collections_tobedone=$TMP/tobedone

echo "Preparing list of packages to be added ..."
# Start with the biggest maxsize. This way adding full collections can be handeld, rather than the packages are not added(added to $collection_done without processing) by the $kb limit.
# todo: extra tobedone-queue for dependend packages, to be sure to get these and not discard by $kb limit.

for kb in $(printf '%s\n' "${!maxsize[@]}"|tac)
do
	for maxsizecollection in ${maxsize[$kb]}
	do
		echo "$maxsizecollection" >> $collections_tobedone
		package_list #$1 # use diffrent package list if $1=docs
	done
done

#[ -f $collections_done ] && rm $collections_done
#[ -f $collections_tobedone ] && rm $collections_tobedone

#echo "Generate the remainder package-list ..."
#cp $TMP/run.tlpkg $output_remainder
## remove packages from remainder packages list
#while read remove
#do
#	sed -i "/^${remove}$/d" $output_remainder
#done < $output

cd $texmf

# split packge
#echo "Finding fonts which are present as metafont-source(.mf), move corresponding pfb to remainder-package. Be patient ..."
##find . -type f -name '*.mf' | tee -a fontfiles
#find texmf-dist -type f -name '*.mf' > fontfiles
##sed -i -n "/amsfonts/!p" fontfiles
#rev fontfiles | cut -d'.' -f2 | cut -d'/' -f1 | rev > fontnames
#find texmf-dist -type f -name "*.pfb" > fonts.type1
#find texmf-dist -type f -name "*.pfm" >> fonts.type1
#find texmf-dist -type f -name "*.afm" >> fonts.type1
#[ -f fonts.pfb ] && rm fonts.pfb
#while read a
#do
#	grep -w "$a.pfb" fonts.type1 >> fonts.pfb
#	grep -w "$a.pfm" fonts.type1 >> fonts.pfb
#	grep -w "$a.afm" fonts.type1 >> fonts.pfb
#       #find . -type f -name "$a.pfb" >> fonts.pfb
#       #find . -type f -name "$a.pfm" >> fonts.pfb
#       #find . -type f -name "$a.afm" >> fonts.pfb
#done < fontnames
#sort -u < fonts.pfb > $tmpfile
#mv $tmpfile fonts.pfb
##sed -i "/.*amsfonts.*/d" fonts.pfb
## Only move cbfonts for now ...
#sed -i -n "/cbfonts/p" fonts.pfb
#rev fonts.pfb | cut -d'/' -f2- | rev > fontpathes
##sort -u < fontpathes > $tmpfile
##mv $tmpfile fontpathes
#while read a; do mkdir -p remainder/$a; done < fontpathes
#while read a; do mv $a remainder/$a; done < fonts.pfb
#rm fontfiles fontnames fontpathes fonts.type1 fonts.pfb
#if [ -d remainder ]
#then
#	cd remainder
#	tar Jvcf $TMP/add-to-remainder.tar.xz texmf-dist || exit 1
#	cd -
#	rm -rf remainder
#fi

# cleanup tar-directorie, in case
[ -d texmf-dist ] && rm -rf texmf-dist
#unset flavour ; export flavour 
mkdir texmf-dist &> /dev/null


case $1 in
	docs)
		export flavour=".doc" 
		untar $output_doc
		#untar $output
		tar Jvcf $TMP/texlive-texmf-docs-$VERSION.tar.xz texmf-dist || exit 1
		ls -lah $TMP/texlive-texmf-docs-$VERSION.tar.xz || exit 1
		rm -rf texmf-dist
		echo "Packages-list: $output_doc"

	;;
	*)
		#XZ_OPT=-4e tar Jvcf $TMP/texlive-${scheme}${flavour}.tar.xz texmf-dist
		untar $output
		#tar  vcf $TMP/texlive-$NAME-$VERSION.tar texmf-dist || exit 1
		tar vrf $TMP/texlive-$NAME-$VERSION.tar texmf-dist || exit 1
		mv $output.meta $output.meta.$NAME
		echo "Packages-list: $output.meta.$NAME"
		rm $output 
		rm -rf texmf-dist
		#[ -f $TMP/texlive-$NAME-$VERSION.tar.xz ] && rm $TMP/texlive-$NAME-$VERSION.tar.xz
		#xz -9 $TMP/texlive-$NAME-$VERSION.tar || exit 1
		#ls -lah $TMP/texlive-$NAME-$VERSION.tar.xz
	;;
esac

# cleanup
rm $tmpfile

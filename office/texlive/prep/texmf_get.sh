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
#  V 0.14.2
#
#  Prepare xz-compressed tarballs of texlive-texmf-trees based on texlive.tlpdb
#  This script takes care of dependencies(as far as these are present in texlive.tlpdb) of collections and packages,
#  and that every texlive-package is included only once.
#  The editions(base/extra/fonts/docs) should contain nobinaries(exception biber)
# -base: the most usefull stuff, all metafonts, all manpages, the most
#  binaries/scripts,  65mb 2017-11-07
# -docs: -base documentation only, no manpages/GNU infofiles
# -fonts: fonts only, no metafonts 
# -extra: remaining stuff
#
#  texlive netarchive policy: Every package is included as dependency 
#  in exactly one collection. A package may have dependencies on other
#  packages from any collection.

# package source: http://mirror.ctan.org/systems/texlive/tlnet/archive/

#set -e
MAJORVERSION=2017

# globally excluded packages, which e.g. are
# -useless without tlmgr-installer
# -non-linux
# -covered by an external package
# -obsolete 

global_exclude="
  asymptote
  tlcockpit
  tlshell
  texosquery
  aleph
  omega
  antomega
  omegaware
  lambda
  otibet
  cslatex
  "

texmf_editions () {
  # At first, $corepackages for the base, and other essentials
  PACKAGES="
    $(cat $corepackages)
    collection-basic
    collection-latex
    collection-metapost
    collection-plaingeneric
    collection-fontutils
    collection-luatex
    collection-context
    cbfonts-fd
    xetex-devanagari
    " texmfget base || exit 1

  # Now the fonts package to make sure that big fonts like cm-super are not included elsewhere as dependency
  PACKAGES="
    cm-super
    cbfonts
    ipaex
    wadalab
    ethiop-t1
    fonts-tlwg
    uhc
    fandol
    arphic
    arphic-ttf
    nanumtype1
    baekmuk
    unfonts-extra
    unfonts-core
    " texmfget fonts || exit 1

  # put some stuff in "extra" to before these make their way into "base" as dependency
  PACKAGES="
    $(grep ^"name biblatex" $db | grep -v '\.' | cut -d' ' -f2 )
    biber.x86_64-linux
    biber.i386-linux
    bib2gls
    bibarts
    arara
    latex2nemeth
    ghsystem
    adobemapping
    knitting
    pgfornament
    pgfplots
    arabi
    nwejm
    uantwerpendocs
    sduthesis
    stellenbosch
    fithesis
    gregoriotex
    lilyglyphs
    musixtex-fonts
    beebe
    velthuis
    mwe
    pdfx
    media9
    pst-cox
    pst-poker
    pst-vectorian
    pst-geo
    quran
    ijsra
    fibeamer
    udesoftec
    xduthesis
    hustthesis
    bangorcsthesis
    sapthesis
    uowthesis
    cs
    pl
    cc-pl
    tipa
    kerkis
    amiri
    cns
    vntex
    montex
    xcharter
    fonts-churchslavonic
    japanese-otf
    sanskrit-t1
    skaknew
    padauk
    " texmfget extra || exit 1

  # Completing the base
  PACKAGES="
    collection-langcyrillic
    collection-langczechslovak
    collection-langeuropean
    collection-langenglish
    collection-langfrench
    collection-langgerman
    collection-langgreek
    collection-langitalian
    collection-langpolish
    collection-langportuguese
    collection-langspanish
    collection-langjapanese
    collection-langkorean
    collection-langarabic
    collection-langchinese
    collection-langcjk
    collection-langother
    collection-xetex
    collection-humanities
    collection-mathscience
    collection-pictures
    collection-publishers
    collection-music
    collection-games
    collection-fontsrecommended
    collection-latexrecommended
    collection-binextra
    collection-bibtexextra
    collection-formatsextra
    collection-latexextra
    acro
    acronym
    acroterm
    enumitem
    enumitem-zref
    yfonts
    doublestroke
    was
    xypic
    barcodes
    qrcode
    lastpage
    appendix
    changebar
    footmisc
    multirow
    overpic
    subfigure
    titlesec
    siunitx
    combelow
    csquotes
    etoolbox
    etextools
    idxlayout
    bidi
    filecontents
    eplain
    texsis
    mltex
    lollipop
    moreverb
    indextools
    splitindex
    eepic
    bigfoot
    xstring
    showexpl
    cweb-latex
    hypdvips
    ptex
    perltex
    collection-pstricks
    $(collection_by_size fontsextra 20000 || exit 1)
    " texmfget base || exit 1

  # Put all remaining stuff in "extra" 
  # Pull some bin-packages from tlnet, which aren't provided by the texlive source tarball
  PACKAGES="
    collection-texworks
    collection-wintools
    wasy2-ps
    " texmfget extra || exit 1

  # Call "fonts" at the end to add remaining fonts
  PACKAGES="
    collection-fontsextra
    " texmfget fonts || exit 1

}

# ==== Nothing to edit beyond this line ====

usage () {
  echo
  echo "Generate texmf trees/editions based on collections/packages and their dependencies."
  echo "./texmf_get.sh [base|docs|extra|fonts]"
  echo
  echo "-base:  texfiles, no docs"
  echo "-docs:  docs of -base"
  echo "-extra: remaining texfiles and docs"
  echo "-fonts: fonts and docs" 
  echo 
  echo "Only new/updated/missing tex packages are downloaded."
  echo "The first run takes \"long\", tex packages(about 2500Mb)"
  echo "need to be downloaded and metafiles are generated."
  echo "To check out a new version/release, delete"
  echo "$db"
  echo "A new ascii database is pulled on the next run,"
  echo "and a new version yymmdd is set."
  echo
  echo "All generated tarballs, logs etc. are going to"
  echo "$TMP"
  echo
}

collection_by_size () {
  # from collection $1, pull packages smaller $2 bytes 
  start_n="$(grep -n ^"name collection-$1"$ $db | cut -d':' -f1)"
  # find end of package/collection
  for emptyline in $emptylines
  do
    if [ "$emptyline" -gt "$start_n" ]
    then
      end_n=$emptyline
      break
    fi
  done
  extrapackages="$(sed "${start_n},${end_n}!d" $db | grep ^"depend " | grep -v ^"depend collection" | sed "s/^depend//g" )"
  
  # add if smaller than ...
  for checksize in $extrapackages
  do
    package_meta $checksize || exit 1
    size=$(grep ^"containersize " $texmf/$checksize.meta | cut -d' ' -f2)
    # for $2, e.g. 3000 means 3kb
    [ $size -lt $2 ] && echo $checksize
  done
}

package_meta () {
  if [ ! -s "$texmf/$1.meta" ]
  then
    # collection start linenumer
    start_n="$(grep -n ^"name ${1}"$ $db | cut -d':' -f1)"
    [ -z "$start_n" ] && echo "$1 was not found in $db, bye." && exit 1
    # find end of package/collection
    for emptyline in $emptylines
    do
      if [ "$emptyline" -gt "$start_n" ]
      then
        end_n=$emptyline
        break
      fi
    done
    # Don't handle collections as dependency of other collections
    sed "${start_n},${end_n}!d;/^depend collection/d" $db > $texmf/$1.meta 
  fi
}

download () {
  # Download packages, if not already available. Not every packages has a corresponding .doc package.
  # Try three times if package isn't present, with -t1 to get another mirror the second time
  cd $texmf
  if [ ! -s "${1}${flavour}.tar.xz" ]
  then
    for run in {1..10}
    do
      wget -t1 -c ${mirror}archive/${1}${flavour}.tar.xz
      [ -s "${1}${flavour}.tar.xz" ] && break
    done
  fi
  # If no success by downloading, write error log
  [ ! -s ${1}${flavour}.tar.xz ] && echo "Downloading ${1}${flavour}.tar.xz did not work, writing to $errorlog" && echo "$VERSION" >> $errorlog && echo "Error downloading ${1}${flavour}.tar.xz" >> $errorlog && exit 1
    
  # check sha512, give three tries for downloading again(diffrent mirrors are used automatically)
  if [ "$flavour" = ".doc" ]
  then
    sha512="$(grep ^doccontainerchecksum $texmf/$1.meta | cut -d' ' -f2 )"
  else
    sha512="$(grep ^containerchecksum $texmf/$1.meta | cut -d' ' -f2 )"
  fi
  
  for run in {1..10}
  do
    if [ "$(sha512sum ${1}${flavour}.tar.xz | cut -d' ' -f1 )" != "$sha512" ]
    then
      # Download (hopefully) newer file
      rm ${1}${flavour}.tar.xz
      wget -t1 -c ${mirror}archive/${1}${flavour}.tar.xz
    else
      break
    fi
  done
  # check sha512 again, exit if it fails
  if [ "$(sha512sum ${1}${flavour}.tar.xz | cut -d' ' -f1 )" != "$sha512" ]
  then
    echo "sha512sum $(sha512sum ${1}${flavour}.tar.xz | cut -d' ' -f1 ) of"
    echo "${package}${flavour}.tar.xz doesn't match with $db"
    # delete metafile on failure to get generated again on next run, where new $db may be in use
    rm $texmf/$1.meta
    echo "sha512sum $sha512"
    echo "Delete ${db}* to be current again, and try again."
    exit 1
  fi
}

untar () {
  # leave if $1 has no content. Therea collections with basically no used package, e.g. texworks
  if [ -s "$1" ]
  then
    while read package
    do
      # untar all packages, check for relocation, "relocate 1" -> untar in texmf-dist
      download $package || exit 1
      # untar the tex package
      unset relocated
      [ -n "$(grep -w ^"relocated 1" $texmf/$package.meta)" ] && relocated="-C texmf-dist" 
      tar vxf ${package}${flavour}.tar.xz --exclude tlpkg $relocated || exit 1
      
      # if binaries are present, put them in texmf-dist
      [ -d bin ] && cp -a bin texmf-dist && rm -rf bin
      if [ "$flavour" = ".doc" ]
      then
        size=$(( $(grep ^doccontainersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
      else
        size=$(( $(grep ^containersize $texmf/$package.meta | cut -d' ' -f2 ) / 1024 ))
      fi
      shortdesc="$(grep ^shortdesc $texmf/$package.meta | cut -d' ' -f2- )"
      echo "$size Kb, $package$flavour: $shortdesc" >> $output.meta
      #grep ^"execute addMap" $texmf/$package.meta | sed "s/^execute //g" >> $output.updmap.cfg
    done < $1
    
    # copy packages index to texmf-dist, so included packages are known in later installation
    cat $output.meta >> $output.$edition.meta
    
    # cleanup
    [ -f $output.meta ] && rm $output.meta
  fi
}

remove_cruft () {
  # Remove m$-stuff, ConTeXt single-user-system stuff, source leftovers and pdf-versions of manpages
  rm -rf texmf-dist/source
  rm -rf texmf-dist/scripts/context/stubs/source/
  find texmf-dist/ -type d -name 'win32'     -exec rm -rf {} +
  find texmf-dist/ -type d -name 'win64'     -exec rm -rf {} +
  find texmf-dist/ -type d -name 'mswin'     -exec rm -rf {} +
  find texmf-dist/ -type d -name 'win'       -exec rm -rf {} +
  find texmf-dist/ -type d -name 'setup'     -exec rm -rf {} +
  find texmf-dist/ -type d -name 'install'   -exec rm -rf {} +
  find texmf-dist/ -type f -name '*.bat'     -delete
  find texmf-dist/ -type f -name '*.bat.w95' -delete
  find texmf-dist/ -type f -name '*win32*'   -delete
  find texmf-dist/ -type f -name 'winansi*'  -delete
  find texmf-dist/ -type f -name '*-man.pdf' -delete
  # Remove zero-length files, as these appear e.g. in hyph-utf8 tex-package.
  find . -type f -size 0c -delete
}

texmfget () {
  # make sure no package is added more than once.
  echo "Preparing index of packages to be added to -${1} ..."
  echo "$PACKAGES" | sed "s/[[:space:]]//g;/^$/d" > $collections_tobedone
  # Remove outputfile if already present
  >$output
  >$output_doc
  
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
        # remove from $collections_tobedone
        sed -i "/^$collection$/d" $collections_tobedone
        if [ -n "$(grep "^${collection} added to" $logfile)" ]
        then
          echo "$collection already added " >> $logfile
        fi
        continue
      fi
    fi
    
    package_meta $collection || exit 1
  
    # Don't handle collections as dependency of other collections, as this destroys control over what packages to be added
    # If $collection is a singel package(not a collection-), add it here
    if [ -n "$(head -n1 $texmf/$collection.meta | fgrep -v "name collection" )" ]
    then
      # if package contains only docs, add to docpackages
      if [ -z "$(grep ^runfiles $texmf/$collection.meta)" -a -n "$(grep ^docfiles $texmf/$collection.meta)" ]
      then
        sed -i "/^$collection$/d" $collections_tobedone
        echo "$collection" >> $collections_done
        echo "$collection" >> $output_doc
        echo "$collection added to -docs $1" >> $logfile
        continue
      fi
      # if package contains also docs, add also to docpackages
      if [ -n "$(grep ^docfiles $texmf/$collection.meta)" ]
      then
        echo "$collection" >> $output_doc
        echo "$collection added to -docs $1" >> $logfile
      fi
      echo "$collection" >> $output
      echo "$collection added to -$1" >> $logfile
    fi
    # add dependend packages, but no binary(ARCH) and no packages conataining a '.'. Packges with dot indicate binary/texlive-manager/windows packages
    grep ^"depend " $texmf/$collection.meta | grep -v "ARCH$" | grep -v '\.' | cut -d' ' -f2- > $dependencies
    if [ -s "$dependencies" ]
    then
      echo "----------------" >> $logfile
      echo "Dependencies of $collection: $(cat $dependencies | tr '\n' ' ')" >> $logfile
      for dependency in $(cat $dependencies)
      do
        if [ -n "$(grep ^"${dependency}"$ $collections_done)" ]
        then
          sed -i "/^${dependency}$/d" $dependencies
          continue
        else
          for exclude in $global_exclude
          do
            if [ "$exclude" = "$dependency" ]
            then
              sed -i "/^${exclude}$/d" $dependencies
              echo "$exclude excluded, see \$global_exclude" >> $logfile
            fi
          done
        fi
      done
      cat $dependencies >> $collections_tobedone
      echo "----------------" >> $logfile
    fi
    
    sed -i "/^${collection}$/d" $collections_tobedone
    echo "$collection" >> $collections_done
  done
  # handle package index list per edition
  cat $output >> $TMP/packages.$1
  # handle doc package index, one for each edition
  cat $output_doc >> $TMP/packages.$1.doc

  # untar only one $edition, untar docs together with -extra/-fonts edition
  if [ "$1" = $edition -o docs = $edition ]
  then
    cd $texmf
    
    # Cleanup tar-directory
    [ -d $texmf/texmf-dist ] && rm -rf $texmf/texmf-dist
    mkdir $texmf/texmf-dist
    
    # Make tarball/checksum reproducible by setting mtime(clamp-mtime), owner, group and sort content
    # --clamp-mtime --mtime doesn't work with tar 1.13, when makepkg creates the tarball:
    # tar-1.13: time_t value 9223372036854775808 too large (max=68719476735)
    case $edition in
      base)
      unset flavour
      untar $output || exit 1
      remove_cruft || exit 1
      tar vrf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
      rm -rf texmf-dist
      ;;
      extra|fonts)
      unset flavour
      untar $output || exit 1
      export flavour=".doc"
      untar $output_doc || exit 1
      remove_cruft || exit 1
      #tar vrf $tarball --clamp-mtime --mtime --owner=0 --group=0 --sort=name texmf-dist || exit 1
      tar vrf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
      rm -rf texmf-dist
      ;;
      docs)
      export flavour=".doc"
      # only add -base docs to -docs
      if [ $1 = base ]
      then
        untar $output_doc || exit 1
        remove_cruft || exit 1
      #tar vrf $tarball --clamp-mtime --mtime --owner=0 --group=0 --sort=name texmf-dist || exit 1
        tar vrf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
        rm -rf texmf-dist
      fi
      ;;
    esac
  fi
}

# Main

# release mirror
mirror="http://mirror.ctan.org/systems/texlive/tlnet/"
# pre-test mirror 2016
# mirror="http://ftp.cstug.cz/pub/tex/local/tlpretest/"
LANG=C
TMP=$PWD/tmp
output=$TMP/packages
output_doc=$TMP/packages.doc.tmp
errorlog=$TMP/error.log
texmf=$TMP/texmf
db=$TMP/texlive.tlpdb
tmpfile=$TMP/tmpfile
collections_done=$TMP/done
collections_tobedone=$TMP/tobedone
corepackages=$TMP/corepackages
allcollections=$TMP/allcollections
metafonts=$TMP/metafonts
manpages=$TMP/manpages
dependencies=$TMP/deps
packages_base=$TMP/packages.base
packages_extra=$TMP/packages.extra
packages_fonts=$TMP/packages.fonts
packages_metafont=$TMP/packages.metafont
packages_manpages=$TMP/packages.manpages

case "$1" in
  base|docs|extra|fonts) edition=$1; echo "Building $edition tarball ...";;
  *) usage; exit 0 ;;
esac
  
mkdir -p $texmf
cd $TMP

# Set VERSION, get texlive.tlpdb and keep unshorten $db.orig 
if [ ! -s ${db}.orig -o ! -s $db ]
then
  echo $MAJORVERSION.$(date +%y%m%d) > VERSION
  wget -c -O ${db}.orig ${mirror}tlpkg/texlive.tlpdb 
  # remove most content from $db to be faster on later processing. 
  # keep dependencies/manpages/metafonts/binfiles/shortdesc/sizes
  egrep '^\S|^ RELOC/doc/man|^ texmf-dist/doc/man/man|^ RELOC/doc/info/|^ texmf-dist/doc/info/|^ texmf-dist/fonts/source/public/|^ RELOC/fonts/source/public|^ bin|^$' ${db}.orig | grep -v ^longdesc > $db
  
  # As $db (might be)/is new, remove the meta-files, might created again with (pontentionally) new content
  rm -rf $texmf/*.meta
fi

# Get linenumbers of empty lines from $db
emptylines="$(grep -n ^$ $db | cut -d':' -f1)"

# Provide TLCore packages for -base, as these packages(and their dependencies) should be present in any case. 
grep -B1 ^'category TLCore' $db | grep -v ^'category TLCore' |  grep -v ^-- | grep -v '\.' | cut -d' ' -f2 > $corepackages

# Make a list of all collections
grep ^"name collection-" $db | cut -d' ' -f2 > $allcollections
  
# globally exclude from $corepackages
for exclude in $global_exclude
do
  sed -i "/^${exclude}$/d" $corepackages
done 
  
VERSION=$(cat $TMP/VERSION)
tarball=$TMP/texlive-$edition-$VERSION.tar
# set logfile
logfile=$TMP/$VERSION.log

# reset some files
>$logfile
>$tarball
>$collections_done
>$metafonts
>$manpages
>$packages_metafont
>$packages_manpages
>$packages_base
>$packages_extra
>$packages_fonts
>$packages_base.doc
>$packages_extra.doc
>$packages_fonts.doc
>$TMP/packages.$edition.meta

# put the editions base/extra/fonts together
texmf_editions || exit 1

# Check if all collections ar part in at least one edition
while read collection
do
  grep -w "$collection" $collections_done &> /dev/null
  if [ $? != 0 ]
  then
    echo "Error: $collection was not handled, edit packages/collections inthe  texmfget function in $0." | tee -a $logfile
    exit 1
  fi
done < $allcollections

# meta data about added packages
sort -n $output.$edition.meta > $tmpfile
mv $tmpfile $output.$edition.meta 

# cleanup 
rm $allcollections
rm $corepackages
rm $collections_done
rm $collections_tobedone
rm $output
rm $output_doc
rm $dependencies

[ ! -d texmf-dist ] && mkdir texmf-dist
# include all metafonts in base package, plus packages which misses font-mf tag on CTAN
echo "Looking for metafont files to be included in -base ..."
for metafont in $(paste -s $packages_extra $packages_fonts )
do
  if [ -n "$(egrep "(fonts/source/public/)" $texmf/$metafont.meta )" ]
  then
    # include all metafonts in -base, write index for later exclution from other editions.
    package_meta $metafont || exit 1
    echo "Adding metafonts from $metafont to -base"
    unset flavour
    download $metafont || exit 1
    unset relocated
    pathprefix="texmf-dist/"
    [ -n "$(grep -w ^"relocated 1" $texmf/$metafont.meta)" ] && relocated="-C texmf-dist" && unset pathprefix
    tar vxf $texmf/$metafont.tar.xz $relocated ${pathprefix}fonts/source ${pathprefix}tex/latex 2>/dev/null | sed "s/^fonts/texmf-dist\/fonts/g;s/^tex\//texmf-dist\/tex\//g" >> $metafonts
    echo $metafont >> $packages_metafont
  fi
done

# include manpages/GNU infofiles in -base, write index for later exclution from other editions.
# In -extra there should not be any manpage left.
echo "Looking for manpages/GNU infofiles to be included in -base ..."
for package in $(paste -s $packages_metafont $packages_base.doc | sort -u)
do
  if [ -n "$(egrep "(doc/man/man|doc/info/)" $texmf/$package.meta )" ]
  then
    echo "Adding manpage from $package to -base"
    flavour=".doc" download $package || exit 1
    unset relocated
    pathprefix="texmf-dist/"
    [ -n "$(grep -w ^"relocated 1" $texmf/$package.meta)" ] && relocated="-C texmf-dist" && unset pathprefix
    tar vxf $texmf/${package}.doc.tar.xz --exclude "*.man[15].pdf" $relocated ${pathprefix}doc/man/ ${pathprefix}doc/info 2>/dev/null | sed "s/^doc/texmf-dist\/doc/g" >> $manpages
    echo "$package" >> $packages_manpages
  fi
done 
  
case $edition in
  base) 
  # Content info
  cat << EOF | gzip -9 >> $texmf/texmf-dist/packages.$edition.gz
Content of -$edition:
$(sort $packages_base)

Metafonts from packages:
$(sort $packages_metafont)

Manpages from packages:
$(sort $packages_manpages)
EOF
  
  # add manpages/metafonts to the tarball
  tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
  # cleanup extracted metafonts/manpages
  rm -rf texmf-dist
  # handle koma-script docs, the author wants the docs to be shipped along, html doc seems sufficient
  tar f $tarball --delete $(tar tf $tarball | grep /doc/.*koma-script.*pdf)
  ;;
  extra|fonts)
  # cleanup extracted metafonts/manpages
  rm -rf texmf-dist
  echo "Removing manpages/metafonts from -extra/-fonts/-docs which now reside in -base" 
  tar -f $tarball --delete $(paste $manpages $metafonts) 2>/dev/null
  # content info
  mkdir texmf-dist
  echo "Content of -$edition, including documentation:" > $texmf/texmf-dist/packages.$edition
  sort $TMP/packages.$edition >> $texmf/texmf-dist/packages.$edition
  gzip -9 $texmf/texmf-dist/packages.$edition
  tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
  ;;
  docs)
  # cleanup extracted metafonts/manpages
  rm -rf texmf-dist
  echo "Removing manpages/metafonts from -extra/-fonts/-docs which no reside in -base" 
  tar -f $tarball --delete $(paste $manpages $metafonts) 2>/dev/null
  # content info, this edition conains all docs from -base
  mkdir texmf-dist
  echo "Content of -$edition, documentation for -base:" > $texmf/texmf-dist/packages.$edition
  sort $packages_base.doc >> $texmf/texmf-dist/packages.$edition
  gzip -9 $texmf/texmf-dist/packages.$edition
  tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
  ;;
esac

# compress the tarball as everything is in place now
echo "Compressing $tarball ..."
[ -f $tarball.xz ] && rm $tarball.xz
xz -9 -T0 $tarball || exit 1
md5sum $tarball.xz
ls -lh $tarball.xz
echo "Logfile: $logfile"

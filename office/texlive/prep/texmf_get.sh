#!/bin/bash

# texmf_get.sh (c) 2016 - 2019 Johannes Schoepfer, Germany, slackbuilds[at]schoepfer[dot]info
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
#  V 15.0.3
#
#  Prepare xz-compressed tarballs of texlive-texmf-trees based on texlive.tlpdb
#  This script takes care of dependencies(as far as these are present in texlive.tlpdb)
#  of collections and packages, and that every texlive-package is included only once.
#  The editions(base/extra/docs) should contain no binaries(exception biber)
# -base: the most usefull stuff, most binaries/scripts,
#  manpages for compiled binaries  65mb 2017-11-07
# -docs: -base documentation only, no manpages/GNU infofiles
# -extra: remaining stuff and corresponding docs
#
#  texlive netarchive policy: Every package is included as dependency
#  in exactly one collection. A package may have dependencies on other
#  packages from any collection.

# package source: http://mirror.ctan.org/systems/texlive/tlnet/archive/

#set -e
MAJORVERSION=2019
mirror="http://mirror.ctan.org/systems/texlive/tlnet/"
TMP=$PWD/tmp

# Globally excluded packages, which are/contain
# -useless without tlmgr-installer
# -non-linux
# -covered by an external package, e.g. asymptote on SBo
# -obsolete, e.g. omega
# -java dependend packages
# -binaries provided already by texlive.Slackbuild
# -binaries provided already other system packages, e.g. texlive-scripts.ARCH
# -only sources, or hyphen directives, e.g. metatype1, patch, ...
# -only hyphen directives, e.g. hyphen-farsi ...

global_exclude="
  aleph
  antomega
  asymptote
  bibtexu
  cslatex
  dviout.win32
  hyphen-arabic
  hyphen-farsi
  lambda
  metatype1
  ocherokee
  oinuit
  omega
  omegaware
  otibet
  patch
  texlive-common
  texlive-docindex
  texlive-msg-translations
  texlive-scripts
  texlive.infra
  texliveonfly
  texosquery
  texworks
  tlcockpit
  tlshell
  wintools.win32
  dvisvgm
  "

  # special packages, move their type1 fonts(if metafonts are present)
  # and/or docs to -extra
special_packages="
  koma-script
  velthuis
  armtex
  montex
  vntex
  pl
  cc-pl
  cs
  musixtex-fonts
  tipa
  cbfonts
  ptex-fonts
  uptex-fonts
  "
#Todo: split type1 fonts, or keep subset of type1 fonts in base
#  cm-super

# keep precompiled binaries, list binary, not package name
keep_precompiled="
  biber
  "

texmf_editions () {

  # "excludes from -base", also dependencies are excluded
  PACKAGES="
    cm-super
    biber
    bib2gls
    knitting
    pgfornament
    pgfplots
    pst-cox
    pst-poker
    pst-vectorian
    pst-geo
    bclogo
    $(grep ^"name .*biblatex" $db | cut -d' ' -f2 )
    " texmfget extra || exit 1
 
    # packages/collections and their dependencies for -base
  PACKAGES="
    $(cat $corepackages)
    etoolbox
    xcolor
    memoir
    velthuis
    wasy
    ptex
    platex
    revtex
    uptex
    uplatex
    ucs
    collection-basic
    collection-latex
    collection-metapost
    collection-plaingeneric
    collection-luatex
    collection-context
    collection-fontutils
    collection-langczechslovak
    collection-langeuropean
    collection-langenglish
    collection-langfrench
    collection-langitalian
    collection-langpolish
    collection-langportuguese
    collection-langspanish
    collection-latexrecommended
    $(collection_by_size fontsextra 70000 || exit 1)
    $(collection_by_size publishers 10000 || exit 1)
    " texmfget base

    # packages/collections and their dependencies for -extra
  PACKAGES="
    amiri
    arabi
    arabi-add
    arara
    arev
    bangorcsthesis
    beamer2thesis
    beamertheme-detlevcm
    beamertheme-epyt
    beamertheme-npbt
    beamertheme-saintpetersburg
    beebe
    bhcexam
    bxtexlogo
    churchslavonic
    collection-fontsextra
    collection-langchinese
    collection-langcjk
    collection-langjapanese
    collection-langkorean
    collection-publishers
    collection-texworks
    collection-wintools
    ctan-o-mat
    ctanify
    ctanupload
    dad
    duckuments
    ethiop-t1
    fibeamer
    fithesis
    ghsystem
    gregoriotex
    hustthesis
    ijsra
    iwhdp
    jpsj
    kerkis
    ketcindy
    kpfonts
    langsci
    latex2nemeth
    libertine
    lilyglyphs
    lni
    luatexko
    media9
    musuos
    mwe
    newtx
    nwejm
    padauk
    pdfwin
    pdfx
    powerdot-tuliplab
    powerdot-FUBerlin
    quran
    quran-de
    realhats
    resumecls
    sanskrit-t1
    sapthesis
    sduthesis
    seuthesix
    simurgh
    skaknew
    stellenbosch
    suanpan
    tudscr
    uantwerpendocs
    ucs
    udesoftec
    universalis
    uowthesis
    wasy2-ps
    xduthesis
    xetexko
    xq
    " texmfget extra || exit 1

   # What's left, for base again
  PACKAGES="
    collection-fontsrecommended
    collection-xetex
    collection-langcyrillic
    collection-langarabic
    collection-langgerman
    collection-langgreek
    collection-langother
    collection-humanities
    collection-mathscience
    collection-pictures
    collection-pstricks
    collection-music
    collection-games
    collection-binextra
    collection-bibtexextra
    collection-formatsextra
    collection-latexextra
    " texmfget base || exit 1

}

# ==== Nothing to edit beyond this line ====

usage () {
  echo
  echo "Generate texmf trees/editions based on collections/packages"
  echo "and their (hard)dependencies."
  echo "./texmf_get.sh [base|docs|extra|lint]"
  echo
  echo "-base:  texfiles, no docs"
  echo "-docs:  docs of -base"
  echo "-extra: remaining texfiles and docs"
  echo "[lint]: compare filename contents of all generated editions,"
  echo " to detect overlapping files"
  echo
  echo "Only new/updated/missing tex packages are downloaded."
  echo "The first run takes \"long\", tex packages(about 2500Mb)"
  echo "need to be downloaded."
  echo "To check out a new version/release, delete"
  echo "$db"
  echo "A new ascii index file/database(texlive.tlpdb) is will be"
  echo "pulled on the next run, and a new version yymmdd will be set."
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
      wget -q --show-progress -t1 -c ${mirror}archive/${1}${flavour}.tar.xz
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
      wget -q --show-progress -t1 -c ${mirror}archive/${1}${flavour}.tar.xz
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
  # leave if $1 has no content
  if [ -s "$1" ]
  then
    while read package
    do
      echo "untar $package"
      # untar all packages, check for relocation, "relocate 1" -> untar in texmf-dist
      download $package || exit 1
      # untar package, relocate to texmf-dist if necessary, binary packages always need relocation
      relocated='.'
      [ -n "$(grep -w ^"relocated 1" $texmf/$package.meta)" -o -n "$(grep ^"binfiles " $texmf/$package.meta)" ] && relocated="texmf-dist" 
      # if not .doc package, investigate files for dependencies/provides
      if [ -n "$flavour" ]
      then
        tar xf ${package}${flavour}.tar.xz --exclude tlpkg -C $relocated || exit 1
      else
        tar vxf ${package}${flavour}.tar.xz --exclude tlpkg -C $relocated | grep -E '\.sty$|\.bbx$|\.cls$' > $texmf/$package.deps
        if [ -n "$texmf/$package.deps" ]
        then
          unset provide
          unset depends
          for depfile in $(cat $texmf/$package.deps)
          do
            filename="$( echo $depfile | rev | cut -d'.' -f2- | cut -d'/' -f1 | rev)"
            # always add $filename as "ProvidesPackage", if it's a .sty
            echo $depfile | grep '\.sty'$ &>/dev/null
            [ $? = 0 ] && provide+="${filename},"
            # remove comments, if there are backslashes ignore that content, except it is \filename
            #provide+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -n "s/.*\\\ProvidesPackage{\([^}]*\)}.*/\1/p" | sed "s/\\\filename/$filename/g;/\\\/d" | sort -u | tr '\n' ',')"
            #sed -z "s/.*\\\Provides\(Package\|ExplPackage\|File\|Class\)*.\n//g" | sed "s/[[:space:]]//
           #provide+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -z "s/.*\\\Provides\(Package\|ExplPackage\|File\|Class\)*.\n//g" | sed "s/[[:space:]]// | sed -n "s/.*\\\Provides\(Package\|ExplPackage\|File\|Class\){\([^}]*\)}.*/\2/p" | sed "s/\\\filename/$filename/g;s/\\\ExplFileName/$filename/g;/\\\/d" | sed "s/\(\.sty$\|\.cls$\)//g" | sort -u | tr '\n' ',')"
            provide+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -z "s/\(Package\|ExplPackage\|File\|Class\)\n/\1/g" | sed "s/[[:space:]]//" | sed -n "s/.*\\\Provides\(Package\|ExplPackage\|File\|Class\){\([^}]*\)}.*/\2/p" | sed "s/\\\filename/$filename/g;s/\\\ExplFileName/$filename/g" | sed "s/\(\.sty$\|\.cls$\)//g" | sort -u | tr '\n' ',')"
            #depends+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -n "s/.*\(\\\require\|\\\use\)package{\([^}]*\)}.*/\2/p" | sed "/\\\/d" | sort -u | tr '\n' ',')"
            depends+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -n "s/.*\(\\\require\|\\\use\)package{\([^}]*\)}.*/\2/p" | sort -u | tr '\n' ',')"
            #depends+="$(sed "s/%.*//g" $texmf/$relocated/$depfile | sed -n "s/.*\\\\(require\|use\)package{\([^}]*\)}.*/\2/p" | sed "/\\\/d" | sort -u | tr '\n' ',')"
          done
          if  [ -n "$provide" ]
          then
            echo "$package $provide" >> $TMP/provides.run.$edition
          fi
          if [ -n "$depends" ]
          then
            echo "$package $depends" >> $TMP/depends.run.$edition
          fi
        fi
      fi

      # Delete binaries, these are provided
      # by texlive.Slackbuild, keep symlinks and scripts

      for arch in $platforms
      do
        if [ -d $texmf/texmf-dist/bin/$arch ]
        then
          [ ! -d $texmf/texmf-dist/linked_scripts ] \
            && mkdir $texmf/texmf-dist/linked_scripts
          # rewrite link target to fit systemwide installation
          for link in $(find $texmf/texmf-dist/bin/$arch -type l)
          do
            ln -sf $(readlink $link | sed "s/^..\/..\(.*\)/..\/share\1/" ) $link || exit 1
          done
          # move symlinks to linked_scripts
          find $texmf/texmf-dist/bin/$arch -type l -exec mv '{}' $texmf/texmf-dist/linked_scripts/ \;

          # keep only binaries of special packages
          # remove xindy.mem(gzip compresses data) to prevent overwriting
          for bin in $(find $texmf/texmf-dist/bin/$arch -type f -exec file '{}' + | \
            grep -e "executable" -e "shared object" -e "gzip compressed data" | \
            grep -e ELF -e "gzip compressed data" | cut -f 1 -d : )
          do
            for binary in $keep_precompiled
            do
              if [ "$(echo $bin | rev | cut -d'/' -f1 | rev)" != "$binary" ]
              then
                rm $bin
                echo $bin | rev | cut -d'/' -f1 | rev >> $binary_removed.$edition
              fi
            done
          done
          # move scripts to linked-scripts
          scripts="$(find $texmf/texmf-dist/bin/$arch -type f -exec file '{}' + | grep -wv ELF | cut -f 1 -d : )"
          for script in $scripts
          do
            mv $script $texmf/texmf-dist/linked_scripts/
          done
        fi
      done

      if [ "$flavour" = ".doc" ]
      then
        size=$(grep ^doccontainersize $texmf/$package.meta | cut -d' ' -f2)
      else
        size=$(grep ^containersize $texmf/$package.meta | cut -d' ' -f2)
	# add maps to updmap.cfg, don't add special_packages map files to -base
	add_map=yes
	if [ $edition = base ]
	then
	  for no_map in $special_packages
	  do
	    [ $no_map = $package ] && add_map=no && break
          done
	fi
	[ $add_map = yes ] && grep ^'execute ' $texmf/$package.meta | grep Map | cut -d' ' -f2- | sed "s/^add//g" >> $updmap.$edition
      fi
      shortdesc="$(grep ^shortdesc $texmf/$package.meta | cut -d' ' -f2- )"
      echo "$size byte, $package$flavour: $shortdesc" >> $output.meta
      # make index of uncompressed size of each package
      echo "$(xz -l --verbose ${package}${flavour}.tar.xz | grep "Uncompressed size" | \
        cut -d'(' -f2 | cut -d' ' -f1 ) byte, $package$flavour: $shortdesc" >> $output.meta.uncompressed
    done < $1

    # copy packages index to texmf-dist, so included packages are known in later installation
    # don't list binary packages, as the binaries itself are not contained, only the symlinks.
    cat $output.meta | grep -v '\-linux:'  >> $output.$edition.meta
    cat $output.meta.uncompressed | grep -v '\-linux:' >> $output.$edition.meta.uncompressed

    # cleanup
    [ -f $output.meta ] && rm $output.meta
    [ -f $output.meta.uncompressed ] && rm $output.meta.uncompressed
  fi
}

remove_cruft () {
  # Remove m$-stuff, ConTeXt single-user-system stuff, source leftovers and pdf-versions of manpages
  rm -rf texmf-dist/source
  rm -rf texmf-dist/scripts/context/stubs/source/
  find texmf-dist/ -type d -name 'win32'         -exec rm -rf {} +
  find texmf-dist/ -type d -name 'win64'         -exec rm -rf {} +
  find texmf-dist/ -type d -name 'mswin'         -exec rm -rf {} +
  find texmf-dist/ -type d -name 'win'           -exec rm -rf {} +
  find texmf-dist/ -type d -name 'setup'         -exec rm -rf {} +
  find texmf-dist/ -type d -name 'install'       -exec rm -rf {} +
  find texmf-dist/ -type f -name 'uninstall*.sh' -delete
  find texmf-dist/ -type f -name '*.bat'         -delete
  find texmf-dist/ -type f -name '*.bat.w95'     -delete
  find texmf-dist/ -type f -name '*win32*'       -delete
  find texmf-dist/ -type f -name 'winansi*'      -delete
  find texmf-dist/ -type f -name '*man1.pdf'     -delete
  find texmf-dist/ -type f -name '*man5.pdf'     -delete
  # Remove zero-length files, as these appear e.g. in hyph-utf8 tex-package.
  # find texmf-dist/ -type f -size 0c -delete
  find texmf-dist/ -type f -empty -delete
  # Remove empty directories recursively
    find texmf-dist/ -type d -empty -delete
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

    # If $collection is a singel package(not a collection-), add it here
    if [ -n "$(head -n1 $texmf/$collection.meta | grep -v "name collection" )" ]
    then
      addpackage=no
      # if package contains docs, add to docpackages
      if [ -n "$(grep ^docfiles $texmf/$collection.meta)" ]
      then
        echo "$collection" >> $output_doc
        echo "$collection added to docs $1" >> $logfile
        addpackage=yes
      fi
      if [ -n "$(grep ^runfiles $texmf/$collection.meta)" -o -n "$(grep ^binfiles $texmf/$collection.meta)" ]
      then
        echo "$collection" >> $output
        echo "$collection added to -$1" >> $logfile
        addpackage=yes
      fi
      # every package should be added to one dedicated edition, abort if that didn't work
      if [ $addpackage = no ]
      then
        echo "$collection doesn't contain any docfiles/runfiles/binfiles"
        echo "Please exclude package/report to upstream mailinglist tex-live@tug.org, bye."
        exit 1
      fi
    fi

    # Don't handle collections as dependency of other collections, as this destroys control over what packages to be added
    # add dependend packages, but no binary(ARCH) and no packages conataining a '.'. Packges with dot indicate binary/texlive-manager/windows packages

    grep ^"depend " $texmf/$collection.meta | cut -d' ' -f2- > $dependencies

    if [ -s "$dependencies" ]
    then
      # check for .ARCH packages which may be binaries, scripts or links
      # Binaries should all come from the sourcebuild(exception biber)
      for dependency in $(cat $dependencies)
      do
        echo $dependency | grep '\.ARCH'$ &>/dev/null
        if [ $? = 0 ]
        then
          for arch in $platforms
          do
            archpackage="$(echo $dependency | sed "s/\.ARCH$/\.$arch/")"
            grep ^"name $archpackage"$ $db &>/dev/null && echo "$archpackage" >> $dependencies.verified_arch
          done
        else
          echo $dependency >> $dependencies.verified_arch
        fi
      done
      if [ -f $dependencies.verified_arch ]
      then
        mv $dependencies.verified_arch $dependencies
      else
        rm $dependencies
      fi
    fi

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

  # untar only one $edition, untar docs together with -extra edition
  if [ "$1" = $edition -o docs = $edition ]
  then
    cd $texmf
    # Cleanup tar-directory
    [ -d $texmf/texmf-dist ] && rm -rf $texmf/texmf-dist
    mkdir $texmf/texmf-dist

    # Make tarball/checksum reproducible by setting mtime(clamp-mtime), owner, group and sort content
    # --clamp-mtime --mtime doesn't work with tar 1.13, when makepkg creates the tarball:
    # tar-1.13: time_t value 9223372036854775808 too large (max=68719476735)
    echo "Adding files to $( echo $tarball | rev | cut -d'/' -f1 | rev ) ..."
    case $edition in
      base)
      unset flavour
      untar $output || exit 1
      remove_cruft || exit 1
      tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
      rm -rf texmf-dist
      ;;
      extra)
      unset flavour
      untar $output || exit 1
      export flavour=".doc"
      untar $output_doc || exit 1
      remove_cruft || exit 1
      #tar vrf $tarball --clamp-mtime --mtime --owner=0 --group=0 --sort=name texmf-dist || exit 1
      tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
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
        tar rf $tarball --owner=0 --group=0 --sort=name texmf-dist || exit 1
        rm -rf texmf-dist
      fi
      ;;
    esac
  fi
}

lint () {

echo "Comparing content of all editions, this may take a while ..."
cd $TMP
# check if all editions of same VERSION are there, take -base as reference
lint_version=$( ls texlive-base-*tar.xz | head -n1 | cut -d'.' -f2 || exit 1)
if [ -s texlive-extra-$MAJORVERSION.$lint_version.tar.xz \
  -a -s texlive-docs-$MAJORVERSION.$lint_version.tar.xz  ]
then
  for edition in base extra docs
  do
    echo "Extracting index of texlive-${edition}-$MAJORVERSION.$lint_version.tar.xz ..."
    # don't list directories
    tar tf texlive-${edition}-$MAJORVERSION.$lint_version.tar.xz | grep -v '/'$ > $TMP/packages.$edition.lint
  done

  # compare content
  for edition in base extra docs
  do
    >$TMP/packages.$edition.lint.dup
    if [ $edition = base ]
    then
      echo "check if files of base are present in another edition"
      while read line
      do
        grep ^"$line"$ $TMP/packages.extra.lint >> $TMP/packages.base.lint.dup
        grep ^"$line"$ $TMP/packages.docs.lint >> $TMP/packages.base.lint.dup
      done < $TMP/packages.$edition.lint
    fi
  done
else
  echo "Not all editions are present to lint them. Create them first by"
  echo "$0 [base|docs|extra]"
  echo "bye."
  exit 1
fi

exit 0

}

# Main

LANG=C
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
binary_removed=$TMP/binaries.removed
manpages=$TMP/manpages
dependencies=$TMP/deps
packages_base=$TMP/packages.base
packages_extra=$TMP/packages.extra
packages_manpages=$TMP/packages.manpages
updmap=$TMP/updmap.cfg
files_split=$TMP/files.split
platforms="x86_64-linux i386-linux"

mkdir -p $texmf
cd $TMP

case "$1" in
  base|docs|extra) edition=$1;;
  lint) lint ;;
  *) usage; exit 0 ;;
esac

echo "Building $edition tarball ..."

# Set VERSION, get texlive.tlpdb and keep unshorten $db.orig 
if [ ! -s ${db}.orig -o ! -s $db -o ! -s VERSION ]
then
  echo $MAJORVERSION.$(date +%y%m%d) > VERSION
  wget -q --show-progress -c -O ${db}.orig ${mirror}tlpkg/texlive.tlpdb 
  # remove most content from $db to be faster on later processing. 
  # keep dependencies/manpages/binfiles/shortdesc/sizes
  grep -E \
    '^\S|^ RELOC/doc/man|^ texmf-dist/doc/man/man|^ RELOC/doc/info/|^ texmf-dist/doc/info/|^ bin|^$' \
    ${db}.orig | grep -v ^longdesc > $db
  
  # As $db might be renewed, remove the meta-files to be created again
  rm -rf $texmf/*.meta
fi

# Get linenumbers of empty lines from $db
emptylines="$(grep -n ^$ $db | cut -d':' -f1)"

# Provide TLCore packages for -base, as these packages(and their dependencies) should be present in any case. 
grep -B1 ^'category TLCore' $db | grep -v ^'category TLCore' |  grep -v ^-- | grep -v '\.' | cut -d' ' -f2 > $corepackages

# Make a list of all collections
grep ^"name collection-" $db | cut -d' ' -f2 > $allcollections

# translate .ARCH to platforms in excludes, to make .ARCH packages excludeable by $global_exclude
for exclude in $global_exclude
do
  if [ -n "$(echo $exclude | grep '\.ARCH'$ )" ]
  then
    for arch in $platforms
    do
      global_exclude+=" $(echo $exclude | sed "s/\.ARCH$/\.$arch/")" 
    done
    global_exclude=${global_exclude/$exclude/}
  fi
done
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
>$files_split
>$manpages
>$packages_manpages
>$updmap.$edition
>$packages_base
>$packages_extra
>$packages_base.doc
>$packages_extra.doc
>$TMP/packages.$edition.meta
>$TMP/packages.$edition.meta.uncompressed
>$TMP/provides.run.$edition
>$TMP/depends.run.$edition
>$binary_removed.$edition

# put the editions base/extra together
texmf_editions || exit 1

# Check if all collections are part in at least one edition
while read collection
do
  grep -w "$collection" $collections_done &> /dev/null
  if [ $? != 0 ]
  then
    echo "Error: $collection was not handled."
    echo "Edit packages/collections in the texmfget function." | tee -a $logfile
    exit 1
  fi
done < $allcollections

# cleanup 
rm $allcollections
rm $corepackages
rm $collections_done
rm $collections_tobedone
rm $output
rm $output_doc
rm $dependencies

# untar special- and manpage packages to be splitted/moved to other editions
# splitting special packages, files index
echo "Prepare index of to be splitted/moved files from -base"
[ ! -d texmf-dist ] && mkdir texmf-dist
for package in $special_packages
do
  echo "Splitting $package"
  # special packages have to be in -base, as only here are special
  # tasks done to reduce size of -base edition
  if [ -z "$( grep ^"$package"$ $packages_base )" ]
  then
    echo "$package was not found to be part of -base"
    echo "Edit \$special_packages in $0,"
    echo "it should contain only packages from -base, bye."
    exit 1
  fi
  unset relocated
  pathprefix="texmf-dist/"
  [ -n "$(grep -w ^"relocated 1" $texmf/$package.meta)" ] && \
    relocated="-C texmf-dist" && unset pathprefix
  # avoid big pdf docs which are also present as html
  # move (big)type1 fonts to -extra
  # $files_split lists files to be moved from -base to -extra
  if [ $package = "cm-super" ]
  then
    # cm-super minimal for -base, create index of extended cm-super
    tar tf $texmf/$package.tar.xz | sed \
      "/1000\.pfb$/d;/^tlpkg/d;/\.sty$/d;/\.enc$/d;/\.GS$/d" \
      | tee -a $files_split > $files_split.tmp
  else
    tar tf $texmf/${package}.tar.xz | sed \
    -ne "/.*doc\/latex\/.*\.pdf$/p" \
    -ne "/.*fonts\/map\/.*\.map$/p" \
    -ne "/.*fonts\/enc\/.*\.enc$/p" \
    -ne "/.*fonts\/afm\/.*\.\(afm\|afm\.gz\)$/p" \
    -ne "/.*fonts\/type1\/.*\.pfb$/p" \
    -ne "/.*fonts\/vf\/.*\.vf$/p" \
    | tee -a $files_split > $files_split.tmp
  fi

  if [ $edition = base ]
  then
    # Calculate package-minimal size, uncompressed and compressed
    mkdir -p calculate/texmf-dist
    tar xf $texmf/$package.tar.xz -C calculate/texmf-dist --exclude-from=$files_split.tmp
    tar cf calculate/calc.tar.xz -I 'xz -9' calculate/texmf-dist
    size_minimal=$(du -bc calculate/calc.tar.xz | tail -n1 | sed "s/[[:space:]].*//")
    size_minimal_uncompressed="$(xz -l --verbose calculate/calc.tar.xz | grep "Uncompressed size" | cut -d'(' -f2 | cut -d' ' -f1 )"
    sed -i \
      -e "s/^[0-9]* byte, $package: /$size_minimal byte, $package-minimal: /" \
      $output.base.meta
    sed -i \
      -e "s/^[0-9]* byte, $package: /$size_minimal_uncompressed byte, $package-minimal: /" \
      $output.base.meta.uncompressed
    rm -rf calculate
  fi
  
  if [ $edition = extra ]
  then
    mkdir -p calculate/texmf-dist
    tar xf $texmf/${package}.tar.xz -C calculate/texmf-dist $(paste $files_split.tmp)
    tar cf calculate/calc.tar.xz -I 'xz -9' calculate/texmf-dist
    size_extended=$(du -bc calculate/calc.tar.xz | tail -n1 | sed "s/[[:space:]].*//")
    size_extended_uncompressed="$(xz -l --verbose calculate/calc.tar.xz | \
      grep "Uncompressed size" | cut -d'(' -f2 | cut -d' ' -f1 )"
 
    # put new sizes in package index uncompressed
    sed -i \
      -e "s/^[0-9]* byte, $package: /$size_extended byte, $package-extended: /" \
      $output.extra.meta
    sed -i \
      -e "s/^[0-9]* byte, $package: /$size_extended_uncompressed byte, $package-extended: /" \
      $output.extra.meta.uncompressed
    rm -rf calculate
    
    # put map files from splitted packages in -extra
    mkdir meta_tmp
    tar xf $texmf/${package}.tar.xz -C meta_tmp tlpkg/tlpobj/$package.tlpobj
    grep ^'execute ' meta_tmp/tlpkg/tlpobj/$package.tlpobj | grep Map | cut -d' ' -f2- | sed "s/^add//g" >> $updmap.$edition
    rm -rf meta_tmp
  fi
 
  # untar to provide files for -extra
  tar xf $texmf/${package}.tar.xz $relocated $(paste $files_split.tmp)
  if [ $package = "cm-super" ]
  then
    # create cm-super- minimal config/maps with 10pt glyphs only
    sed "s/cm-super/cm-super-minimal/g" $texmf/texmf-dist/dvips/cm-super/config.cm-super \
      > $texmf/texmf-dist/dvips/cm-super/config-minimal.cm-super
    for map in t1 t2a t2b t2c ts1 x2
    do
      grep 1000 $texmf/texmf-dist/fonts/map/dvips/cm-super/cm-super-$map.map \
        > $texmf/texmf-dist/fonts/map/dvips/cm-super/cm-super-minimal-$map.map 
      sed -i "/.*1000\.pfb/d" $texmf/texmf-dist/fonts/map/dvips/cm-super/cm-super-$map.map 
    done
  fi
done

# cleanup
rm $files_split.tmp
# fix relocation in index for splitted packages
sed -i \
  -e "s|^doc|texmf-dist\/doc|g" \
  -e "s|^fonts|texmf-dist\/fonts|g" \
  -e "s|^dvips|texmf-dist\/dvips|g" \
  $files_split

# sort meta data about added packages
sort -n $output.$edition.meta > $tmpfile
mv $tmpfile $output.$edition.meta 
sort -n $output.$edition.meta.uncompressed > $tmpfile
mv $tmpfile $output.$edition.meta.uncompressed 

sort -u $binary_removed.$edition > $tmpfile
mv $tmpfile $binary_removed.$edition

# include manpages/GNU infofiles in -base, write index for later exclusion from other editions.
# In -extra/-docs there should not be any manpage left.
echo "Looking for manpages/GNU infofiles to be included in -base ..."
for package in $(paste -s $packages_base.doc | sort -u)
do
  if [ -n "$(grep -E "(doc/man/man|doc/info/)" $texmf/$package.meta )" ]
  then
    echo "Adding manpage from $package.doc to -base"
    flavour=".doc" download $package || exit 1
    unset relocated
    pathprefix="texmf-dist/"
    [ -n "$(grep -w ^"relocated 1" $texmf/$package.meta)" ] \
      && relocated="-C texmf-dist" && unset pathprefix
    tar tf $texmf/${package}.doc.tar.xz | sed \
    -ne "/.*doc\/man\/.*\.1$/p" \
    -ne "/.*doc\/man\/.*\.5$/p" \
    -ne "/.*doc\/info\/.*\.info$/p" \
    | tee -a $manpages > $manpages.tmp
    # untar to provide files for -/extra/-docs
    tar xf $texmf/${package}.doc.tar.xz $relocated $(paste $manpages.tmp)
    echo "$package" >> $packages_manpages
  fi
done 
# cleanup
rm $manpages.tmp
sed -i \
  -e "s/^doc/texmf-dist\/doc/g" \
  $manpages
  
case $edition in
  base) 
  # Content info
  cat << EOF | gzip -9 >> $texmf/texmf-dist/packages.$edition.gz
Content of -$edition:
$(sed "/-linux$/d" $packages_base | sort)
EOF
  # create texdoc cache file
  if [ $(command -v texdoc) ]
  then
    mkdir -p texmf-dist/scripts/texdoc || exit 1
    TEXMFVAR=$texmf/texmf-dist \
      texdoc -c texlive_tlpdb=$TMP/texlive.tlpdb.orig \
      -DlM texlive-en >/dev/null 2>&1 
    mv texmf-dist/texdoc/cache-tlpdb.lua \
      texmf-dist/scripts/texdoc/Data.tlpdb.lua || exit 1
    # add cache to tarball
    tar rf $tarball --owner=0 --group=0 --sort=name \
      texmf-dist/scripts/texdoc/Data.tlpdb.lua || exit 1
  else
    echo "WARNING: texdoc binary(comming with texlive) is not installed, the texdoc cache"
    echo "Data.tlpdb.lua can't be created and wont't be available."
    echo "Texdoc will not wotk without this."
    echo ""
    echo "Continue with any key or abort with ctrl-c"
    read -n1
  fi

  # prepare updmap.cfg
  tar xf $tarball texmf-dist/web2c/updmap.cfg
  end_n="$(grep -n 'end of updmap-hdr' texmf-dist/web2c/updmap.cfg | cut -d':' -f1)"
  
  sed "1,${end_n}!d" texmf-dist/web2c/updmap.cfg > $TMP/updmap.cfg.tmp
  cat $updmap.$edition >> $TMP/updmap.cfg.tmp
  mv $TMP/updmap.cfg.tmp texmf-dist/web2c/updmap.cfg
  tar f $tarball --delete texmf-dist/web2c/updmap.cfg
  tar rf $tarball --owner=0 --group=0 --sort=name \
    texmf-dist/web2c/updmap.cfg

# add manpages/GNU infofiles to the tarball
  tar rf $tarball --owner=0 --group=0 --sort=name \
    texmf-dist/doc/man/ texmf-dist/doc/info/ \
    texmf-dist/packages.$edition.gz \
    || exit 1
#  # add cm-super minimal maps/config
#  tar rf $tarball --owner=0 --group=0 --sort=name \
#    texmf-dist/dvips/cm-super/config-minimal.cm-super \
#    --wildcards texmf-dist/fonts/map/dvips/cm-super/cm-super-minimal-*.map \
#    || exit 1
  echo "Removing files -from base, splitted from special packages to be included in -extra"
  tar f $tarball --delete $(paste $files_split) || exit 1
  ;;
  extra)
  echo "Removing manpages from $edition which now reside in -base" 
  tar f $tarball --delete $(paste $manpages) 2>/dev/null 
  # content info
  echo "Content of -$edition, including documentation:" > $texmf/texmf-dist/packages.$edition
  sed "/-linux$/d" $TMP/packages.$edition | sort >> $texmf/texmf-dist/packages.$edition
  gzip -9 $texmf/texmf-dist/packages.$edition
#  # remove cm-super minimal config, which resides in -base
#  rm \
#    $texmf/texmf-dist/dvips/cm-super/config-minimal.cm-super \
#    $texmf/texmf-dist/fonts/map/dvips/cm-super/cm-super-minimal-*.map 

    # add -extra updmap.cfg
    mkdir -p $texmf/texmf-dist/web2c
    mv $updmap.$edition $texmf/texmf-dist/web2c
  tar rf $tarball --owner=0 --group=0 --sort=name \
    --exclude texmf-dist/doc \
    texmf-dist \
    || exit 1
  ;;
  docs)
  # add docs splittet from base from special packages, add packages index
  # content info, this edition contains all docs from -base
  echo "Content of -$edition, documentation for -base:" > $texmf/texmf-dist/packages.$edition
  sort $packages_base.doc >> $texmf/texmf-dist/packages.$edition
  gzip -9 $texmf/texmf-dist/packages.$edition
  tar rf $tarball --owner=0 --group=0 --sort=name \
    texmf-dist/doc/ \
    texmf-dist/packages.$edition.gz \
    || exit 1
  echo "Removing manpages from $edition which now reside in -base" 
  tar f $tarball --delete $(paste $manpages) || exit 1
  ;;
esac
  
rm -rf texmf-dist
[ -f $updmap.$edition ] && rm $updmap.$edition

# compress the tarball as everything is in place now
echo "Compressing $tarball ..."
[ -f $tarball.xz ] && rm $tarball.xz
xz -9 -T0 $tarball || exit 1
md5sum $tarball.xz
ls -lh $tarball.xz
echo "Logfile: $logfile"

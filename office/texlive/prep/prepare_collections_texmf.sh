#!/bin/bash 

TMP=$PWD/tmp
collections_done=$TMP/done
collections_tobedone=$TMP/tobedone
[ -f $collections_done ] && rm $collections_done
[ -f $collections_tobedone ] && rm $collections_tobedone

# fonts-package first to make sure that cm-super is not included elsewhere
NAME=fonts \
  PACKAGES="
    cm-super
    cbfonts
    sanskrit-t1
    cmcyr
    cs
    uhc
    fonts-tlwg
    ethiop-t1
    ipaex
    wadalab
    fandol
    arphic
    nanumtype1" \
  ./texmf_get.sh

# collection-langgreek is added as single packages, as the cbfonts should go 
# to the lang-texmftree because of its size
NAME=base \
  PACKAGES="
    collection-basic 
    collection-latex 
    collection-genericrecommended 
    collection-latexrecommended 
    collection-xetex
    collection-metapost
    collection-plainextra
    collection-fontutils
    collection-genericextra
    collection-formatsextra
    collection-htmlxml
    collection-luatex
    collection-fontsrecommended
    collection-mathextra 
    collection-humanities
    lh
    yfonts
    doublestroke
    was
    xypic
    xindy
    asymptote
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
    csplain
    biblatex
    collection-langeuropean
    collection-langenglish
    collection-langfrench
    collection-langgerman
    collection-langitalian
    collection-langpolish
    collection-langportuguese
    collection-langspanish
    collection-langgreek
    collection-langafrican
    hyphen-czech
    hyphen-slovak
    hyphen-indic 
    hyphen-sanskrit 
    hyphen-armenian 
    hyphen-afrikaans
    hyphen-esperanto
    hyphen-bulgarian 
    hyphen-churchslavonic 
    hyphen-mongolian 
    hyphen-russian 
    hyphen-serbian 
    hyphen-ukrainian 
    hyphen-catalan 
    hyphen-galician 
    hyphen-chinese 
    hyphen-coptic 
    hyphen-georgian 
    hyphen-indonesian 
    hyphen-interlingua 
    hyphen-thai 
    hyphen-turkmen 
    hyphen-arabic 
    hyphen-farsi" \
  ./texmf_get.sh 

# Call "fonts"-tarball again to add remaining fonts
NAME=fonts PACKAGES="collection-fontsextra" ./texmf_get.sh 

# Put all remaining stuff in the "extra" tarball
NAME=extra \
  PACKAGES="
    collection-latexextra
    collection-pictures
    collection-games
    collection-publishers 
    collection-bibtexextra 
    collection-binextra 
    collection-science 
    collection-omega
    collection-music 
    collection-langother
    collection-pstricks
    collection-langcyrillic
    collection-langczechslovak
    collection-langindic
    collection-langjapanese
    collection-langkorean
    collection-langarabic
    collection-langchinese
    collection-langcjk" \
  ./texmf_get.sh

# Finally, the docs-tarball - very big (about 1300 MB)
#./texmf_get.sh docs

# Now that everything is added and appended, compress it.
VERSION=$(cat tmp/VERSION)
for NAME in base extra fonts docs; do
  echo $TMP/texlive-$NAME-$VERSION.tar 
  if [ -s $TMP/texlive-$NAME-$VERSION.tar ]; then
    [ -f $TMP/texlive-$NAME-$VERSION.tar.xz ] && rm $TMP/texlive-$NAME-$VERSION.tar.xz
    xz -9 $TMP/texlive-$NAME-$VERSION.tar || exit 1
    ls -lah $TMP/texlive-$NAME-$VERSION.tar.xz
  fi
done

# Following aren't supported
#NAME=context PACKAGES="collection-context" ./texmf_get.sh
#NAME=texworks PACKAGES="collection-texworks" ./texmf_get.sh
#NAME=wintools PACKAGES="collection-wintools" ./texmf_get.sh

# Documentation on some decisions made for texlive-base:
#
# hyphen-packages are for "fmtutil-sys -all" to proceed without errors
#
# for building dblatex:
#   appendix
#   changebar
#   footmisc
#   multirow
#   overpic
#   stmaryrd
#   subfigure
#   titlesec

# for math masters thesis
#   doublestroke
#   was

# decided these are commonly useful and not too big
#   csplain

# to make biber functional
#   biblatex


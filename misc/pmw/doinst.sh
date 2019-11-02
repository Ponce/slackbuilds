fontdir=`gs -h|grep -A5 Search|grep fonts|cut -d : -f1`

ln -s /usr/share/pmw/psfonts/PMW-Alpha $fontdir
ln -s /usr/share/pmw/psfonts/PMW-Music.pfa  $fontdir


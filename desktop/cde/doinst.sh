/usr/bin/ln -sf /bin/gawk /bin/nawk
if [ -d /usr/lib64/locale ]; then
    /usr/bin/ln -sf /usr/lib64/locale/de_DE /usr/lib64/locale/de_DE.ISO-8859-1
    /usr/bin/ln -sf /usr/lib64/locale/es_ES /usr/lib64/locale/es_ES.ISO-8859-1
    /usr/bin/ln -sf /usr/lib64/locale/fr_FR /usr/lib64/locale/fr_FR.ISO-8859-1
    /usr/bin/ln -sf /usr/lib64/locale/it_IT /usr/lib64/locale/it_IT.ISO-8859-1
fi
if [ -d /usr/lib/locale ]; then
    /usr/bin/ln -sf /usr/lib/locale/de_DE /usr/lib/locale/de_DE.ISO-8859-1
    /usr/bin/ln -sf /usr/lib/locale/es_ES /usr/lib/locale/es_ES.ISO-8859-1
    /usr/bin/ln -sf /usr/lib/locale/fr_FR /usr/lib/locale/fr_FR.ISO-8859-1
    /usr/bin/ln -sf /usr/lib/locale/it_IT /usr/lib/locale/it_IT.ISO-8859-1
fi

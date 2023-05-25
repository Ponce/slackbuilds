if [ ! -d etc/slapt-get ]; then
mkdir -p etc/slapt-get
fi

if [ -f etc/slapt-getrc -a ! -f etc/slapt-get/slapt-getrc ]; then
mv -f etc/slapt-getrc etc/slapt-get/slapt-getrc
fi

if [ ! -f etc/slapt-get/slapt-getrc ]; then
mv -f etc/slapt-get/slapt-getrc.new etc/slapt-get/slapt-getrc
else cmp etc/slapt-get/slapt-getrc etc/slapt-get/slapt-getrc.new >/dev/null 2>&1 && rm etc/slapt-get/slapt-getrc.new
fi

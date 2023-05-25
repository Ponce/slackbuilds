if [ ! -d etc/slapt-get ]; then
mkdir -p etc/slapt-get
fi

if [ ! -f etc/slapt-get/slapt-srcrc ]; then
mv -f etc/slapt-get/slapt-srcrc.new etc/slapt-get/slapt-srcrc
else
! diff -q etc/slapt-get/slapt-srcrc etc/slapt-get/slapt-srcrc.new >/dev/null 2>&1 || rm etc/slapt-get/slapt-srcrc.new
fi

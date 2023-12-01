info_install() {
  INFO="$1"
  if [ -x /usr/bin/install-info ]; then
    chroot . /usr/bin/install-info --info-dir=/usr/info $INFO 2> /dev/null
  fi
}

if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info \
                        /usr/info/mit-scheme-ffi.info.gz \
                        /usr/info/mit-scheme-ref.info-1.gz \
                        /usr/info/mit-scheme-ref.info-3.gz \
                        /usr/info/mit-scheme-ref.info-5.gz \
                        /usr/info/mit-scheme-sos.info.gz \
                        /usr/info/mit-scheme-imail.info.gz \
                        /usr/info/mit-scheme-ref.info-2.gz  \
                        /usr/info/mit-scheme-ref.info-4.gz \
                        /usr/info/mit-scheme-ref.info.gz  \
                        /usr/info/mit-scheme-user.info.gz \
                        1> /dev/null 2>&1
fi

if [ -x /usr/bin/ghc-pkg ]; then
  chroot . /usr/bin/ghc-pkg recache
fi


if ! grep -q '/bin/pdksh' etc/shells ; then
  printf "/bin/pdksh\n" >> etc/shells ;
fi


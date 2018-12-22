if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

( cd usr/bin ; rm -rf fastqc )
( cd usr/bin ; ln -sf ../share/java/fastqc/fastqc fastqc )
( cd usr/doc/fastqc-0.11.8 ; rm -rf Help )
( cd usr/doc/fastqc-0.11.8 ; ln -sf ../../share/java/fastqc/Help Help )

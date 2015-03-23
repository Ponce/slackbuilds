# Override xflock4 binary
( cd usr/local/bin ; rm -rf xflock4 )
( cd usr/local/bin ; ln -sf /usr/bin/slock xflock4 )

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
}

config etc/fdclone/fd2rc.siteconfig.new

# If there's no fd link, take over:
if [ ! -r usr/bin/fd ]; then
  ( cd usr/bin ; rm -rf fd )
  ( cd usr/bin ; ln -sf fdclone fd )
  ( cd usr/man/man1 ; rm -rf fd.1.gz )
  ( cd usr/man/man1 ; ln -sf fdclone.1.gz fd.1.gz )
  ( cd usr/man/ja/man1 ; rm -rf fd.1.gz )
  ( cd usr/man/ja/man1 ; ln -sf fdclone.1.gz fd.1.gz )
fi

# 20230620 bkw: reverted this to the config() function from SBo
# template. Please leave this as-is. It works, and it won't confuse
# us (we have over 8000 scripts to look after...)

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/iscsi/iscsid.conf.new
config etc/iscsi/initiatorname.iscsi.new

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

config etc/sddm.conf.new

if [ -n "$(grep sddm etc/passwd | grep var/empty)" ]; then
  echo "*NOTICE*"
  echo
  echo 'SDDM $HOME is set to /var/empty in /etc/passwd'
  echo "This needs to be changed to /var/lib/sddm"
  echo "(see README)."
  echo
  echo "Please run:"
  echo "usermod -d /var/lib/sddm sddm"
  echo
fi

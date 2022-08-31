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

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

preserve_perms etc/rc.d/rc.unbound.new
config etc/unbound/unbound.conf.new

# MD5SUM d837bf4c42abb7048c90d720a579f829 is a file hash from the previous initscript.

if [ $(md5sum /etc/rc.d/rc.unbound | cut -f 1 -d " ") == "d837bf4c42abb7048c90d720a579f829" ]
then
  echo ""
  echo "Warning! Red Hat style init script detected at /etc/rc.d/rc.unbound !"
  echo "It's likely from your previous Unbound installation."
  echo "The init script will probably work just fine but the script has since been rewritten"
  echo "as of Unbound version 1.16.2 and it's no longer supported by this SlackBuild."
  echo ""
  echo "Simply run the following commands to install the new Unbound init script:"
  echo "# cd /etc/rc.d && mv rc.unbound.new rc.unbound"
  echo ""
  echo "...or if you use slackpkg:"
  echo "# slackpkg new-config"
  echo ""
fi

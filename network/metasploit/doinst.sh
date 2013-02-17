config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.metasploit.new:
if [ -e etc/rc.d/rc.metasploit ]; then
  cp -a etc/rc.d/rc.metasploit etc/rc.d/rc.metasploit.new.incoming
  cat etc/rc.d/rc.metasploit.new > etc/rc.d/rc.metasploit.new.incoming
  mv etc/rc.d/rc.metasploit.new.incoming etc/rc.d/rc.metasploit.new
fi

config etc/rc.d/rc.metasploit.new
# Initialize a msf3 git repo for msfupdate
( cd opt/metasploit/apps/pro/msf3
  git init >/dev/null )

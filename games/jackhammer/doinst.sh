# Based on qstat's "doinst.sh" by David Somero
# Handle configuration files
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
# List of configuration files (they should end in .new)

config opt/Jackhammer/VDKGameCfg.ini.new
config opt/Jackhammer/VDKRunCfg.ini.new
config opt/Jackhammer/VDKSettings.ini.new

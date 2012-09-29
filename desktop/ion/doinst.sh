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

config etc/ion3/look_ios.lua.new
config etc/ion3/look_cleanios.lua.new
config etc/ion3/cfg_kludges.lua.new
config etc/ion3/look_greenlight.lua.new
config etc/ion3/cfg_pwm.lua.new
config etc/ion3/look_brownsteel.lua.new
config etc/ion3/cfg_layouts.lua.new
config etc/ion3/lookcommon_emboss.lua.new
config etc/ion3/cfg_ion.lua.new
config etc/ion3/lookcommon_clean.lua.new
config etc/ion3/cfg_menu.lua.new
config etc/ion3/look_newviolet.lua.new
config etc/ion3/cfg_defaults.lua.new
config etc/ion3/cfg_tiling.lua.new
config etc/ion3/look_cleanviolet.lua.new
config etc/ion3/cfg_statusbar.lua.new
config etc/ion3/look_simpleblue.lua.new
config etc/ion3/look_dusky.lua.new
config etc/ion3/look_clean.lua.new
config etc/ion3/cfg_ioncore.lua.new
config etc/ion3/look_greyviolet.lua.new
config etc/ion3/cfg_dock.lua.new
config etc/ion3/cfg_sp.lua.new
config etc/ion3/cfg_query.lua.new

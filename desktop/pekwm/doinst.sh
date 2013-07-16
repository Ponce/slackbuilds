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

config etc/pekwm/autoproperties.new
config etc/pekwm/autoproperties_typerules.new
config etc/pekwm/config.new
config etc/pekwm/config_system.new
config etc/pekwm/keys.new
config etc/pekwm/menu.new
config etc/pekwm/mouse.new
config etc/pekwm/mouse_click.new
config etc/pekwm/mouse_sloppy.new
config etc/pekwm/mouse_system.new
config etc/pekwm/start.new
config etc/pekwm/vars.new

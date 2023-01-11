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

config etc/timidity/eawpats.cfg.new

# if there's no existing timidity.cfg, eawpats takes over.
if [ ! -r etc/timidity/timidity.cfg ]; then
  ( cd etc/timidity ; ln -sf eawpats.cfg timidity.cfg )
fi

# SDL 1.2's SDL_mixer still uses the obsolete location for timidity.cfg:
if [ ! -r etc/timidity.cfg ]; then
  ( cd etc ; ln -sf timidity/eawpats.cfg timidity.cfg )
fi

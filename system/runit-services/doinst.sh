
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

CONF_FILES=$()
while IFS= read -r -d ''; do
  CONF_FILES+=( "$REPLY" )
done < <(find -L etc/sv -type f -name conf.new -print0)

for conf_file in "${CONF_FILES[@]}"; do
  if [ "$conf_file" != '' ]; then
    config "${conf_file}"
  fi
done


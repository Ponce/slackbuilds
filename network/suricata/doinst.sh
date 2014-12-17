config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

CONFIGS="classification.config reference.config suricata.yaml threshold.config"
for file in $CONFIGS; do
    config etc/suricata/${file}.new
done

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

# Keep same perms:
if [ -e etc/httpd/extra/httpd-awstats.conf.new ]; then
  cp -a etc/httpd/extra/httpd-awstats.conf etc/httpd/extra/httpd-awstats.conf.new.incoming
  cat etc/httpd/extra/httpd-awstats.conf.new > etc/httpd/extra/httpd-awstats.conf.new.incoming
  mv etc/httpd/extra/httpd-awstats.conf.new.incoming etc/httpd/extra/httpd-awstats.conf.new
fi

config etc/httpd/extra/httpd-awstats.conf.new
config etc/awstats/awstats.model.conf.new


config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.privoxy.new:
if [ -e etc/rc.d/rc.privoxy ]; then
  cp -a etc/rc.d/rc.privoxy etc/rc.d/rc.privoxy.new.incoming
  cat etc/rc.d/rc.privoxy.new > etc/rc.d/rc.privoxy.new.incoming
  mv etc/rc.d/rc.privoxy.new.incoming etc/rc.d/rc.privoxy.new
else
  # Install executable otherwise - irrelevant unless user starts in rc.local
  chmod 0755 etc/rc.d/rc.privoxy.new
fi

# If there's no existing log file, move this one over; 
# otherwise, kill the new one
if [ ! -e var/log/privoxy/logfile ]; then
  mv var/log/privoxy/logfile.new var/log/privoxy/logfile
else
  rm -f var/log/privoxy/logfile.new
fi

config etc/privoxy/config.new
config etc/privoxy/default.action.new
config etc/privoxy/default.filter.new
config etc/privoxy/match-all.action.new
config etc/privoxy/templates/blocked.new
config etc/privoxy/templates/cgi-error-404.new
config etc/privoxy/templates/cgi-error-bad-param.new
config etc/privoxy/templates/cgi-error-disabled.new
config etc/privoxy/templates/cgi-error-file-read-only.new
config etc/privoxy/templates/cgi-error-file.new
config etc/privoxy/templates/cgi-error-modified.new
config etc/privoxy/templates/cgi-error-parse.new
config etc/privoxy/templates/cgi-style.css.new
config etc/privoxy/templates/connect-failed.new
config etc/privoxy/templates/connection-timeout.new
config etc/privoxy/templates/default.new
config etc/privoxy/templates/edit-actions-add-url-form.new
config etc/privoxy/templates/edit-actions-for-url-filter.new
config etc/privoxy/templates/edit-actions-for-url.new
config etc/privoxy/templates/edit-actions-list-button.new
config etc/privoxy/templates/edit-actions-list-section.new
config etc/privoxy/templates/edit-actions-list-url.new
config etc/privoxy/templates/edit-actions-list.new
config etc/privoxy/templates/edit-actions-remove-url-form.new
config etc/privoxy/templates/edit-actions-url-form.new
config etc/privoxy/templates/forwarding-failed.new
config etc/privoxy/templates/mod-local-help.new
config etc/privoxy/templates/mod-support-and-service.new
config etc/privoxy/templates/mod-title.new
config etc/privoxy/templates/mod-unstable-warning.new
config etc/privoxy/templates/no-server-data.new
config etc/privoxy/templates/no-such-domain.new
config etc/privoxy/templates/show-request.new
config etc/privoxy/templates/show-status-file.new
config etc/privoxy/templates/show-status.new
config etc/privoxy/templates/show-url-info.new
config etc/privoxy/templates/show-version.new
config etc/privoxy/templates/toggle-mini.new
config etc/privoxy/templates/toggle.new
config etc/privoxy/templates/untrusted.new
config etc/privoxy/templates/url-info-osd.xml.new
config etc/privoxy/trust.new
config etc/privoxy/user.action.new
config etc/privoxy/user.filter.new
config etc/rc.d/rc.privoxy.new

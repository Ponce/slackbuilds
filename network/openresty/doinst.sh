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
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

preserve_perms etc/rc.d/rc.openresty.new
config etc/logrotate.d/openresty.new
config etc/openresty/fastcgi_params.new
config etc/openresty/fastcgi.conf.new
config etc/openresty/mime.types.new
config etc/openresty/nginx.conf.new
config etc/openresty/koi-utf.new
config etc/openresty/koi-win.new
config etc/openresty/scgi_params.new
config etc/openresty/uwsgi_params.new
config etc/openresty/win-utf.new

# The gnome-shell doinst.sh script compiles custom gsettings-schemas
# in the location /usr/share/gnome-shell/gsettings-desktop-schemas
#
# The compiled schemas will remain after package removal, so clean
# them up:

GSCHEMA_DIR="/usr/share/gnome-shell/gsettings-desktop-schemas"
if [ -e "$GSCHEMA_DIR" ]; then
  rm -rf "$GSCHEMA_DIR"
fi


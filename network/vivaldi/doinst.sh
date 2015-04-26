set -e

# make links...
ln -sf /opt/vivaldi-snapshot/vivaldi-snapshot /usr/bin/vivaldi-snapshot
ln -sf /opt/vivaldi-snapshot/vivaldi-snapshot /opt/vivaldi-snapshot/vivaldi

# chmod vivaldi_sandbox.
chmod 4755 /opt/vivaldi-snapshot/vivaldi-sandbox

# modify .desktop file.
sed -i 's/TargetEnvironment/X-TargetEnvironment/g' /usr/share/applications/vivaldi-snapshot.desktop

# Add icons to the system icons
XDG_ICON_RESOURCE="`which xdg-icon-resource 2> /dev/null || true`"
if [ ! -x "$XDG_ICON_RESOURCE" ]; then
  echo "Error: Could not find xdg-icon-resource" >&2
  exit 1
fi
for icon in "/opt/vivaldi-snapshot/product_logo_"*.png; do
  size="${icon##*/product_logo_}"
  "$XDG_ICON_RESOURCE" install --novendor --size "${size%.png}" "$icon" "vivaldi-snapshot"
done

# begin SlackBuild options.
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
# end SlackBuild options.

# Updates defaults.list file if present.
update_defaults_list() {
  # $1: name of the .desktop file

  local DEFAULTS_FILE="/usr/share/applications/defaults.list"

  if [ ! -f "${DEFAULTS_FILE}" ]; then
    return
  fi

  # Split key-value pair out of MimeType= line from the .desktop file,
  # then split semicolon-separated list of mime types (they should not contain
  # spaces).
  mime_types="$(grep MimeType= /usr/share/applications/${1} |
                cut -d '=' -f 2- |
                tr ';' ' ')"
  for mime_type in ${mime_types}; do
    if egrep -q "^${mime_type}=" "${DEFAULTS_FILE}"; then
      if ! egrep -q "^${mime_type}=.*${1}" "${DEFAULTS_FILE}"; then
        default_apps="$(grep ${mime_type}= "${DEFAULTS_FILE}" |
                        cut -d '=' -f 2-)"
        egrep -v "^${mime_type}=" "${DEFAULTS_FILE}" > "${DEFAULTS_FILE}.new"
        echo "${mime_type}=${default_apps};${1}" >> "${DEFAULTS_FILE}.new"
        mv "${DEFAULTS_FILE}.new" "${DEFAULTS_FILE}"
      fi
    else
      # If there's no mention of the mime type in the file, add it.
      echo "${mime_type}=${1};" >> "${DEFAULTS_FILE}"
    fi
  done
}

update_defaults_list "vivaldi-snapshot.desktop"

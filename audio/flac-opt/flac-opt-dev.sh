# profile.d script for SBo flac-opt build, WTFPL, B. Watson.

# Note: DO NOT chmod +x this file. It exists to be sourced only when
# actually needed, and can cause problems when not needed.

Ptmp=@LIBDIR@/pkgconfig

if [ -z "$PKG_CONFIG_PATH" ]; then
  PKG_CONFIG_PATH="$Ptmp"
else
  PKG_CONFIG_PATH="$Ptmp:$PKG_CONFIG_PATH"
fi

export PKG_CONFIG_PATH
unset Ptmp

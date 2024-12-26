###########################
# Remove library symlinks #
###########################
case "$( uname -m )" in
  x86_64) LIBDIRSUFFIX="64" ;;
  *) LIBDIRSUFFIX="" ;;
esac

( cd /usr/lib${LIBDIRSUFFIX}/sane && unlink libsane-brother4.so.1 )
( cd /usr/lib${LIBDIRSUFFIX}/sane && unlink libsane-brother4.so )

################################################
# Remove "brother4" entry from SANE's dll.conf #
################################################
# inspired by Void Linux's brother-brscan4/REMOVE
readonly _TMP_FILE="$(mktemp sane_dll_conf_XXXXXXXXXXX)"
readonly _SANE_CONF=/etc/sane.d/dll.conf
readonly _ENTRY=brother4
if cat "${_SANE_CONF}" | sed -e "/${_ENTRY}/d" > "${_TMP_FILE}"
then
    cat "${_TMP_FILE}" > "${_SANE_CONF}"
fi
rm "${_TMP_FILE}"

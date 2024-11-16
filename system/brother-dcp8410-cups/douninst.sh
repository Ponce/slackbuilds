case "$( uname -m )" in
  x86_64|aarch64) LIBDIRSUFFIX="64" ;;
  *) LIBDIRSUFFIX="" ;;
esac

( cd /usr/lib${LIBDIRSUFFIX}/cups/filter && unlink brother_lpdwrapper_dcpl8410cdw )
( cd /usr/share/cups/model && unlink brother_dcpl8410cdw_printer_en.ppd )

case "$( uname -m )" in
  x86_64|aarch64) LIBDIRSUFFIX="64" ;;
  *) LIBDIRSUFFIX="" ;;
esac

( cd /usr/lib${LIBDIRSUFFIX}/cups/filter && rm -rf brother_lpdwrapper_dcpl8410cdw )
( cd /usr/lib${LIBDIRSUFFIX}/cups/filter && ln -sf /opt/brother/Printers/dcpl8410cdw/cupswrapper/brother_lpdwrapper_dcpl8410cdw )

( cd usr/share/cups/model && rm -rf brother_dcpl8410cdw_printer_en.ppd )
( cd usr/share/cups/model && ln -sf /opt/brother/Printers/dcpl8410cdw/cupswrapper/brother_dcpl8410cdw_printer_en.ppd )

( cd usr/libSUFFIX/xorg/modules/extensions
  if [ -f libglx.so-xorg ]; then
    mv libglx.so-xorg libglx.so
  else
    if [ ! -e libglx.so ]; then
      echo -e "WARNING: libglx.so not found!  Please reinstall xorg-server!\n"
    fi
  fi
  )
echo "The Nvidia legacy390 driver is removed.  Make sure the Nvidia driver is"
echo "DISABLED in /etc/X11/xorg.conf as well as /etc/X11/xorg.conf.d/ and"
echo "/usr/share/X11/xorg.conf.d/.  Otherwise, this may lead to improperly"
echo -e "working drivers.\n"


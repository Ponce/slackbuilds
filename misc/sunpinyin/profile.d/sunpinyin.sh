#!/bin/sh

# SunPinyin is a statistical language model based Chinese input method, which
# was firstly developed by Sun Beijing Globalization team.

if [ -x /usr/bin/xsunpinyin ]; then
  # Enable legacy X applications to use sunpinyin:
  export XMODIFIERS="@im=xsunpinyin"
  # Enable Qt/KDE applications to use sunpinyin.
  export QT_IM_MODULE=XIM
  # Enable GTK applications to use sunpinyin:
  export GTK_IM_MODULE=XIM
  # Make sunpinyin start automatically if the "magic key" Ctrl-Space is pressed:
  export XIM_PROGRAM="/usr/bin/xsunpinyin -d"
fi


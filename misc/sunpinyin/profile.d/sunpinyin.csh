#!/bin/csh

# SunPinyin is a statistical language model based Chinese input method, which
# was firstly developed by Sun Beijing Globalization team.

[ -x /usr/bin/xsunpinyin ]
if ($status == 0) then
  # Enable legacy X applications to use sunpinyin:
  setenv XMODIFIERS="@im=xsunpinyin"
  # Enable Qt/KDE applications to use sunpinyin.
  setenv QT_IM_MODULE="XIM"
  # Enable GTK applications to use sunpinyin:
  setenv GTK_IM_MODULE="XIM"
  # Make sunpinyin start automatically if the "magic key" Ctrl-Space is pressed:
  setenv XIM_PROGRAM="/usr/bin/xsunpinyin -d"
endif


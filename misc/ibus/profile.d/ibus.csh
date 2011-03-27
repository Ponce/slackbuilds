#!/bin/csh

# ibus - Intelligent Input Bus for Linux / Unix OS. This is used to support the
# entering of text in non-US-English languages.

[ -x /usr/bin/ibus-daemon ]
if ($status == 0) then
  # Enable legacy X applications to use ibus:
  setenv XMODIFIERS "@im=ibus"
  # Enable Qt/KDE applications to use ibus.
  setenv QT_IM_MODULE "ibus"
  # Enable GTK applications to use ibus:
  setenv GTK_IM_MODULE "ibus"
  # Make ibus start automatically if the "magic key" Ctrl-Space is pressed:
  setenv XIM_PROGRAM "/usr/bin/ibus-daemon -xdrt"
endif


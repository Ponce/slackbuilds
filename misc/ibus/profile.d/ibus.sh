#!/bin/sh

# ibus - Intelligent Input Bus for Linux / Unix OS. This is used to support the
# entering of text in non-US-English languages.

if [ -x /usr/bin/ibus-daemon ]; then
  # Enable legacy X applications to use ibus:
  export XMODIFIERS="@im=ibus"
  # Enable Qt/KDE applications to use ibus.
  export QT_IM_MODULE="ibus"
  # Enable GTK applications to use ibus:
  export GTK_IM_MODULE="ibus"
  # Make ibus start automatically if the "magic key" Ctrl-Space is pressed:
  export XIM_PROGRAM="/usr/bin/ibus-daemon -xdrt"
fi


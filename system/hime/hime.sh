#!/bin/sh

# hime-ime is a chinese-input-method.

if [ -x /usr/bin/hime ]; then
  export XMODIFIERS="@im=hime"
  export GTK_IM_MODULE="hime"
  export QT_IM_MODULE="hime"
  export XIM_PROGRAM="/usr/bin/hime -d"
fi

# /usr/bin/hime -d &

#!/bin/csh

# hime-ime is a chinese-input-method.

[ -x /usr/bin/hime ]
if ($status == 0) then
  setenv XMODIFIERS "@im=hime"
  setenv GTK_IM_MODULE "hime"
  setenv QT_IM_MODULE "hime"
  setenv XIM_PROGRAM "/usr/bin/hime -d"
endif

#  /usr/bin/hime -d &

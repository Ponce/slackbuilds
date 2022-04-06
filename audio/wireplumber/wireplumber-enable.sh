#!/bin/bash
# Copyright 2022  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This script will attempt to enable wireplumber as the default media session server.

# Condition: check if pipewire is enabled
if [ -f /etc/xdg/autostart/pipewire.desktop ] ; then

  # Rename the XDG autostart files:
  for file in /etc/xdg/autostart/wireplumber.desktop.sample ; do
    if [ -r $file ]; then
      mv $file /etc/xdg/autostart/$(basename $file .sample)
    fi
  done

  # Disable pipewire-media-session.desktop:
  if ! grep -q "^Hidden=true$" /etc/xdg/autostart/pipewire-media-session.desktop ; then
    echo "Hidden=true" >> /etc/xdg/autostart/pipewire-media-session.desktop
  fi
  echo "Wireplumber enabled as system media session server."
else
  echo "Pipewire is disabled"
  echo "you must enable pipewire first : /usr/sbin/pipewire-enable.sh"
fi

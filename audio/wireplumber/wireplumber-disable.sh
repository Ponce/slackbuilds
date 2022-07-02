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

# This script will attempt to disable pipewire as the default audio server,
# changing it back to pulseaudio.

# Remove or rename the XDG autostart files:
for file in /etc/xdg/autostart/wireplumber.desktop ; do
  if [ -r ${file}.sample ]; then
    rm -f $file
  elif [ -r $file ]; then
    mv ${file} ${file}.sample
  fi
done

# Condition: check if pipewire is enabled
if [ -f /etc/xdg/autostart/pipewire.desktop ] ; then
  # Enable pipewire-media-session.desktop:
  if grep -q "^Hidden=true$" /etc/xdg/autostart/pipewire-media-session.desktop ; then
    grep -v "^Hidden=true$" /etc/xdg/autostart/pipewire-media-session.desktop > /etc/xdg/autostart/pipewire-media-session.desktop.new
    mv /etc/xdg/autostart/pipewire-media-session.desktop.new /etc/xdg/autostart/pipewire-media-session.desktop
  fi

  echo "Pipewire Media Session enabled as media session server."
  if ps ax | grep -q wireplumber ; then
    echo
    echo "You may need to stop running daemon/wireplumber processes."
    echo "The clean way is to run these commands as the user that owns the processes:"
    echo "/usr/bin/daemon --pidfiles=~/.run --name=wireplumber --stop"
    echo
    echo "The quick and dirty way if nothing else on the machine is using the daemon"
    echo "utility is to issue this command:"
    echo "killall daemon"
  fi
fi


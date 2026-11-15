xroar supports multiple audio systems and has support for both Gtk+2
and Gtk+3, as well as SDL 2 and SDL 3.

This SlackBuild only builds the Gtk+3 and SDL 2 or 3 user
interfaces. There are no longer any options to build with Gtk+2, and
SDL 1 support was dropped by upstream.

By default, support for SDL 2, PulseAudio, and plain ALSA audio are
built. For most users, these defaults are just fine. If you have
different needs, read on.


Optional Dependencies
=====================

SDL3 - If you want to use SDL 3, install SDL3 and set SDL3=yes
  in the environment before building xroar.

jack - If you want to use JACK for audio output, install jack and set
  JACK=yes in the environment before building xroar. If JACK audio has
  x-runs, try:

  # setcap cap_ipc_lock,cap_sys_nice=ep /usr/games/xroar

  If you don't know what jack is, or why you might want to use it, then
  you don't want it.


Environment Variables
=====================

SDL3 - see above. Default: no. Most users won't need this.

JACK - see above. Default: no. Most users won't need this.

OSS - use OSS for audio? Default is "no", export OSS="yes" to enable.
  Most users won't need this.

PULSE - use PulseAudio? Default is "yes", export PULSE="no" to disable.
  Most users won't need this.

There is no environment variable for ALSA audio. It's is always enabled.

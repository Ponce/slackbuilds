xroar supports multiple audio systems and has support for both Gtk+2
and Gtk+3, as well as SDL 1.x and SDL 2.x.

This SlackBuild only builds the Gtk+3 and SDL 2 user interfaces. There
are no longer any options to build with Gtk+2 or SDL 1.

By default, support for PulseAudio and plain ALSA audio are built. For
most users, these defaults are just fine. If you have different needs,
read on.


Optional Dependencies
=====================

jack - If you want to use JACK for audio output, install jack and set
  JACK=yes in the environment before building xroar. If JACK audio has
  x-runs, try:

  # setcap cap_ipc_lock,cap_sys_nice=ep /usr/games/xroar

  If you don't know what jack is, or why you might want to use it, then
  you don't want it.


Environment Variables
=====================

JACK - see above. Default: no. Most users won't need this.

OSS - use OSS for audio? Default is "no", export OSS="yes" to enable.
  Most users won't need this.

PULSE - use PulseAudio? Default is "yes", export PULSE="no" to disable.
  Most users won't need this.

ALSA audio is always enabled.

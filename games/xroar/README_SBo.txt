Optional Dependencies
=====================

SDL2 - If this is installed, xroar's alternate "bare-bones" SDL2
  user inteface will be available via the "-ui sdl" option.

jack - if you want to use JACK for audio output, install jack and set
  JACK=yes in the environment before building xroar. If JACK audio has
  x-runs, try 'setcap cap_ipc_lock,cap_sys_nice=ep /usr/games/xroar'.


Environment Variables
=====================

GTKGLEXT - If you have gtkglext installed, but don't want to build
  xroar with it, export GTKGLEXT=no [1] [2].

SDL2 - If you have SDL2 installed, but don't want to build xroar with
 it, export SDL2=no [2].

OSS - use OSS for audio? Default is "no", export OSS="yes" to enable.
  Most users won't need this.

PULSE - use PulseAudio? Default is "yes", export PULSE="no" to disable.


Notes
=====

[1]: Yes, gtkglext is optional, despite being listed in REQUIRES in
     the .info file. There's no "either-or" syntax for REQUIRES, so
     I had to list either gtkglext or SDL2, and the gtkglext UI
     is a lot nicer so it's what most people will want.

[2]: At least one of SDL2 or gtkglext is required, so you can't build
     with SDL2=no GTKGLEXT=no. If you want to be super-pedantic, yes,
     it *is* possible to build xroar without either gtkglext or SDL2,
     but the result is that xroar won't display anything at all. This
     is useless and confusing, nobody wants it, and I'm not willing to
     support it.

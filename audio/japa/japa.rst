.. RST source for japa(1) man page. Convert with:
..   rst2man.py japa.rst > japa.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.9.2
.. |date| date::

====
japa
====

----------------------------
JACK and ALSA Audio Analyser
----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

japa **-J** [**-name** *name* ] [**-s** *server*]

japa **-A** [**-name** *name* ] [**-d** *device*] [**-C** *device* ] [**-P** *device* ] [**-r** *rate*] [**-p** *period*] [**-n** *nfrags*]

DESCRIPTION
===========

japa (JACK and ALSA Perceptual Analyser), is a 'perceptual'
or 'psychoacoustic' audio spectrum analyser. In contrast to
JAAA, this is more an acoustical or musical tool than a purely
technical one. Possible uses include spectrum monitoring while
mixing or mastering, evaluation of ambient noise, and (using
pink noise), equalisation of PA systems. For more information see
/usr/doc/japa-|version|/README.

In JACK mode (**-J**), japa creates 4 input ports (for spectrum
analysis), named *japa:in_<N>* (where *<N>* ranges 1 to 4) and
2 output ports (for noise generation), named *japa:pink* and
*japa:white*. By default, these aren't connected to anything; use
e.g. **qjackctl**\(1) or **jack_connect**\(1) to connect to other JACK
clients.

In ALSA mode, the inputs and outputs are connected directly to the
ALSA device, meaning e.g. there will be 2 inputs and 2 outputs for
a typical stereo audio card. Yes, this means the pink and white
noise generators will be heard immediately on starting up japa;
if you don't need them you can silence them with e.g. **-C hw:0 -P
null**. If you get "Can't connect to ALSA", try a different device
(use **alsamixer**\(1) or **aplay**\(1) to get a list of them).

OPTIONS
=======

Either **-J** or **-A** is required.

**-h**
  Show built-in help message.

**-name** *name*
  Set X11 client name (and JACK client name, with **-J**).

**-J**
  Use JACK for audio. This option is available in JACK mode:

  **-s** *server*
    Connect to a specific JACK server. Default is 'default' or
    **$JACK_DEFAULT_SERVER** environment variable.

**-A**
  Use ALSA for audio. These options are available in ALSA mode:

  **-d** *device*
    ALSA device for capture and playback. This option sets the
    playback and capture devices to the same device. For separate
    capture and playback, use the **-C** and **-P** options.
    Default: **hw:0** unless **-C** or **-P** is used.

  **-C** *device*
    ALSA device for capture. Default: not used.

  **-P** *device*
    ALSA device for playback. Default: not used.

  **-r** *rate*
    Sample frequency. Default: 48000.

  **-p** *period*
    Period size. Default: 1024.

  **-n** *nfrags*
    Number of fragments. Default: 2.

COPYRIGHT
=========

See the file /usr/doc/japa-|version|/COPYING for license information.

AUTHORS
=======

japa was written by Fons Adriaensen <fons@kokkinizita.net>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jackd**\(1), **jaaa**\(1)

https://kokkinizita.linuxaudio.org/linuxaudio/

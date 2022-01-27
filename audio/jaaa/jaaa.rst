.. RST source for jaaa(1) man page. Convert with:
..   rst2man.py jaaa.rst > jaaa.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.9.2
.. |date| date::

====
jaaa
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

jaaa **-J** [**-name** *name* ] [**-s** *server*]

jaaa **-A** [**-name** *name* ] [**-d** *device*] [**-C** *device* ] [**-P** *device* ] [**-r** *rate*] [**-p** *period*] [**-n** *nfrags*]

DESCRIPTION
===========

jaaa is a graphical (X11) audio signal generator and spectrum analyser
designed to make accurate measurements. For more information see
/usr/doc/jaaa-|version|/README.

In JACK mode (**-J**), jaaa creates 8 input ports (for spectrum
analysis) and 8 output ports (for signal generation), named
*jaaa:in_<N>* and *jaaa:out_<N>* (where *<N>* ranges 1 to 8). By default,
these aren't connected to anything; use e.g. **qjackctl**\(1) or
**jack_connect**\(1) to connect to other JACK clients.

In ALSA mode, the inputs and outputs are connected directly to the
ALSA device, meaning e.g. there will be 2 inputs and 2 outputs for a
typical stereo audio card. If you get "Can't connect to ALSA", try a
different device (use **alsamixer**\(1) or **aplay**\(1) to get a list
of them).

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

See the file /usr/doc/jaaa-|version|/COPYING for license information.

AUTHORS
=======

jaaa was written by Fons Adriaensen <fons@kokkinizita.net>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jackd**\(1), **japa**\(1)

https://kokkinizita.linuxaudio.org/linuxaudio/

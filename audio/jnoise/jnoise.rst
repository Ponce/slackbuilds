.. RST source for jnoise(1) man page. Convert with:
..   rst2man.py jnoise.rst > jnoise.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6.0
.. |date| date::

======
jnoise
======

---------------------------------------
white and pink noise generator for JACK
---------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

jnoise

jnoise *gain*

DESCRIPTION
===========

Jnoise is a small command line JACK app generating both white and pink
noise. Both noise sources produce a Gaussian amplitude distribution,
and by default output a signal at -20dB RMS ref. a full scale sine
wave.

jnoise creates two JACK ports: *jnoise:pink* and *jnoise:white*. These
are not connected to anything by default; use **qjackctl**\(1) or
**jack_connect**\(1) to connect them to e.g. *system:playback_1*
and/or *system:playback_2*, or your DAW's input ports, etc.

The default gain is -20dB. The optional *gain* argument must be a
negative integer, and will set the gain in dB up to a maximum of
-10.

There are no other options or arguments.

COPYRIGHT
=========

See the file /usr/doc/jnoise-|version|/COPYING for license information.

AUTHORS
=======

jnoise was written by Fons Adriaensen <fons@kokkinizita.org>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jackd**\(1)

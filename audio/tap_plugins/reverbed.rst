.. RST source for reverbed(1) man page. Convert with:
..   rst2man.py reverbed.rst > reverbed.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: r0
.. |date| date::

========
reverbed
========

-------------------------------------------
reverb (room acoustics simulation) for JACK
-------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

reverbed [**-a** | **-i** | **-o**] [**-c** *client_name*]

DESCRIPTION
===========

**reverbed**, aka TAP Reverb Editor, is a standalone JACK application
that implements a reverb effect, with graphical interface to allow
changing parameters on the fly.

**reverbed** creates two JACK inputs and two JACK outputs, which must
be connected to other JACK inputs/outputs in order to route audio
through the application. By default, these aren't connected to anything
at startup, but see the options below.

OPTIONS
=======

**-i**
  Autoconnect JACK inputs to the first two hardware capture ports.

**-o**
  Autoconnect JACK outputs to the first two hardware playback ports.

**-a**
  Autoconnect both input and output ports (same as **-i** **-o**).

**-c** *client_name*
  Use **client_name** instead of the default *reverbED* when
  connecting to JACK. You need this option if you want to run more
  than one instance of the program at the same time, since JACK
  client programs must have unique client names.

FILES
=====

**$HOME/.reverbed**
  Presets are loaded from here at startup, if this file exists.

**/etc/reverbed/reverbed.conf**
  Presets are loaded from here if **$HOME/.reverbed** doesn't exist.

COPYRIGHT
=========

See the file /usr/doc/tap_plugins-1.0.1/COPYING for license information.

AUTHORS
=======

reverbed was written by Tom Szilagyi.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The user manual for reverbed:

*/usr/doc/tap_plugins-1.0.1/tap-plugins-doc-20140526/reverbed/manual.html*

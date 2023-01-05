.. RST source for envision(1) man page. Convert with:
..   rst2man.py envision.rst > envision.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.9
.. |date| date::

========
envision
========

---------------------------------
Atari 8-bit graphics editing tool
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

envision [**-f** | **-full**] [**-z** *factor* | **-zoom** *factor*]

DESCRIPTION
===========

**envision** is a font/map editing program similar to the old APX
Envision program on the Atari 8-bits.

It is a full-featured character editor and map-maker. It supports both
native files and .XFD disk images. It is mouse based, and includes all
the standard editing methods (flips, fills, rotates, invert, etc).

This man page doesn't explain how to actually use **envision**. For that,
see the full documentation: /usr/doc/envision-|version|/envision.txt

OPTIONS
=======

**-f**, **-full**
  Runs **envision** in full-screen mode. You can also toggle fullscreen
  by pressing Ctrl-Enter.

**-z** *factor*, **-zoom** *factor*
  Set the zoom level (2 to 8). This is multiplied by 320x200. The default
  is 3, which gives a 960x600 display. For 1080p displays, try **-z 5**.
  For 4k, try 7 or 8. The window isn't actually resizable after the
  application starts...

AUTHORS
=======

envision was written by Mark Schmelzenbach.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The envision homepage: https://atari.miribilist.com/envision/index.html

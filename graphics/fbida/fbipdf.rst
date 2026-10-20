.. RST source for fbipdf(1) man page. Convert with:
..   rst2man.py fbipdf.rst > fbipdf.1

.. |version| replace:: 2.15_1
.. |date| date::

======
fbipdf
======

--------------------------------------
display PDF files in the Linux console
--------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

fbipdf [*-i* | *-info*]

fbipdf [*-options*] **pdf-file**

DESCRIPTION
===========

This program displays PDF files using the Linux fbdev or drm device.
It's much faster and more user-friendly than **fbgs**, but lacks support
for PostScript files.

**fbipdf** is part of the **fbida** suite. Its original name was
**fbpdf**, but it's been renamed (for this SlackBuilds.org package)
to **fbipdf** since there's another **fbpdf** in the SBo repo.

OPTIONS
=======

**-h**, **-help**
  Print help text and exit.

**-V**, **-version**
  Print version number and exit.

**-i**, **-info**
  Print device info and exit.

**-store**
  Write command line arguments to config file. *NOTE*: this option
  doesn't seem to actually work.

**-w**, **-fitwidth**
  Fit page width to screen [default: on].

**-nofitwidth**
  Don't fit page width on screen.

**-d**, **-device** *<arg>*
  Use framebuffer/drm device *<arg>*.

**-o**, **-output** *<arg>*
  Use drm output *<arg>* (try **-info** for a list).

**-pageflip**
  Use pageflip (drm only).

**-nopageflip**
  Don't use pageflip (drm only).

**-m**, **-mode** *<arg>*
  Use video mode *<arg>* (from /etc/fb.modes).

**-libinput**
  Use libinput (experimental; default off).

**-nolibinput**
  Don't use libinput.

FILES
=====

**~/.fbpdf.rc**
    Config file created by **-store** option. *NOTE*: this doesn't
    seem to actually work.

COPYRIGHT
=========

See the file /usr/doc/fbida-|version|/COPYING for license information.

AUTHORS
=======

fbipdf was written by Gerd Knorr <gerd@kraxel.org>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

fbi(1), ida(1), exiftran(1), fbgs(1)

The fbida homepage: https://gitlab.com/kraxel/fbida/

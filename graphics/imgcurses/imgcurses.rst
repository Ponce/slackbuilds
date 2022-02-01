.. RST source for imgcurses(1) man page. Convert with:
..   rst2man.py imgcurses.rst > imgcurses.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20151107_de613ca
.. |date| date::

=========
imgcurses
=========

----------------------------
character-based image viewer
----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

imgcurses *filename*

DESCRIPTION
===========

**imgcurses** is a smart console-based image viewer, using color ASCII art.

**imgcurses** supports TGA, PNG, and JPEG images. Images are scaled to fit
the terminal size.

CONTROLS
========

**[**
  Zoom out.

**]**
  Zoom in.

**Arrow Keys**
  Scroll.

**m**
  Change mode (solid, value, color, detail).

**q**
  Quit.

COPYRIGHT
=========

See the file /usr/doc/imgcurses-|version|/LICENSE.md for license information.

AUTHORS
=======

imgcurses was written by Daniel Holden.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The imgcurses homepage: https://github.com/orangeduck/imgcurses

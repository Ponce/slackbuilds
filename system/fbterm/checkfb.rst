.. RST source for checkfb(1) man page. Convert with:
..   rst2man.py checkfb.rst > checkfb.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: SBo
.. |date| date::


=======
checkfb
=======

-----------------------------------------------
check for the existence of a framebuffer device
-----------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

checkfb <[*device*]>

DESCRIPTION
===========

checkfb attempts to open the Linux framebuffer device read-only. If successful,
it reports the display resolution and bit depth.

By default, it opens **/dev/fb0**. The *device* option overrides this.

There are no options.

EXIT STATUS
===========

0 (success) if the framebuffer exists and can be opened.

Non-zero means failure: the device doesn't exist, the permissions
don't allow opening it, or possibly the kernel doesn't support
framebuffer devices at all.

EXAMPLES
========

::

  # checkfb
  The framebuffer device (/dev/fb0) was opened successfully.
  1920x1080, 32bpp
  The framebuffer device was mapped to memory successfully.

COPYRIGHT
=========

checkfb is released under the GPL (according to the comments in its source).

AUTHORS
=======

checkfb was originally written by Trolltech, and was modified by
Sébastien Ballet.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

fbset(8)

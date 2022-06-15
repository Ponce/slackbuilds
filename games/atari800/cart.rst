.. RST source for cart(1) man page. Convert with:
..   rst2man.py cart.rst > cart.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 5.0.0
.. |date| date::

====
cart
====

----------------------------------------------------------
convert raw Atari 8-bit ROM images to Atari800 CART files.
----------------------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

cart *romfile* *cartfile* *carttype*

cart **-l**

cart **-p** *romfile*

DESCRIPTION
===========

**cart** creates an Atari800 CART image file from a raw Atari 8-bit ROM
image file by adding a 16-byte **CART** header.

The *romfile* is a file containing a raw Atari 8-bit ROM image
dump. It must be of the correct size for the *carttype* argument
(e.g. for type 1, "Standard 8KB cartridge", the file must be exactly
8192 bytes).

Output is written to *cartfile*. This must be a different filename
from *romfile* (in-place conversion is not supported). *cartfile* will
be exactly 16 bytes longer than *romfile* (e.g. for type 1, it will be
8208 bytes).

The *carttype* argument is numeric, one of the supported types. The
list can be viewed with **cart -l**. If you're not sure of the correct
type for a given ROM, you can narrow it down by running **cart -p**
*romfile*, which will show all the possible types that match the size
of the ROM.

There is no corresponding tool to convert a CART image back to a raw
ROM file, but this can be done with e.g. **dd**\(1)::

  dd if=image.cart of=image.raw bs=1 skip=16

...or **head**\(1) and **cat**\(1)::

  cat image.cart | ( head -c16 >/dev/null ; cat ) > image.raw

OPTIONS
=======

-l    Show the complete list of supported cartridge types.

-p *romfile*
      Show the list of cartridge types that match the size of *romfile*.

COPYRIGHT
=========

See the file /usr/doc/atari800-|version|/COPYING for license information.

AUTHORS
=======

**cart** is part of the **atari800**\(6) distribution. See
/usr/doc/atari800-|version|/CREDITS for the list of authors.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**atari800**\(6)

Full documentation for the CART file format:
  /usr/doc/atari800-|version|/cart.txt

The **atari800** website:
  https://atari800.github.io/

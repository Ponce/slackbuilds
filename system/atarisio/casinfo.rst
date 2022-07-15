.. RST source for casinfo(1) man page. Convert with:
..   rst2man.py casinfo.rst > casinfo.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.30-210714
.. |date| date::

=======
casinfo
=======

--------------------------------------------
print info about Atari 8-bit cassette images
--------------------------------------------

:Manual section: 1
:Manual group: HiassofT Atari 8-bit Tools
:Date: |date|
:Version: |version|

SYNOPSIS
========

casinfo **file**

DESCRIPTION
===========

**casinfo** reads an Atari 8-bit cassette image (aka CAS file) and prints
the following information:

  - Description
  - Number of Parts (aka Stages or Files)
  - Number of Blocks
  - The metadata for each block:

    - Block Number
    - Record Type (data or fsk)
    - Part (0 for the first file/stage, 1 for the 2nd, etc)
    - Baud (bits/sec; normally 600)
    - Gap aka PRWT (Pre-Record Write Tone, in milliseconds)
    - Block length in bytes (normally 132)

If an invalid file (not a CAS image) is given, **casinfo** will print
**Error: "file" doesn't start with FUJI header** to stderr, then
exit. Beware that the exit status is always 0 (success), so a script
would have to capture and parse stderr to catch errors.

EXAMPLE
=======

::

   $ casinfo test.cas
   casinfo 0.30-210714 (c) 2007-2010 Matthias Reichl
   infos for "test.cas":
   Description: <none>
   Number of Parts: 1
   Number of Blocks: 3
      0:  data part:  0  baud:   600  gap: 25647  length:   132
      1:  data part:  0  baud:   600  gap:   252  length:   132
      2:  data part:  0  baud:   600  gap:   254  length:   132

AUTHOR
======

Matthias Reichl <hias@horus.com>.

Man page by B. Watson <urchlay@urchlay.com>.

SEE ALSO
========

**atariserver**\(1), **atarixfer**\(1), **dir2atr**\(1), **adir**\(1), **ataricom**\(1).

AtariSIO home page: https://www.horus.com/~hias/atari/

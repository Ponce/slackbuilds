.. RST source for ataricom(1) man page. Convert with:
..   rst2man.py ataricom.rst > ataricom.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.30-210714
.. |date| date::

========
ataricom
========

-----------------------------------------------------
utility for manipulating Atari 8-bit executable files
-----------------------------------------------------

:Manual section: 1
:Manual group: HiassofT Atari 8-bit Tools
:Date: |date|
:Version: |version|

SYNOPSIS
========

ataricom [*options*]... **file** [**outfile**]

DESCRIPTION
===========

ataricom performs various useful operations on Atari 8-bit executable
files. These files are also known as binary load files, or COM, BIN,
XEX, OBJ, OBX, et al. These are only names; there is only one Atari
8-bit executable file format.

OPTIONS
=======

-c address
      create COM file from raw data file.

-e
      extract blocks to outfileBBBB.ext.

-E
      extract blocks to outfileBBBB_SADR_EADR.ext.

-r address
      add RUN block with specified address at end of file.

-i address
      add INIT block with specified address at end of file.

-b start[-end][,...]
      only process specified blocks.

-x start[-end][,...]
      exclude specified blocks.

-m start-end[,...]
      merge specified blocks.

-s block,adr...
      split block at given addresses.

-n
      write raw data blocks (no COM headers).

-X
      show block length and file offset in hex.

AUTHOR
======

Matthias Reichl <hias@horus.com>.

Man page by B. Watson <urchlay@urchlay.com>.

SEE ALSO
========

**atariserver**\(1), **atarixfer**\(1), **dir2atr**\(1), **adir**\(1), **casinfo**\(1).

AtariSIO home page: https://www.horus.com/~hias/atari/

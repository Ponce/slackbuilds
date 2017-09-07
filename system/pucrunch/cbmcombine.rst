.. RST source for cbmcombine(1) man page. Convert with:
..   rst2man.py cbmcombine.rst > cbmcombine.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20081122
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

==========
cbmcombine
==========

------------------------------------
combines Commodore 8-bit executables
------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

cbmcombine [*input-file[,load-address]*] [[[*input-file[,load-address]*]] ...]

DESCRIPTION
===========

cbmcombine combines several Commodore executables into one. All Commodore
8-bit machines (64, 128, VIC-20, Plus4, 16, PET, etc) are supported,
since they all use the same executable file format.

Files are read in the order listed on the command line. The combined
executable is written to standard output. Each file's load address can
be forced by adding a comma and the new address (in decimal, or in hex
with 0x prefix), in which case the load address in the file will be read
and ignored.

If any of the input files overlap the same area of memory, the overlap
area will contain only data from the file(s) listed later in the command
line. The output file's load address will be that of the input file with
the lowest address, and it will extend to the highest address contained
in any of the files. If there are gaps in the address space (areas where
no file was loaded), the output will contain 0x00 bytes to fill the gap.

Load address overrides do NOT relocate code.

There are no switches (options) for cbmcombine.

EXAMPLES
========

The examples use 1024 byte input files, named after their load addresses
in hex:

x1000.prg   Load address **$1000**, last address **$13FF**

x1400.prg   Load address **$1400**, last address **$17FF**

x1600.prg   Load address **$1600**, last address **$19FF**

cmbcombine x1000.prg x1400.prg > new.prg

  new.prg will have a load address of 0x1000, and contain data from
  0x1000 to 0x17ff.  Since x1000.prg ends at address 0x13ff, there is
  no overlap. If the order of arguments were swapped, the result would
  be the same.

cmbcombine x1000.prg x1600.prg > new.prg

  new.prg's load address will be **$1000**, and its end address will be **$19FF**.
  From **$1400** to **$15FF**, it will contain 512 bytes of zeroes, since none
  of the input files had any data at these addresses. If the order were
  swapped, the result would be the same.

cmbcombine x1400.prg x1600.prg > new.prg

  new.prg's load address will be **$1400** and it will end at **$19FF**. The
  data from **$1400** to **$15FF** comes from x1400.prg, and the rest from x1600.prg.

cmbcombine x1600.prg x1400.prg > new.prg

  As above, but data at **$1400** to **$15FF** comes from x1400.prg.

cmbcombine x1400.prg x1600.prg,0x1800 > new.prg

  new.prg loads at **$1400** and extends to **$1BFF**. Data at **$1400** to
  **$17FF** comes from x1400.prg, data at **$1800** to **$1BFF** comes from
  x1600.prg. If x1600.prg contains non-relocatable code org'ed at **$1600**,
  it will fail to run when loaded at **$1800**.

EXIT STATUS
===========

0 for success, non-zero for failure. If any of the input files can't be
read, the process exits with failure status, without writing anything
to standard output.

BUGS
====

There is very little error-checking. It may be possible to crash
cbmcombine by feeding it bogus input.

There's no way to give cbmcombine a filename containing a comma.

Not exactly bugs, per se, but missing features:

  The user should be notified if files overlap and/or there are gaps in
  the output.

  There should be warnings if a file wraps around the top of the 64K address
  space, or loads into dangerous or invalid areas such as ROM or page zero.
  Odds are, the file isn't really a valid CBM executable.

  There should be a cbmsplit utility that does the opposite of cbmcombine.

COPYRIGHT
=========

As of 21.12.2005 Pucrunch is under GNU LGPL. See\:

  http://creativecommons.org/licenses/LGPL/2.1/
  http://www.gnu.org/copyleft/lesser.html

AUTHORS
=======

cbmcombine was written by Pasi Ojala <a1bert@iki.fi>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

pucrunch(1), exomizer(1), vice(1)

The pucrunch homepage: http://a1bert.kapsi.fi/Dev/pucrunch/

The full documentation and sample decompressor code\:

  /usr/doc/pucrunch-|version|/

.. RST source for fasm(1) man page. Convert with:
..   rst2man.py fasm.rst > fasm.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.73.29
.. |date| date::

====
fasm
====

---------------------------------------------------
fast assembler for the x86 and x86-64 architectures
---------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

fasm [**-d** *name=value* ...] [**-m** *mem-limit*] [**-p** *pass-limit*] [**-s** *symbol-file*] *source-file* [*output-file*]

DESCRIPTION
===========

**fasm** (aka flat assembler) is a fast assembler for the x86 and
x86-64 architectures.  When executed, it will assemble the given
source file.

If no *output-file* is given, the output filename will be the
*source-file* name with the extension replaced with *.o*.

OPTIONS
=======

The space between an option and its argument is optional (**-m10** and
**-m 10** are both acceptable).

**-d** *name=value*
  Predefine a symbol (variable). May be given multiple times, as needed.

**-m** *mem-limit*
  Set the limit in *1024-byte* kilobytes for the amount of memory **fasm** can
  use. If the limit is exceeded, **fasm** will exit with an "out of
  memory" error and nonzero exit status. Default is 16384 (aka 16MB),
  minimum is 1, maximum allowed is 4194303 (~4GB)... but values ~4000000 and up
  can cause **fasm** to segfault.

**-p** *pass-limit*
  Set the maximum number of passes **fasm** will make over the source. Default
  is 100; maximum is 65536.

**-s** *symbol-file*
  Dump symbolic information for debugging to *symbol-file*. This file
  can be processed with the **listing**, **symbols**, or **prepsrc** tools:
  see /usr/doc/fasm-|version|/tools-readme.txt for details.

EXIT STATUS
===========

Zero for successful completion, 1 for invalid command-line option(s),
or non-zero (apparently always 255) for any fatal assembly error.

COPYRIGHT
=========

See the file /usr/doc/fasm-|version|/license.txt for license information.

AUTHORS
=======

**fasm** was written by Tomasz Grysztar.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The full documentation: /usr/doc/fasm-|version|/fasm.txt

The fasm homepage: https://flatassembler.net

.. RST source for ophis(1) man page. Convert with:
..   rst2man.py ophis.rst > ophis.1

.. |version| replace:: 2.2
.. |date| date::

=====
ophis
=====

---------------------------------------------
cross assembler for the 6502 and related CPUs
---------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ophis [**-o** *OUTFILE*] [**-l** *LISTFILE*] [**-m** *MAPFILE*] [**-u** | **--undoc**] [**-c** | **--65c02**] [**-4** | **--4502**] [**-v** | **--verbose**] [**-q** | **--quiet**] [**--no-warn**] [**--no-branch-extend**] *sourcefile* [*sourcefile ...*]

DESCRIPTION
===========

Ophis is a cross-assembler for the 65xx series of chips. It supports
the stock 6502 opcodes, the 65c02 extensions, experimental support
for the 4502/4510 used in the Commodore 65 prototypes, and syntax for
the "undocumented opcodes" in the 6510 chip used on the Commodore
64.

The full **ophis** manual is available at:

  /usr/doc/ophis-|version|/ophismanual.pdf

Or on the author's site at:

  https://michaelcmartin.github.io/Ophis/book/book1.html

The platform headers and example code mentioned in the manual can be found
in **/usr/share/ophis/platform/** and **/usr/share/ophis/examples/**.

OPTIONS
=======

  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -o OUTFILE            Output filename (default 'ophis.bin')
  -l LISTFILE           Listing filename (not created by default)
  -m MAPFILE            Label-address map filename (not created by default)

  Input options:
    -u, --undoc         Enable 6502 undocumented opcodes
    -c, --65c02         Enable 65c02 extended instruction set
    -4, --4502          Enable 4502 extended instruction set

  Console output options:
    -v, --verbose       Verbose mode
    -q, --quiet         Quiet mode
    --no-warn           Do not print warnings

  Compilation options:
    --no-branch-extend  Disable branch-extension pass

COPYRIGHT
=========

See the file /usr/doc/ophis-|version|/README for license information.

AUTHORS
=======

**ophis** was written by Michael C. Martin.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The ophis homepage: https://michaelcmartin.github.io/Ophis/

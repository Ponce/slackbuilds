.. RST source for ftohex(1) man page. Convert with:
..   rst2man.py ftohex.rst > ftohex.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2.20.14.1
.. |date| date::

======
ftohex
======

---------------------------------------------
convert dasm output files to intel hex format
---------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ftohex *format* *infile* [*outfile*]

DESCRIPTION
===========

**ftohex** converts a binary file produced by **dasm**\(1) to an Intel
.HEX file, which may be useful as input to an EPROM programmer.

*format* is required, and must match the **-f** option given to
**dasm** to produce the file. Format *3* is a raw binary image, which
need not have been produced by **dasm**. Format *1* is **dasm**'s default,
if no **-f** was given.

*infile* is required; there's no option to read from **stdin**, but you
might try **/dev/stdin** if that's supported on your OS.

If *outfile* is given, .HEX output will be written to it. Otherwise, the output
is written to **stdout**.

EXAMPLE
=======

::

  dasm example.asm -f2 -oexample.out
  ftohex 2 example.out example.hex

COPYRIGHT
=========

See the file /usr/doc/dasm-|version|/LICENSE for license information.

AUTHORS
=======

**ftohex** is written and maintained by the DASM team and its contributors.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**dasm**\(1)

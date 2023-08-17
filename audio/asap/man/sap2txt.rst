.. RST source for sap2txt(1) man page. Convert with:
..   rst2man.py sap2txt.rst > sap2txt.1

.. |version| replace:: 5.3.0
.. |date| date::

=======
sap2txt
=======

------------------------------------------------------------
dump or modify the header of a SAP Atari 8-bit chiptune file
------------------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**sap2txt** **SAP-file** [ > **text-file** ]

**sap2txt** **text-file** **SAP-file**

DESCRIPTION
===========

**sap2txt** dumps the header of an Atari 8-bit chiptune in SAP format
in human-readable format, or replaces the header of a SAP file with
the contents of a text file previously created with **sap2txt** and
probably edited with a text editor.

With one argument, **sap2txt** reads the input SAP file and prints
its header in text format on standard output. Use redirection to
capture this in a text file (e.g. *>file.txt*).

With two arguments, **sap2txt** reads the first file as a text
file, in the format created by **sap2txt** itself, and replaces
the SAP header in the second file (which must be a valid SAP
file). **Beware**: **SAP-file** is overwritten without confirmation.
If you need backups of the original files, you should make copies
*before* running **sap2txt**.

Non-SAP chiptune files (e.g. RMT, CMC) are not supported.

OPTIONS
=======

**-h**, **--help**
  Show built-in help.

**-v**, **--version**
  Show version number.

EXAMPLE
=======

To change the title of a SAP file, first::

  sap2txt file.sap > file.txt

Then edit file.txt (with your preferred text editor, whatever that
is). Change the line that begins with NAME. Be careful not to remove
the double-quotes around the name. After editing the text file, you
should make a backup of the original SAP file::

  cp file.sap file.original.sap

Now you're ready to update the header in the SAP file::

  sap2txt file.txt file.sap

When you play the new file.sap, your modified title should show
up in the player.

Note that it's **very bad form** to change the author's name to
your name and redistribute the file. In fact, you should never
redistribute modified versions of SAP files without the original
author's permission.

COPYRIGHT
=========

See the file /usr/doc/asap-|version|/COPYING for license information.

AUTHORS
=======

The ASAP suite was written by Piotr Fusik, with contributions from many
others (see the website for details).

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**asapconv**\(1), **asap-sdl**\(1), **asap-mplayer**\(1), **chksap.pl**\(1), **sap2ntsc**\(1)

The ASAP website: https://asap.sourceforge.net/

.. RST source for isextract(1) man page. Convert with:
..   rst2man.py isextract.rst > isextract.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20141107_5adb0af
.. |date| date::

=========
isextract
=========

---------------------------------
Extract InstallShield v3 archives
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

isextract [*l*] *file.z*

isextract [*x*] *file.z* [*output-dir*]

DESCRIPTION
===========

**isextract** is a command line tool to extract the .Z InstallShield v3
packages many old windows games were distributed as.

The files **isextract** supports normally have a **.Z** extension, and can be
idenfified by the **file**\(1) command:

::

  $ file data.z
  data.z: InstallShield Z archive Data

...or by the hex signature at the start of the file:

::

  $ head -c6 data.z | xxd
  00000000: 135d 658c 3a01                           .]e.:.

OPTIONS
=======

**l**
  List contents of archive.

**x**
  Extract archive. If an *output-dir* is given, extracted files will be written
  there (the *output-dir* must already exist). Without *output-dir*, the current
  directory is used.

If **file** says "compress'd data" or similar, your file isn't an
InstallShield archive; it's compressed with the old UNIX compress
command, and can be extracted with **uncompress**\(1) or **gzip**\(1).

When extracting, **isextract** *DOES NOT* preserve the directory structure
inside the archive. All files are written to the same directory. If you
need the directories, use **unshieldv3** instead.

COPYRIGHT
=========

See the file /usr/doc/isextract-|version|/LICENSE for license information.

AUTHORS
=======

isextract was written by OmniBlade.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**unshieldv3**\(1), **unshield**\(1), **cabextract**\(1)

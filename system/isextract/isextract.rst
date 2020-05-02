.. RST source for isextract(1) man page. Convert with:
..   rst2man.py isextract.rst > isextract.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20141107_5adb0af
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

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

isextract [*l|x*] file.z

DESCRIPTION
===========

isextract is a command line tool to extract the .z InstallShield v3
packages many old windows games were distributed as.

The files isextract supports normally have a **.z** extension, and can be
idenfified by the file command:

::

  $ file data.z
  data.z: InstallShield Z archive Data

...or by the hex signature at the start of the file:

::

  $ head -c6 data.z | xxd
  00000000: 135d 658c 3a01                           .]e.:.

OPTIONS
=======

**l**       List contents of archive.

**x**       Extract archive to current directory.

COPYRIGHT
=========

See the file /usr/doc/PRGNAM-|version|/LICENSE for license information.

AUTHORS
=======

isextract was written by OmniBlade.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

unshield(1), cabextract(1)

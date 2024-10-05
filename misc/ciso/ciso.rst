.. RST source for ciso(1) man page. Convert with:
..   rst2man.py ciso.rst > ciso.1

.. |version| replace:: 1.0.2
.. |date| date::

====
ciso
====

------------------------------
compress/decompress CSO images
------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ciso *level* *input-file* *output-file*

DESCRIPTION
===========

CSO (compressed ISO) images are used with the Sony Playstation
Portable game console.

**ciso** compresses ISO images to CSO, or decompresses CSO to ISO. This
is lossless compression.

To compress, set *level* to a number between 1 (least compression,
fastest) and 9 (most compression, slowest). Example::

  ciso 5 something.iso something.cso

To decompress, set *level* to 0 (zero). Example::

  ciso 0 something.cso something.iso

All 3 arguments are required. With missing arguments, **ciso** will
print its built-in usage message and exit.

The CSO images produced by *ciso* are "version 1". For more information
on the CSO image format, see: https://en.wikipedia.org/wiki/.CSO

COPYRIGHT
=========

See the file /usr/doc/ciso-|version|/license for license information.

AUTHORS
=======

**ciso** was written by BOOSTER.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The **ciso** homepage: https://sourceforge.net/projects/ciso/

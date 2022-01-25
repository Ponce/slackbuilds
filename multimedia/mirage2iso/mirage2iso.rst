.. RST source for mirage2iso(1) man page. Convert with:
..   rst2man.py mirage2iso.rst > mirage2iso.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.4.2
.. |date| date::

==========
mirage2iso
==========

-------------------------------------------
convert various CD/DVD image formats to ISO
-------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

mirage2iso [*-options*] *input-file* [*output.iso*]

DESCRIPTION
===========

**mirage2iso** extracts an ISO-9660 image from a CD/DVD image in any
format supported by **libmirage**. This includes *bin/cue*, *nrg*
(Nero), *mds* (Alcohol 120%), and many more; see the libmirage
documentation for the full list.

The *input-file* argument is required, and there's no way to read
from standard input. For multi-file formats (*bin/cue*, *bin/toc*,
etc), the *input-file* must be the one containing the table of
contents (the *cue* or *toc* file, which will also be the smallest
file of the set).

With no *output.iso* argument, the output filename is "guessed" based
on the input filename, with the extension changed to *.iso*. If this
file already exists, it will not be overwritten (unless the **-f**,
**--force** option is given).

OPTIONS
=======

-f, --force
  Force replacing the guessed output file.

-p, --password=PASS
  Password for the encrypted image.

-q, --quiet
  Disable progress reporting, output only errors.

-s, --session=N
  Session to use (default: the last one).

-c, --stdout
  Output the image into stdout instead of a file.

-v, --verbose
  Increase progress reporting verbosity.

-V, --version
  Print program version and exit.

-h, --help
  Print built-in help and exit.

LIMITATIONS
===========

**mirage2iso** doesn't support images with multiple data tracks in the
same session. Only the first data (Mode1) track will be converted.

It doesn't support tracks other than Mode1 either, i.e. it is able to
convert only standard data tracks. It won't work with your PSX games
and other stuff relying on Mode2.

COPYRIGHT
=========

See the file /usr/doc/mirage2iso-|version|/COPYING for license information.

AUTHORS
=======

mirage2iso was written by Michał Górny.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**bchunk**\(1)

/usr/doc/mirage2iso-|version|/README

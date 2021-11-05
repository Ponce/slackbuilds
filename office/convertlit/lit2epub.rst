.. RST source for lit2epub(1) man page. Convert with:
..   rst2man.py lit2epub.rst > lit2epub.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20160803
.. |date| date::

========
lit2epub
========

---------------------------------
convert a DRM1 .lit file to .epub
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

lit2epub **input.lit** *[ output.epub ]*

DESCRIPTION
===========

**lit2epub** is a wrapper script that uses **convertlit**\(1) and **zip**\(1) to
convert a DRM1 .lit ebook file to an .epub.

Default output file is written to the current directory, named after the
input filename with the .lit or .LIT extension changed to .epub, or the
input filename with .epub appended, if there is no .lit extension.

Use - for the output file, to output to stdout.

Exit status is 0 on success, non-zero on failure.

If you need to convert a non-DRM1 .lit file, use convertlit to downconvert
to DRM1 first.

AUTHOR
======

**lit2epub** and this man page were written for the SlackBuilds.org
project by B. Watson, and are licensed under the WTFPL.

SEE ALSO
========

**convertlit**\(1), **zip**\(1)

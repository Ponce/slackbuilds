.. RST source for pdf.py(1) man page. Convert with:
..   rst2man.py pdf.py.rst > pdf.py.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.28
.. |date| date::

======
pdf.py
======

----------------------------------
create PDF files from JBIG2 images
----------------------------------

SYNOPSIS
========

jbig2 -b newdoc -s -p image1.jpg image2.jpg ...

pdf.py newdoc > newdoc.pdf

DESCRIPTION
===========

**pdf.py** creates a PDF document from **jbig2**'s PDF-ready output
(created using *-s* and *-p*, *--pdf*).

**pdf.py** takes only one argument: the base name of the files created
by **jbig2**, which is set with **jbig2**'s *-b* option.  Without *-b*,
the default name is **output**.

The PDF is written to standard output, which normally should be redirected
to a file (see the example above).

EXIT STATUS
===========

**pdf.py** exits with 0 (success) status if the conversion completed
OK, and non-zero status if anything went wrong. If standard output was
redirected to a file, the file will be empty or invalid when non-zero
status is returned. Diagnostic messages are printed to standard error.

COPYRIGHT
=========

See the file /usr/doc/jbig2enc-|version|/COPYING for license information.

AUTHORS
=======

pdf.py and jbig2enc were written by:
  Adam Langley <agl@imperialviolet.org>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jbig2(1)**, **jbig2dec(1)**

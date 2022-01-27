.. RST source for jpdfcat(1) man page. Convert with:
..   rst2man.py jpdfcat.rst > jpdfcat.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6.0
.. |date| date::

=======
jpdfcat
=======

----------------------------------------------------
extract and print the text content in a PDF document
----------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

jpdfcat [*-P pass*] **filename.pdf**

DESCRIPTION
===========

**jpdfcat** extracts and prints the text content in a PDF document. It's
part of the **jfbview** suite.

OPTIONS
=======

-P,--password=pass
  Unlock PDF document with the given password.

-h,--help
  Show built-in help message.

COPYRIGHT
=========

jpdfcat is distributed under the Apache License v2.

AUTHORS
=======

jpdfcat was written by Chuan Ji.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jfbview**\(1), **jpdfgrep**\(1), **pdftotext**\(1)

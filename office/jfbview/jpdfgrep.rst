.. RST source for jpdfgrep(1) man page. Convert with:
..   rst2man.py jpdfgrep.rst > jpdfgrep.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.6.0
.. |date| date::

========
jpdfgrep
========

-------------------------------------
search for a string in a PDF document
-------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

jpdfgrep [*-P pass*] [*-w width*]  **filename.pdf** **search-string**

DESCRIPTION
===========

**jpdfgrep** searches for a string in the text content of a PDF
document and prints all matching lines. Despite the name, the
**search-string** is a fixed string, *not* a regular expression.
Also, be aware that the file and search string arguments must
be given in the opposite order from grep.

**jpdfgrep** is part of the **jfbview** suite.

OPTIONS
=======

-P,--password=pass
  Unlock PDF document with the given password.

-w,--width=width
  Specify result line width. The default is to autodetect terminal width.

-h,--help
  Show built-in help message.

COPYRIGHT
=========

jpdfgrep is distributed under the Apache License v2.

AUTHORS
=======

jpdfgrep was written by Chuan Ji.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**jfbview**\(1), **jpdfcat**\(1), **pdftotext**\(1)

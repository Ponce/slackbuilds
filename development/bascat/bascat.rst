.. RST source for bascat(1) man page. Convert with:
..   rst2man.py bascat.rst > bascat.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.2pre2
.. |date| date::

======
bascat
======

----------------------------------------
detokenizer for BBC Micro BASIC programs
----------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**bascat** [*--help* | *-h*] [*--version* | *-v*] [*--line-numbers* | *-n*] [*--no-line-numbers* | *+n*] [*--highlight* | *-l* ] [*--no-highlight* | *+l* ] [*--pager=PAGER* | *-p PAGER*] [*file* ...]

DESCRIPTION
===========

Types tokenized (SAVEd) BBC BASIC programs in a readable way.

With no *file* arguments, **bascat** reads from standard input.

If standard output is a terminal, output will be piped through a
pager. The default is **$PAGER** from the environment, or **less** if
not set. Note that if standard output is not a terminal (e.g. if redirecting to
a file), no pager is used.

Options can be placed in the **BASCAT** environment variable, if you don't
like the standard settings.

OPTIONS
=======

Prefix long options with **no-** to cancel them.  Use **+** to cancel short options.

--help, -h
  Display built-in help message and exit.

--version, -h
  Display version number and exit.

--line-numbers, -n
  Display line numbers for each line. This is enabled by default; use **+n** or
  **--no-line-numbers** to disable.

--highlight, -l
  Attempts to highlight keywords. Whether this works properly or not depends on
  the pager in use; **more**\(1), **less**\(1), and **most**\(1) work correctly.
  **lv**\(1) will work if you have **-c** in **~/.lv** or **LV** in the environment.

--pager=pager, -p pager
  Sets pager to use, if standard output is a terminal. Overrides **PAGER** environment variable.
  If you don't want a pager, use **-p cat**.

.. FILES
.. =====

.. ENVIRONMENT
.. ===========

.. EXIT STATUS
.. ===========

.. BUGS
.. ====

.. EXAMPLES
.. ========

COPYRIGHT
=========

See the file /usr/doc/bascat-|version|/README for license information.

AUTHORS
=======

**bascat** was written by Matthew Wilcox and Mark Wooding.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**dfsimage**\(1)

The bascat homepage: https://git.distorted.org.uk/~mdw/

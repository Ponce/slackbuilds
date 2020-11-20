.. RST source for x_x(1) man page. Convert with:
..   rst2man.py x_x.rst > x_x.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20150330_d236f8f
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

===
x_x
===

-----------------------------------------
display Excel and CSV files on a terminal
-----------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

x_x [**-h** *row*] [**-f** *csv|excel*] [**-d** *delimiter*] [**-q** *quotechar*] [**-e** *encoding*]

DESCRIPTION
===========

x_x (the Dead Guy CLI) is a command line reader that displays either
Excel files or CSVs in your terminal. The purpose of this is to not
break the workflow of people who live on the command line and need to
access a spreadsheet generated using Microsoft Excel.

OPTIONS
=======

**-h**, **--heading** *row*
  Row number containing the headings (default: none). Note: the first row is
  numbered 0, not 1!

**-f**, **--file-type** *csv|excel*
  Override autodetection of input file type.

**-d**, **--delimiter** *character*
  Delimiter (only applicable to CSV files) [default: ','].

**-q**, **--quotechar**
  Quote character (only applicable to CSV files) [default: '"'].

**-e**, **--encoding** *encoding*
  Encoding [default: UTF-8].

**--version**
  Show the version and exit.

**--help**
  Show built-in help and exit.

EXAMPLES
========

So, for example:

::

  $ x_x dead_guys.xlsx
  +---------------+--------------+
  | A             | B            |
  +---------------+--------------+
  | Person        | Age at Death |
  | Harrold Holt  | 59.0         |
  | Harry Houdini | 52.0         |
  | Howard Hughes | 70.0         |

Or to specify a specific row as the header which will be visible on each page:

::

  $ x_x -h 0 dead_guys.xlsx
  +---------------+--------------+
  | Person        | Age at Death |
  +---------------+--------------+
  | Harrold Holt  | 59.0         |
  | Harry Houdini | 52.0         |
  | Howard Hughes | 70.0         |

Weird CSVs? No problem!

::

    $ cat dead_guys.csv
    person;age_at_death
    Harrold Holt;59
    Harry Houdini;52
    Howard Hughes;70
    |Not some guy, but just a string with ; in it|;0

::

    $ x_x -h 0 --delimiter=';' --quotechar='|' dead_guys.csv
    +----------------------------------------------+--------------+
    | person                                       | age_at_death |
    +----------------------------------------------+--------------+
    | Harrold Holt                                 | 59           |
    | Harry Houdini                                | 52           |
    | Howard Hughes                                | 70           |
    | Not some guy, but just a string with ; in it | 0            |

Does your CSV file not end in "csv"? Again, no problem:

::

    $ mv dead_guys.csv dead_guys.some_other_extension
    $ x_x -h 0 --file-type=csv --delimiter=';' --quotechar='|' dead_guys.some_other_extension
    +----------------------------------------------+--------------+
    | person                                       | age_at_death |
    +----------------------------------------------+--------------+
    | Harrold Holt                                 | 59           |
    | Harry Houdini                                | 52           |
    | Howard Hughes                                | 70           |
    | Not some guy, but just a string with ; in it | 0            |

COPYRIGHT
=========

See the file /usr/doc/x_x-|version|/LICENSE for license information.

AUTHORS
=======

x_x was written by krockode.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The x_x homepage: https://github.com/krockode/x_x

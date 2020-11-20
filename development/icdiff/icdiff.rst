.. RST source for icdiff(1) man page. Convert with:
..   rst2man.py icdiff.rst > icdiff.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.9.5
.. |date| date::

======
icdiff
======

-------------------
improved color diff
-------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

icdiff [*-options*] left_file right_file

git-icdiff [*git diff options*]

DESCRIPTION
===========

**icdiff** show differences between files in a colorful two column view.

**git-icdiff** is a wrapper around **git diff** that uses **icdiff** to show diffs.

OPTIONS
=======

--version             show program's version number and exit
-h, --help            show this help message and exit
--cols=COLS           specify the width of the screen. Autodetection is Unix only
--encoding=ENCODING   specify the file encoding; defaults to utf8
-E MATCHER, --exclude-lines=MATCHER
                      Do not diff lines that match this regex. Not compatible with the 'line-numbers' option
--head=HEAD           consider only the first N lines of each file
-H, --highlight       color by changing the background color instead of the foreground color.  Very fast, ugly, displays all changes
-L LABELS, --label=LABELS
                      override file labels with arbitrary tags. Use twice, one for each file
-N, --line-numbers    generate output with line numbers. Not compatible with the 'exclude-lines' option.
--no-bold             use non-bold colors; recommended for solarized
--no-headers          don't label the left and right sides with their file names
--output-encoding=OUTPUT_ENCODING
                      specify the output encoding; defaults to utf8
-r, --recursive       recursively compare subdirectories
--show-all-spaces     color all non-matching whitespace including that which is not needed for drawing the eye to changes.  Slow, ugly, displays all changes
--tabsize=TABSIZE     tab stop spacing
-u, --patch           generate patch. This is always true, and only exists for compatibility
-U NUM, --unified=NUM, --numlines=NUM
                      how many lines of context to print; can't be combined with --whole-file
-W, --whole-file      show the whole file instead of just changed lines and context
--strip-trailing-cr   strip any trailing carriage return at the end of an input line
--color-map=COLOR_MAP
                      choose which colors are used for which items. Default is --color-map='add:green_bold,change:yellow_bold,description:blue,meta:magenta,separator:blue,subtract:red_bold'.  You don't have to override all of them: '--color-map=separator:white,description:cyan'

NOTE
====

It's highly recommended to use wide terminals with **icdiff**, for
instance 160 columns or more.

EXAMPLES
========

See the file /usr/doc/icdiff-|version|/README.md for examples.

COPYRIGHT
=========

See the file /usr/doc/icdiff-|version|/LICENSE for license information.

AUTHORS
=======

icdiff was written by Jeff Kaufman.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

diff(1), colordiff(1), git-difftool(1)

The icdiff homepage: https://www.jefftk.com/icdiff

.. RST source for zennode-tools(6) man page. Convert with:
..   rst2man.py zennode-tools.rst > zennode-tools.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.2.1
.. |date| date::

=============
zennode-tools
=============

-----------------------------
get information on .wad files
-----------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

| bspdiff *filename1*\[*.wad*] *filename2*\[*.wad*] [*level*\[*+level*]]
| bspinfo [*-t*] *filename*\[*.wad*] [*level*\[*+level*]]
| zn-compare *filename1*\[*.wad*] *filename2*\[*.wad*] [*level*\[*+level*]]

DESCRIPTION
===========

This man page briefly documents the tools that ship with *ZenNode*\(6):
*bspdiff*, *bspinfo*, and *zn-compare*.

*bspdiff* compares the BSP trees of two .wad files and displays the
point at which they differ. Since the BSP is essentially a binary
tree, a single difference in a partition for a given group of SEGS
will create a tree that is radically different for all points below
that node.

*bspinfo* reports statistics that describe the BSP tree(s) of a
.wad file. It can be used to give you a feel of how particular BSP
builders are performing.

*zn-compare* is a simple utility to compare two REJECT maps and
display any differences between them. The command line syntax
is similar to that of ZenNode except that two .wad files must be
specified. After loading each .wad file, the list of levels in each
file is compared and for each matching level, the REJECT maps are
compared and the results displayed.

OPTIONS
=======

-t    display NODE tree (*bspinfo* only)

COPYRIGHT
=========

See the file /usr/doc/zennode-|version|/COPYING for license information.

AUTHORS
=======

*ZenNode* was written by Marc Rousseau.

This man page was written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

*zennode*\(6)

The full documentation at /usr/doc/zennode-|version|/index.html

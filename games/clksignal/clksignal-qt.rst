.. RST source for clksignal-qt(6) man page. Convert with:
..   rst2man.py clksignal-qt.rst > clksignal-qt.6
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20211219
.. |date| date::

============
clksignal-qt
============

------------------------------------------
graphical interface for clksignal emulator
------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

clksignal-qt [*file*]

DESCRIPTION
===========

**clksignal-qt** is a Qt-based build of **clksignal**. It accepts no
command-line options; starting and configuring the emulator is
done via the GUI.

If *file* is given, it's used as the ROM/disk/tape image to run.
If it's a recognized file type, the appropriate emulated machine will
automatically be started.

Unlike **clksignal**, **clksignal-qt** *only* supports PulseAudio for
audio output. No, it won't work with **apulse**\(1), either.

COPYRIGHT
=========

See the file /usr/doc/clksignal-|version|/LICENSE for license information.

AUTHORS
=======

clksignal-qt was written by Thomas Harte.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**clksignal**\(6)

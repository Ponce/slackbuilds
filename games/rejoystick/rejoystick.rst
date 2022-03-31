.. RST source for rejoystick(1) man page. Convert with:
..   rst2man.py rejoystick.rst > rejoystick.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.8.1
.. |date| date::

==========
rejoystick
==========

--------------------------------------------------
translates joystick movement/buttons to keystrokes
--------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

rejoystick [*-d*]

DESCRIPTION
===========

**rejoystick** is a daemon that converts joystick movement and/or
button presses to X keystroke events. This allows the user to use the
joystick with games that don't have joystick support.

There are two modes of operation for **rejoystick**: the GUI configuration
mode, and daemon mode.

To configure the axes/buttons **rejoystick** will map to keystrokes,
run **rejoystick** with no arguments. This will display a GUI which
you can use to set the mappings. When you're done, exit the program
(close its window). The mappings will be written to *~/.rejoystickrc*.
Although the configuration is graphical, it's recommended to run it
from a terminal (not a desktop launcher), so you can see its output.

To run **rejoystick** as a daemon, run it with the **-d** option. It
will fork to the background, monitor the joystick, and generate
keystroke events according to the configuration in *~/.rejoystickrc*.

To exit **rejoystick**, use "**killall -9 rejoystick**". If you want to
change the mappings, you'll have to kill the daemon and restart it,
since it won't re-read its config file.

OPTIONS
=======

-d
  Run as a daemon. Default is to show the config GUI.

COPYRIGHT
=========

See the file /usr/doc/rejoystick-|version|/COPYING for license information.

AUTHORS
=======

rejoystick was written by Samuel <samel_tvom@yahoo.se>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The rejoystick homepage: http://rejoystick.sourceforge.net/

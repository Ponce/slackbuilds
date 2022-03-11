.. RST source for irc.c(1) man page. Convert with:
..   rst2man.py irc.c.rst > irc.c.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20210302_490f194
.. |date| date::

=====
irc.c
=====

----------------------------
minimalist curses IRC client
----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

irc.c [*-n NICK*] [*-u USER*] [*-s SERVER*] [*-p PORT*] [*-l LOGFILE*] [*-t*] [*-h*]

DESCRIPTION
===========

**irc.c** is a simple IRC client. Features:

  * infinite scrollback
  * automatic reconnection
  * utf8 support (inputting is still to do)
  * line editing (emacs like keybindings)
  * activity markers
  * logging
  * terminal resizes (inside an xterm)

The user interface uses multiple windows. The first window is always
the server window, and each channel or private message conversation
gets its own window. Press **^N** and **^P** for next/previous window.

There is no config file. Options are set on the command line and/or
in the environment.

OPTIONS
=======

-n NICK
  Sets the nickname (default: **IRCNICK** from environment; if not set, the
  username from **-u** or **USER**).

-u USER
  Sets the username (default: **USER** from environment, or *anonymous* if not set).

-s SERVER
  Server to connect to (default: irc.oftc.net).

-p PORT
  Port to connect to (default: 6667).

-l FILE
  File to log recieved data (default: none). If the file already
  exists, new data is appended to it.

-t
  Use a secured connection. For most IRC servers, you'll also have to set
  **-p 6697** (or whatever port the server uses for secure connections).

-h
  Display help.

COMMANDS
========

IRC commands are *not* prefixed with a slash, in this client.

**j** *channel*
  Join a channel and create a new window for it.

**l**
  Leave (part) the currently displayed channel and close its window.

**m** *nick* *message*
  Send a private message. This creates a new window for the conversation.

**r** *text*
  Send raw *text* to the server (like **/QUOTE** in other clients).

**q**
  Quit. There is no way to send a quit message.

KEYSTROKES
==========

**^N**
  Next window.

**^P**
  Previous window.

**PageUp**
  Scroll up.

**PageDown**
  Scroll down.

Emacs-style editing keys are also supported (**^U**, **^W**, etc).

ENVIRONMENT
===========

**USER**
  The default IRC username (override with **-u**). This is unlike other
  IRC clients, which use **IRCUSER**.

**IRCNICK**
  The default IRC nickname. Override with **-n**.

**IRCPASS**
  Password used to authenticate to the IRC server, if set.

COPYRIGHT
=========

The author has placed **irc.c** in the public domain.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The irc.c homepage: https://c9x.me/irc/

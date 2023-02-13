.. RST source for tetrinetx(6) man page. Convert with:
..   rst2man.py tetrinetx.rst > tetrinetx.6

.. |version| replace:: 1.13.16+qirc_1.40c_15
.. |date| date::

=========
tetrinetx
=========

------------------------
server for tetrinet game
------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

/etc/rc.d/rc.tetrinetx [ **start** | **stop** | **restart** ]

DESCRIPTION
===========

**tetrinetx** provides a server for hosting TetriNET games. TetriNET
is a multiplayer variant of Tetris played over the internet. Up to
six people may simultaneously connect to a server to participate in
a game.

**tetrinetx** supports only the original TetriNET game mode, not the
TetriFAST mode. Clients attempting to connect with TetriFAST will be
immediately disconnected.

The actual **tetrinetx** binary should not normally be run
directly. Instead, use the startup script. If you want to start the
server at boot, include a call to it in your */etc/rc.d/rc.local*::

  if [ -x /etc/rc.d/rc.tetrinetx ]; then
    /etc/rc.d/rc.tetrinetx start
  fi

...and possibly in */etc/rc.d/rc.local_shutdown*::

  if [ -x /etc/rc.d/rc.tetrinetx ]; then
    /etc/rc.d/rc.tetrinetx stop
  fi

FILES
=====

All configuration is done via config files; there are no command-line
options (other than start/stop/restart, for the init script).

/etc/tetrinetx/game.conf
  The main config file for **tetrinetx**. Human-readable and editable,
  with explanatory comments.

/etc/tetrinetx/game.motd
  The "message of the day" shown to regular clients when they connect.

/etc/tetrinetx/game.pmotd
  Message shown to playback (spectator) service clients.

/etc/tetrinetx/game.secure
  Used to define passwords clients can send to authenticate as server
  admins. By default, nothing is defined here (everything is commented out).

/etc/tetrinetx/game.ban, game.allow, game.ban.compromise
  Controls who is allowed to connect to the server. These files don't
  ship with the package, but ".example" files are included to show you
  how they work.

/var/log/tetrinetx/game.log
  Log file for **tetrinetx**.

/var/games/tetrinetx/game.winlist, game.winlist2, game.winlist3
  Lists of game winners.

/var/run/tetrinetx/game.pid
  PID file for the daemon is normally stored here, although this can be
  changed in **game.conf**. The PID file is deleted when **tetrinetx**
  exits normally (including being killed with **SIGTERM**).
  The init script doesn't actually use the PID file.

NETWORK
=======

**tetrinetx** uses the following TCP ports:

31457
  Standard port used for tetrinet clients.

31456
  Query service. Supposedly can be connected to with a standard IRC client.
  See:

    /usr/doc/tetrinetx-|version|/README.qirc.spectators

31458
  "Playback" port, used for connecting as a spectator. **tetrinetx** must
  have a *query_password* set in **/etc/tetrinetx/game.secure** to enable
  spectator connections.

LIMITATIONS
===========

**tetrinetx** can only be compiled for *either* IPv4 *or* IPv6
support, not both. The SlackBuilds.org build allows choosing this at
build time.

COPYRIGHT
=========

See the file /usr/doc/tetrinetx-|version|/COPYING for license information.

AUTHORS
=======

**tetrinetx** was written by Brendan Grieve and Roongroj Phoophuangpairoj.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**gtetrinet**\(6)

The tetrinetx homepage: https://tetrinetx.sourceforge.net/

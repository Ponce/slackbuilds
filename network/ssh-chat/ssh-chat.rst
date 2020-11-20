.. RST source for ssh-chat(1) man page. Convert with:
..   rst2man.py ssh-chat.rst > ssh-chat.8
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.10
.. |date| date::

========
ssh-chat
========

-----------------------------------------
custom ssh server providing IRC-like chat
-----------------------------------------

:Manual section: 8
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

ssh-chat [*-options*]

DESCRIPTION
===========

ssh-chat is a custom SSH server written in Go. Instead of a shell,
clients get a chat prompt when they connect.

There is no specific client for ssh-chat; use a standard ssh client to connect.

OPTIONS
=======

-v, --verbose
  Show verbose logging.

--version
  Print version and exit.

-i, --identity=file
  Private key to identify server with. (default: ~/.ssh/id_rsa)

--bind=host:port
  Host and port to listen on. (default: 0.0.0.0:2022)

--admin=file
  File of public keys who are admins.

--whitelist=file
  Optional file of public keys who are allowed to connect.

--motd=file
  Optional Message of the Day file.

--log=file
  Write chat log to this file.

--pprof=yes
  Enable pprof http server for profiling.

-h, --help       Show this help message

DEMO
====

To connect to the project's ssh-chat server:

$ ssh ssh.chat

EXAMPLES
========

ssh-chat --verbose --bind ":22" --identity ~/.ssh/id_dsa

To bind on port 22, you'll need to make sure it's free (move any other ssh
daemons to another port) and run ssh-chat as root (or with sudo).

Note that ssh-chat doesn't run in the background. If you want to 'daemonize' it,
use the --log option, and run it with a command like:

$ cd / ; ssh-chat [options] --log=logfile </dev/null >/dev/null 2>&1 &

COPYRIGHT
=========

See the file /usr/doc/ssh-chat-|version|/LICENSE for license information.

AUTHORS
=======

ssh-chat was written by Andrey Petrov.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

ssh(1), sshd(1)

The ssh-chat homepage: https://github.com/shazow/ssh-chat/

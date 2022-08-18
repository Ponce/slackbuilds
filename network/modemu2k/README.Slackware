# modemu2k v0.1.0

modemu2k is a fork of modemu, originally developed by Toru Egashira

(Build status
<https://github.com/theimpossibleastronaut/modemu2k/actions/workflows/c-cpp.yml>)


## What is modemu2k?

modemu2k adds telnet capability to a comm program. It can redirect
telnet I/O to a pty so that a comm program can handle the pty as a tty
with a real modem, and allows you to use a comm program's scripting
and file transfer features over telnet. Now supports IPv6 connections.

Maintainer: Andy Alt <andy400-dev [at] yahoo [dot] com>

License: GNU GPL 3

Home page: <http://theimpossibleastronaut.com/modemu2k/>

[Issues and bug reporting](https://github.com/theimpossibleastronaut/modemu2k/issues)


Dependencies
------------

  * gettext (optional, for translations)
  * flex


Compilation
-----------

    meson builddir
    cd builddir

Use `meson configure` to see extra options

    ninja


`ninja install` is optional. The binary can be run from the build
directory; however, installation is required to use the translations,
and to create and install a script (m2k-minicom) that can invoke
minicom (see below).


## Sample Usage


Note: while in the program if backspace doesn't work, use CTRL+H.

1) Stand alone usage

  Invoked with no option,

      modemu2k

  modemu2k reads from standard input and writes to standard output.
  Input

  > atd"localhost [port]

  (prompt ">" is not shown) You will see your host's login prompt
  (if a server is running). When you disconnect, you will get "NO
  CARRIER" indication. Then input

  > at%q

  to quit modemu2k.

2) With a comm program

  (This example uses minicom as the comm program)

  Invoke with "-c" option,

      modemu2k -e "AT%B0=1%B1=1&W" -c "minicom -l -tansi -con -p %s"

  From within the comm program, if you have a server running, to
  connect you can enter:

      atd"localhost

  You could also connect to a BBS. For some telnet addresses, see:

  * The Rusty Mailbox (telnet to [trmb.ca](https://trmb.ca/), port 2030)
  * [Synchronet BBS List](https://www.synchro.net/sbbslist.html)

  To quit modemu2k, just quit the comm program.

  A script to invoke minicom as mentioned above will be installed to
  your bin directory when `make install` is run.

## Escaping to command mode and returning

To escape to command mode, use '+++'. Use ATO to return to online mode.


## Hanging up a call/closing a connection

If you are connected to a server where gracefully logging out isn't
possible, to "hang up" or close the connection you can escape to command
mode and enter 'ATH`.

## Extra Notes

(*) Almost all file xfer protocols require 8bit through connection,
which means Modemu2k must be in the binary transmission mode.  See %B
command description in the man page.

More details are in the QuickStart guide
<https://github.com/theimpossibleastronaut/modemu2k/blob/master/QuickStart>

A man page is also available.


# Downloads

* Release page<https://github.com/theimpossibleastronaut/modemu2k/releases>

[![Packaging status](https://repology.org/badge/vertical-allrepos/modemu2k.svg)](https://repology.org/project/modemu2k/versions)

## Translate

See <https://github.com/theimpossibleastronaut/modemu2k/blob/master/TRANSLATE.md>


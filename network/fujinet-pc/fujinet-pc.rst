.. RST source for fujinet-pc(1) man page. Convert with:
..   rst2man.py fujinet-pc.rst > fujinet-pc.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 2206.1
.. |date| date::

==========
fujinet-pc
==========

-----------------------------------------------------------------
peripheral emulator and network adaptor for Atari 8-bit computers
-----------------------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

fujinet-pc [**-V**] [**-u** *host:port*] [**-c** *config-file*] [**-s** *SD-directory*]

DESCRIPTION
===========

FujiNet is a network adaptor for the Atari 8-bit line of computers. It
has many features, including the ability to netboot the Atari from a
disk image on an Internet TNFS server. It's a piece of hardware which
plugs into the Atari's SIO port and connects to a wireless network.

fujinet-pc is a Linux port of the FujiNet firmware, which allows using
most of the FujiNet's features with just an SIO2PC cable and a PC.

FujiNet features that work with fujinet-pc:

  - Disk drive (D:) emulation with support for ATR disk images and XEX files (no ATX yet)
  - Modem emulation (R:)
  - Printer emulation (P:)
  - APETIME protocol
  - TNFS File System to access image files over network
  - Web interface to control program's settings, browse TNFS hosts and mount disk images
  - FujiNet network device (N:) with support for various network protocols:
    TCP, UDP, TNFS, HTTP, FTP, Telnet **[\*]**

Not (yet) working:

  - CP/M emulation
  - SSH and SMB support for N:
  - SAM voice synthesizer
  - MIDIMaze support
  - Program recorder (tape) emulation

**[\*]** Note that some applications using the N: device may rely on the SIO
**PROCEED** line being connected. Most SIO2PC cables don't have this
line connected.

OPTIONS
=======

**-V**
  Print version number (including build date and OS).

**-u** *host:port*
  Host interface and port to listen on, for the web user interface. Default is
  **0.0.0.0:8000**, meaning TCP port 8000 on all interfaces. To access the
  web UI, point a browser at e.g. **http://localhost:8000**. Leaving off
  the *:port* isn't actually an error, but it causes **fujinet-pc** to
  choose a random port number (which it doesn't tell you; you'd have
  to use **netstat**\(8) to find it).

**-c** *config-file*
  Use *config-file* instead of the default **fnconfig.ini**.

**-s** *SD-directory*
  Use *SD-directory* instead of the default **SD/** for the virtual
  SD card.

FILES
=====

**~/.fujinet-pc/**
  The default directory for **fujinet-pc**, containing the following:

**fnconfig.ini**
  The default config file for **fujinet-pc**. This is where settings
  are saved when they're changed with the web user interface. This file
  can also be edited with a regular text editor.

**SD/**
  The FujiNet hardware device has a slot for a Micro-SD card. For fujinet-pc,
  the contents of this directory will be available in the host list, under
  the name **SD**. The default contents of this directory include a good
  selection of DOS and utility disk images.

.. AUTHOR
.. ======
.. normally I would put the upstream author's name here, but I have
.. no idea what it is. The github user is just called FujiNetWIFI,
.. and I haven't found any contact info anywhere in the source git
.. repo. *shrug*.

COPYRIGHT
=========

See the file /usr/doc/fujinet-pc-|version|/LICENSE for license information.

SEE ALSO
========

**atariserver**\(1), **tnfsd**\(1), **tnfs-fuse**\(1)

The fujinet-pc homepage: https://github.com/FujiNetWIFI/fujinet-pc

The FujiNet documentation wiki: https://github.com/FujiNetWIFI/fujinet-platformio/wiki

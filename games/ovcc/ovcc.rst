.. RST source for ovcc(1) man page. Convert with:
..   rst2man.py ovcc.rst > ovcc.6

.. |version| replace:: 1.6.1+20240328_cc936b2
.. |date| date::

====
ovcc
====

----------------------
TRS-80 CoCo 3 emulator
----------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**ovcc** [*quickload-file*]

DESCRIPTION
===========

**ovcc** is "the portable and open Virtual Color Computer", an emulator
for the TRS-80 Color Computer 3.

This man page documents **ovcc** as packaged by SlackBuilds.org.

[*quickload-file*] can be a cartridge ROM image (**\*.rom** or **\*.ccc**)
or a binary executable (**\*.bin**). If the file exists, it will be
loaded into the emulator at startup and executed. The filename
extensions are required, although they are case-insensitive.

There are no other command-line options.

KEYBOARD
========

The keyboard is laid out like the CoCo 3, meaning that e.g. the
double-quote is *Shift-2*.

While **ovcc** is running, press *F12* for a list of keyboard commands.

DISK IMAGES
===========

To use a disk image (**\*.dsk**), first connect the floppy drive:
select *Cartridge* -> *Load Cart* -> **libfd502.so**. After doing
this, the *Cartridge* menu will now have entries for 4 drives. Select
*FD-502 Drive 0* -> *Insert*, then use the file selector to navigate
to the disk image. If necessary, you can choose *File* -> *Hard Reset*
or press *F9* to reboot the Coco 3.

Note that it's easier to move or symlink the disk images into the
**~/.ovcc** directory, since this is the default location for the file
selector.

All the inserted media are remembered in the config file, so when
you exit and re-run **ovcc**, the devices and disks will still be
connected and loaded.

FILES
=====

/usr/games/ovcc
  Shell script wrapper, which sets up the per-user working directory if
  needed, **chdir**\s to it, and executes the real executable.

/usr/libexec/ovcc/ovcc
  The actual executable. Normally you don't want to call this directly.
  Since **ovcc** was ported from Windows, it expects to find its config
  files, ROMs, and loadable modules in the directory it was launched from.

~/.ovcc
  Per-user working directory for **ovcc**. If this dir doesn't exist, the
  **ovcc** wrapper script will create it. Contents:

  Vcc.ini
    The config file. Human-readable and (if you're careful), editable. However,
    the primary way to change the settings here is to use the graphical user
    interface. Any changes made there will be written to this file.

  Vcc.ini_bck
    Backup of the config file, created whenever **ovcc** is about to overwrite the
    config.

  lib\*.so
    Loadable modules which emulate various hardware that can be attached to the
    CoCo 3. In the GUI, you load these from the Cartridge menu. The standard
    floppy disk module is **libfd502.so**. These are symlinks to the real files
    in the package.

    For a description of each emulated device, see:

    https://raw.githubusercontent.com/VCCE/VCC/main/README.md

  \*.rom
    ROM images.

    **coco3.rom** is automatically loaded when the emulator starts up.

    **disk11.rom** is loaded when the **libfd502.so** module is loaded.

    Other modules may require other ROM images (not included in the SBo package).

/usr/lib/ovcc or /usr/lib64/ovcc
  ROM images and loadable modules, which are symlinked by the wrapper script.
  **lib64** is used on 64-bit systems (x86_64 or aarch64).

COPYRIGHT
=========

See the file /usr/doc/ovcc-|version|/README.md for license information.

AUTHORS
=======

ovcc was ported from the original VCC by Joseph Forgione.

VCC was written by the VCC Developement Team.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The ovcc homepage: https://github.com/WallyZambotti/OVCC

The original (Windows-only) VCC homepage: https://github.com/VCCE/VCC/

The TRS-80 Color Computer Archive, which has lots of software for TRS-80
CoCo machines, including the CoCo 3:

https://colorcomputerarchive.com/

**xroar**\(6), which can emulate the Color Computer 2.

.. RST source for xkegs(6) man page. Convert with:
..   rst2man.py man/xkegs.rst > man/xkegs.6

.. |version| replace:: 1.29
.. |date| date::

=====
xkegs
=====

-------------------
Apple IIgs emulator
-------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**xkegs** [-skip *num*] [-audio [*0|1*] [-arate *num*] [-dhr140] [-15] [-16] [-24] [-display *xdisplay*] [-noshm]

DESCRIPTION
===========

KEGS (Kent's Emulated GS) is an Apple IIgs emulator for Mac OS X,
Linux, and Win32. The Apple IIgs was the most powerful computer in the
Apple II line. It first was sold in 1986. An Apple IIgs has the
capability to run almost all Apple II, Apple IIe, and Apple IIc
programs.

xkegs is the KEGS binary, compiled for Linux and X-Window support.

This manual page only documents the command-line options
and key mappings. For the full documentation, see
/usr/doc/kegs-|version|/README.kegs.txt (and the other files in the
same directory).

Note: There is no way to specify disk or ROM images on the command
line. Use the configuration menu (F4) from within the emulator to select images.

OPTIONS
=======

-skip *num*
  KEGS will "skip" that many screen redraws between refreshes.
  -skip 0 will do 60 frames per second, -skip 1 will do 30 fps,
  -skip 5 will do 10 fps.

-audio *0|1*
  Forces audio [off/on]. By default, audio is on unless the X
  display is a remote machine or shared memory is off. This
  switch can override the default. -audio 0 causes KEGS to not
  fork the background audio process, but Ensoniq emulation is
  still 100% accurate, just the sound is not sent to the workstation
  speaker.

-arate *num*
  Forces audio sample rate to [num]. 44100 and 48000 are usual,
  you can try 22050 to reduce KEGS's overhead. On a reasonably
  fast machine (>250MHz or so), you shouldn't need to mess with
  this.

**-dhr140**
  Will use the old Double-hires color algorithm that results in
  exactly 140 colors across the screen, as opposed to the blending
  being done by default.

-15
   KEGS will only look for a 15-bit X-Window display.

-16
   KEGS will only look for a 16-bit X-Window display (not tested, probably
   will get red colors wrong).

-24
   KEGS will only look for a 24-bit X-Window display.

-display *xdisplay*
  Same as setting the environment variable DISPLAY. Sends X display to [xdisplay]

**-noshm**
  KEGS will not try to used shared memory for the X graphics
  display. This will make KEGS much slower on graphics-intensive
  tasks, by as much as a factor of 10! By default, -noshm causes
  an effective -skip of 3 which is 15 fps. You can override this
  default by specifying a -skip explicitly.

KEY BINDINGS
============

F1
  Alias of Command

F2
  Alias of Option

F3
  Alias of ESC for OS/2 compatibility.

F4
  Configuration Panel

F6
  Toggle through the 4 speeds: Unlimited, 1MHz, 2.8MHz, 8.0MHz

Shift-F6
  Enter KEGS debugger (can also be done by center-clicking the
  mouse on the xkegs window).
  The debugger is X-based, and runs in a separate window.

F7
  Toggle fast_disk_emul on/off

F8
  Toggle pointer hiding on/off.

F9
  Invert the sense of the joystick.

Shift-F9
 Swap x and y joystick/paddle axes.

F10
  Attempt to change the a2vid_palette (only useful on 256-color displays)

F11
  Full screen mode (only on Mac OS X).

F12
  Alias of Pause/Break which is treated as Reset

F2, Alt_R, Meta_r, Menu, Print, Mode_switch, Option
      Option key

F1, Alt_L, Meta_L, Cancel, Scroll_lock, Command
      Command key

Num_Lock
  Keypad "Clear".

F12, Pause, Break
  Reset

Home
  Alias for "=" on the keypad

FILES
=====

~/.config.kegs
  The KEGS configuration file. This can be directly edited if necessary,
  but normally is changed by using the configuration menu
  (F4) from within KEGS. To return to the default configuration,
  you may remove this file.

/usr/share/kegs/rom03 (or /usr/share/kegs/rom01)
  The Apple IIgs BIOS ROM image. If KEGS can't find this ROM, it
  will start up with a black display, full of white @ characters.
  Press F4 for the config menu and use the UI to select the correct
  ROM image file.

  For reference, the ROM image details are:

  .. csv-table::
    :header: "Filename", "Size (bytes)", "md5sum"

    "rom03", "262144", "ba89edf2729a28a17cd9e0f7a0ac9a39"
    "rom01", "131072", "20a0334c447cb069a040ae5be1d938df"

  Other versions of the IIgs ROMs may exist (this author isn't aware of
  any), but these two images are known to work.

/usr/bin/xkegs
  Wrapper script. xkegs will fail to run if it can't find its config
  file, so this script creates one in the user's home directory
  if necessary, then runs the real xkegs binary.

/usr/libexec/xkegs
  Actual xkegs binary. Shouldn't be run directly (use the wrapper
  instead).

/usr/share/kegs/config.kegs.default
  Copied to **~/.config.kegs** by the wrapper script, if **~/.config.kegs**
  doesn't already exist. Can be used to set system-wide
  defaults (such as the path to the ROM image).

AUTHORS
=======

KEGS is by Kent Dickey <kadickey@alumni.princeton.edu>.

This manual page was written by B. Watson <urchlay@slackware.uk> for
the SlackBuilds.org project, but may be used by anyone for any purpose.

Wrapper script also by B. Watson.

SEE ALSO
========

Full KEGS docs in /usr/doc/kegs-|version|/

KEGS homepage at http://kegs.sourceforge.net/

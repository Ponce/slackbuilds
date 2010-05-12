
The Atari 8-bit computer's operating system is stored on a ROM chip inside
the Atari. Without the OS, the Atari isn't capable of doing anything
useful. Also, many Atari programs are written in the Atari BASIC language,
which was an optional ROM cartridge on the 400/800 and 1200XL, but was
included as a built-in ROM in the 600XL, 800XL, and all XE machines.

To use the Atari800 emulator, you'll need suitable ROM images/dumps. You
can either use the original OS and BASIC from Atari, or an open source
OS replacement called OS++.

The original ROMs of course provide the best compatibility with software
for the Atari, but they are still copyrighted by Atari. In practice,
this doesn't cause a problem: the ROM images have been widely available
on the 'net for many years, and there has never been any legal action
taken regarding their use.

If you'd prefer to use Open Source code, there is a replacement ROM called
OS++, written from scratch by Thomas Richter (author of the Atari++
emulator) and released under the TPL (a variant of the Mozilla Public
License). Be aware that OS++ isn't 100% compatible with all software for
the Atari: it contains no support for the BASIC language or floating point
math. However, if your main purpose is to play games, you'll find that
(almost) all game cartridge ROMs work perfectly well with OS++. Many boot
disk games and XEX (binary load file) games work as well. OS++ runs on
XL/XE machines only, so you won't be able to emulate the original 400/800.

To use the original proprietary Atari ROMs, install the atari800_roms
package from slackbuilds.org

To use OS++ (a version slightly modified for use with Atari800 rather
than Atari++), install the atari800_os++ package instead.

If you like, you can install both packages and choose between them at
runtime by altering the symlink at /usr/share/atari800/roms/atarixl.rom, by
running atari800 with the -xlxe_rom switch, or by editing the config file
(~/.atari800.cfg, created the first time you run the emulator).

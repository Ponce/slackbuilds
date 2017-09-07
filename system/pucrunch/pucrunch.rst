.. RST source for pucrunch(1) man page. Convert with:
..   rst2man.py pucrunch.rst > pucrunch.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20081122
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

========
pucrunch
========

---------------------------------------------------
compressor optimized for low-resource decompression
---------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

pucrunch [*-options*] [*infile]* [*outfile*]]

DESCRIPTION
===========

Pucrunch is a Hybrid LZ77 and RLE compressor, uses an Elias Gamma Code
for lengths, mixture of Gamma Code and linear for LZ77 offset, and
ranked RLE bytes indexed by the same Gamma Code. Uses no extra memory
in decompression.

Input files can be arbitrary data (with *-d* option) or executables for
Commodore 64, VIC-20, C16, or Plus/4. Output is either a self-extracting
compressed Commodore executable, or a compressed data file suitable for
extracting via *pucrunch -u* or the included decompressor routines. See
/usr/doc/pucrunch-|version|/examples/\*.asm for 6502, 6809, and Z80
assembly code implementations of the decompressor.

Note: Because pucrunch contains both RLE and LZ77 and they are
specifically designed to work together, DO NOT RLE-pack your files
first, because it will decrease the overall compression ratio.

OPTIONS
=======

Pucrunch expects any number of options and up to two filenames. If you
only give one filename, the compressed file is written to the stardard
output. If you leave out both filenames, the input is in addition
read from the standard input. Options needing no value can be grouped
together. All values can be given in decimal (no prefix), octal (prefix
0), or hexadecimal (prefix $ or 0x). [*Note*: escape the *$* with quotes
or a backslash, to avoid your shell treating it as a metacharacter]

Example: pucrunch demo.prg demo.pck -m6 -fs -p2 -x0xc010

**-c<machine>**
       Selects the machine. Possible values are 128 (C128), 64 (C64),
       20 (VIC20), 16 (C16/Plus4), 0 (standalone). The default is 64, i.e.
       Commodore 64.

       If you use -c0, a file without the embedded decompression code
       is produced. This can be decompressed with a standalone routine
       and of course with pucrunch itself. Options marked with [*SFX*]
       have no effect if -c0 is used.

       The 128-mode is not fully developed yet. Currently it overwrites
       memory locations $f7-$f9 (Text mode lockout, Scrolling, and Bell
       settings) without restoring them later.

**-a**
       [*SFX*] Avoids video matrix if possible. Only affects VIC20 mode.

**-d**
       [*SFX*] Indicates that the file does not have a load address. A load
       address can be specified with -l option. The default load
       address if none is specified is 0x258.

**-l<addr>**
       [*SFX*] Overrides the file load address or sets it for data files.

**-x<addr>**
       [*SFX*] Sets the execution address or overrides automatically detected
       execution address. Pucrunch checks whether a SYS-line is present
       and tries to decode the address. Plain decimal addresses and
       addresses in parenthesis are read correctly, otherwise you need
       to override any incorrect value with this option.

**-e<val>**
       Fixes the number of escape bits used. You don't usually need or
       want to use this option.

**-r<val>**
       Sets the LZ77 search range. By specifying 0 you get only RLE.
       You don't usually need or want to use this option.

**+f**
       Disables 2MHz mode for C128 and 2X mode in C16/+4.

**-fbasic**
       [*SFX*] Selects the decompressor for basic programs. This version
       performs the RUN function and enters the basic interpreter
       automatically. Currently only C64 and VIC20 are supported.

**-ffast**
       [*SFX*] Selects the faster, but longer decompressor version, if such
       version is available for the selected machine and selected
       options. Without this option the medium-speed and medium-size
       decompressor is used.

**-fshort**
       [*SFX*] Selects the shorter, but slower decompressor version, if such
       version is available for the selected machine and selected
       options. Without this option the medium-speed and medium-size
       decompressor is used.

**-flist**
       List all available decompressors (the *-f* options above), for all
       supported machines. The list may contain more decompressors than are
       shown above (the extras might be experimental, use at your own risk).

**-fdelta**
       Allows delta matching. In this mode only the waveforms in the
       data matter, any offset is allowed and added in the
       decompression. Note that the decompressor becomes 22 bytes
       longer if delta matching is used and the short decompressor
       can't be used (24 bytes more). This means that delta matching
       must get more than 46 bytes of total gain to get any net
       savings. So, always compare the result size to a version
       compressed without -fdelta.

       Also, the compression time increases because delta matching is
       more complicated. The increase is not 256-fold though, somewhere
       around 6-7 times is more typical. So, use this option with care
       and do not be surprised if it doesn't help on your files.

**-n**
       Disables RLE and LZ77 length optimization. You don't usually
       need or want to use this option.

**-s**
       Display full statistics instead of a compression summary.

**-p<bits>**
       Fixes the number of extra LZ77 position bits used for the low
       part. If pucrunch tells you to to use this option, see if the
       new setting gives better compression.

**-m<bits>**
       Sets the maximum length value. The value should be 5, 6, or 7.
       The lengths are 64, 128 and 256, respectively. If pucrunch tells
       you to to use this option, see if the new setting gives better
       compression. The default value is 7.

**-i<0|1>**
       Defines the interrupt enable state to be used after
       decompression. Value 0 disables interrupts, other values enable
       interrupts. The default is to enable interrupts after
       decompression.

**-g<byte>**
       Defines the memory configuration to be used after decompression.
       Only used for C64 mode (-c64). The default value is $37.

**-u**
       Unpacks/decompresses a file instead of compressing it. The file
       to decompress must have a decompression header compatible with
       one of the decompression headers in the current version.

**-h**
       Print built-in help and exit.


COPYRIGHT
=========

As of 21.12.2005 Pucrunch is under GNU LGPL. See\:

  http://creativecommons.org/licenses/LGPL/2.1/
  http://www.gnu.org/copyleft/lesser.html

AUTHORS
=======

pucrunch was written by Pasi Ojala <a1bert@iki.fi>.

This man page consists of excerpts from the author's documentation. It
was written for the SlackBuilds.org project by B. Watson, and is licensed
under the same terms as the original docs.

SEE ALSO
========

cbmcombine(1), exomizer(1), vice(1)

The pucrunch homepage: http://a1bert.kapsi.fi/Dev/pucrunch/

The full documentation and sample decompressor code\:

  /usr/doc/pucrunch-|version|/

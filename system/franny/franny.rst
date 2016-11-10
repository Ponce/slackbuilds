.. RST source for franny(1) man page. Convert with:
..   rst2man.py franny.rst > franny.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 1.1.3
.. |date| date::

======
franny
======

-----------------------------
Atari 8-bit disk image editor
-----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

franny [*-options*] [*file.atr*]

franny-extract.sh [*file.atr*] [*target_directory*]

franny-insert.sh [*file.atr*] [*source_directory*]

DESCRIPTION
===========

Franny is an ATR and XFD disk image editor. It supports AtariDOS II and
SpartaDOS 2 and 3 disk formats. Single, enhanced, double, and custom
formats are supported, though writing to AtariDOS images is limited to
the first 720 sectors.

There are also two scripts:

franny-extract.sh
  dump all files from ATR or XFD to specified directory (works like atr2unix)

franny-insert.sh
  insert all files from specified directory to ATR (works like unix2atr)

OPTIONS
=======

All options that take an argument require a space between the option
and its argument, *except* the -L option, which doesn't allow a space.

Generally, uppercase options can be thought of as commands, which edit
the given disk image, and lowercase options can be thought of as options
to the uppercase commands.

-A
  Add file to image. Paths must be given by using -i and -o. Writing past
  sector 720 on an AtariDOS image is not supported.

-C
  Create new image. Will not be bootable. Use -d, -f, -m, -s, -t, -T options
  to control the image type. Default is 256 bytes per sector, 720 sectors,
  SpartaDOS filesystem, ATR image, normal (non-sio2ide) image type.

-d [s|d]
  Sector size for -C [single|double]; default: double. Single is 128 bytes/sector, double
  is 256.

-f [a|s]
  File system type for -C [AtariDOS II|Sparta 2.0]; default: Sparta 2.0.

-F
  Format image. Ignores any -d, -f, -m, -s, -t, -T options.

-h
  Show help and exit.

-i filename
  Input filename (source file for -A and -S). When using the -S option,
  the filename is treated case-insensitively, unless it contains a
  directory path.

-I
  Image summary. Shows disk label, filesystem type, density, total
  sectors, free sectors, image type (standard or sio2ide) and image
  media (ATR for ATR images, RAW for XFD images).

-l format
  List format used by -L. Default is **"A F.E S B D T"**. The format specifiers
  are:

  **A**: Attributes (R for locked files, D for directories, H for hidden files)

  **B**: Size in bytes

  **D**: Date. For AtariDOS images, this is always "00-00-2000".

  **E**: Filename extension

  **F**: Filename (minus the extension)

  **S**: Size in sectors

  **T**: Time. For AtariDOS images, this is always "00:00:00".

  Any other character represents itself. The list above is case-insensitive.

  For example, this gives a more AtariDOS-like display:

    franny -L -l "fe s" file.atr

-Lmask
  List directory. Mask is optional; default: \*.\* (all files). NOTE
  that NO SPACE is allowed before the mask, unlike all the other franny
  options! Also, the mask is case-sensitive (e.g. -L*.SYS, not -L*.sys).
  Files using the DOS 2.5 extra sectors on enhanced density disks will
  display, but without the < > around them like DOS 2.5 does.

-m [a|r]
  Media type for -C (atr|raw); default: atr. Raw images are also known as XFD images.

-M dirname
  Create directory. Only works for SpartaDOS images.

-N name
  Set volume name. Only works for SpartaDOS images.

-o filename
  Output filename (destination file for -A and -S). When using the -A option,
  the filename is treated case-insensitively, unless it contains a directory path.

-O [a|r]
  New media type (BROKEN). This option is apparently supposed to convert
  between ATR and XFD, but it doesn't appear to actually do anything.

-R dirname
  Remove dir. Only works for SpartaDOS images.

-s sectors
  Total sectors for -C. For standard single or double density, use 720. For 1050 enhanced
  density (aka 'medium'), use 1040.

-S
  Save (extract) filename from image. Paths must be given with -i and -o.

-t [s|m|d|f|F]
  Image templates for -C [single|medium|double|full/Full(65535 sectors, 128/256 bytes each)].
  Used for -C option. 's' is equivalent to "-s 720 -d s", etc.

-T [d|s]
  change image type (default|sio2ide). Only applies to ATR images, not RAW/XFD.

-U Filename
  Unlink (remove) file. filename is case-sensitive.

-v
  Show version and exit.

-V sector
  view (dump) sector in hex and ASCII. Output is OK for ATR images but
  badly formatted for raw/XFD.

EXIT STATUS
===========

franny returns 0 for success and non-zero for failure. On failure,
a diagnostic message is printed to standard error.

DIAGNOSTICS
===========

franny: You can specify only one command.

  Only one of the -A -C -I -L -M -N -O -R -S -T -U -V options may be given.

franny: Cannot open image '[*image*]'

  This means the image is invalid. Either it's not actually an Atari
  disk image, or it's a boot disk that doesn't contain a filesystem,
  or it's a truncated image (see NOTES), or you don't have permission
  to read the file.

franny: Specified file is not regular file.

  Means the image file or the file given to the -i / -o options doesn't
  exist, or is something other than a regular file or a symlink to a
  regular file (e.g. a directory or a device node).

franny: Command failed.

  Catch-all error message. Can be caused by:

    - attempting to access a nonexistant file in the image

    - a 'disk full' condition (trying to copy too much data into the image)

    - trying to create/delete a subdirectory on an AtariDOS image (currently not supported)

    - trying to delete or overwrite a locked file in the image (unfortunately franny has no way to unlock files)

franny: Cannot change directory.

  For SpartaDOS images, the given subdirectory doesn't exist within the image. Remember to use >
  as a path separator, and quote any arguments containing > to avoid the shell
  interpreting it as a redirection. Also, directory names are case-sensitive.

  For AtariDOS images, any attempt to copy files to/from a subdirectory
  will give this error, as subdirs aren't supported in AtariDOS images.

NOTES
=====

franny is intended for use only with disk images containing
AtariDOS/MyDOS-compatible or SpartaDOS 2/3 filesystems. Attempting to
edit non-filesystem-bearing images (such as boot disks) will fail and/or
have unpredictable results.

Most emulators support truncated or 'short' disk images, where only the
sectors actually used are stored in the file. franny is unable to operate
properly with truncated images, even if the missing part of the image
contains no filesystem data (sectors containing all zeroes). This type
of image can be turned back into a full image with a dd command such as

  dd if=truncated.atr of=fixed.atr bs=92176 count=1 conv=sync

92176 is for a single-density image. Replace with 184336 for double density
or 133120 for 1050 enhanced density. For ATR images, this is **(number_of_sectors * bytes_per_sector) + 16**. For XFD (raw) images, don't add the 16.

The -I option will mis-identify most non-filesystem boot or data disks as
containing a Sparta 2 filesystem. The other options will (usually?) fail
with 'Cannot open image' for non-fs disks (see DIAGNOSTICS).

Filenames within the image can be entered in lowercase with the -i or -o
options, but they're always converted to uppercase (and truncated to 8.3
format, if they're not already). If the filename contains a directory
path, only the base filename gets converted, NOT the directory name(s).
Also, this ONLY applies to -i and -o. The other options that take Atari
filenames require them to match exactly (e.g. -U autorun.sys will fail,
use -U AUTORUN.SYS instead).

There is no way to delete or overwrite a locked file within the image, as
franny has no Unlock option. There's also no Lock option.

Also missing is a Rename option. To rename a file, do something like this:

  franny -S -i sxhand.sys -o sxhand.sys image.atr

  franny -U SXHAND.SYS image.atr

  franny -A -i sxhand.sys -o autorun.sys image.atr

The above renames SXHAND.SYS to AUTORUN.SYS. Note that the -U option
required the filename in uppercase.

The -O option doesn't work. You can convert an ATR image to a raw one
with dd:

  dd if=disk.atr of=disk.xfd bs=16 skip=1

BUGS
=====

Some things are not implemented yet. Main disability is write support for
enhanced density in AtariDOS II disk format. Second problem is mydos's
subdirectories. An extra tool to develop is a gui.

The -O (new media type) option doesn't work.

The franny-insert.sh script will fail, if any of the files/directories
contain spaces or other shell metacharacters such as > or \|.

Report bugs to ten.egrofecruos.stsil@leved-8irata.

COPYRIGHT
=========

See the file /usr/doc/franny-|version|/copying for license information.

AUTHORS
=======

Rafael 'Bob_er' Ciepiela <ten.egrofecruos.sresu@re_bob> - Coder and designer of the franny program itself.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.


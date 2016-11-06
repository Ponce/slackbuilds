.. RST source for jbig2(1) man page. Convert with:
..   rst2man.py jbig2.rst > jbig2.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.28
.. |date| date::

=====
jbig2
=====

-----------------------------------
convert image files to JBIG2 format
-----------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**jbig2** [*-options*] *imagefile* > *output.jb2*

DESCRIPTION
===========

JBIG2 is an image compression standard from the same people who brought
you the JPEG format. It compresses 1bpp (black and white) images only.

jbig2enc is a library that encodes JBIG2 images.

**jbig2** is a command-line tool that uses the jbig2enc library to convert an
image to the JBIG2 format. *imagefile* can be in any format readable by
leptonica (png, jpeg, tiff, gif, webp, jp2, bmp, pnm, spix). The image
is converted to 1bbp (monochrome) before processing.

Without the *-p*, *--pdf* option, the converted image is written to
standard output. This should be redirected to a file, normally with
the *.jb2* extension. If stdout isn't redirected to a file (or a pipe),
the JBIG2 data will be written to the terminal, which may get confused.

There is no way to have **jbig2** read an image file on standard input. This
is by design, as it needs to seek within the file.

All options must appear before the filename. With the generic encoder
(no *-s* option), anything after the filename is silently ignored. The
symbol encoder (*-s*) can handle multiple images (which end up as pages
in the JBIG2 file).

The *-r*, *--refine* option mentioned in the documentation and in
the *--help* output of **jbig2** is *disabled* in this version of
**jbig2**.

OPTIONS
=======

.. some of these are from the HTML file, some from --help.

-b *basename*
  Output file root name when using symbol coding in PDF mode (*-s*
  and *-p*). Default is **output**.

-d, --duplicate-line-removal
  When encoding generic regions each scan line can be tagged to indicate
  that it's the same as the last scanline - and encoding that scanline
  is skipped. This drastically reduces the encoding time (by a factor
  of about 2 on some images) although it doesn't typically save any
  bytes. This is an option because some versions of jbig2dec (an open
  source decoding library) cannot handle this.

-p, --pdf
  The PDF spec includes support for JBIG2 (Syntax->Filters->JBIG2Decode in
  the PDF references for versions 1.4 and above). However, PDF requires
  a slightly different format for JBIG2 streams: no file/page headers or
  trailers and all pages are numbered 1. In symbol mode the output is to
  a series of files: symboltable and page-n (numbered from 0). By default
  these are named **output.sym** and **output.0000**, **output.0001**,
  etc. Use *-b* to change the base filename.

-s, --symbol-mode
  Use symbol encoding. Turn on for scanned text pages.

-t *threshold*
  Sets the fraction of pixels which have to match in order for
  two symbols to be classed the same. This isn't strictly true, as there are
  other tests as well, but increasing this will generally increase the number
  of symbol classes. Default is 0.85.

-T *threshold*
  Sets the black threshold (0-255). Any gray value darker than
  this is considered black. Anything lighter is considered white.
  Default is 188.

-O *outfile*
  Dump a PNG of the 1 bpp image before encoding. Can be used to
  test loss.

-2, -4
  Upscale either two or four times before converting to black and
  white.

-S
  Segment an image into text and non-text regions. This isn't perfect, but
  running text through the symbol compressor is terrible so it's worth doing
  if your input has images in it (like a magazine page).

--image-output
  Set filename to which the parts which were removed by -S are written.
  Default is PNG format.

-j, --jpeg-output
  Write images from -S as JPEG instead of PNG.

-a, --auto-thresh
  Use automatic thresholding in symbol encoder.

--no-hash
  Disables use of hash function for automatic thresholding.

-v
  Be verbose.

-V, --version
  Display version number and exit.

-h, --help
  Display help and exit.

EXIT STATUS
===========

**jbig2** exits with 0 (success) status if the conversion completed
OK, and non-zero status if anything went wrong. If standard output was
redirected to a file, the file will be empty or invalid when non-zero
status is returned. Diagnostic messages are printed to standard error.

COPYRIGHT
=========

See the file /usr/doc/jbig2enc-|version|/COPYING for license information.

This software is a description of processes which may be patented.

Use of this software may require patent licenses in some countries.
You are directed to annex I of the JBIG2 specification for information.

Some information could be found at:
    http://www.jpeg.org/jbig/index.html
    http://www.cl.cam.ac.uk/~mgk25/jbigkit/patents/
    http://www.jpeg.org/public/fcd14492.pdf
    http://itscj.ipsj.or.jp/sc29/open/29view/29n55161.doc

AUTHORS
=======

jbig2 and jbig2enc were written by:
  Adam Langley <agl@imperialviolet.org>.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**pdf.py(1)**, **jbig2dec(1)**

Full documentation for jbig2 and jbig2enc:
  /usr/doc/jbig2enc-|version|/jbig2enc.html

The JBIG2 specification was formerly located at:
  http://www.jpeg.org/public/fcd14492.pdf

A copy can be found here:
  http://www.hlevkin.com/Standards/fcd14492.pdf

SBo development/pli notes
=========================

The package is called pli, but the actual compiler binary is plic.
I've written a man page for it, but it's not very detailed. You should
read the HTML and PDF docs in /usr/doc/pli-$VERSION.

The compiler doesn't have a default include path. The documentation
claims that it looks in the current directory, but it won't even do
that without "-i ." on the command line.

PL/I doesn't seem to rely as heavily on includes as C does (very
few of the samples/ programs include anything at all). This package
installs the includes in /usr/lib/pli-$VERSION/include, which
gets symlinked as /usr/lib/pli/include. That's what you should
use for plic's -i option in your Makefile for a PL/I project.

x86_64 notes
------------

The package will always have i586 architecture, which might confuse
sbopkg and/or sbotools. However, it can be installed and run on pure
64-bit Slackware (without multilib).

The compiler is a fully statically linked 32-bit x86 executable. This
means it can be run on an x86_64 Slackware system even without
multilib. When compiling PL/I code to standalone executables (that
don't use the C library), the resulting binaries are also statically
linked 32-bit, and will run on non-multilib x86_64. For examples
of standalone use, see:

  /usr/doc/pli-$VERSION/samples/SA_make

What you *can't* do on x86_64 without multilib is link with the C
library (LC_make and LCC_make in samples/), or use the alt/ library
to use the C malloc() and free() for the PL/I heap. This means that
trying to build the samples will fail.

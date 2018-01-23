#!/bin/sh

# z26 is written partly in x86 (32-bit) assembly, so it can't be built
# for 64-bit. So the solution for running it on pure 64-bit systems is
# to use a static binary that doesn't require any 32-bit libs.

# Run this script on a 32-bit host *with VDSO disabled*, to generate
# the binary used for the 64-bit build.

# Notes:
# - libgcc_s.so has to be included or else z26 dumps core on exit.
# - libaoss and libasound are needed because z26 doesn't use SDL's
#   sound API, it talks directly to OSS via /dev/dsp.
# - libudev is needed for SDL to detect the mouse.
# - If you run "file" on the statified binary, it looks dynamic:
#   $ file /usr/games/z26 
#   /usr/games/z26: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, stripped
#   ...but ldd says it's "not a dynamic executable". This is normal
#   for statified binaries.
# - Do not attempt to strip the statified binary. It will break.

statifier --set=LD_PRELOAD=/usr/lib/libudev.so:/usr/lib/libaoss.so:/usr/lib/libasound.so:/usr/lib/libgcc_s.so /usr/games/z26 z26.static

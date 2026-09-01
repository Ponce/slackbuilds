#!/bin/sh
# strncpy() was removed from the kernel (see
# Documentation/process/deprecated.rst, gone as of Linux 7.2); ddcci/ddcci.c's
# sysfs attribute show functions use it and fail to build once it's gone.
# Detect this directly against the target kernel's own headers (rather than
# assuming a version number) and only then apply ddcci-sysfs-emit.patch,
# which rewrites those show() functions to use sysfs_emit()/sysfs_emit_at()
# -- the kernel's own documented replacement for raw buffer copies in show()
# methods, see https://docs.kernel.org/filesystems/sysfs.html. Pulled from
# https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/merge_requests/21
# (open, unmerged upstream as of 2026-08-24; not in any tagged release yet).
#
# Run from the top of the ddcci-driver-linux source tree, with the target
# kernel version as $1 (falls back to $KERNEL, then `uname -r`). Safe to run
# more than once (no-op if already applied, or if strncpy() is still
# available). Used both directly by the SlackBuild and as dkms.conf's
# PRE_BUILD (invoked as "./fix-strncpy.sh $kernelver"), so a DKMS-managed
# install keeps building correctly across future kernel upgrades on this
# machine, not just against the kernel present at packaging time. $kernelver
# is only available to PRE_BUILD as dkms.conf's own textual substitution
# (dkms does not export it to the script's environment), hence the
# positional argument rather than an env var.

set -e

KVER="${1:-${KERNEL:-$(uname -r)}}"
STRING_H="/lib/modules/$KVER/build/include/linux/string.h"

if [ ! -f "$STRING_H" ]; then
  exit 0
fi

if grep -Eq '\bstrncpy[[:space:]]*\([^)]*char' "$STRING_H"; then
  # strncpy() is still declared for this kernel, nothing to do.
  exit 0
fi

if grep -q 'sysfs_emit' ddcci/ddcci.c; then
  # Already applied.
  exit 0
fi

patch -p1 < ddcci-sysfs-emit.patch

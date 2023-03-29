.. RST source for bbf(1) man page. Convert with:
..   rst2man.py bbf.rst > bbf.8

.. |version| replace:: 20220524_0e90e04
.. |date| date::

===
bbf
===

----------------
bad block finder
----------------

:Manual section: 8
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

bbf [*options*] *instruction* *path*

DESCRIPTION
===========

**bbf** is a safer and more featureful tool for dealing with bad
blocks on hard drives. It's built around the workflow of dealing with
hard drive bad blocks. It has a number of features to limit risk in
using the tool and provides features to more easily track down what
files are affected by the bad blocks found. It also gives you the
ability to manually mark blocks as corrupted in cases where a block
isn't technically bad, but is causing issues.

FEATURES
========

 * readonly scanning of bad blocks
 * safe 'fix' mode which won't overwrite good blocks
 * burnin mode for checking new drives
 * manual marking blocks as corrupted
 * find files given list of blocks
 * dump list of files and associated block ranges
 * dump list of blocks used by a file
 * issue secure drive erasure
 * filesystem stressing


OPTIONS
=======

Arguments
---------

-f, --force
  override checking if drive is in use when trying to perform destructive actions

-t, --rwtype *os|ata*
  select between OS or ATA reads and writes (default: os)

-q, --quiet
  redirects stdout to /dev/null or otherwise limits output

-s, --start-block *lba*
  block to start from (default: 0)

-e, --end-block *lba*
  block to stop at (default: last block)

-S, --stepping *n*
  number of logical blocks to read at a time (default: physical / logical)

-o, --output *file*
  file to write bad block list to (default: $HOME/badblocks.*captcha*)

-i, --input *file*
  file to read bad block list from (default: $HOME/badblocks.*captcha*)

-r, --retries *count*
  number of retries on certain reads & writes

-c, --captcha *captcha*
  needed when performing destructive operations

-M, --maxerrors *n*
  max r/w errors before exiting (default: 1024)

Instructions
------------

**info**

  *path* is a block device. Prints out details about the block device.

**captcha**

  *path* is a block device. Prints out captcha needed for certain instructions.

**scan**

  *path* is a block device. A read-only scan of the block device for
  bad blocks. *rwtype=ata* will be slower but may catch more.

  Relevant options: rwtype, start block, end block, stepping, max errors, input file, output file.

**fix**

  *path* is a block device. Writes to bad blocks in an attempt to
  force the drive to reallocate the block. Attempts to read the block
  first and will write the read data if successful otherwise it will
  write zeros. This means it is pretty safe to use even if the blocks
  'fixed' aren't in fact damaged.

*rwtype=ata* will work better.

  Requires captcha.

  Relevant options: captcha, rwtype, force, input file.

**fix-file**

  *path* is a file. Gets the list of blocks that a file uses and then
  goes through each block reading what is there and then writing it
  back which will force reallocation if a block is bad.

  *rwtype=ata* will work better.

  Requires captcha.

  Relevant options: captcha, rwtype, retries.

**burnin**

  *path* is a block device. Iterates through the blocks of the device performing the following:

    1) Read block data (zero out on failure)

    2) Write 0x00's and read back to confirm data integrity.

    3) Write 0x55's and read back to confirm data integrity.

    4) Write 0xAA's and read back to confirm data integrity.

    5) Write 0xFF's and read back to confirm data integrity.

    6) Write back originally read data.

  Requires captcha.

  Relevant options: rwtype, start block, end block, stepping, max
  errors, retries, input file, output file.

**fsthrash**

  *path* is a directory. Spawns a number of threads to hammer the
  filesystem using a number of functions to stress the filesystem and
  underlying device. Functions include: create, open, mkdir, unlink,
  rmdir, write, read, close, readdir, stat, chmod, chown, link,
  symlink. Cleans up after itself on exit but does consume storage and
  inodes as it runs.

  Use *--quiet* to keep it from printing out what it is doing and improve performance.

**filethrash**

  *path* is a non-existent file. Creates a file, expands it to fill
  up the rest of the filesystem, and spawns a thread per core which
  writes 1MB blocks to the file at random offsets to stress the
  filesystem and unerlying device.

**find-files**

  *path* is a filesystem mount point. Attempts to find the
  files associated with any blocks listed in the bad block input
  file. Useful after running *scan* to find the files with bad blocks.

  Relevant options: input file.

**dump-files**

  *path* is a filesystem. Scans the filesystem and dumps a list of the files with the blocks on the device it occupies.

**file-blocks**

  *path* is an existing file. Prints out a list of all logical blocks the file uses.

**write-pseudo-uncorrectable-wl**

**write-pseudo-uncorrectable-wol**

**write-flagged-uncorrectable-wl**

**write-flagged-uncorrectable-wol**

  *path* is a block device. Marks blocks listed in the bad block input
  file as 'pseudo' or 'flagged' uncorrectable. Blocks marked 'pseudo',
  when read, cause the drive to perform normal error recovery and
  return errors if necessary. Blocks marked 'flagged', when read,
  will simply return errors indicating it is bad. 'wl' means 'with
  logging' and if read will result in failed reads being stored in
  SMART logs. 'wol' means 'without logging' and will not log any read
  failures in the SMART log.

  Relevant options: input file.

**security-erase**

  *path* is a block device. Issues an ATA Security Erase command to
  the device. What this means specifically is device specific but
  generally it is supposed to be like a low-level format. Use with
  care.

  Requires captcha.

  Relevant options: captcha.

**enhanced-security-erase**

  Theoretically a more thorough version of the standard ATA Security
  Erase command. Similarly its function depends on the device and may
  be the same as the regular security erase.

  Requires captcha.

  Relevant options: captcha.

EXAMPLES
========

| # bbf info /dev/sdb
| /dev/sdi:
|  - serial_number: XXXXXXXX
|  - firmware_revision: SC61
|  - model_number: ST8000VN0022-2EL112
|  - RPM: 7200
|  - features:
|    - form_factor: 3.5"
|    - write_uncorrectable: 1
|    - smart_supported: 1
|    - smart_enabled: 1
|    - security_supported: 1
|    - security_enabled: 0
|    - security_locked: 0
|    - security_frozen: 0
|    - security_count_expired: 0
|    - security_enhanced_erase_supported: 1
|    - security_normal_erase_time: 698
|    - security_enhanced_erase_time: 698
|    - block_erase: 0
|    - overwrite: 1
|    - crypto_scramble: 0
|    - sanitize: 1
|    - supports_sata_gen1: 1
|    - supports_sata_gen2: 1
|    - supports_sata_gen3: 1
|    - trim_supported: 0
|  - block_size:
|    - physical: 4096
|    - logical: 512
|    - stepping: 8
|  - block_count:
|    - physical: 1953506646
|    - logical: 15628053168
|  - size:
|    - bytes: 8001563222016
|    - human:
|      - base2: 7.28TB
|      - base10: 8.00TiB
|

| # bbf -S 256 -t ata scan /dev/sdb
| start block: 0
| end block: 15628053168
| stepping: 256
| logical block size: 512
| physical block size: 4096
| read size: 131072
| Scanning: 0 - 15628053168
| Current: 2425512192 (15.52%); bps: 179384.74; eta: 20:26:39; bad: 0
|

| # bbf captcha /dev/sdb
| Z8400VR0
|

| # bbf -i ~/badblocks.Z8400VR0 -c Z8400VR0 fix /dev/sdb
|

| # bbf -q fsthrash /mnt/mydrive0
| CTRL-C to exit...
| ^CCleaning up...
|

| # bbf filethrash /mnt/mydrive0/test
| Creating file: /mnt/mydrive0/test
| Expanding file to fill drive: 200209731584 bytes
| Spawning thrashing threads: 4 (one per core)
| CTRL-C to exit...

COPYRIGHT
=========

See the file /usr/doc/bbf-|version|/LICENSE for license information.

AUTHORS
=======

**bbf** was written by Antonio SJ Musumeci <trapexit@spawn.link>.

This man page created for the SlackBuilds.org project by
B. Watson. Since it's just copy/pasted from README.md, the man page is
licensed the same as **bbf** itself.

SEE ALSO
========

**badblocks**\(8), **smartctl**\(8), **fsck**\(8)

The **bbf** homepage: https://github.com/trapexit/bbf

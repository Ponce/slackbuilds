# rmw v0.7.01

rmw (ReMove to Waste) is a cross-platform command-line "trash can"
utility. It can send files to your "Desktop" trash, or a completely
separate folder; restore files and append a unique string to the
filenames so they won't be overwritten (duplication protection).

Web site: https://remove-to-waste.info/

## Build Status

* [Travis Build](https://travis-ci.org/theimpossibleastronaut/rmw) ![Build Status](https://travis-ci.org/theimpossibleastronaut/rmw.svg?branch=master)
* [Semaphore Build](https://semaphoreci.com/andy5995/rmw-3) ![Build Status](https://semaphoreci.com/api/v1/andy5995/rmw-3/branches/master/badge.svg)

## Screenshots

![rmw usage output](https://remove-to-waste.info/images/Screenshot_2018-11-01_21-45-05_911x795.png)

[More Screenshots](https://remove-to-waste.info/screenshots.html)

## Contact / Support

See website [Help and Support section](https://remove-to-waste.info/#support)

## Required libraries

libncursesw

If you are building from source, you will need the libncursesw(5 or 6)-dev
package from your operating system distribution.

Note: On OpenBSD, you must precede `./configure` with `MENU_LIBS=-lmenuw`.
Example:

    MENU_LIBS=-lmenuw ./configure

Note: rmw has been built on Windows 2 years ago using Cygwin but it
didn't use the proper directories. We have no Windows developers
working on this project and are hoping that some will join soon!. As
stated in the description, the goal of this project is a
"cross-platform" utility; so getting rmw to work reliably on Windows is
still on the TODO list.

## Compiling

### As a normal user:

Use `../configure --help` to view available compile-time options.

    mkdir build
    cd build
    ../configure
    make

### Installing without superuser privileges

If you would like to install rmw without superuser privileges, use a prefix
that you have write access to. Example:

    ../configure --prefix=$HOME/usr
    make
    make install

rmw will be installed to $HOME/usr/bin and the configuration file will be
copied to $HOME/usr/etc

### Pre-built binary packages

Packages for some operating systems are available on the
[Downloads](https://github.com/theimpossibleastronaut/rmw/releases) page

### Using _Homebrew_ on Mac OS X

Add a tap and install rmw:

* brew tap [theimpossibleastronaut/homebrew-extras](https://github.com/theimpossibleastronaut/homebrew-extras)
* brew install rmw

## Uninstall / Cleaning up

* make uninstall (uninstalls the program if installed with 'make install`)
* make distclean (removes files in the build directory created by
`configure` and 'make')

## Usage
```
== First-time use ==

If you installed rmw as a normal user, this next step can be skipped.

After rmw is installed, create the user configuration directory by
typing 'rmw' and hitting enter. A configuration file will be
automatically created in $HOME/.config/rmw. Edit the file as desired.

== Configuration File ==

Documentation explaining the configuration can be found in rmwrc.

Waste folders will be created automatically. (e.g. if '$HOME/trash.rmw'
is listed in the config file, these 3 directories will be created:
$HOME/trash.rmw
$HOME/trash.rmw/files
$HOME/trash.rmw/info

If one of the WASTE folders is on removable media, then the user has the
option of appending ',removable' (details in etc/rmwrc).

== Features and Options ==

Usage: rmw [OPTION]... FILE...
ReMove the FILE(s) to a WASTE directory listed in configuration file

   or: rmw -s
   or: rmw -u
   or: rmw -z FILE...
Restore FILE(s) from a WASTE directory

-h, --help
-t, --translate           display a translation of the configuration file
-c, --config filename     use an alternate configuration
-l, --list                list waste directories
-g, --purge               run purge even if it's been run today
-o, --orphaned            check for orphaned files (maintenance)
-f, --force               allow purge to run
-v, --verbose             increase output messages
-w, --warranty            display warranty
-V, --version             display version and license information


	===] Restoring [===

-z, --restore <wildcard filename(s) pattern>
-s, --select              select files from list to restore
-u, --undo-last           undo last ReMove

== Purging ==

If purging is 'on', rmw will permanently delete files from the folders
specified in the configuration file after 'x' number of days. Purging can be
disabled by using 'purge_after = 0' in configuration file. rmw will only check
once per day if it's time to purge (use -g to check more often).

Purge requires -f (--force) to run.

To skip that requirement, add the line

force_not_required

to your configuration file.

The day of the last purge is stored in $HOME/config/rmw/lastpurge

== Empty the Trash ==

To empty the trash completely, rmw can use the environmental variable
RMWTRASH. Usage:
RMWTRASH=empty rmw -fg

== -z option ==

To restore a file, or multiple files, specify the path to them in in the
<WASTE>/files folder (wildcards ok).
e.g. 'rmw -z ~/.local/share/Trash/files/foo*'

Files can also be restored using only the basename, from within any directory.
NOTE: That feature will not process wildcards unless the user is in a
<WASTE>/files folder and the filespec actually exists in the present working
directory.

== -t, --translate ==

A translation of the configuration file in your native
language (if available) will be displayed.

(If you would be interested in adding a translation, please visit
https://github.com/theimpossibleastronaut/rmw/wiki/Translating)

== -f, --force ==

rmw will normally refuse to purge directories if they contain non-writable
subdirectories. You can use -f 2 times if you ever see a message that tells
you "permission denied; directory still contains files" (e.g. rwm -gff).

## Notes

After you use rmw, it will create a 'lastpurge' and 'lastrmw' file in
$HOME/config/rmw. `lastpurge` contains the day of the last time rmw did
a purge check (it only checks once per day). `lastrmw` contains the
filenames of the last rmw operation; the file is read when `rmw -u` is
used.

```

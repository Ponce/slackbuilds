# rmw-0.7.04

## Description

rmw (ReMove to Waste) is a safe-remove utility for the command line.
Its goal is to conform to [the FreeDesktop.org Trash
specification](https://specifications.freedesktop.org/trash-spec/trashspec-latest.html)
and therefore be compatible with KDE, GNOME, XFCE, and others. Desktop
integration is optional however, and by default, rmw will only use a
waste folder separated from your desktop trash. One of its unique
features is the ability to purge files from your Waste/Trash
directories after x number of days.

Web site: <https://remove-to-waste.info/>

## Build Status

* [![Build Status](https://travis-ci.org/theimpossibleastronaut/rmw.svg?branch=master)](https://travis-ci.org/theimpossibleastronaut/rmw)
* [![Build Status](https://semaphoreci.com/api/v1/andy5995/rmw-3/branches/master/badge.svg)](https://semaphoreci.com/andy5995/rmw-3)

## Screenshots

![rmw usage output](https://remove-to-waste.info/images/Screenshot_2019-07-05_22-47-51.png)

[More Screenshots](https://remove-to-waste.info/screenshots.html)

## Contact / Support

* [Bug Reports and Feature Requests](https://github.com/theimpossibleastronaut/rmw/blob/master/CONTRIBUTING.md#bug-reports-and-feature-requests)
* [General Help, Support, Discussion](https://remove-to-waste.info/#support)

## Required libraries

* libncursesw (ncurses-devel on some systems, such as CentOS)
* gettext (or use --disable-nls if you only need English language support)

If you are building from source, you will need the libncursesw(5 or
6)-dev package from your operating system distribution. On some systems
just the ncurses packages is needed, and it's often already installed.

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

The rmw binary will be installed to `$HOME/usr/bin` and documentation to
`$HOME/usr/doc`.

### If configure fails

On **OSX**, ncursesw isn't provided by default but can be installed
using `brew install ncurses`. Then precede `./configure` with
`PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig"` Example:

    PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig" ../configure

If you can't use [brew](https://brew.sh/), or install libncursesw or
libmenuw some other way, rmw will use `ncurses` but you may experience
[this minor
bug](https://github.com/theimpossibleastronaut/rmw/issues/205).

Note: rmw has been built on **Windows** 2 years ago using Cygwin but it
didn't use the proper directories. We have no Windows developers
working on this project and are hoping that some will join soon!. As
stated in the description, the goal of this project is a
"cross-platform" utility; so getting rmw to work reliably on Windows is
still on the TODO list.

## Uninstall / Cleaning up

* make uninstall (uninstalls the program if installed with 'make install`)
* make distclean (removes files in the build directory created by
`configure` and 'make')

## Usage
```
== First-time use ==

After rmw is installed, running `rmw` will create a configuration file
(rmwrc) in $HOME/.config (or $XDG_CONFIG_HOME). Edit the file as
desired.

== Configuration File ==

Documentation explaining the configuration can be found in your config
file.

Waste folders will be created automatically; e.g. if '$HOME/.local/share/Waste'
is uncommented in the config file, these 3 directories will be created:
$HOME/.local/share/Waste
$HOME/.local/share/Waste/files
$HOME/.local/share/Waste/info

If one of the WASTE folders is on removable media, then the user has the
option of appending ',removable'.

If a folder has ',removable' appended to it, rmw will not try to create
it; it must be initially created manually. If  the folder exists when
rmw is run, it will be used; if not, it will be skipped. Once you
create "example_waste", rmw will automatically create
example_waste/info and example_waste/files

    e.g: WASTE=/mnt/sda10000/example_waste, removable

== Features and Options ==

Usage: rmw [OPTION]... FILE...
ReMove the FILE(s) to a WASTE directory listed in configuration file

   or: rmw -s
   or: rmw -u
   or: rmw -z FILE...
Restore FILE(s) from a WASTE directory

-h, --help
-c, --config filename     use an alternate configuration
-l, --list                list waste directories
-g, --purge               run purge even if it's been run today
-o, --orphaned            check for orphaned files (maintenance)
-f, --force               allow purge to run
-e, --empty               completely empty (purge) all waste folders
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

The time of the last automatic purge check is stored in `purge-time`,
located in $HOME/.local/share/rmw (or $XDG_DATA_HOME/rmw).

== -e, --empty ==

Completely empty (purge) all waste folders

== -u, --undo ==

Restores files that were last rmw'ed. No arguments for `-u` are
necessary. The list of files that were last rmw'ed is stored in `mrl`, located in
$HOME/.local/share/rmw (or $XDG_DATA_HOME/rmw).

== -z, --restore ==

To restore a file, or multiple files, specify the path to them in in the
<WASTE>/files folder (wildcards ok).
e.g. 'rmw -z ~/.local/share/Trash/files/foo*'

Files can also be restored using only the basename, from within any directory.
NOTE: That feature will not process wildcards unless the user is in a
<WASTE>/files folder and the filespec actually exists in the present working
directory.

== -f, --force ==

A change from previous versions, purge is allowed to run without the '-f'
option. If you'd rather require the use of '-f', you can add the line
'force_required' in your configuration file.

rmw will refuse to purge directories if they contain non-writable
subdirectories. You can use -f 2 times if you ever see a message that tells
you "permission denied; directory still contains files" (e.g. rwm -gff).

```

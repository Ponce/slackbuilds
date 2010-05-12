Atari800 is an Atari 800, 800XL, 130XE and 5200 emulator for Unix, Amiga,
MS-DOS, Atari TT/Falcon, SDL and WinCE. Our main objective is to create a
freely distributable portable emulator (i.e. with source code available).

This build of atari800 uses SDL for graphics/sound, and has no other
dependencies.

To use the emulator, you will need a set of Atari ROM images. Install
the atari800_roms package to get the official (proprietary) ROM images,
or the atari800_os++ package to use an Open Source replacement ROM,
with some loss of compatibility/functionality.

(Actually, a very small handful of cartridge games will run with no OS
ROM image at all: Star Raiders, Montezuma's Revenge, and Atari Basketball
all work fine. Most other carts won't work, and no disks or tapes will).

This package registers new MIME types for Atari-related files in the
shared-mime-info database. After installation, it should be possible to
run Atari machine language executables (XEX files), Atari BASIC programs,
and disk/cartridge/cassette images by double-clicking them in Konqueror
or on the KDE desktop (or GNOME, if you've installed that). If you
don't want the package to include the MIME types and auto-registration,
set MIME_TYPES=no in the environment.

This package, by default, enables serial port emulation via a TCP port.
When an Atari program that uses the R: (serial port) device is run, the
emulator listens for connections on a TCP port, and the Atari program
"sees" data received from the port as though it were coming from the
Atari serial port. Although there are no known security issues with
this, the security-conscious types may wish to disable this behaviour.
To disable, set RIO_DEVICE=no in the environment.

Optionally, the various Atari file formats can be registered with the
Linux kernel's binfmt_misc mechanism, so it's possible to run Atari
native executables from the shell, if their executable bits are turned
on (e.g. with "chmod +x"). To enable this, add lines like these to your
/etc/rc.d/rc.local:

if [ -x /etc/rc.d/rc.atari8bit_binfmt_misc ]; then
   /etc/rc.d/rc.atari8bit_binfmt_misc start
fi

...then "chmod +x /etc/rc.d/rc.atari8bit_binfmt_misc" to
enable on the next boot. If you don't want to reboot, run
"/etc/rc.d/rc.atari8bit_binfmt_misc start".

If you're using a custom kernel, make sure binfmt_misc is compiled in,
either statically or as a module. The Slackware 12.x -generic kernels
ship with binfmt_misc as a module, which will be loaded by the rc script
if necessary.

Note that the neither the KDE desktop integration nor the binfmt_misc
script will handle raw ROM cartridge images. This is because there's no
"signature" that can be used to auto-detect them, and filename globbing
is a bad idea since many emulators use raw dumps with .rom as the default
filename extension. Also, the current version of atari800 requires an
extra -cart argument for raw ROM images. To convert a raw ROM to a CART
image that can be used with KDE or binfmt_misc, load it with "atari800
-cart filename.rom", choose the cartridge type, then press F1 to enter
atari800's menu, select "Cartridge Management", then "Create cartridge
from ROM image". Save the file with .car or .cart as the extension.

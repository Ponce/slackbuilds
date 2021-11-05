TL;DR version: if you want the ROMs to be included in the package,
find the file "intv.zip" (and optionally "intv_ecs.zip") somewhere on
the internet and place it in the SlackBuild directory, before running
the script.

Long version:

By default, this package does not contain the ROM images due to
copyright concerns. You can use the ROMs from the commercially
available "Intellivision Lives!" CD-ROM, dump the ROMs from an
Intellivision console, or attempt to find the ROMs on the 'net
somewhere. These are the same ROMs used by the MAME/MESS emulator.

For the Intellivision console, there are 2 ROM images, usually
found in a file called "intv.zip". Contents:

exec.bin, 8192 bytes, md5sum 62e761035cb657903761800f4437b8af
grom.bin, 2048 bytes, md5sum 0cd5946c6473e42e8e4c2137785e427f

If you also want to emulate the Computer Module (aka the Entertainment
Computer System), you'll also need its ROM, usually found in a file
called "intv_ecs.zip". Contents:

ecs.bin, 24576 bytes, md5sum 2e72a9a2b897d330a35c8b07a6146c52

*or*, split into 3 files:

ecs_rom.20, 8192 bytes, md5sum 52f0bbbaff9ca21e619eb0ad5d85f9fb
ecs_rom.70, 8192 bytes, md5sum 83efe70ebb42e3ded46ac76d851838a0
ecs_rom.e0, 8192 bytes, md5sum ee2d7856f667ed66430be88871d86c39

Your md5sums may not match, since Mattel released several versions of
the ROMs. The above are known to work, but other versions might also
work.

If you want to include the ROM images in the package, place either
the zip file(s) (intv.zip, and intv_ecs.zip if you need it) or the
unzipped contents in the SlackBuild directory... or if you have them
installed already in a previous jzintv package, or if you have them in
/usr/share/games/mame/roms, the script will find them there also. You
can also export JZINTV_ROM_PATH in the environment, to find the ROMs
there.

If you'd rather install the ROMs manually: build the package without
them, install it, then copy them to /usr/share/games/jzintv/rom. If
your ECS ROM is split into 3 files, join them with a command like:

cat ecs_rom.20 ecs_rom.70 ecs_rom.e0 > ecs.bin

jzintv looks for the .bin files, not the .zip file(s).

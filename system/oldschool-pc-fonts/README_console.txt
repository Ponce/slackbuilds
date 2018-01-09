
If psftools is installed when oldschool-pc-fonts.SlackBuild is run,
the .FON fonts in the upstream zip file will be converted to .psfu fonts
and installed in /usr/share/kbd/consolefonts.

If you have psftools installed and *don't* want this package to include
console fonts, you can set CONSOLE=no in the script's environment.

The console font filenames begin with Bm_437. You can try them out in
the console with a command like:

setfont -v Bm437_IBM_MDA_10

...in other words, the filename, minus the path and .psfu extension.

When you find a font you like, edit /etc/rc.d/rc.font, and add
the font name to the "setfont" command there. Also run "chmod +x
/etc/rc.d/rc.font".

The new fonts *do not* show up in the menu shown by the Slackware
"setconsolefont" utility, since it uses a hard-coded list of fonts.

Since these fonts were designed for displays from the 1970s and 80s, you
might find them too small to read on modern high-resolution systems. If
so, you can use a 'video=' kernel argument in /etc/lilo.conf to change
the default resolution of the console. Also you may be able to use fbset
to change the resolution without rebooting, but this doesn't work on some
(most?) modern video hardware.

Unicode support is pretty sparse with these fonts. They only support the
glyphs found in the MS-DOS codepage 437 character set, although they do
include Unicode mappings so that e.g. codepoint U263A is rendered as a
smiley face (aka character code 1, in codepage 437). You should get a
full set of box-drawing characters for use with 'dialog', at least.

For the full character set supported, see:

https://en.wikipedia.org/wiki/Codepage_437

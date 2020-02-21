For now, the xcowsay SlackBuild remains one version behind the latest
release. This is because the latest (1.5) release doesn't work for
everybody.

Starting with version 1.5, xcowsay requires a compositing window manager
that supports alpha channels. This build is for version 1.4, the last
one which works correctly with traditional window managers such as
WindowMaker or FVWM. Version 1.4 also works fine in environments where
1.5 would work. If you *really* want version 1.5, download its source
to the SlackBuild's directory and build it with a command like:

# VERSION=1.5 BUILD=1 TAG=_custom ./xcowsay.SlackBuild

Hopefully, some future version of xcowsay will make the compositing
support optional (and maybe even autodetected), so this script can be
updated to track new xcowsay releases again.

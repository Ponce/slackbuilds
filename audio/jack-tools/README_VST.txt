jack-tools includes a utility called "jack-lxvst", which is a host for
Linux native VST plugins.

For licensing reasons, the VST headers (copyright Steinberg) cannot
be included in this SlackBuild. If you need jack-lxvst, you'll have to
register as a developer at https://www.steinberg.net/ and download the VST
developers' kit from there. You want version 2.x of the dev kit (which may
no longer be available; not sure if version 3.x works with jack-lxvst). Once
you've downloaded the files and extracted them, do one of these things:

- Copy or symlink the files aeffect.h and aeffectx.h to the jack-tools
  directory (the one that contains jack-tools.SlackBuild).

- Or, export VST_HEADERS=<path> in the environment before running the
  SlackBuild. <path> is the directory that contains the files aeffect.h
  and aeffectx.h. Example: export VST_HEADERS=/usr/local/include/VST

If all went well, when you install the jack-tools package, the description
will say "This package was built WITH Steinberg Linux VST support". Just
to be on the safe side, do not redistribute the package. I'm not a lawyer
and I'm not sure whether Steinberg's license would allow redistribution
of a compiled binary using the VST headers.

If you did the above but the build fails to compile, you might be using
the wrong version of the VST headers. This would be a problem for upstream
(the actual author of jack-tools) to fix, so report it there.

The above only has to be done if you actually need jack-lxvst. If you
don't know whether you need it, read this FAQ:

Q: What is VST?
A: If you don't know, you don't need jack-lxvst, and you can stop
   reading now.

Q: What is a Linux native VST?
A: The vast majority of VST plugins (effects and instruments) are
   distributed as Windows executables (or DLLs). A Linux native VST is a
   Linux executable (or shared library), either distributed as source and
   compiled by the user, or (more often) as a precompiled binary. Linux
   native VST plugins are pretty rare, although they do exist.

Q: What is jack-lxvst?
A: jack-lxvst is a standalone host for Linux native VSTs. If you don't
   use Linux native VSTs, you don't need jack-lxvst.

Q: I want to use Linux native VST plugins in my DAW, which has Linux
   native VST support. Do I need jack-lxvst?
A: No. If your DAW supports Linux native VST plugins, you don't need a
   separate host for them (such as jack-lxvst).

Q: I have this Windows VST plugin I want to use on Linux, do I need
   jack-lxvst?
A: No. jack-lxvst is only for Linux native VST plugins. For Windows VSTs,
   try wineasio. Ardour can also be built with Windows VST support,
   using WINE. Whatever solution you find for Windows VSTs on Linux
   will pretty much have to involve WINE somehow.

Q: I have a Linux native VST I want to use with my DAW, but my DAW
   doesn't have VST support. Can I use jack-lxvst for this?
A: Yes. This is the intended use for jack-lxvst.

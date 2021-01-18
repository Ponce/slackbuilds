The main purpose for cmake-202x is to allow SlackBuild scripts to
build software that needs a cmake newer than the version that ships
with Slackware 14.2.

If you're writing a new SlackBuild or updating an old one, and you're
using cmake.template, but you get an error complaining that CMake is
too old, here's how to use this:

1. Change the "cmake" command in your SlackBuild to
   /opt/cmake-202x/bin/cmake. In context, it will look like:

   mkdir -p build
   cd build
     export "PATH=/opt/cmake-202x/bin:$PATH"
     cmake \
       -DCMAKE_C_FLAGS:STRING="$SLKCFLAGS" \
       -DCMAKE_CXX_FLAGS:STRING="$SLKCFLAGS" \
   ...etc, etc.

2. Add cmake-202x to the REQUIRES in your .info file.

That's it. Your SlackBuild shouldn't need any other changes. If you
want to look at a complete SlackBuild script that uses cmake-202x,
see academic/bibletime.

Note: If you're using cmake interactively (developing software outside
the context of SlackBuild scripts), there are a couple of things you
might want to add to your .bash_profile to make things smoother:

  export PATH=/opt/cmake-202x/bin:$PATH
  export MANPATH=/opt/cmake-202x/man:$MANPATH

Then when you type "cmake", you'll get the new version. Also "man
cmake" will show the man page for the new version. You *don't* need
this stuff in a SlackBuild script!

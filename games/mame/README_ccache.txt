Notes about building modern mame with ccache...

TL;DR version: I had to use clang and clang++ (not gcc and g++) to get
ccache to work with mame, and add timestamps to the GroovyMAME patch
to make it work with ccache.

mame uses a precompiled header (PCH), called emu.h.gch. It gets
created by precompiling emu.h, which is just a list of #include
directives that include every header in mame's emulation core.

This speeds up the build approximately 50% (cuts the build time in
half)... you can test this by passing PRECOMPILE=0 to mame's make
command. On my test box, it takes approximately 1h45m to build with
gcc using the precompiled headers, and about twice as long (3h30m)
without. So far so good.

If you build with ccache and PCH (aka without PRECOMPILE=0), either
with "ccache g++" or via symlinks, the 2nd build takes just as long as
the first. ccache wasn't able to save any time... why not?

To get ccache to even *try* to work with precompiled headers, you
have to 'export CCACHE_SLOPPINESS=time_macros'. However, it doesn't
actually fix the problem if you're using gcc.

One "fix" would be to disable use of emu.cgh (PRECOMPILE=0). But
that makes the first build take 2x as long (though later builds would
indeed benefit from ccache). But can we get the best of both worlds?

When gcc compiles a header into a .gch file, it "bakes in" the address
the kernel gave it when it allocated memory... Since Slackware's
kernels (and pretty much all other distros) have ASLR (address space
layout randomization) enabled, this means that given identical input,
gcc will generate a slightly different .gch file as output. You
can easily test this yourself:

  echo 'extern int foo(int bar);' > a.h
  g++ -o a.gch a.h
  md5sum a.gch

Now repeat the last 2 commands:
  g++ -o a.gch a.h
  md5sum a.gch

The md5sum will be different... it's possible to disable ASLR on a
running x86_64 kernel (echo 0 > /proc/sys/kernel/randomize_va_space),
which will cause gcc to generate an identical .gch every time...
but last I checked, this doesn't work on 32-bit x86. Plus, ASLR is
there for a reason: it's a security mechanism.

ccache dutifully caches the .gch file, indexed by its hash... but
on the next attempt to build mame with ccache, the .gch file it
generates (early in the build) will have different contents, thus
ccache computes a different hash, and correctly finds no cache entry
for that hash. So, every C++ source file that uses emu.gch (which is
all of them) will be a cache miss and get recompiled. Whoops.

So what to do? Well, it turns out that clang++ doesn't have this
problem: given identical input, it produces the same .gch every time,
regardless of whether ASLR is enabled or not. Note: "identical input"
includes not only the contents of emu.h and the headers it includes,
but the timestamps on those headers as well!

Unfortunately, on my test box at least, clang/clang++ takes 10%
longer to build mame than gcc/g++. I've seen various blog/forum posts
claiming that clang builds mame faster than gcc, but these were all
from a few years ago. To me, this 10% penalty is worth it: whenever
there's a new mame release, I have to test any changes I made to the
SlackBuild, which involves running it repeatedly. The first run will
take about 2 hours, but the 2nd and later ones will take <10 minutes.

There's a bit more to the story than just using clang++: I
noticed that with the GroovyMAME patch applied, ccache would still
fail... this turns out to be because, even with CCACHE_SLOPPINESS set
to include_file_mtime, ccache still rejects the cached emu.gch. The
is because emu.gch is made from emu.h, which contains a bunch of
"#include <whatever>"... and the timestamps of those included files
get baked into the .gch file that clang++ generates.

Try another test:

  echo '#include "b.h"' > a.h
  echo 'extern int foo(int bar);' > b.h
  clang++ -o a.gch a.h
  md5sum a.gch

Now repeat the last 2 commands:

  clang++ -o a.gch a.h
  md5sum a.gch

Same md5sum, right? Now:

  sleep 2
  touch b.h
  clang++ -o a.gch a.h
  md5sum a.gch

Different md5sum. clang++ produced a different a.gch because b.h's
timestamp changed. Notice we aren't using ccache for the test code:
this is a feature (or misfeature?) of clang++ itself.

The reason this was a problem with mame + the groovy patch is that the
groovy patch as sent to us by github.com's REST API doesn't include
timestamps (normally they appear on the diff lines that begin with
'--- filename' and '+++ filename'). This isn't github's fault: the
regular 'git diff' command doesn't put timestamps in its diffs, and
the API is just running that for us, remotely.

So on every run of the SlackBuild, ccache runs clang++ to generate
emu.gch, and the emu.gch contents include the timestamps of the
patched includes... which are set to the time the patch happened to be
applied! This means that any file that includes emu.gch (pretty much
all of them!) would be a cache miss and have to be recompiled. So on
every run, ccache would refuse to use *any* cached result from the
previous run!

CCACHE_SLOPPINESS=include_file_mtime seems like it should fix the
problem, but it doesn't. It would have worked if we weren't using
PCH...

The solution was to add timestamps to the context headers in the .diff
(which is done in mkgroovy.sh) and use "patch -f -Z" to force patch to
apply the timestamps.

If the diff had been made by the regular diff command, it would have
had timestamps already, and ccache would have Just Worked.

If mame didn't use precompiled headers, the lack of timestamps
wouldn't have caused a problem (or if they had, CCACHE_SLOPPINESS
could have worked around it).

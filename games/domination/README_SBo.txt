Notes on the SlackBuild. Probably only of interest to SBo packagers.
This stuff was comments in the script, until it got too long.

There's no audio in this game. That's not a bug or anything, it's designed
that way.

The source is included in the package (src.zip), but nothing like a
Makefile or build.xml. I have no idea how to build it. If I knew how, or
wanted to spend the time/effort (and grit my teeth & ignore my distaste
for all things Java), I'd try to build it with gcc-java... any takers?

Slackware 14.2 ships with gij, gcc-java's bytecode interpreter. I tried
running 'gij -jar Domination.jar' and was able to start a single-player
(vs. AI) game, but 'play online' threw a crypto exception:

java.security.NoSuchAlgorithmException: Algorithm [RSA] of type [Cipher] from provider [gnu.javax.security.auth.callback.GnuCallbacks: name=GNU-CALLBACKS version=2.1] is not found

Not sure if this is something that can be worked around or not. A bit
of googling led me to something called the Bouncy Castle JCE, which
adds crypto support and might work with gcc-java... but, that's more
involved with Java than I want to get. If you want to check it out and
maybe submit a build for it, see: http://www.bouncycastle.org/java.html

This is a binary package, everything in one dir. move around to make
sense. Have to have a wrapper script and symlink forest in user's
homedir, since it expects to write to the dir it runs from. Looks
like help/ lib/ maps/ resources/ can be symlinked. game.ini and saves/
need to be user-writable.

The various *.sh scripts run with different frontends. Unless someone
requests any of the others, I'm only going to care about the main
one (run.sh) and the swing one (which has the map editor). There's a
command-line frontend, but it looks like it wouldn't be much fun to play:
doesn't even draw ASCII art maps, not menu driven, uses long command
names and no readline/etc. I assume the Domination maintainers use it
for testing purposes.

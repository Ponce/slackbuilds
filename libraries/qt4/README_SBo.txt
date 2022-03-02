There are a few deliberate differences between this qt4 and the one
that was in Slackware 14.2 as (as "qt"):

- The install prefix is /usr/lib(64)?/qt4 (note that 14.2 used
  /usr/lib(64)?/qt). This is because qt4 is no longer a core
  Slackware package, and to avoid confusing users (and scripts).

- The profile.d scripts are installed non-executable, and are intended
  to stay that way. This is to avoid conflicts between our qt4 and
  Slackware's qt5.

What this means for users of SBo builds that use qt4: Nothing
special. You just install qt4 when you need it as a dependency.
It lives in its own directory, and it won't conflict with qt5.

What it means for the maintainers of SBo builds that use qt4:

1. If your script uses cmake, you might not have to change anything.
   cmake is smart enough to find Qt4 without help from the environment.
   For instance, quazip-qt4 didn't need any changes.

2. If your script uses qmake, replace the qmake command with qmake-qt4.
   If it also uses lrelease, moc, and/or uic, replace those with the
   -qt4 versions as well.

3. If the above doesn't work, your script should run
     source /etc/profile.d/qt4.sh
   before it compiles anything. I recommend putting it right after the
   "set -e" line in the template. An example script that uses this
   is kardsgt.

4. If your script refers to any files in $PKG/usr/lib$LIBDIRSUFFIX/qt,
   you'll have to change the 'qt' part to 'qt4'. The best way to do
   this is to use the $QT4DIR variable: it's defined in qt4.sh (which
   you already sourced), and in the unlikely event the qt4 directory
   ever changes again, your script won't break. An example of a script
   that needed this change is qt-assistant-compat.

Note: if you're writing a new script and getting errors about qt4 not
being installed, it might mean that your script depends on qt4... but
before you decide that's the case, check and see if whatever you're
building offers an option (configure flag, cmake variable, whatever)
to use qt5. Also it's worth checking to see if someone has already
ported it to qt5 (check upstream's git repo, packages.debian.org, the
Arch AUR, the Gentoo ebuild repo, etc). qt4 is outdated and EOLed, and
will eventually have to go away... not in Slackware 15, but at some
point, gcc probably will change enough to make qt4 unbuildable on some
future Slackware version.

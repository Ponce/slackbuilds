cc65 releases are few and far between, so unlike most SlackBuilds, this
one packages a git snapshot. The build is only updated once or twice a
year, but you might find you need a later snapshot that fixes a bug or
adds a feature that you need.

To build a specific tag or commit of the cc65 source, use the git2tarxz.sh
script included in the SlackBuild directory. For instance, to build a
package of the 2.17 release:

# sh git2tarxz.sh V2.17

You could use a commit hash instead:

# sh git2tarxz.sh 8e75906

The last lines of output from git2tarxz.sh show the filename of
the created tarball and the VERSION you should set in the script's
environment. For the above example:

Created tarball: cc65-2.17_20180307.tar.xz
VERSION=2.17_20180307

So you'd this this command to build the package:

# VERSION=2.17_20180307 sh ./cc65.SlackBuild

Notes:

- Obviously I haven't tested every single commit. There are thousands
  of them. If the SlackBuild fails, either use a different commit,
  or contact me on IRC (user Urchlay on FreeNode ##slackbuilds or the
  email address in the .info file) and I'll try to help.

- git2tarxz.sh will probably fail on Slackware-current. Use 14.2 to
  prepare the source, even if you're going to build on -current. See
  the comments in the script about linuxdoc-tools for details.

- The output of "cc65 --version" will always include the git commit that
  was used to build it. This might be useful to know, if you're messing
  around with different revisions.

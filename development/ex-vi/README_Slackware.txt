
To avoid conflicting with Slackware's elvis and vim packages, this build
installs binaries to /opt/ex-vi/bin and man pages to /opt/ex-vi/man,
along with a script in /etc/profile.d to prepend these paths to PATH and
MANPATH. If you *really* want, you can replace the /usr/bin/vi symlink
(that normally points to elvis or vim), but it shouldn't be necessary.

After installing, either log out & back in, or "source
/etc/profile.d/ex-vi.sh". To temporarily disable the scripts, remove
their execute bits. Users can always set PATH and MANPATH in their own
dotfiles, of course.

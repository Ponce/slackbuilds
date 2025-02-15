# profile.d script for SBo flac-opt build, WTFPL, B. Watson.

# don't know if MANPATH might be set already, so cover both cases.

Mtmp=@PREFIX@/man

if [ -z "$MANPATH" ]; then
  MANPATH="$Mtmp"
else
  MANPATH="$Mtmp:$MANPATH"
fi

unset Mtmp

# PATH will already be set (in /etc/profile) so don't worry about it.

PATH=@PREFIX@/bin:$PATH

export PATH
export MANPATH

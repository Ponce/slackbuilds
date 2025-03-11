#!/usr/bin/bash
_MANPATH=/usr/man

if [[ $MANPATH != *"$_MANPATH"* ]]; then
	MANPATH=/usr/man:$MANPATH
fi

MANPATH="$_MANPATH" sh /usr/share/tkman/tkman.tcl

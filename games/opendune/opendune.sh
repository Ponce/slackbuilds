#!/bin/sh

# shell script wrapper for SBo games/opendune
# written by B. Watson, licensed under the WTFPL.

# this wrapper is needed because the game uses timidity in alsa client
# mode for MIDI audio, but doesn't start timidity itself (it just tells
# you to). so this script starts it, if necessary (and if possible). if
# timidity isn't installed, we don't complain about it, just run the
# game without it (the game will complain so this script doesn't have to).

# if timidity or some other alsa client is running (if there are writable
# MIDI ports other than 'MIDI Through'), we won't start anything.

# when the game is through running, we have to kill off timidity if we
# started it (not if it was already running). unfortunately timidity's
# daemon mode doesn't write a PID file, and it forks so we can't easily
# get the PID, so we can't use daemon mode.

# the code in src/audio/midi_alsa.c of the game will actually connect
# to the first writable, subscribable port it can find, other than
# "Midi Through". so if the user's already running some MIDI daemon
# like FluidSynth, the game will use it, and we shouldn't be starting
# timidity here.

# KNOWN ISSUE: if lashd is running, it sometimes creates a MIDI port that
# doesn't appear in aconnect's list, but opendune will see & connect to
# it. Result is that you get no complaint about timidity not running,
# but don't hear any audio either.

if [ "$( aconnect -o | grep -v 'Midi Through' )" = "" ]; then
	if which timidity &> /dev/null; then
		timidity -iAq &
		kidpid="$!"

		# it might take timidity a while to start up & register its MIDI port.
		# we wait up to 10 sec for it to start.
		for i in 0 1 2 3 4; do
			sleep $i
			if [ "$( aconnect -o | grep TiMidity )" != "" ]; then
				break
			fi
		done
	fi
fi

# run the game, wait for it to exit. its status will be the
# return value of this script.
/usr/libexec/opendune/opendune "$@"
retval="$?"

# kill timidity, if we started it. PIDs can get reused, we don't
# want to kill some random process if timidity already exited and
# its PID got reused, so check & make sure it really is timidity.
if [ "$kidpid" != "" ]; then
	if [ "$( ps h -o comm $kidpid )" = "timidity" ]; then
		kill "$kidpid"
	fi
fi

exit $retval

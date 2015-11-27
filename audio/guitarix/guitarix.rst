.. RST source for guitarix(1) man page. Convert with:
..   rst2man.py guitarix.rst > guitarix.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.32.3
.. |date| date::

.. converting from pod:
.. s/B<\([^>]*\)>/**\1**/g
.. s/I<\([^>]*\)>/*\1*/g

========
guitarix
========

------------------------------------------
guitar amp simulator and effects processor
------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

guitarix [*-options*]

DESCRIPTION
===========

Guitarix is a rock guitar amplifier for Jack (Jack Audio Connection
Kit) with one input and two outputs. It is designed to get nice
trash/metal/rock guitar sounds.  Guitarix comes with a GTK+ graphical
user interface and a set of LADSPA plugins. This manual page describes
the GTK+ interface.

Guitarix provides one JACK input port and two JACK output ports.
Controls for bass, treble, gain, compressor, preamp, balance, distortion,
freeverb, crybaby (wah) and echo are available. A fixed resonator is
used when distortion is disabled. To modify the sound 'pressure', you
can use the feedback and feedforward sliders.

Guitarix includes an experimental tuner and a JACK MIDI output port
with 3 channels. They are fed by a mix from a pitch tracker and a
beat detector. You can pitch the octave (2 octaves up or down), choose the
MIDI channel, the MIDI program, the velocity and the sensitiviy, which
translates into how fast the note will read after the beat detector
emits a signal. Values for the beat detector can be set for all
channels.

OPTIONS
=======

All parameters are optional. Examples::

  guitarix
  guitarix -r gx4-black -i system:capture_3
  guitarix -c -o system:playback_1 -o system:playback_2

Help Options:
  -h, --help                      Show help options
  --help-all                      Show all help options
  --help-style                    GTK style configuration options
  --help-jack                     JACK configuration options
  --help-overload                 Switch to bypass mode on overload condition
  --help-file                     File options
  --help-debug                    Debug options
  --help-gtk                      Show GTK+ Options

GTK style configuration options
  -c, --clear                     Use 'default' GTK style
  -r, --rcset=STYLE               Style to use, 'gx1-alloy', 'gx2-emerald', 'gx3-dezert', 'gx4-black', 'gx5-gree', 'gx6-blue', 'gx7-blues', 'gx8-dark', 'gx9-flat', 'gx9-grass'

JACK configuration options
  -i, --jack-input=PORT           Guitarix JACK input
  -o, --jack-output=PORT          Guitarix JACK outputs
  -m, --jack-midi=PORT            Guitarix JACK midi control
  -J, --jack-no-conect            dissable self-connect JACK ports
  -n, --name=NAME                 instance name (default gx_head)
  -U, --jack-uuid=UUID            JackSession ID
  -A, --jack-uuid2=UUID2          JackSession ID
  -s, --server-name=NAME          JACK server name to connect to

Switch to bypass mode on overload condition
  -I, --idle-timeout=SECONDS      starved idle thread probe (default: disabled)
  -C, --no-convolver-overload     disable overload on convolver missed deadline
  -X, --xrun-overload             JACK xrun (default: false)
  -S, --sporadic=SECONDS          allow single overload events per interval (default: disabled)

File options
  -f, --load-file=FILE            load state file on startup
  -P, --plugin-dir=DIR            directory with guitarix plugins (.so files)
  -K, --disable-save-on-exit      disable auto save to state file when quit
  -a, --auto-save                 enable auto save (only in server mode)

Debug options
  -B, --builder-dir=DIR           directory from which .glade files are loaded
  --style-dir=DIR                 directory with skin style definitions (.rc files)
  -t, --log-terminal              print log on terminal
  -d, --dump-parameter            dump parameter table in json format

GTK+ Options
  --class=CLASS                   Program class as used by the window manager
  --gtk-name=NAME                 Program name as used by the window manager
  --screen=SCREEN                 X screen to use
  --sync                          Make X calls synchronous
  --gtk-module=MODULES            Load additional GTK+ modules
  --g-fatal-warnings              Make all warnings fatal

Application Options:
  -v, --version                   Print version string and exit
  -N, --nogui                     start without GUI
  -p, --rpcport=PORT              start a JSON-RPC server listening on port PORT
  -H, --rpchost=HOSTNAME          set hostname to connect to
  -G, --onlygui                   start only GUI
  -L, --liveplaygui               start with Live Play GUI
  -M, --mute                      start with engine muted
  --display=DISPLAY               X display to use


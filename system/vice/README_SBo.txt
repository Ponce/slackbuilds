Optional dependencies: ffmpeg and SDL2.

Vice can use ffmpeg to record videos of the emulated machine. If
ffmpeg is installed, it will be autodetected. If you have ffmpeg
installed but don't want ffmpeg support, you'll have to removepkg
ffmpeg before building (there's no way to override the autodetection).

By default, vice will be built with SDL2 if it's installed, otherwise
SDL1. You can set SDL=1 to force building with SDL1 even if SDL2 is
installed.

If you want to build without PulseAudio, set PULSE=no in the environment.

Note: To use the standard application menu instead of the in-emulator
PETSCII menu, GTK3 v3.22 is required. Slackware 14.2 ships with 3.18
and there is no upgrade package for this. Slackware -current has
3.22. So to use the normal application menus, either use Slackware
-current or find a way to upgrade your Slackware 14.2's GTK3 to
v3.22. The SlackBuild maintainer has NOT tested this build with
Slackware -current, you're on your own if it doesn't work (fix it and
send me a patch if you can).

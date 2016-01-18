# ssr.SlackBuild
SimpleScreenRecorder is a Linux program that I've created to record programs and games. 
SimpleScreenRecorder is a screen recorder for Linux. Despite the name, 
this program is actually quite complex. It's 'simple' in the sense
 that it's easier to use than ffmpeg/avconv or VLC :).
 
 This will also build your multi-lib for x86_64 with Alien Bobs multi-lib installed
 
 NO you do not need ffmpeg-compat32 installed this allows you to capture 32 bit gaming like Steam audio
 
 Pulseaudio and Jack are enabled by default to build with out one or the other
 
 You can pass these options.
 
 PULSE=no ./ssr.SlackBuild
 
 JACK=no  ./ssr.SlackBuild
 
 Or for both.
 
 PULSE=no JACK=no ./ssr.SlackBuild
 
 
 Optional dependency:libav (libavformat, libavcodec, libavutil, libswscale)
 
 
 This requires:ffmpeg 

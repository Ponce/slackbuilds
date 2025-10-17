#!/bin/bash
unset _JAVA_OPTIONS
unset _JAVA_AWT_WM_NONREPARENTING
cd "${HOME}"
/opt/android-studio-for-platform-Stable.3.7/bin/studio "$@"

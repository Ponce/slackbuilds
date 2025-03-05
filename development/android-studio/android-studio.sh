#!/bin/bash
unset _JAVA_OPTIONS
unset _JAVA_AWT_WM_NONREPARENTING
cd "${HOME}"
/opt/android-studio/bin/studio "$@"

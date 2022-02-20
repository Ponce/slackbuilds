#!/bin/sh

# wrapper script for ggmud, part of SlackBuilds.org ggmud build.
# written by B. Watson, licensed under the WTFPL.
# this script is needed because ggmud segfaults if it's started
# from anywhere but its install directory.

cd @OPT@/ggmud && exec ./ggmud "$@"

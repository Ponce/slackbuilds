# mozjpeg.sh: part of the SBo mozjpeg build, by B. Watson
# <yalhcru@gmail.com>. Source this file in your shell, to run
# mozjpeg's binaries by default, and to compile software with
# mozjpeg's libraries. Not installed +x by default to avoid
# conflicting with Slackware's libjpeg-turbo package.

export PATH=/opt/mozjpeg/bin:$PATH
export PKG_CONFIG_PATH=/opt/mozjpeg/lib@/pkgconfig:$PKG_CONFIG_PATH

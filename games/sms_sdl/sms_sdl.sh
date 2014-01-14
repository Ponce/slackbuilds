#!/bin/bash

# 20091011 bkw: Wrapper script for sms_sdl, does the following:

# - Savestates and screenshots will be saved in ~/.sms_sdl/
# - A ~/.sms_sdl/config file will be read if present, and converted to
#   command-line options for the real sms_sdl binary.

# To make things work properly, we have to run the real emulator binary
# with its cwd set to ~/.sms_sdl/, and create a symlink to the ROM file
# in the same directory. After the emu exits, we remove the symlink.

sms_exe="/usr/libexec/sms_sdl"
sms_userdir=~/.sms_sdl
conf_file="$sms_userdir/config"

romfile=""
conf_args=""

set -e

mkdir -p $sms_userdir

if [ -e "$conf_file" ]; then
	while read line; do
		# remove comments
		line="${line/\#*/}"
		case "$line" in
			"") ;;   # ignore empty lines
			-*)
				conf_args="$conf_args $line"
				;;
			*)
				conf_args="$conf_args --$line"
				;;
		esac
	done < "$conf_file"
fi

for arg; do
	case "$arg" in
		-h|-help|--help|-\?)
			$sms_exe
			exit 0
			;;

		--*)
			conf_args="$conf_args $arg"
			;;

		*)
			if [ -z "$romfile" ]; then
				arg="$( readlink -f "$arg" )"
				romfile="$( basename "$arg" )"
				( cd $sms_userdir ; rm -f "$romfile" ; ln -s "$arg" . )
			fi
			;;
	esac
done

set +e
if [ -z "$romfile" ]; then
	$sms_exe
else
	cd $sms_userdir
	$sms_exe $conf_args "$romfile"
	rm -f "$romfile"
fi

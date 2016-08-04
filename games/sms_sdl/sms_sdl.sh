#!/bin/bash

# 20091011 bkw: Wrapper script for sms_sdl, does the following:

# - Savestates and screenshots will be saved in ~/.sms_sdl/
# - A ~/.sms_sdl/config file will be read if present, and converted to
#   command-line options for the real sms_sdl binary.

# To make things work properly, we have to run the real emulator binary
# with its cwd set to ~/.sms_sdl/, and create a symlink to the ROM file
# in the same directory. After the emu exits, we remove the symlink.

# 20160804 bkw: various fixes and enhancements.
# - Make --filter <mode> and --fskip <n> options work from
#   the command line. They work already in a config file, which is why
#   I didn't notice they were broken for *7 years*.
# - Fix the usage message so it doesn't show the /usr/libexec/ path.
# - Make the return value of the script match the return value of the emulator.
# - Add support for single-file zipped ROMs, since I have so many of them.

sms_exe="/usr/libexec/sms_sdl"
sms_userdir=~/.sms_sdl
conf_file="$sms_userdir/config"

romfile=""
conf_args=""

set -e

usage() {
	$sms_exe | sed "/^Usage:/s,$sms_exe,sms_sdl,"
}

unzip_rom() {
	# extract one file (hopefully a ROM image) from a zip file. if there are
	# more files (ROMs or otherwise), they will be ignored.

	# look for known filename extensions first, in case there are readme or
	# file_id or whatever inside the zipfile.
	romfile="$( zipinfo -1 "$1" | egrep -i '\.(sms|gg|rom|bin)$' | head -1 )"

	# if none found, just grab the first filename and hope for the best.
	if [ -z "$romfile" ]; then
		romfile="$( zipinfo -1 "$1" | head -1 )"
	fi

	unzip "$arg" "$romfile" -d $sms_userdir || exit 1
}

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
	if [ "$needparam" = "1" ]; then
		conf_args="$conf_args $arg"
		needparam=0
	else
		case "$arg" in
			-h|-help|--help|-\?)
				usage
				exit 0
				;;

			--filter|--fskip)
				conf_args="$conf_args $arg"
				needparam=1
				;;

			--*)
				conf_args="$conf_args $arg"
				;;

			*)
				if [ -z "$romfile" ]; then
					case "$arg" in
						*.zip|*.ZIP*|*.Zip)
							unzip_rom "$arg" # sets romfile
						;;
						*)
							arg="$( readlink -f "$arg" )"
							romfile="$( basename "$arg" )"
							( cd $sms_userdir ; rm -f "$romfile" ; ln -s "$arg" . )
					esac
				fi
				;;
		esac
	fi
done

set +e
if [ -z "$romfile" ]; then
	usage
	exit 1
else
	cd $sms_userdir
	#echo $sms_exe $conf_args "$romfile"
	$sms_exe $conf_args "$romfile"
	rv="$?"
	rm -f "$romfile"
	exit $rv
fi

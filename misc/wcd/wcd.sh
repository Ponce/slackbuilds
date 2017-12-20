wcd() {
	/usr/bin/wcd "$@"
	. ${WCDHOME:-${HOME}}/bin/wcd.go
}

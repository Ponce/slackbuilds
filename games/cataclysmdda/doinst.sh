# HACK: The binary build depends on this symlink present
if [ ! -e /usr/lib64/libtinfo.so.5 ]
then
	if [ ! -e /usr/lib64/libtinfo.so ]
	then
		echo "libtinfo.so cannot be found. Expect problems"
	fi
	echo "Creating symlink /usr/lib64/libtinfo.so.5 => /usr/lib64/libtinfo.so"
	ln -s /usr/lib64/libtinfo.so /usr/lib64/libtinfo.so.5
fi


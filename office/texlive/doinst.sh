# Temporarily add /usr/share/texmf/bin to $PATH or 
# the updmap-sys and fmtutil-sys calls will not work 
TEMP_PATH=$PATH
export PATH=/usr/share/texmf/bin:$PATH

# This one shouldn't be needed, but just in case...
chroot . /usr/share/texmf/bin/mktexlsr 1>/dev/null 2>/dev/null

# This is to generate /usr/share/texmf-var/ stuff
chroot . /usr/share/texmf/bin/updmap-sys --nohash --syncwithtrees 1>/dev/null 2>/dev/null
chroot . /usr/share/texmf/bin/mktexlsr 1>/dev/null 2>/dev/null
chroot . /usr/share/texmf/bin/fmtutil-sys --all 1>/dev/null 2>/dev/null

# Just in case...
export PATH=$TEMP_PATH
unset TEMP_PATH


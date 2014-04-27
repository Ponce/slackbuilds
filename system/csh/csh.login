# /etc/csh.login: This file contains login defaults used by csh and tcsh.

# This version is slightly modified for use with the SlackBuilds.org build of
# Berkeley csh (but still works with tcsh). Changes are marked with ##BKW.
# For tcsh, this behaves exactly like the original.

# Set up some environment variables:
if ($?prompt) then
	umask 022
	set cdpath = ( /var/spool )
	set notify
	set history = 100
        setenv MANPATH /usr/local/man:/usr/man
	setenv MINICOM "-c on"
	setenv HOSTNAME "`cat /etc/HOSTNAME`"
	setenv LESS "-M"
	setenv LESSOPEN "|lesspipe.sh %s"
	set path = ( $path /usr/games )
endif

# If the user doesn't have a .inputrc, use the one in /etc.
if (! -r "$HOME/.inputrc") then
	setenv INPUTRC /etc/inputrc
endif

# I had problems with the backspace key installed by 'tset', but you might want
# to try it anyway instead of the section below it.  I think with the right
# /etc/termcap it would work.
# eval `tset -sQ "$term"`

# Set TERM to linux for unknown type or unset variable:
if ! $?TERM setenv TERM linux
if ("$TERM" == "") setenv TERM linux
if ("$TERM" == "unknown") setenv TERM linux

##BKW unfortunately plain csh doesn't support the handy prompt % macros, so
# we have to do some complex and ugly stuff for csh. However, tcsh will still
# use the macros.

# Set the default shell prompt:
if $?tcsh then
	set prompt = "%n@%m:%~%# "
else
	set _promptchar = $prompt
   # cache the hostname, assume it will never change (usually true)
	set _hostname = `hostname`
	alias _setprompt 'set prompt="$user@${_hostname}:$cwd$_promptchar "'
	alias cd 'cd \!*;_setprompt'
	alias chdir 'chdir \!*;_setprompt'
	alias pushd 'pushd \!*;_setprompt'
	alias popd 'popd \!*;_setprompt'
	cd
endif

# Notify user of incoming mail.  This can be overridden in the user's
# local startup file (~/.login)
biff y >& /dev/null

# Set an empty MANPATH if none exists (this prevents some profile.d scripts
# from exiting from trying to access an unset variable):
if ! $?MANPATH setenv MANPATH ""

# Append any additional csh scripts found in /etc/profile.d/:
##BKW plain csh doesn't support [ ] unless nonomatch is set, so move the
# 'set nonomatch' and 'unset nonomatch' outside of the for loop.
set nonomatch
[ -d /etc/profile.d ]
if ($status == 0) then
        foreach file ( /etc/profile.d/*.csh )
                [ -x $file ]
                if ($status == 0) then
                        source $file
                endif
        end
        unset file
endif
unset nonomatch

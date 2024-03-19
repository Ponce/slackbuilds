# $RCSfile: doinst.sh,v $
# $Revision: 1.9 $
# $Date: 2023-05-11 07:58:15+01 $
# DW

# NOTE DO:
# PLEASE only keep the functions/sections/commands that you need.
# PLEASE delete EVERYTHING else (including these comments).
# PLEASE let us know in the comment section of the upload form if including
#        custom functions or commands.

# NOTE PLEASE DO NOT:
# Add or change user or group accounts.
# Change any of the default system settings files.
# Add commands that take forever to complete.
# Use applications like checkinstall or installwatch, that 'touch' every file
# on the system.


# NOTE on paths
# Most commands do not have an initial '/' in directory path arguments so that
# they work correctly when using pkgtools --root <path> or $ROOT options.
# Installpkg and friends chdir to $ROOT or --root <path> before installing packages.
# The exceptions are the 'chroot' commands which do use an initial '/'.
# The chroot command is used to avoid files on the host being changed when
# using --root or $ROOT.
#
# Example: /usr/bin/update-desktop-database -q usr/share/applications
#          ^Full path for command^             ^No initial slash^

# NOTE on tests
# [ -e <path> ]    => Tests if a directory or file exists.
# [ -x <command> ] => Tests if command is executable.
#                     Will also fail silently if not -e too.

# NOTE on redirections
# Most commands redirect stdout and stderr to /dev/null to keep down the noise.
# If you need to see error messages while testing, the easiest way is to
# temporarily comment out 2>&1.

# FUNCTION:    config()
# DESCRIPTION: Discards identical copies of config and rc.INIT files.
# ARGUMENTS:   A single filename.
# NOTE
# Files should be installed with a .new extension.
# Example: etc/rc.d/rc.myshinynewdaemon.new
# We don't clobber if it's avoidable.
# "slackpkg new-config" is one way that users can list+process .new files.

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# FUNCTION:    preserve_perms()
# DESCRIPTION: Keeps the executable bit that a user may have set (or unset) on
#              an rc.INIT or config file since she first installed a package.
# ARGUMENTS:   A single filename.
# NOTE
# This calls the above config() function to discard identical copies.
# Files should be installed with a .new extension.
# Use for files in etc/rc.d/ and etc/profile.d/
# Other config files may also need this.

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

# FUNCTION:    schema_install()
# DESCRIPTION: Installs options (schemas) to the gnome config database.
# ARGUMENTS:    A single filename.
# NOTE Not to be confused with glib schemas

schema_install() {
  SCHEMA="$1"
  GCONF_CONFIG_SOURCE="xml::etc/gconf/gconf.xml.defaults" \
  chroot . gconftool-2 --makefile-install-rule \
    /etc/gconf/schemas/$SCHEMA \
    1>/dev/null
}

config etc/nvidia-container-runtime/config.toml.new
config usr/share/containers/oci/hooks.d/oci-nvidia-hook.json.new


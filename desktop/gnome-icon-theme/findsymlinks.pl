#!/usr/bin/perl -w

# 20240821 bkw: Find symlinks. Call from a SlackBuild, after 'cd $PKG'
# and before 'makepkg'. Call as "perl $CWD/findsymlinks.pl >> install/doinst.sh".
# Do not expect this script's +x bit to be set; it won't be.

# For each symlink, print a pair of doinst.sh lines, then remove the symlink.
# This happens *many* times faster than makepkg's make_install_script()
# function, especially when there are thousands of symlinks. The output
# is (or should be) identical to the lines makepkg would add to doinst.sh.

# Feel free to use this in your own SlackBuilds. It has been
# thoroughly tested with gnome-icon-theme. If you run into problems
# with it, please email me at urchlay@slackware.uk so I can fix it.

use File::Find;

sub wanted { # dead or aliiive!
	return unless -l $_; # only care about symlinks.
	$found{join("/", $File::Find::dir, $_)} = [$File::Find::dir, $_];
}

find(\&wanted, ("."));

# since makepkg sorts the symlinks, we will too.
for(sort keys %found) {
	my $dir = substr($found{$_}[0], 2); # remove leading ./
	my $target = $found{$_}[1];
	my $src = readlink($_);

	for my $name ($dir, $src, $target) {
		# escape special chars; regex comes from makepkg itself, but with
		# ] and } added. \x27 is a single-quote, BTW.
		$name =~ s,[] "#\$\&\x27()*;<>?[\\`{}|~],\\$&,g;
	}

	print "( cd $dir ; rm -rf $target )\n( cd $dir ; ln -sf $src $target )\n";
	unlink $_;
}

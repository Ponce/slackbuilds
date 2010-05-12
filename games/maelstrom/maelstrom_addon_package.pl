#!/usr/bin/perl -w

# maelstrom_addon_package.pl - create a Slackware tgz
# package from a Maelstrom addon zip file, for use with
# the SlackBuilds.org maelstrom package.

# Beware: only *one* addon may be installed at a time!

# This script is meant to work on a stock Slackware system, so it
# doesn't use any CPAN modules (which makes the code a bit awkward).

# Author: B. Watson (yalhcru@gmail.com)

# This program is released into the public domain; do as ye list wi' her.
# Author not responsible for any damages resulting from the use of this
# program.

use strict;
use File::Find; # core Perl module, not CPAN

our $GAMEDIR = "/usr/share/games/Maelstrom";

chomp(our $pkgver = `date +%Y%m%d`);

our $pkgname;
our $spritefile;
our $soundfile;
our @text_files;

sub usage() {
	warn <<EOF;
Usage: maelstrom_addon_package.pl zipfile [pkgname]

Creates a Slackware tgz package from a Maelstrom addon zip file. The
zipfile may be either a local file (e.g. "my_addon.zip") or a URL
(e.g. "http://example.com/foo_addon.zip").

The output file will be located in /tmp, and will be named

	maelstrom_addon_pkgname-YYYYMMDD-noarch-1_mael.tgz

where pkgname is the [pkgname] argument, or derived from the zipfile name if
no [pkgname] is given on the command line, and YYYYMMDD is the current date.

The resulting .tgz package is suitable for installation with installpkg.
However, only one Maelstrom addon package may be installed at a time
(since the addon filenames are the same, the 2nd one would overwrite the
first one).

Since the script must be able to create files as the root user, you
must run it with root privileges (e.g. with su or sudo).

You can find a collection of Maelstrom add-on zip files here:

	http://www.devolution.com/~slouken/Maelstrom/add-ons.html
EOF
	exit 1;
}


sub make_temp_dir() {
	my $dir = "/tmp/maelstrom_addon_" . rand(10000000) . $$;
	system("mkdir -p \"$dir\"") && die "can't create $dir\n";
	return $dir;
}

sub extract($$) {
	my $tmpdir = shift;
	my $archive = shift;
	system("cd \"$tmpdir\" && unzip \"$archive\"") &&
		die "can't extract $archive in $tmpdir\n";
}

sub cleanup(@) {
	for my $tmpdir (@_) {
		system("cd \"$tmpdir\" && rm -rf *");
		system("cd / && rmdir \"$tmpdir\"");
	}
}

sub make_slack_desc($) {
	my $package_dir = shift;

	mkdir($package_dir . "/install");
	open my $f, ">$package_dir/install/slack-desc";
	print $f "$pkgname: Maelstrom add-on sprites/sound package\n";
	print $f "$pkgname:\n" for (1..10);
	close $f;
}

sub copy_files($) {
	my $package_dir = shift;

	system("mkdir -p $package_dir/usr/share/games/Maelstrom");
	system("mkdir -p $package_dir/usr/doc/$pkgname-$pkgver");

	system("cp \"$_\" $package_dir/usr/doc/$pkgname-$pkgver") for @text_files;

	if($spritefile) {
		system("cp \"$spritefile\" " .
				"$package_dir/usr/share/games/Maelstrom/\%Maelstrom_Sprites");
	}

	if($soundfile) {
		system("cp \"$soundfile\" " .
				"$package_dir/usr/share/games/Maelstrom/\%Maelstrom_Sounds");
	}
}

sub wanted {
	my $file = $File::Find::fullname;
	if(/\.txt$/i) {
		warn "Found text file: $file\n";
		push @text_files, $file;
	} elsif(/\%?maelstrom.sounds(?:\..*)?$/i) {
		warn "Found sounds: $file\n";
		warn "warning: Duplicate sounds file $file\n" if $soundfile;
		$soundfile = $file;
	} elsif(/\%?maelstrom.sprites(?:\..*)?$/i) {
		warn "Found sprites: $file\n";
		warn "warning: Duplicate sprites file $file\n" if $spritefile;
		$spritefile = $file;
	}
}

# main()
my $archive = shift || usage();
usage() if $archive =~ /^--?(?:\?|h(?:elp)?)/i;

die "You must run this script as root\n" if $> != 0;

$pkgname = shift || $archive;
for($pkgname) {
	s/.*\///;
	s/\..*//;
	s/-/_/g;
	s/\W//g;
	y/A-Z/a-z/;
}

die "Invalid package name\n" unless $pkgname;

$pkgname =~ s/^/maelstrom_addon_/;

if($archive =~ /^(?:ht|f)tps?:\/\//) {
	system("wget -O /tmp/$pkgname.zip \"$archive\"");
	$archive = "/tmp/$pkgname.zip";
}

my $unzip_dir = make_temp_dir();

extract($unzip_dir, $archive);
find({ wanted => \&wanted, follow => 1 }, $unzip_dir);

unless($spritefile or $soundfile) {
	die "Can't find any sprites or sounds, aborting\n";
}

my $package_dir = make_temp_dir();

copy_files($package_dir);
make_slack_desc($package_dir);

chdir($package_dir) or die $!;
system("/sbin/makepkg -l y -c y /tmp/$pkgname-$pkgver-noarch-1_mael.tgz");
chdir("/");
cleanup($package_dir, $unzip_dir);


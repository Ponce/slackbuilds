#!/usr/bin/perl -wT

# Copyright 2009 Kagan D. MacTane
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 5.004;
use strict;
use Sys::Syslog;

# -------------------------------------------------------------------

# This is the whitelist. Any IP address that's listed in this array will
# never be blocked.
my @never_block_these = qw(127.0.0.1 192.168.1.1);

# Where should SSHblock track which addresses it's blocked? This will be
# a text file with tab-delimited fields:
# IP address - # of times blocked # timestamp of last block
my $history_file = '/etc/ssh/block-history';

# If email notifications 
# Set to an empty string to suppress email notifications.
my $send_email = '';

# Only send email if IP has been blocked at least this many times.
# E.g., at $email_level = 3, email will only be sent if an IP is
# blocked for the 3rd (or greater) time.
my $email_level = 2;

# This is just to keep SSHblock from having to run `hostname` every time
# it wants to notify you that it's blocked something. This text is only
# used in the notification email, and can be safely altered.
my $myhostname = 'localhost';

my $Syslog_Level = 'info';
my $Syslog_Facility = 'user';
my $Syslog_Options = '';

my $VERSION = 0.5;

# -------------------------------------------------------------------

$ENV{PATH} = '/sbin:/usr/sbin:/usr/bin:/bin';

unless (scalar @ARGV) {
	LogMessage("Called with no arguments; aborting.");
	print "Usage: $0 ip_addr\n\"perldoc $0\" for full man page\n";
	exit 1;
}
my $ip_addr = shift;

# Ensure we were passed a valid IP address as first argument
if ($ip_addr =~ /^((\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3}))$/) {
	$ip_addr = $1;
} else {
	LogMessage("first arg not IP address: $ip_addr");
	exit 1;
}
if ($2 > 255 || $3 > 255 || $4 > 255 || $5 > 255) {
	exit 1;
}

# Abort if you're not running as root
if ($>) {
	print "Only root can run this program.\n";
	exit 1;
}

# And don't waste processor cycles if the IP's already blocked
exit 0 if (is_blocked($ip_addr));

if (grep { $_ eq $ip_addr } @never_block_these) {
    LogMessage("Not bothering to block whitelisted IP $ip_addr");
    exit 3;
}

# block command:
`iptables -A INPUT -p tcp -s $ip_addr --dport 22 --syn -j DROP`;

if ($?) {
	LogMessage("Failed to block IP $ip_addr; error $?: $!");
	exit $?;
}

# Assuming that succeeded, add a record to the history file.

my @history;
open FH, "$history_file" || exit 7;
@history = <FH>;
close FH;

my ($prev) = grep /^$ip_addr\s/, @history;
my $how_many;

if ($prev) {
	my @prev = split /\s+/, $prev;
	$prev[1]++;
	splice(@prev, 2, 1, time());
	map { if ($_ =~ /^$ip_addr\s/) { $_ = join("\t", @prev)."\n"; } } @history;
	$how_many = ordinal($prev[1]);
} else {
	push(@history, join("\t", $ip_addr, 1, time()), "\n");
	$how_many = ordinal(1);
}

open FH, ">$history_file" || exit 8;
print FH @history;
close FH;

LogMessage("Blocked IP $ip_addr for $how_many time");

my $num = $how_many;
$num =~ s/\D//g;


if ($send_email && $num >= $email_level) {
    open MAIL, "|[[SENDMAIL_PATH]] -t";
    print MAIL "From: sshblock <noreply\@$myhostname>\nTo: $send_email\nSubject: SSH Block: $ip_addr\n\nBlocked IP address $ip_addr for $how_many time.\n\n";
    close MAIL;
}

exit 0;

sub is_blocked {
	my $ip_addr = shift;
	return grep /^$ip_addr/, split /\n/, `iptables -nL | grep DROP | grep 'dpt:22' | grep '0x17/0x02' | awk '{print \$4}'`;
}

sub ordinal {
	my $num = shift;
	if (length($num) > 1 && substr($num, -2, 1) == 1) {
		return $num . 'th';
	}
	if (substr($num, -1) == 1) {
		return $num . 'st';
	} elsif (substr($num, -1) == 2) {
		return $num . 'nd';
	} elsif (substr($num, -1) == 3) {
		return $num . 'rd';
	} else {
		return $num . 'th';
	}
}



sub LogMessage {
	my $format = shift;
	openlog('sshblock', $Syslog_Options, $Syslog_Facility);
	syslog($Syslog_Level, $format, @_);
	closelog();
}


__END__

=head1 NAME

sshblock.pl - SSH dictionary attack blocker

=head1 SYNOPSIS

B<sshblock.pl> I<ip_address>

=head1 DESCRIPTION

This is part of the SSHblock system; the B<sshblock.pl> executable is responsible for blocking IP addresses from access to port 22. B<sshblock.pl> does this by adding a firewall rule to B<iptables>, which must be present on the system. Because of this, SSHblock must be run as root.

B<sshblock.pl> only blocks addresses; unblocking them is the responsibility of B<sshunblock.pl>, which should be run as an hourly cron(8) job.

=head1 INVOCATION

B<sshblock.pl> is intended to be called by swatch(1) or a similar automated process. You I<can> call it from the command line, passing it a single IP address to block, and this won't actualyl cause any problems, but it will only take one argument per invocation.

By default, SSHblock logs its activity to syslog(8), using the "user" facility at level "info".

=head1 CONFIGURATION

SSHblock can be configured by changing the following options in the program's source code:

=over

=item B<@never_block_these>

This array holds SSHblock's whitelist. Any IP address found in this array will never be blocked.

=item B<$history_file>

Where SSHblock should store its history file. This file keeps a record of all IP addresses SSHblock has ever blocked, one per line. Each line consists of three tab-delimited fields: the IP address; the total number of times it's been blocked; and the timestamp it was last blocked at.

=item B<$email_level>

If this number is nonzero, then SSHblock will send an email to the address specified in B<$send_email> whenever an address is blocked for the Nth or greater time. For example, if $email_level is 3, SSHblock will remain silent when it blocks an address for the 1st or 2nd time, but send email on the 3rd time.

=back

=head1 FILES

=over

=item F</etc/ssh/block-history>

=back


=head1 BUGS

Please let me know if you find any.

=head1 AUTHOR

Kagan D. MacTane (kai@mactane.org)

=head1 SEE ALSO

sshunblock(8), iptables(8), L<http://sourceforge.net/projects/swatch/>

=cut


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

# This option *MUST* match the corresponding value in sshblock.pl!
my $history_file = '/etc/ssh/block-history';


# Blocking duration formula: If blocking for the Nth time, and
# b = $base and m = $mult, then block for:
#
# T = m * ( b ^ (N-1) )
#
# Time T is expressed in hours.
my $base = 4;
my $mult = 3;

my $Syslog_Level = 'info';
my $Syslog_Facility = 'user';
my $Syslog_Options = '';

my $VERSION = 0.5;

$ENV{'PATH'} = '/bin:/usr/bin:/usr/sbin:/sbin';

# -------------------------------------------------------------------

# Abort if you're not running as root
if ($>) {
	print "Only root can run this program.\n";
	exit 1;
}

my $now = time();

my @history;
open FH, "$history_file" || exit 7;
@history = <FH>;
close FH;

my @input_chain = `iptables -nL INPUT | tail +3`;

# Your iptables output needs to look like:
# DROP   tcp  --  1.2.3.4     0.0.0.0/0   tcp dpt:22 flags:0x17/0x02

if (scalar @input_chain > 0) {
    LogMessage("Checking ".scalar @input_chain." blocked IPs against ".scalar @history." block-history entries.");
}

foreach my $item (@input_chain) {
	my @stats = split(/\s+/, $item);
	next unless ($stats[0] eq 'DROP');
	next unless ($stats[1] eq 'tcp');
	next unless ($stats[6] eq 'dpt:22');
	next unless ($stats[7] eq 'flags:0x17/0x02');
	my $curr_ip = $stats[3];
	
	if ($curr_ip =~ /^(\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b)$/) {
		$curr_ip = $1;
	} else {
		LogMessage("Invalid IP address in output from iptables?!?");
		next;
	}
	for ( my $i = 0; $i < scalar @history; $i++ ) {
my $hist_ip = (split(/\t/, $history[$i]))[0];
		if ((split(/\t/, $history[$i]))[0] eq $curr_ip) {
			my ($times_blocked, $blocked_since) = (split(/\t/, $history[$i]))[1,2];
			my $duration = $now - $blocked_since;
			$duration /= 3600;
			$duration = sprintf("%.2f", $duration);
			my $block_for = $mult * ($base ** ($times_blocked - 1));
			if ($duration > $block_for) {
				`iptables -D INPUT -p tcp -s $curr_ip --dport 22 --syn -j DROP`;
				if ($?) {
					LogMessage("Couldn't unblock IP $curr_ip (now blocked for $duration hours)! Error $?: $!");
				} else {
					LogMessage("Unblocked IP $curr_ip after $duration hours.");
				}
			}
		}
	}
}


exit 0;



sub is_blocked {
	my $ip_addr = shift;
	return grep /^$ip_addr/, split /\n/, `iptables -nL | grep DROP | grep 'dpt:22' | grep '0x17/0x02' | awk '{print \$4}'`;
}


sub LogMessage {
	my $format = shift;
	openlog('sshblock', $Syslog_Options, $Syslog_Facility);
	syslog($Syslog_Level, $format, @_);
	closelog();
}


__END__

=head1 NAME

sshunblock.pl - SSH dictionary attack (un)blocker

=head1 SYNOPSIS

B<sshblock.pl>

=head1 DESCRIPTION

This is part of the SSHblock system; the B<sshunblock.pl> executable is responsible for unblocking blocked IP addresses after a suitable length of time has passed. It does this by removing the B<iptables> firewall rules created by B<sshblock.pl>. In order to use iptables, sshunblock.pl must be run as root.

=head1 INVOCATION

B<sshunblock.pl> is intended to be called as an hourly cron(8) job. Calling it more or less frequently will not interfere with its operation.

By default, SSHblock logs its activity to syslog(8), using the "user" facility at level "info".

=head1 CONFIGURATION

F<sshunblock.pl> can be configured by changing the following options in the program's source code.

=over

=item B<$history_file>

Note that B<this option MUST match the value in sshblock.pl!> This is where SSHblock should store its history file. This file keeps a record of all IP addresses SSHblock has ever blocked, one per line. Each line consists of three tab-delimited fields: the IP address; the total number of times it's been blocked; and the timestamp it was last blocked at.

=item B<$base, $mult>

These control the behavior of SSHblock's exponential increase algorithm. By tweaking these, you can make SSHblock block attacking IP addresses for longer or shorter periods of time.

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

sshblock(8), iptables(8), L<http://sourceforge.net/projects/swatch/>

=cut


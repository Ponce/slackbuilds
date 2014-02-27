#!/usr/bin/perl -w

# Extract the documentation that's buried in the .ttl files.

# This is hideous code, but it does work, and doesn't require
# spending a week learning the overly-complex LV2 and RDF specs.
# Plus the LV2 scripting API is Python, so add a few more weeks
# for me to learn Python...

open OUT, "|fmt -s";
select(OUT);

$baseurl = "http://drobilla.net/plugins/mda/";

undef $/;

for(<*.ttl>) {
	next if /-presets/;
	my ($type, $name, $shortdesc, $url, $desc);
	open I, "<$_";
	$_ = <I>;
	close I;

	s/lv2:port.*//ms;

	$type = $1 if /lv2:(\w+)Plugin\b/;
	$name = $1 if /doap:name\s*"([^"]+)"/;
	$shortdesc = $1 if /doap:shortdesc\s*"([^"]+)"/;
	$url = $baseurl . $1 if /^mda:(\w+)\s*$/ms;
	$desc = $2 if /rdfs:comment\s+("+)(.*?)\1/ms;

	$name ||= "(no name, WTF?)";
	print "\nName: $name\n";
	print "URL: $url\n";
	print "Type: $type\n" if $type;
	print "Short Description: $shortdesc\n" if $shortdesc;
   print "\nDescription:\n$desc\n" if $desc;
	print '-' x 50, "\n";
}

#!/usr/bin/perl -w

# mkwtfdb.pl: create wtf(6) compatible acronym database from vera source.
# part of slackbuilds.org vera SlackBuild.
# by B. Watson, licensed under WTFPL.

$dir = shift || ".";
chdir $dir || die "$0: $dir: $!\n";

@output = ();

for $ext (0, 'a'..'z') {
	open(my $f, "<vera.$ext") or next;
	warn "reading file vera.$ext\n";
	my ($acronym, $definition);

	while(<$f>) {
		last if /^\@table/;
	}

	while(<$f>) {
		chomp;
		last if /^\@end/;

		if(/^\@item\s+(\w+)/) {
			$acronym = $1;
			undef $definition;
		} elsif(/^\s*$/) {
			push @output, "$acronym\t$definition\n";
			undef $acronym;
		} else {
			$definition .= $_;
		}
	}
}

while(<DATA>) {
	push @output, $_;
}

print sort { $a cmp $b } @output;

# Rest of this file is the original contents of
# /usr/share/misc/acronyms from Slackware -current (pre-15.0)
# bsd-games-2.17-x86_64-3, minus the comment at the top.

__DATA__
10Q	thank you
10X	thanks
1337	elite ("leet")
224	today, tomorrow, forever
31337	elite ("eleet")
4TW	for the win
A/S/L	age/sex/location
AAMOF	as a matter of fact
ABD	all but dissertation
AC	audible chuckle
ADD	attention deficit disorder
ADHD	attention deficit (and) hyperactivity disorder
ADN	any day now
ADOS	attention deficit ... oh, shiny!
AEAP	as early as possible
AFAIAC	as far as I am concerned
AFAIC	as far as I'm concerned
AFAICR	as far as I can {recall,remember}
AFAICS	as far as I can see
AFAICT	as far as I can tell
AFAIK	as far as I know
AFAIR	as far as I {recall,remember}
AFAIU	as far as I understand
AFD	away from desktop
AFK	away from keyboard
AFW	away from window
AGM	annual general meeting
AINEC	and it's not even close
AISE	as I see it
AIU	as I understand
AIUI	as I understand it
AKA	also known as
AM	ante meridiem
AMA	ask me anything
AMOL	a mountain of love
ASAIC	as soon as I can
ASAP	as soon as possible
ASL	age/sex/location
ATEOTD	at the end of the day
ATM	at the moment
ATM	{automated,automatic} teller machine
ATW	around the world
AWK	Aho, Weinberger, [and] Kernighan
AWOL	absent without official leave
AYBABTU	all your base are belong to us
AYF	all your fault
AYOR	at your own risk
AYT	are you there
B&	banned
B/C	because
B/W	bandwidth
B/W	between
BAI	goodbye
BAK	back at keyboard
BBIAB	be back in a bit
BBL	[I'll] be back later
BBR	burnt beyond repair
BBS	be back soon
BBT	be back tomorrow
BCNU	be seeing you
BCNUL8R	be seeing you later
BCP	best current practice
BF	best friend
BF	boyfriend
BFF	best {friend,friends} forever
BIAB	back in a bit
BIAF	back in a few
BIALW	back in a little while
BIAS	back in a second
BIAW	back in a while
BIDI	boy, I did it
BNYA	burned now you are
BOC	but of course
BOFH	bastard operator from hell
BOT	back on topic
BPM	beam propagation method
BPM	beats per minute
BRB	[I'll] be right back
BSD	booze, sex, drugs
BTDT	been there, done that
BTFT	been there, fixed that
BTTH	boot to the head
BTW	by the way
BYOB	bring your own {beer,booze}
CC	credit card
CEO	chief executive officer
CFV	call for votes
CFY	calling for you
CG	center of gravity
CHANOPS	channel operator status
CMIIW	correct me if I'm wrong
CNP	continued [in my] next post
COB	close of business [day]
COTS	commercial off-the-shelf
CPC	cost per click
CPE	customer premises equipment
CRM	customer relationship management
CTN	can't talk now
CU	see you
CUL	see you later
CYA	see ya
CYA	see you around
CYE	check your email
D/B/A	doing business as
D/L	download
DBA	doing business as
DBEYR	don't believe everything you read
DIAFYO	did I ask for your opinion?
DIY	do it yourself
DKDC	don't know, don't care
DM	direct message
DM	dungeon master
DME	durable medical equipment
DMEPOS	durable medical equipment, prosthetics, orthotics and supplies
DMZ	demilitarized zone
DND	do not disturb
DNF	did not finish
DNFT	do not feed troll
DOA	dead on arrival
DRY	don't repeat yourself
DSTM	don't shoot the messenger
DTRT	do the right thing
DTWT	do the wrong thing
DWIM	do what I mean
DYK	do you know?
EA	early adopter
ECR	electronic cash register
EDS	eternal downward spiral
EFT	electronic funds transfer
EG	evil grin
EIE	enough is enough
EMSG	email message
EOB	end of business [day]
EOD	end of {day,discussion}
EOL	end of life
EOM	end of message
EOS	end of story
ETA	edited to add
ETA	estimated time of arrival
ETLA	extended three letter acronym
ETR	early to rise
EWAG	experienced wild-ass guess
EZ	easy
EZPZ	easy-peasy
F9	fine
FAQ	frequently asked question
FBOW	for better or worse
FCFS	first come, first served
FCOL	for crying out loud
FFS	free for shipping
FITB	fill in the blank
FNO	for nerds only
FNO	from now on
FOC	free of charge
FPS	first person shooter
FPS	frames per second
FSDO	for some definition of
FSVO	for some value of
FTBFS	fails to build from source
FTFY	fixed that for you
FTHOI	for the {heck,hell} of it
FTL	faster than light
FTL	for the loss
FTR	for the record
FTTT	from time to time
FTW	for the win
FUD	fear, uncertainty, [and] doubt
FWIW	for what it's worth
FYEO	for your eyes only
FYI	for your information
G	grin
G/C	garbage collect
G2G	got to go
G2K	good to know
GA	go ahead
GAC	get a clue
GAL	get a life
GBTW	get back to work
GF	girlfriend
GFU	good for you
GFY	good for you
GG	good game
GGA	good game all
GGP	good game partner
GGWP	good game, well played
GIGO	garbage in, garbage out
GIYF	Google is your friend
GJ	good job
GL	good luck
GLHF	good luck, have fun
GLINE	global kill line
GLWT	good luck with that
GM	game master
GMT	Greenwich mean time
GMTA	great minds think alike
GOK	God only knows
GOP	Grand Old Party
GOWI	get on with it
GPS	global positioning system
GR8	great
GTG	got to go
GTH	go to hell
GTSY	{glad,good} to see you
GWS	get well soon
H8	hate
HAND	have a nice day
HE	how embarrasing
HF	have fun
HHIS	hanging head in shame
HHOS	ha ha, only serious
HICA	here it comes again
HME	home medical equipment
HNY	happy new year
HOAS	hold on a second
HOPS	half-operator status
HTH	hope this helps
IAC	in any case
IAE	in any event
IANAL	I am not a lawyer
IAW	in another window
IAWTC	I agree with this comment
IAWTP	I agree with this post
IAY	I adore you
IB	I'm back
IC	I see
ICBW	I could be {worse,wrong}
ICCL	I couldn't care less
ICUR	I see you are
ICYMI	in case you missed it
IDC	I don't care
IDGI	I don't get it
IDGW	in a good way
IDI	I doubt it
IDIFTL	I did it for the lulz
IDK	I don't know
IDRC	I don't really care
IDTS	I don't think so
IDTT	I drink to that
IFF	if and only if
IFTTT	if this then that
IHBW	I have been wrong
IIANM	if I am not mistaken
IIRC	if I {recall,remember} correctly
IIUC	if I understand correctly
IKR	I know, right?
IKWYM	I know what you mean
ILU	I love you
ILY	I love you
IMAO	in my arrogant opinion
IMBO	in my biased opinion
IMCO	in my considered opinion
IME	in my experience
IMHO	in my humble opinion
IMNSHO	in my not so humble opinion
IMO	in my opinion
INB4	in before
INPO	in no particular order
IOW	in other words
IPML	I pissed myself laughing
IQ	intelligence quotient
IRCOP	Internet relay chat {operator,operators}
IRCOPS	Internet relay chat operator status
IRL	in real life
IRT	in real time
IRT	in regards to
ISAGN	I see a great need
ISBN	International Standard Book Number
ISTM	it seems to me
ISTR	I seem to {recall,remember}
ITC	in this {channel,chat}
ITT	in this thread
ITYM	I think you mean
IUD	insert usual disclaimers
IUSS	if you say so
IW	it's worse
IWBNI	it would be nice if
IYD	in your dreams
IYKWIM	if you know what I mean
IYSS	if you say so
IYSWIM	if you see what I mean
J/K	just kidding
JAM	just a minute
JAS	just a second
JFK	John Fitzgerald Kennedy
JFTR	just for the record
JFYI	just for your information
JGI	just Google it
JGI	just got it
JHD	just hit delete
JIC	just in case
JJA	just joking around
JK	just kidding
JMO	just my opinion
JSYK	just so you know
JTLYK	just to let you know
JW	just wondering
KISS	keep it simple, stupid
KITA	kick in the ass
KK	okay, okay
KLINE	kill line
KMA	keep me advised
KMA	keep moving ahead
KMA	kill me already
KNF	kernel normal form
KOS	kill on sight
KTHX	okay, thanks
KTHXBAI	okay, thanks. Goodbye.
KWIM	know what I mean?
L8	late
L8R	later
LART	luser attitude readjustment tool
LBNL	last but not least
LGTM	looks good to me
LJBF	let's just be friends
LMAO	laughing my ass off
LMC	let me check
LMGTFY	let me google that for you
LMHO	laughing my head off
LMK	let me know
LMNO	laughing my nuts off
LMSO	laughing my socks off
LOIC	low orbit ion cannon
LOL	laughing out loud
LP	long playing [record]
LTNS	long time no see
LWYL	laugh with you later
M8	mate
MAD	mutually assured destruction
MBA	master of business administration
MFW	my face when
MIA	missing in action
MMB	message me back
MO	modus operandi
MOTAS	member of the appropriate sex
MOTOS	member of the opposite sex
MOTSS	member of the same sex
MTF	more to follow
MVP	minimum viable product
MVP	most valuable player
MYOB	mind your own business
N/A	not {applicable,available}
N/M	never mind
NAFAIK	not as far as I know
NB	nota bene
NBD	no big deal
NE1	anyone
NEDM	not even Doom music
NFA	no flaming allowed
NFC	no functional change
NIFOC	naked in front of computer
NIH	not invented here
NIMBY	not in my backyard
NM	never mind
NMF	not my fault
NMP	not my problem
NMU	not much, you?
NOM	no offence meant
NOOB	newbie
NORP	normal ordinary {respectable,responsible} person
NOYB	none of your business
NP	no problem
NPC	non-player character
NRFPT	not ready for prime time
NRN	no reply necessary
NRN	not right now
NSFW	not suitable for work
NTN	no thanks needed
NUNP	no users, no problems
NVM	never mind
NW	no way
NXT	next
NYPA	not your personal army
O2W	off to work
OAO	over and out
OBV	obviously
OBVS	obviously
ODTW	others do the work (cf. "otdw source")
OFC	of course
OH	other half
OIC	oh, I see
OMG	oh my God
OMW	on my way
ONNA	oh no, not again
ONNTA	oh no, not this again
OOB	out of bounds
OOC	out of curiosity
OOI	out of interest
OOSOOM	out of sight, out of mind
OPS	operator status
OPS	operators
ORITE	oh, right
OT	off topic
OTL	out to lunch
OTOH	on the other hand
OTP	one true pairing
OTS	off the shelf
OTT	over the top
OTTOMH	off the top of my head
OWTTE	or words to that effect
PC	player character
PC	politically correct
PCB	polychlorinated biphenyl(s)
PD	police department
PDA	public display of affection
PDQ	pretty darn quick
PDS	please don't shout
PEBCAK	problem exists between chair and keyboard
PEBKAC	problem exists between keyboard and chair
PFI	pay for inclusion
PFY	pimply faced youth
PHB	pointy haired boss
PIN	personal identification number
PITA	pain in the ass
PITR	{parent,parents} in the room
PKSP	pound keys and spew profanity
PM	post meridiem
PMFI	problem magically fixed itself
PMFJI	pardon me for jumping in
PMSL	pissing myself laughing
PNG	persona non grata
PNP	plug and pray
POC	point of contact
POC	proof of concept
POLA	principle of least astonishment
POLS	principle of least surprise
POS	point of sale
POV	point of view
PPL	people
PPL	pretty please
PPP	petty pet peeve
PPS	pulse per second (signal)
PR	public relations
PSA 	prostate-specific antigen
PSA 	public service announcement
PTA	parent-teacher association
PTO	{paid,personal} time off
PTO	parent-teacher organization
PTO	please turn over
PTO	power takeoff
PTV	parental tunnel vision
QED	quod erat demonstrandum
QFT	quoted for truth
RA	residential advisor
RFC	request for comments
RFD	request for discussion
RFE	request for enhancements
RIP	rest in peace
RL	real life
RLC	rod length check
RMS	Richard Matthew Stallman
ROFL	rolling on floor laughing
ROFLMAO	rolling on floor laughing my ass off
ROI	return on investment
ROTFL	rolling on the floor laughing
RP	responsible person
RR	railroad
RSI	repetitive strain injury
RSN	real soon now
RSVP	respondez s'il vous plait ("reply please")
S/T	self titled
SAR	search and rescue
SAR	some assembly required
SCNR	sorry, could not resist
SEP	someone else's problem
SERP	search engine results page
SFAICT	so far as I can tell
SHID	slaps head in disgust
SIMCA	sitting in my chair amused
SITD	still in the dark
SMAP	Soil Moisture Active Passive
SMH	shaking my head
SMLSFB	so many losers, so few bullets
SMOP	simple matter of programming
SNERT	snot-nosed egotistical rude teenager
SNMP	sorry, not my problem
SO	significant other
SOB	son of [a] bitch
SOP	standard operating procedure
SRS	serious
SRSLY	seriously
SSIA	subject says it all
SSTO	single stage to orbit
STW	search the web
SUS	stupid user syndrome
SUX	sucks
SUX2BU	sucks to be you
SWAG	silly, wild-assed guess
SWAHBI	silly, wild-assed hare-brained idea
SWMBO	she who must be obeyed
SYS	see you soon
TA	teaching assistant
TANSTAAFL	there ain't no such thing as a free lunch
TBA	to be announced
TBC	to be continued
TBD	to be {decided,determined,done}
TBH	to be honest
TBOMK	the best of my knowledge
TCB	taking care of business
TCO	taken care of
TCO	total cost of ownership
TFOA	things falling off aircraft
TFW	that feeling when
TGIF	thank goodness it's Friday
THNX	thanks
THX	thanks
TIA	thanks in advance
TIAVP	this is a volunteer project
TIC	tonque in cheek
TIL	today I learned
TINC	there is no cabal
TINLA	this is not legal advice
TINWIS	this is not what I said
TJM	that's just me
TLA	three letter acronym
TLA	true love always
TLC	tender loving care
TLDR	too long, didn't read
TM	trademark
TM	trust me
TMA	too many abbreviations
TMG	too much government
TMI	too much information
TMJ	temporomandibular joint
TMK	to my knowledge
TMTOWTDI	there's more than one way to do it
TNF	The NetBSD Foundation
TOC	table of contents
TOCTOU	time of check to time of use
TOEFL	test of english as a foreign language
TOH	to other half
TP	toilet paper
TPTB	the powers that be
TRT	the right thing
TTBOMK	to the best of my knowledge
TTFN	ta ta for now
TTM	to the moderator
TTT	thought that too
TTYL	talk to you later
TTYS	talk to you soon
TWAIN	thing without an interesting name
TWDT	the whole damn thing
TWIAVBP	the world is a very big place
TY	thank you
TYVM	thank you very much
U/L	upload
UGT	universal greeting time
UR	your
UR	{you're, you are}
UTSL	use the source, Luke
VCR	video cassette recorder
VEG	very evil grin
VIP	very important person
W/	with
W/E	whatever
W/O	without
W8	wait
WAFWOT	what a foolish waste of time
WAG	wild-ass guess
WB	welcome back
WCPGW	what could possibly go wrong
WDYMBT	what do you mean by that
WELC	working effectively with legacy code
WFH	working from home
WFM	works for me
WIBNI	wouldn't it be nice if
WIP	work in progress
WMNC	watch me not care
WOMBAT	waste of money, brain, and time
WRT	with respect to
WTB	{waiting,want,willing} to buy
WTF	where's the food
WTG	way to go
WTH	{what,when,where,who,why} the hell
WTS	{waiting,want,willing} to sell
WTT	{waiting,want,willing} to trade
WWJD	what would Jesus do?
YAGNI	you ain't gonna need it
YALIMO	you are lame, in my opinion
YAOTM	yet another off-topic message
YCTAT	you can't troll a troll
YGM	you got mail
YHBT	you have been trolled
YHL	you have lost
YKWIM	you know what I mean
YMMV	your mileage may vary
YOLO	you only live once
YW	you're welcome
YWSYLS	you win some, you lose some
ZIP	zoning improvement plan

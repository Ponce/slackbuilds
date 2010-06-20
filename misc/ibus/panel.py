



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<!-- ViewVC :: http://www.viewvc.org/ -->
<head>
<title>[KDE] Log of /tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py</title>
<style type="text/css">
.cp-doNotDisplay { display: none; }
@media aural, braille, handheld, tty { .cp-doNotDisplay { display: inline; speak: normal; }}
.cp-edit { text-align: right; }
@media print, embossed { .cp-edit { display: none; }}
.vc_header_sort a:link { color: #ffffff; }
.vc_header_sort a:visited { color: #ffffff; }
.vc_header_sort a:active { color: #ffffff; }
.vc_header {
background-color: #73A5DE;
}
.vc_header_sort {
background-color: #0069BD;
border-bottom: 1px solid #000000;
color: #ffffff;
}
.vc_row_odd {
background-color:#BDCEEE;
}
</style>
<link rel="shortcut icon" href="/docroot/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/docroot/styles.css" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link rel="meta" href="http://www.kde.org/labels.rdf" type="application/rdf+xml" title="ICRA labels" />
<meta name="trademark" content="KDE e.V." />
<meta name="description" content="KDE Source Cross Reference" />
<meta name="MSSmartTagsPreventParsing" content="true" />
<meta name="robots" content="all" />
<meta name="no-email-collection" content="http://www.unspam.com/noemailcollection" />
<link rel="shortcut icon" href="/docroot/images/favicon.ico" />
<link rel="icon" href="/docroot/images/favicon.ico" />
<link rel="stylesheet" media="screen" type="text/css" title="KDE Colors" href="/docroot/kde.css" />
<link rel="stylesheet" media="print, embossed" type="text/css" href="/docroot/print.css" />
<link rel="stylesheet" media="screen, aural, handheld, tty, braille" type="text/css" title="Flat" href="/docroot/flat.css" />
</head>
<body id="cp-site-wwwkdeorg">
<ul class="cp-doNotDisplay">
<li><a href="#cp-content" accesskey="2">Skip to content</a></li>
<li><a href="#cp-menu" accesskey="5">Skip to link menu</a></li>
</ul>
<div id="container">
<div id="header">
<div id="header_top"><div><div>
<img alt ="" src="/docroot/top-kde.jpg"/>
The KDE Source Repository </div></div></div>
<div id="header_bottom">
<div id="location">
<ul>
<li><a href="http://www.kde.org" accesskey="1">KDE Homepage</a> / <a href="/" >KDE Source Repository Homepage</a></li>
</ul>
</div>
<div id="menu">
<ul>
<li><a href="javascript:fullWidth()"><img src="/docroot/images/full.png" alt="-" />Full Width</a></li>
<li><a href="http://kde.org/family/">Sitemap</a></li>
<li><a href="http://kde.org/contact/">Contact Us</a></li>
</ul> </div>
</div>
</div>
<!-- End page header -->
<div id="body_wrapper">
<div id="body">
<!-- begin main content -->
<div class="content">
<div id="main">
<div class="clearer">&nbsp;</div>
<a name="cp-content" />
<div class="vc_navheader">
<table><tr>
<td><strong><a href="/?view=roots"><span class="pathdiv">/</span></a><a href="/">[KDE]</a><span class="pathdiv">/</span><a href="/tags/">tags</a><span class="pathdiv">/</span><a href="/tags/KDE/">KDE</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/">4.4.3</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/kdeplasma-addons/">kdeplasma-addons</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/">applets</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/">kimpanel</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/">backend</a><span class="pathdiv">/</span><a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/">ibus</a><span class="pathdiv">/</span>panel.py</strong></td>
<td style="text-align: right;"></td>
</tr></table>
</div>
<h1>Log of /tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py</h1>

<p style="margin:0;">

<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/"><img src="/docroot/images/back_small.png" class="vc_icon" alt="Parent Directory" /> Parent Directory</a>

| <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?view=log"><img src="/docroot/images/log.png" class="vc_icon" alt="Revision Log" /> Revision Log</a>




</p>

<hr />
<table class="auto">



<tr>
<td>Links to HEAD:</td>
<td>
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?view=markup">view</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?view=annotate">annotate</a>)
</td>
</tr>



<tr>
<td>Sticky Revision:</td>
<td><form method="get" action="/" style="display: inline">
<div style="display: inline">
<input type="hidden" name="orig_pathtype" value="FILE"/><input type="hidden" name="orig_view" value="log"/><input type="hidden" name="orig_path" value="tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py"/><input type="hidden" name="view" value="redirect_pathrev"/>

<input type="text" name="pathrev" value="" size="6"/>

<input type="submit" value="Set" />
</div>
</form>

</td>
</tr>
</table>
 







<div>
<hr />

<a name="rev1120722"></a>


Revision <a href="/?view=revision&amp;revision=1120722"><strong>1120722</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1120722&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1120722">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1120722&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=1120722">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=1120722&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Thu Apr 29 19:55:36 2010 UTC</em>
(7 weeks, 2 days ago)
by <em>mueller</em>









<br />File length: 13866 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=1070858&amp;r2=1120722">previous 1070858</a>







<pre class="vc_log">KDE 4.4.3
</pre>
</div>



<div>
<hr />

<a name="rev1070858"></a>


Revision <a href="/?view=revision&amp;revision=1070858"><strong>1070858</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1070858&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1070858">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1070858&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=1070858">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=1070858&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Wed Jan  6 22:46:33 2010 UTC</em>
(5 months, 1 week ago)
by <em>mueller</em>

<br />Original Path: <a href="/branches/KDE/4.4/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=1070858"><em>branches/KDE/4.4/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13866 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=1053797&amp;r2=1070858">previous 1053797</a>







<pre class="vc_log">creating KDE 4.4 branch based on KDE 4.4 RC1 tag
</pre>
</div>



<div>
<hr />

<a name="rev1053797"></a>


Revision <a href="/?view=revision&amp;revision=1053797"><strong>1053797</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1053797&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1053797">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=1053797&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=1053797">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=1053797&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Tue Nov 24 20:23:56 2009 UTC</em>
(6 months, 3 weeks ago)
by <em>aseigo</em>

<br />Original Path: <a href="/trunk/KDE/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=1053797"><em>trunk/KDE/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13866 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=948185&amp;r2=1053797">previous 948185</a>







<pre class="vc_log">move to addons
</pre>
</div>



<div>
<hr />

<a name="rev948185"></a>


Revision <a href="/?view=revision&amp;revision=948185"><strong>948185</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=948185&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=948185">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=948185&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=948185">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=948185&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Thu Apr  2 14:21:40 2009 UTC</em>
(14 months, 2 weeks ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/kdereview/plasma/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=948185"><em>trunk/kdereview/plasma/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13866 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=942652&amp;r2=948185">previous 942652</a>







<pre class="vc_log">disable page up/down button when can't go up/down,
slightly change dbus interface,
reserved parameters for UpdateLookupTable removed
</pre>
</div>



<div>
<hr />

<a name="rev942652"></a>


Revision <a href="/?view=revision&amp;revision=942652"><strong>942652</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=942652&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=942652">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=942652&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=942652">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=942652&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Sun Mar 22 12:09:21 2009 UTC</em>
(14 months, 4 weeks ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/kdereview/plasma/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=942652"><em>trunk/kdereview/plasma/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13799 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=939029&amp;r2=942652">previous 939029</a>







<pre class="vc_log">move to kdereview

</pre>
</div>



<div>
<hr />

<a name="rev939029"></a>


Revision <a href="/?view=revision&amp;revision=939029"><strong>939029</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=939029&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=939029">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=939029&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=939029">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=939029&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Fri Mar 13 15:56:35 2009 UTC</em>
(15 months, 1 week ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/playground/base/plasma/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=939029"><em>trunk/playground/base/plasma/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13799 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=938831&amp;r2=939029">previous 938831</a>







<pre class="vc_log">rename kimpaneltye.h to kimagenttype.h
trivial margin fix
</pre>
</div>



<div>
<hr />

<a name="rev938831"></a>


Revision <a href="/?view=revision&amp;revision=938831"><strong>938831</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=938831&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=938831">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=938831&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=938831">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=938831&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Fri Mar 13 08:55:44 2009 UTC</em>
(15 months, 1 week ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/playground/base/plasma/applets/kimpanel/backend/ibus/panel.py?view=log&amp;pathrev=938831"><em>trunk/playground/base/plasma/applets/kimpanel/backend/ibus/panel.py</em></a>









<br />File length: 13341 byte(s)


<br />Copied from: <a href="/trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py?view=log&amp;pathrev=937826"><em>trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py</em></a> revision 937826






<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937826&amp;r2=938831">previous 937826</a>







<pre class="vc_log">Rewrite statusbar and candiate window code to use QGraphicsView.
Support page up/down, select entry with mouse in candiate window.
Basic hover effect on candidate entry.
</pre>
</div>



<div>
<hr />

<a name="rev937826"></a>


Revision <a href="/?view=revision&amp;revision=937826"><strong>937826</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937826&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937826">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937826&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=937826">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937826&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Tue Mar 10 13:44:42 2009 UTC</em>
(15 months, 1 week ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py?view=log&amp;pathrev=937826"><em>trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py</em></a>









<br />File length: 13341 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937620&amp;r2=937826">previous 937620</a>







<pre class="vc_log">Handle input styles which client can't display preedit text.
Cursor move/edit support in preedit text.
</pre>
</div>



<div>
<hr />

<a name="rev937620"></a>


Revision <a href="/?view=revision&amp;revision=937620"><strong>937620</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937620&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937620">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937620&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=937620">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937620&amp;view=log">[select for diffs]</a>




<br />

Modified

<em>Tue Mar 10 05:38:50 2009 UTC</em>
(15 months, 1 week ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py?view=log&amp;pathrev=937620"><em>trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py</em></a>









<br />File length: 13034 byte(s)







<br />Diff to <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937601&amp;r2=937620">previous 937601</a>







<pre class="vc_log">Handle show/hide candidate window better.
Install instruction for ibus backend.
</pre>
</div>



<div>
<hr />

<a name="rev937601"></a>


Revision <a href="/?view=revision&amp;revision=937601"><strong>937601</strong></a> -


(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937601&amp;view=markup">view</a>)


(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937601">download</a>)
(<a href="/*checkout*/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?revision=937601&amp;content-type=text%2Fplain">as text</a>)
(<a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?annotate=937601">annotate</a>)



- <a href="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py?r1=937601&amp;view=log">[select for diffs]</a>




<br />

Added

<em>Tue Mar 10 01:14:51 2009 UTC</em>
(15 months, 1 week ago)
by <em>wkai</em>

<br />Original Path: <a href="/trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py?view=log&amp;pathrev=937601"><em>trunk/playground/base/plasma/applets/kimpanel/ibus/panel.py</em></a>







<br />File length: 12676 byte(s)











<pre class="vc_log">Add an ibus backend with main features done: 
    statusbar,auxiliary text,candidate window,cursor follow etc..
Don't show an empty lookup table.
</pre>
</div>

 


 <hr />
<p><a name="diff"></a>
This form allows you to request diffs between any two revisions of this file.
For each of the two "sides" of the diff,

enter a numeric revision.

</p>
<form method="get" action="/tags/KDE/4.4.3/kdeplasma-addons/applets/kimpanel/backend/ibus/panel.py" id="diff_select">
<table cellpadding="2" cellspacing="0" class="auto">
<tr>
<td>&nbsp;</td>
<td>
<input type="hidden" name="view" value="diff"/>
Diffs between

<input type="text" size="12" name="r1"
value="1120722" />

and

<input type="text" size="12" name="r2" value="937601" />

</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
Type of Diff should be a
<select name="diff_format" onchange="submit()">
<option value="h" selected="selected">Colored Diff</option>
<option value="l" >Long Colored Diff</option>
<option value="f" >Full Colored Diff</option>
<option value="u" >Unidiff</option>
<option value="c" >Context Diff</option>
<option value="s" >Side by Side</option>
</select>
<input type="submit" value=" Get Diffs " />
</td>
</tr>
</table>
</form>




 </div>
</div>
</div>
<div class="clearer"></div>
</div>
<div class="clearer"></div>
</div>
<div id="end_body"></div>
<div id="footer"><div id="footer_text">
Maintained by the <a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;sysadmin&#64;kde&#46;or&#x67;">KDE sysadmins</a><br />
KDE<sup>&#174;</sup> and <a href="http://kde.org/media/images/kde_gear_black.png">the K Desktop Environment<sup>&#174;</sup> logo</a> are registered trademarks of <a href="http://ev.kde.org/" title="Homepage of the KDE non-profit Organization">KDE e.V.</a> |
<a href="http://www.kde.org/contact/impressum.php">Legal</a>
</div></div>
</div>
<script type="text/javascript">
function $(id)
{
return document.getElementById(id);
}
function setCookie(key, value, life){
var today = new Date(), expires = '';
if(life)
{
expires = new Date(today.getTime() + (life * 24*60*60*1000));
expires = "; expires=" + expires.toGMTString();
}
var str = key + "=" + escape(value) + expires + "; path=/";
document.cookie = str;
}
function deleteCookie(key) {
setCookie(key,"",-1);
}
function getCookie(key)
{
var istart = document.cookie.indexOf(key + '=') + 1;
istart = document.cookie.indexOf("=", istart) + 1
if (istart == -1)
{
return false;
}
var iend = document.cookie.indexOf(";", istart);
if (iend == -1)
{
iend = document.cookie.length;
}
return unescape(document.cookie.substring(istart, iend));
}
var fullsize = false;
function fullWidth()
{
if(fullsize)
{
deleteCookie('fullWidth');
fullsize = false;
}
else
{
fullsize = true;
setCookie('fullWidth', 'true');
}
$('body_wrapper').style.width = (fullsize) ? '95%' : '60em';
$('body_wrapper').style.maxWidth = (fullsize) ? '95%' : '45em';
$('body').style.width = (fullsize) ? '100%' : '60em';
$('body').style.maxWidth = (fullsize) ? '100%' : '45em';
}
if(getCookie('fullWidth') == 'true')
{
fullWidth();
}
</script>
</body>
</html>



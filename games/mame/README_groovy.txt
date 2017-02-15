GroovyMAME, also known as GroovyUME, is a fork of MAME/UME with greater
emphasis on CRT monitor support, in order to provide smoother gameplay
with less input lag than using regular MAME on an LCD screen. GroovyMAME
is provided as a patch against the standard MAME sources.

GroovyMAME forum: http://forum.arcadecontrols.com/index.php?board=52.0

GroovyMAME patches can be downloaded from:

https://drive.google.com/drive/folders/0B5iMjDor3P__aEFpcVNkVW5jbEE

Get the latest patch that matches the version of MAME. Example:

0182_groovymame_017a.diff

The "0182" is the MAME version, without the dots. The "017a" is the
GroovyMAME version. You want the .diff file, not the .tar.bz2 or .7z!

Download or copy the .diff file to the SlackBuild's directory and run the
SlackBuild script. The script will find the .diff, apply it, and update
the slack-desc to say "This package was patched with GroovyMAME 017a"
(or whatever the version number really is). You *don't* have to do
anything about the CRLF line endings, the script will handle that.

If the script seems to be ignoring the .diff file, you probably have a
.diff for a different version of MAME. Check the version number at the
start of the filename. Don't try to rename the .diff file to force it
to apply: the SlackBuild will fail because the patch will fail.

If you have multiple .diff files that match the MAME version, the script
will try to use the one with the highest GroovyMAME version number. If
it picks the wrong one, remove the ones you don't want to use.

If all else fails, please contact me by email (yalhcru@gmail.com) or on
IRC (##slackware or #slackbuilds channel on FreeNode, user Urchlay). I
won't necessarily be testing each MAME release against each version
of the GroovyMAME patch for that release, so there might be problems I
won't know about.

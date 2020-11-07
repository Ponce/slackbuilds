.. RST source for mag(1) man page. Convert with:
..   rst2man.py mag.rst > mag.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 20100913
.. |date| date::

===
mag
===

----------------------------
dynamic X11 screen magnifier
----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

mag [*-d*] [*-s | -m | -l*]  [*-z factor*] [*-x Xcoord*] [*-y Ycoord*]

DESCRIPTION
===========

**mag** is a screen magnifier similar to xmag(1), but it has the
ability to move itself out of the way when not in use.

With dynamic placement ([*-d*] option), the magnifier will flee to the
furthest corner away from the mouse. Without, you can grab it and move it as you like.

OPTIONS
=======

-s                 small window.                                     
-m                 medium window.                                    
-l                 large window.                                     
-d                 Dynamic placement.                                
-z n               Zoom factor.                                      
-x Xcoord          Original X placement.                             
-y Ycoord          Original Y placement.

AUTHORS
=======

mag was written by Danny Chouinard.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The mag homepage:

https://sites.google.com/site/dannychouinard/Home/unix-linux-trinkets/little-utilities/mag-dynamic-x11-screen-magnifier

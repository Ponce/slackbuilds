.. RST source for mitmproxy(1) man page. Convert with:
..   rst2man.py mitmproxy.rst > mitmproxy.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 7.0.4
.. |date| date::

=========
mitmproxy
=========

--------------------------------------------
man-in-the-middle SSL/TLS intercepting proxy
--------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

DESCRIPTION
===========

This man page just provides links to the actual documentation.

**mitmproxy** is an interactive, SSL/TLS-capable intercepting proxy with a console
(curses-style) interface for HTTP/1, HTTP/2, and WebSockets.

**mitmdump** is the command-line version of **mitmproxy**. Think **tcpdump** for HTTP(S).

**mitmweb** is a web-based interface for **mitmproxy**.

These commands have lots of options; each one can be run with
**--help** for a full list.

Full documentation is available at: https://docs.mitmproxy.org/stable/

Quite a few example scripts for **mitmproxy** are installed in
/usr/doc/mitmproxy-|version|/examples/

COPYRIGHT
=========

See the file /usr/doc/mitmproxy-|version|/LICENSE for license information.

AUTHORS
=======

**mitmproxy** was written by Aldo Cortesi.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The mitmproxy homepage: http://www.mitmproxy.org/

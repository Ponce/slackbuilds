.. RST source for kodespel(1) man page. Convert with:
..   rst2man.py kodespel.rst > kodespel.1

.. |version| replace:: 0.1.1+20220227_e0095c7
.. |date| date::

========
kodespel
========

-----------------------------
spell-checker for source code
-----------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

kodespel [**-d** *dictionary*] *file* [*file* ...]

kodespel **--list-dicts**

DESCRIPTION
===========

kodespel is a spellchecker for source code. kodespel's nifty trick
is that it knows how to split common programming identifiers like
'getAllStuff' or 'DoThingsNow' or 'num_objects' or 'HTTPResponse' into
words, feed those to **ispell**\(1), and interpret ispell's output.

Basic usage is to run kodespel on one or more individual files
or directories::

  kodespel foo.py main.go README.md

kodespel uses a collection of dictionaries to spellcheck each file.
It always uses the **base** dictionary, which is a set of words
common in source code across languages and platforms. Additionally,
there is a language-specific dictionary for each language kodespel
knows about. Language-specific dictionaries are automatically chosen
for you.

In this example, kodespell will spellcheck each file with:

  * **foo.py**: dictionaries **base** and **python**
  * **main.go**: dictionaries **base** and **go**
  * **README.md**: dictionary **base** only (no language dictionary for Markdown)

If run on a directory, kodespel will recurse into that directory
and spellcheck every file that it recognizes::

    kodespel src/

will search for **\*.py**, **\*.c**, **\*.h**, and any other
extension that kodespel has built-in support for.
(Currently: Python, Perl, Go, C, C++, and Java).
Unsupported files are ignored, but if you pass those filenames
explicitly, they will be checked.

  Note: the SlackBuilds.org package of **kodespel** includes a
  **sbo** dictionary. It will only be used if you enable it
  with **-d sbo**.

kodespel ships with several other common dictionaries.
For example, if the program you are spellchecking uses
a lot of Unix system calls, you would add the **unix** dictionary::

    kodespel -d unix foo.py main.go README.md

The **-d** option applies to every file being checked.

To see the list of all builtin dictionaries, run::

    kodespel --list-dicts

Finally, you can create your own dictionaries,
and use as many of them as you like.
A dictionary is a plain text file with one word per line::

    $ cat myproject.dict
    nargs
    args

You can specify your personal dictionaries with **-d**,
just like kodespel's builtin dictionaries::

    kodespel -d unix -d myproject.dict foo.py ...

OPTIONS
=======

-h, --help
  Show built-in help and exit.

-a, --all
  Report every single misspelling [default: **--unique**].

-u, --unique
  Report each misspelling only once [default].

-d dict, --dictionary=dict
  Use this dictionary. *dict* may be a filename or a dictionary name. Use
  multiple times to include multiple dictionaries.

--list-dicts
  List available dictionaries and exit.

--dump-dict
  Build custom dictionary (respecting **-d** options).

--make-dict=dictfile
  Write unknown words to *dictfile*.

-i string, --ignore=regex
  Ignore any words matching *regex*.

-C, --compound
  Allow compound words (e.g. **getall**) [default].

--no-compound
  Do not allow compound words

-W N, --wordlen=N
  Ignore words with <= *N* characters [default: 3].

EXIT STATUS
===========

* **0** - success; no misspellings found.
* **1** - at least one misspelling found *or* there was an error reading
  one or more input file (including encoding errors for non-UTF8 files).
* **2** - invalid command line option(s).

FILES
=====

**/usr/share/kodespel/**
  The default dictionaries are stored here.

LIMITATIONS
===========

**kodespel** has no option to read from standard input. However, on Linux,
you can run **kodespel** **/dev/stdin**.

**kodespel** can only handle **UTF-8** encoding (which includes 7-bit **ASCII**).
It will choke on files that use e.g. **ISO-8859** encoding.

**kodespel** writes its output to **stderr**, not **stdout**. This makes
it difficult to use it from a script. Try e.g::

  kodespel <args> 2>&1 | <command>

Also, if you get exit status 1, you can't tell if that's an actual error
or misspellings were found, without examining the actual output.

COPYRIGHT
=========

See the file /usr/doc/kodespel-|version|/LICENSE.txt for license information.

AUTHORS
=======

kodespel was written by Greg Ward.

This man page written (mostly copied and adapted from README.md and
the --help output) for the SlackBuilds.org project by B. Watson, and
is licensed under the WTFPL.

SEE ALSO
========

The kodespel homepage: https://pypi.org/project/kodespel/

**codespell**\(1)

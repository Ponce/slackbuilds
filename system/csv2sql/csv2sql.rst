.. RST source for csv2sql(1) man page. Convert with:
..   rst2man.py csv2sql.rst > csv2sql.1
.. rst2man.py comes from the SBo development/docutils package.

.. |version| replace:: 0.1
.. |date| date::

=======
csv2sql
=======

--------------------------------------------------
import data from CSV files into an SQLite database
--------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

csv2sql [**-d** | **--database**  *database*] [**-e** | **--encoding** *encoding* *INPUT*:*OUTPUT*] [**-f** | **--file** *filename*] [**-h** | **--help**] [**-t** | **-table** *table*] [**-v** | **--verbose**] [**-V** | **--version**]

DESCRIPTION
===========

**csv2sql** is a Ruby script for importing comma-separated value files
into SQLite.

The destination table and database will automatically be created if
they do not already exist.

If the destination table already exists, then **csv2sql** assumes that
it contains the same number of columns as the input data. The column
names do not need to match.

OPTIONS
=======

-d, --database DATABASE
  Database to import into. Default is *csv2sql.db*.

-e, --encoding INPUT:OUTPUT
  Input and output encodings. Default is *UTF-8:UTF-8*.

-f, --file FILENAME
  CSV file to import. You can alternately read CSV data from standard input.

-h, --help
  Print built-in help message and exit.

-t, --table TABLE
  Table to import into. Default is the name of the file being imported from or *stdin* if CSV data is from standard input. Periods in the filename are replaced with underscores.

-v, --verbose
  Print verbose output.

-V, --version
  Print version number and exit.

NOTE
====

**csv2sql** assumes the first line of CSV data is a header giving the
column names. If your CSV file doesn't have column names (if the first
line is just CSV data), you'll have to edit it and add the column
names for **csv2sql** to work correctly with it.

EXAMPLES
========

1. Import widgets.csv into the default table (widgets_csv) and database (csv2sql.db)::

        csv2sql -f widgets.csv

2. Import standard input into the "foo" table within the "bar.db" database::

        cat widgets.csv | csv2sql -t foo -d bar.db

3. Import products.csv and more-products.csv into the "products" table within the default database (csv2sql.db)::

        csv2sql -f products.csv -t products
        csv2sql -f more-products.csv -t products

4. Export data from SQLite sorted by the "ProductName" column to output.csv::

        sqlite3 -header -csv csv2sql.db "SELECT * FROM products ORDER BY ProductName" > output.csv

COPYRIGHT
=========

**csv2sql** is open source software released under the MIT License. See::

  http://www.opensource.org/licenses/MIT

AUTHORS
=======

**csv2sql** was written by Matt Rideout.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The csv2sql homepage: http://csv2sql.org/

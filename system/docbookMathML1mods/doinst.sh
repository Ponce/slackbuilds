catalog_filepath=etc/xml/docbook

if [ ! -e etc/xml ]; then
    mkdir -p etc/xml
    xmlcatalog --noout --create $catalog_filepath
fi

# DocBook V4.5 Entries
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML V4.5//EN" \
  "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
 "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
 "file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://www.oasis-open.org/docbook/xml/4.5" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://www.oasis-open.org/docbook/xml/4.5" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML V4.1.2//EN" \
  "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://www.oasis-open.org/docbook/xml/4.1.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://www.oasis-open.org/docbook/xml/4.1.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML V4.2//EN" \
  "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://www.oasis-open.org/docbook/xml/4.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://www.oasis-open.org/docbook/xml/4.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML V4.3//EN" \
  "http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://www.oasis-open.org/docbook/xml/4.3" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://www.oasis-open.org/docbook/xml/4.3" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'public' \
  "-//OASIS//DTD DocBook XML V4.4//EN" \
  "http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://www.oasis-open.org/docbook/xml/4.4" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://www.oasis-open.org/docbook/xml/4.4" \
  "file:///usr/share/xml/docbook/xml-dtd-4.5" \
  $catalog_filepath
 
# DocBook MathML1 modules' catalog entry
xmlcatalog --noout --add 'nextCatalog' \
  '' \
  "file:///usr/share/xml/docbook/custom/mathml/catalog_DocBook_MathML1_mods.xml" \
  $catalog_filepath

# 'docbook-xml5' package installation check
if [ -e var/lib/pkgtools/packages/docbook-xml5* ]; then
    xmlcatalog --noout --del \
      "file:///usr/share/xml/docbook/5.0/catalog_docbook-5.0.0.xml" \
      $catalog_filepath
    xmlcatalog --noout --add 'nextCatalog' \
      '' \
      "file:///usr/share/xml/docbook/5.0/catalog_docbook-5.0.0.xml" \
      $catalog_filepath
fi

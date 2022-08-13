catalog_filepath=etc/xml/catalog

if [ ! -e etc/xml ]; then
    mkdir -p etc/xml
    xmlcatalog --noout --create $catalog_filepath
fi

# DocBook V4.x Entries
xmlcatalog --noout --add 'delegatePublic' \
  "-//OASIS//ENTITIES DocBook XML" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegatePublic' \
  "-//OASIS//DTD DocBook XML" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateSystem' \
  "http://www.oasis-open.org/docbook/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateURI' \
  "http://www.oasis-open.org/docbook/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateSystem' \
  "http://www.oasis-open.org/docbook/xml/4.1.2/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateURI' \
  "http://www.oasis-open.org/docbook/xml/4.1.2/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateSystem' \
  "http://www.oasis-open.org/docbook/xml/4.2/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateURI' \
  "http://www.oasis-open.org/docbook/xml/4.2/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateSystem' \
  "http://www.oasis-open.org/docbook/xml/4.3/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateURI' \
  "http://www.oasis-open.org/docbook/xml/4.3/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateSystem' \
  "http://www.oasis-open.org/docbook/xml/4.4/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'delegateURI' \
  "http://www.oasis-open.org/docbook/xml/4.4/" \
  "file:///etc/xml/docbook" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://cdn.docbook.org/release/xsl-nons/1.79.2" \
  "file://usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://cdn.docbook.org/release/xsl-nons/1.79.2" \
  "file://usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://cdn.docbook.org/release/xsl-nons/current" \
  "file://usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://cdn.docbook.org/release/xsl-nons/current/" \
  "file://usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteSystem' \
  "http://docbook.sourceforge.net/release/xsl/current" \
  "/usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath
xmlcatalog --noout --add 'rewriteURI' \
  "http://docbook.sourceforge.net/release/xsl/current" \
  "/usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
  $catalog_filepath

# 'mathML2dtd' catalog Entry
xmlcatalog --noout --add 'nextCatalog' \
  '' \
  "file:///usr/share/xml/schema/w3c/mathml2/catalog_mathML2.xml" \
  $catalog_filepath

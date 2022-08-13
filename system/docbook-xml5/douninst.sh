catalog_filepath=etc/xml/docbook

# Remove DocBook V5.0.0 catalog entry
xmlcatalog --noout --del \
  "file:///usr/share/xml/docbook/5.0/catalog_docbook-5.0.0.xml" \
  $catalog_filepath

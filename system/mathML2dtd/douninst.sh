catalog_filepath=etc/xml/catalog

# Remove 'mathML2dtd' catalog Entry
xmlcatalog --noout --del \
  "file:///usr/share/xml/schema/w3c/mathml2/catalog_mathML2.xml" \
  $catalog_filepath

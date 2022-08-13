catalog_filepath=etc/xml/docbook

# Remove DocBook MathML1 modules' catalog entry
xmlcatalog --noout --del \
  "file:///usr/share/xml/docbook/custom/mathml/catalog_DocBook_MathML1_mods.xml" \
  $catalog_filepath

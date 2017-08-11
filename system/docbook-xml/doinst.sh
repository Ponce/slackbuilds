if [ ! -e etc/xml/docbook ]; then
  mkdir -p etc/xml
  xmlcatalog --noout --create etc/xml/docbook
fi

# V4.1.2
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook XML V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/docbookx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/calstblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/soextblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook XML Information Pool V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/dbpoolx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/dbhierx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/dbgenent.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook XML Notations V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/dbnotnx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook XML Character Entities V4.1.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2/dbcentx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem" \
  "http://www.oasis-open.org/docbook/xml/4.1.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteURI" \
  "http://www.oasis-open.org/docbook/xml/4.1.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
  etc/xml/docbook

# V4.2
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook XML V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/docbookx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook CALS Table Model V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/calstblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/soextblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Information Pool V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/dbpoolx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/dbhierx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Additional General Entities V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/dbgenent.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Notations V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/dbnotnx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Character Entities V4.2//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2/dbcentx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem" \
  "http://www.oasis-open.org/docbook/xml/4.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteURI" \
  "http://www.oasis-open.org/docbook/xml/4.2" \
  "file:///usr/share/xml/docbook/xml-dtd-4.2" \
  etc/xml/docbook

# V4.3
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook XML V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/docbookx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook CALS Table Model V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/calstblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/soextblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Information Pool V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/dbpoolx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/dbhierx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Additional General Entities V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/dbgenent.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Notations V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/dbnotnx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Character Entities V4.3//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3/dbcentx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem" \
  "http://www.oasis-open.org/docbook/xml/4.3" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteURI" \
  "http://www.oasis-open.org/docbook/xml/4.3" \
  "file:///usr/share/xml/docbook/xml-dtd-4.3" \
  etc/xml/docbook

# V4.4
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook XML V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/docbookx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD DocBook CALS Table Model V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/calstblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/htmltblx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/soextblx.dtd" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Information Pool V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/dbpoolx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/dbhierx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Additional General Entities V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/dbgenent.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Notations V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/dbnotnx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "public" \
  "-//OASIS//ENTITIES DocBook Character Entities V4.4//EN" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4/dbcentx.mod" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteSystem" \
  "http://www.oasis-open.org/docbook/xml/4.4" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4" \
  etc/xml/docbook
xmlcatalog --noout --add "rewriteURI" \
  "http://www.oasis-open.org/docbook/xml/4.4" \
  "file:///usr/share/xml/docbook/xml-dtd-4.4" \
  etc/xml/docbook

if [ ! -e etc/xml/catalog ]; then
  xmlcatalog  --create etc/xml/catalog
fi
xmlcatalog --noout --add "delegatePublic" \
  "-//OASIS//ENTITIES DocBook XML" \
  "file:///etc/xml/docbook" \
  etc/xml/catalog
xmlcatalog --noout --add "delegatePublic" \
  "-//OASIS//DTD DocBook XML" \
  "file:///etc/xml/docbook" \
  etc/xml/catalog
xmlcatalog --noout --add "delegateSystem" \
  "http://www.oasis-open.org/docbook/" \
  "file:///etc/xml/docbook" \
  etc/xml/catalog
xmlcatalog --noout --add "delegateURI" \
  "http://www.oasis-open.org/docbook/" \
  "file:///etc/xml/docbook" \
  etc/xml/catalog

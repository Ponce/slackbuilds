# Update SAX parsers
chroot .  
/usr/bin/perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::LibXML::SAX::Parser))->save_parsers()" 1>/dev/null
/usr/bin/perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::LibXML::SAX))->save_parsers()" 1>/dev/null



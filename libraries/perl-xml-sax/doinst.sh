if [ -f usr/lib/perl5/vendor_perl/5.10.0/XML/SAX/ParserDetails.ini ]; then
	echo "ParserDetails.ini file already installed.";
else
 	perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::SAX::PurePerl))->save_parsers()"
	echo "Creating ParserDetails.ini..."
fi


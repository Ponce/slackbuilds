if [ -f usr/lib/perl5/site_perl/5.8.8/XML/SAX/ParserDetails.ini ]; then
	echo "ParserDetails.ini file already installed.";
else
 	perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::SAX::PurePerl))->save_parsers()"
	echo "Creating ParserDetails.ini..."
fi


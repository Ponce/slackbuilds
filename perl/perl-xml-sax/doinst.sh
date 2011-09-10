if [ -f @PERLPATH@/XML/SAX/ParserDetails.ini ]; then
	echo "ParserDetails.ini file already installed.";
else
 	perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::SAX::PurePerl))->save_parsers()"
	echo "Creating ParserDetails.ini..."
fi


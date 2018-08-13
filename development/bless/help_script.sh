#!/bin/sh

# Script that loads help for Bless. Modified by B. Watson for
# slackbuilds.org. No idea if the gnome-help or yelp stuff really works,
# I haven't got either one installed. At least the user manual opens
# in an actual browser with this version of the script.

xml_help="/usr/doc/bless-@VERSION@/user/bless-manual.xml"
html_help="/usr/doc/bless-@VERSION@/user/index.html"

# try to get default browsers from GConf
GCONFTOOL=`which gconftool-2 2> /dev/null`

if [[ -n $GCONFTOOL ]];
then
    help_browser=`$GCONFTOOL --get "/desktop/gnome/url-handlers/ghelp/command"`
    if [[ -n "$help_browser" ]];
    then
        help_browser=`echo "$help_browser" | cut -d' ' -f1`
    fi
    
    http_browser=`$GCONFTOOL --get "/desktop/gnome/url-handlers/http/command"`
    
    if [[ -n "$http_browser" ]];
    then
        http_browser=`echo "$http_browser" | cut -d' ' -f1`
    fi
fi

# some other browsers
yelp_browser=`which yelp 2> /dev/null`
firefox_browser=`which firefox 2> /dev/null`
mozilla_browser=`which mozilla 2> /dev/null`

([[ -n $help_browser ]] && $help_browser $xml_help) ||
([[ -n $yelp_browser ]] && $yelp_browser $xml_help) ||
([[ -n $http_browser ]] && $http_browser $html_help) ||
([[ -n $firefox_browser ]] && $firefox_browser $html_help) ||
([[ -n $mozilla_browser ]] && $mozilla_browser $html_help)

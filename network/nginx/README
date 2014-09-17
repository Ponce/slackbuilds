nginx [engine x] is a high-performance HTTP server and reverse proxy
as well as an IMAP/POP3 proxy server.

By default, nginx will use the "nobody" user and group accounts. You may
specify alternate values on the command line if desired; for example:

    NGINXUSER=backup NGINXGROUP=backup ./nginx.SlackBuild

Regardless of which user and group you decide to use, you will need to make
sure they exist on both the build system and the target system.

Geoip support is now available as an option using the GeopIP package. If you wish
to enable GeoIP the pass USE_GEOIP variable to the slackbuild:

    USE_GEOIP=yes ./nginx.SlackBuild

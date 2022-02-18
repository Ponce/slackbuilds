#!/bin/sh

# 20220218 bkw: download the PDF docs for SOGo. upstream site does
# user-agent checking, so we pretend to be an ancient version of
# firefox.

wget --user-agent 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)' \
  https://sogo.nu/files/docs/SOGoInstallationGuide.pdf \
  https://sogo.nu/files/docs/SOGoMozillaThunderbirdConfigurationGuide.pdf \
  https://sogo.nu/files/docs/SOGoOutlookConnectorConfigurationGuide.pdf

md5sum -c docs.md5sums
exit $?

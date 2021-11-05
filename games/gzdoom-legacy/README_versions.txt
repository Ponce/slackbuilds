
This SlackBuild script can be used to build older versions
of gzdoom. Supported versions:

1.8.09 - last version to use SDL1 (good for older/slower systems).
1.9.1 - last version to not require OpenGL 3.0 (good for nouveau).
2.4.0 - latest version of gzdoom 2.x.

By default, 2.4.0 is built (as per the .info file). If you'd like to
try one of the others, download the source, save it in the SlackBuild
directory, and run gzdoom.SlackBuild with VERSION=1.8.09 or VERSION=1.9.1
set in the environment. If you use sbopkg, you can create a custom .info
file, and copy the lines below:

For 1.8.09:

VERSION="1.8.09"
DOWNLOAD="https://slackware.uk/~urchlay/src/g1.8.09.tar.gz"
MD5SUM="ddc1dd8aef254312031184be6dec21e6"

For 1.9.1:

VERSION="1.9.1"
DOWNLOAD="https://github.com/coelckers/gzdoom/archive/g1.9.1.tar.gz"
MD5SUM="0fb38fcf73084f9a798f9d3af643d02e"

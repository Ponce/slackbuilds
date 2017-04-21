VERSION=0.2

if [ -e config.h ]; then
  echo "config.h file already exists."
  exit 1
fi
echo "2bwm-$VERSION.tar.gz -> config.h"
gzip -d < 2bwm-$VERSION.tar.gz | tar xO 2bwm-$VERSION/config.h > config.h

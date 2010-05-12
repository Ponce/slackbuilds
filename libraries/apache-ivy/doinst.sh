postinstall scriptlet (using /bin/sh):
rm -f /usr/share/java/ivy.jar
ln -s /usr/share/java/ivy-1.4.1.jar /usr/share/java/ivy.jar
postuninstall scriptlet (using /bin/sh):
if [ "$1" = "0" ]; then
  # Remove the old link
  rm -f /usr/share/java/ivy.jar

  # Put back a new link. It's OK if this fails, that just means there
  # is no other version of the package installed
  ln -fs `ls -tr /usr/share/java/ivy-* 2>/dev/null|tail -n 1` /usr/share/java/ivy.jar || true
fi

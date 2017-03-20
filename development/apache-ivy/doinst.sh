# 20170320 bkw: got rid of dead code (if [ "$1" = "0" ]... would never be
# true in a doinst), got rid of absolute paths, and there were comments
# missing their # so they were executed as code...
rm -f usr/share/java/ivy.jar
ln -s ivy-1.4.1.jar usr/share/java/ivy.jar

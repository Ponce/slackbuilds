svn co svn://svn.icculus.org/alienarena/trunk
cd trunk
svn update -r 4307
cd ..
mv trunk alienarena-7.66-svn4307
tar --exclude-vcs -cJf alienarena-7.66-svn4307.tar.xz alienarena-7.66-svn4307

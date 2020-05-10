rm -fR /tmp/tmp-etlegacy
mkdir -p /tmp/tmp-etlegacy
cd /tmp/tmp-etlegacy
git clone git://github.com/etlegacy/etlegacy.git
cd etlegacy
git submodule init
git submodule update
cd libs
git archive master > ../../libs.tar
cd ..
COMMIT=$( git log -1 | head -1 | cut -c 8-14 )
COMMDATE=$( git log -1 --date=short | grep ^Date | awk '{print $2}' | sed 's/-//g' )
rm -f /tmp/etlegacy-${COMMDATE}_${COMMIT}.tar.xz
git archive master > ../src.tar
cd ..
mkdir etlegacy-${COMMDATE}_${COMMIT}
cd etlegacy-${COMMDATE}_${COMMIT}
tar xf ../src.tar
cd libs
tar xf ../../libs.tar
cd ..
cd ..
rm -f src.tar libs.tar scripts.tar
tar Jcf /tmp/etlegacy-${COMMDATE}_${COMMIT}.tar.xz etlegacy-${COMMDATE}_${COMMIT}
echo "/tmp/etlegacy-${COMMDATE}_${COMMIT}.tar.xz done."

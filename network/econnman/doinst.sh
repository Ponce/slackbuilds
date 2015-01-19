# Ugly hack since this version linked statically to icu4c-49
## thanks to willysr
(
cd /usr/lib${LIBDIRSUFFIX}
if ! [ -f libicule.so.49 ]; then
  ln -s libicule.so.51 libicule.so.49
fi

if ! [ -f libicuuc.so.49 ]; then
  ln -s libicuuc.so.51 libicuuc.so.49
fi

if ! [ -f libicudata.so.49 ]; then
  ln -s libicudata.so.51 libicudata.so.49
fi
)

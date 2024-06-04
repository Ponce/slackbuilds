echo "Generating images"

echo usr/lib64/chibi/chibi.img
LD_LIBRARY_PATH="/usr/lib64" DYLD_LIBRARY_PATH="usr/lib64" CHIBI_MODULE_PATH="usr/lib64/chibi" usr/bin/chibi-scheme -mchibi.repl -d usr/lib64/chibi/chibi.img

echo usr/lib64/chibi/red.img
LD_LIBRARY_PATH="/usr/lib64" DYLD_LIBRARY_PATH="usr/lib64" CHIBI_MODULE_PATH="usr/lib64/chibi" usr/bin/chibi-scheme -xscheme.red -mchibi.repl -d usr/lib64/chibi/red.img

echo usr/lib64/chibi/snow.img
LD_LIBRARY_PATH="/usr/lib64" DYLD_LIBRARY_PATH="usr/lib64" CHIBI_MODULE_PATH="usr/lib64/chibi" usr/bin/chibi-scheme -mchibi.snow.commands -mchibi.snow.interface -mchibi.snow.package -mchibi.snow.utils -d usr/lib64/chibi/snow.img

echo Done

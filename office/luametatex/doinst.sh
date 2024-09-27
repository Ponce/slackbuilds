if [ -e /usr/bin/context ]; then
	rm /usr/bin/context* /usr/bin/mtxrun*
fi
( cd opt/context/native/bin; rm -rf context )
( cd opt/context/native/bin; ln -sf luametatex context )
( cd opt/context/native/bin; rm -rf mtxrun )
( cd opt/context/native/bin; ln -sf luametatex mtxrun )
( cd opt/context/native/bin; rm -rf context.lua )
( cd opt/context/native/bin; ln -sf /usr/share/texmf-dist/scripts/context/lua/context.lua )
( cd opt/context/native/bin; rm -rf mtxrun.lua )
( cd opt/context/native/bin; ln -sf /usr/share/texmf-dist/scripts/context/lua/mtxrun.lua )
( cd opt/context; rm -f texmf-config )
( cd opt/context; ln -sf /usr/share/texmf-config )
( cd opt/context; rm -f texmf-dist )
( cd opt/context; ln -s /usr/share/texmf-dist )
( cd opt/context; rm -f texmf-local )
( cd opt/context; ln -sf /usr/share/texmf-local )
( cd opt/context; rm -f  texmf-var )
( cd opt/context; ln -sf /usr/share/texmf-var )

./opt/context/native/bin/mtxrun --generate

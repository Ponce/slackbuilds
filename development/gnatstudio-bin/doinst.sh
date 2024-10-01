# Update gdkpixbuf loaders cache

basedir=/opt/gnatstudio
LD_LIBRARY_PATH=$basedir/lib/gnatstudio:$LD_LIBRARY_PATH \
GDK_PIXBUF_MODULE_FILE=$basedir/lib/gnatstudio/gdk-pixbuf-2.0/2.10.0/loaders.cache \
GDK_PIXBUF_MODULEDIR=$basedir/lib/gnatstudio/gdk-pixbuf-2.0/2.10.0/loaders \
./$basedir/bin/gdk-pixbuf-query-loaders --update-cache

# Update immodules cache

LD_LIBRARY_PATH=$basedir/lib/gnatstudio:$LD_LIBRARY_PATH \
GTK_IM_MODULE_FILE=$basedir/lib/gnatstudio/gtk-3.0/3.0.0/immodules.cache \
GTK_PATH=$basedir/lib/gnatstudio/gtk-3.0 \
./$basedir/bin/gtk-query-immodules-3.0 --update-cache

/* 20191231 bkw: This seems like stupidity: g_content_type_is_mime_type
   is a new function in glib-2.52, which literally just calls the
   g_content_type_is_a function from older glibs, and returns its
   result. Here's the function from the glib-2.52 source:

   gboolean
   g_content_type_is_mime_type (const gchar *type,
                                const gchar *mime_type)
   {
     return g_content_type_is_a (type, mime_type);
   }

   The docs describe it as a "convenience wrapper" but there's
   nothing more or less convenient about it, except that it breaks builds
   with older glib versions. Why does it even exist?
 */
#define g_content_type_is_mime_type(x,y) g_content_type_is_a(x,y)

/* 20191231 bkw: We'd need gtk+-3.22 to have gtk_popover_popup and
   gtk_popover_popdown. They're functionally the same as gtk_widget_show
   and gtk_widget_hide, except they have a "transition" (fade-in/out).
   Some folks might actually prefer it without the fade.
 */
#define gtk_popover_popup(x) gtk_widget_show(GTK_WIDGET(x))
#define gtk_popover_popdown(x) gtk_widget_hide(GTK_WIDGET(x))

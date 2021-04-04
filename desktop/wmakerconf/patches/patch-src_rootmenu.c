--- src/rootmenu.c.orig	2005-02-26 15:31:26.000000000 +0100
+++ src/rootmenu.c	2020-12-19 11:01:13.863392000 +0100
@@ -365,7 +365,7 @@
 		       node_freeitem, NULL);
       g_node_destroy (node);
 
-      if (WMWritePropListToFile (menu, filename, YES))
+      if (WMWritePropListToFile(menu, filename))
       {
 	 menu_changed = NO;
 	 message (_("Window Maker root menu file '%s' saved."), filename);

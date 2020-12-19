--- src/menu.c.orig	2004-12-05 04:19:25.000000000 +0100
+++ src/menu.c	2020-12-19 10:50:15.292392000 +0100
@@ -500,10 +500,10 @@
  *  No return value.
  */
 {
-   if (!WMWritePropListToFile (orig_wmaker, orig_wmaker_fname, YES))
+   if (!WMWritePropListToFile(orig_wmaker, orig_wmaker_fname))
       warning (_("Can't revert to backupfile of `WindowMaker'. "
 		 "Please manually revert from file WindowMaker.bak."));
-   if (orig_rootmenu && !WMWritePropListToFile (orig_rootmenu, orig_rootmenu_fname, YES))
+   if (orig_rootmenu && !WMWritePropListToFile(orig_rootmenu, orig_rootmenu_fname))
       warning (_("Can't revert to backupfile of `WMRootMenu'. "
 		 "Please manually revert from file WMRootMenu.bak."));
    gtk_main_quit ();

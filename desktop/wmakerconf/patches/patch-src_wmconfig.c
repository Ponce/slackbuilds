--- src/wmconfig.c.orig	2007-05-18 12:41:22.000000000 +0200
+++ src/wmconfig.c	2020-12-19 11:03:44.037392000 +0100
@@ -216,7 +216,7 @@
 	 /*
 	  *  Generate backup file "'path'.bak"
 	  */
-	 if (WMWritePropListToFile (orig_rootmenu, new, YES))
+	 if (WMWritePropListToFile(orig_rootmenu, new))
 	    message (_("Backupfile `%s' generated."), new);
 	 else
 	    error (_("Can't write backupfile `%s'."), new);
@@ -280,7 +280,7 @@
    if (!windowmaker)
    {
       windowmaker = global_windowmaker;
-      if (WMWritePropListToFile (windowmaker, orig_wmaker_fname, YES))
+      if (WMWritePropListToFile(windowmaker, orig_wmaker_fname))
 	 warning (_("New WindowMaker configuration file `%s' created."),
 		  orig_wmaker_fname);
       else
@@ -294,7 +294,7 @@
       /*
        *  Generate backup file "'path'.bak"
        */
-      if (WMWritePropListToFile (windowmaker, new, YES))
+      if (WMWritePropListToFile(windowmaker, new))
 	 message (_("Backupfile `%s' generated."), new);
       else
 	 error (_("Can't write backupfile `%s'."), new);

diff -Naur Mad-Assembler-2.1.6/examples/compression/deflate/pc/zoplfi.sh Mad-Assembler-2.1.6.patched/examples/compression/deflate/pc/zoplfi.sh
--- Mad-Assembler-2.1.6/examples/compression/deflate/pc/zoplfi.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/deflate/pc/zoplfi.sh	2024-11-02 02:48:27.941314366 -0400
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+zopfli --deflate INPUT_FILE
diff -Naur Mad-Assembler-2.1.6/examples/compression/doynamite/pc/lz.sh Mad-Assembler-2.1.6.patched/examples/compression/doynamite/pc/lz.sh
--- Mad-Assembler-2.1.6/examples/compression/doynamite/pc/lz.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/doynamite/pc/lz.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+lz -o filename.out --raw --binfile filename.in
+
+# lz.exe -o %~dp1%~n1.lz --raw --binfile %1
diff -Naur Mad-Assembler-2.1.6/examples/compression/exomizer/pc/exomizer.sh Mad-Assembler-2.1.6.patched/examples/compression/exomizer/pc/exomizer.sh
--- Mad-Assembler-2.1.6/examples/compression/exomizer/pc/exomizer.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/exomizer/pc/exomizer.sh	2024-11-02 02:48:27.941314366 -0400
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+# https://bitbucket.org/magli143/exomizer/wiki/Home
+
+# exomizer sfx sys -t 168 -Di_ram_enter=0xff -Di_ram_exit=0xff -Di_table_addr=0xbc40 -c -n %1.obx -o %1.xex
+
+exomizer mem -l none -c filename.mic -o filename.pck
diff -Naur Mad-Assembler-2.1.6/examples/compression/lz4/@make.sh Mad-Assembler-2.1.6.patched/examples/compression/lz4/@make.sh
--- Mad-Assembler-2.1.6/examples/compression/lz4/@make.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/lz4/@make.sh	2024-11-02 02:48:27.941314366 -0400
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+lz4 koronis.mic koronis.lz4
+mads unlz4.asm
diff -Naur Mad-Assembler-2.1.6/examples/compression/pucrunch/pc/pucrunch.sh Mad-Assembler-2.1.6.patched/examples/compression/pucrunch/pc/pucrunch.sh
--- Mad-Assembler-2.1.6/examples/compression/pucrunch/pc/pucrunch.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/pucrunch/pc/pucrunch.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+pucrunch -c0 -d -l0x4000 -fshort filename.dat filename.pck
diff -Naur Mad-Assembler-2.1.6/examples/compression/subsizer/pc/subsizer.sh Mad-Assembler-2.1.6.patched/examples/compression/subsizer/pc/subsizer.sh
--- Mad-Assembler-2.1.6/examples/compression/subsizer/pc/subsizer.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/compression/subsizer/pc/subsizer.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+subsizer -m -o filename.out filename.in
+subsizer -r -o filename.out filename.in
diff -Naur "Mad-Assembler-2.1.6/examples/graphics/lepix v0.2.0/!go.sh" "Mad-Assembler-2.1.6.patched/examples/graphics/lepix v0.2.0/!go.sh"
--- "Mad-Assembler-2.1.6/examples/graphics/lepix v0.2.0/!go.sh"	1969-12-31 19:00:00.000000000 -0500
+++ "Mad-Assembler-2.1.6.patched/examples/graphics/lepix v0.2.0/!go.sh"	2024-11-02 02:48:27.941314366 -0400
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+mads lepix.asx -o:lepixtip.xex
diff -Naur Mad-Assembler-2.1.6/examples/sprites/chars/!engine.sh Mad-Assembler-2.1.6.patched/examples/sprites/chars/!engine.sh
--- Mad-Assembler-2.1.6/examples/sprites/chars/!engine.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/sprites/chars/!engine.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+mads init/init.asm -d:charsBAK=56 -i:global -i:init
+
+mads bcalc.asm -d:bufor=2 -o:b2calc.obx -i:global
+mads bcalc.asm -d:bufor=3 -o:b3calc.obx -i:global
+
+mads engine.asm -i:global
diff -Naur Mad-Assembler-2.1.6/examples/sprites/chars/shape/!go.sh Mad-Assembler-2.1.6.patched/examples/sprites/chars/shape/!go.sh
--- Mad-Assembler-2.1.6/examples/sprites/chars/shape/!go.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/sprites/chars/shape/!go.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+mads -d:x=0 -d:type=3 -d:frames=10 shape.asm -o:shape1.dat -i:../global
+mads -d:x=4 -d:type=3 -d:frames=8 shape.asm -o:shape2.dat -i:../global
+mads -d:x=8 -d:type=2 -d:frames=13 shape.asm -o:shape3.dat -i:../global
diff -Naur Mad-Assembler-2.1.6/examples/time-date/@mads.sh Mad-Assembler-2.1.6.patched/examples/time-date/@mads.sh
--- Mad-Assembler-2.1.6/examples/time-date/@mads.sh	1969-12-31 19:00:00.000000000 -0500
+++ Mad-Assembler-2.1.6.patched/examples/time-date/@mads.sh	2024-11-02 02:48:27.942314366 -0400
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+YYYY="$( date +%Y )"
+MM="$( date +%m )"
+DD="$( date +%d )"
+
+HH24="$( date +%H )"
+MI="$( date +%M )"
+SS="$( date +%S )"
+FF="00" # 20241102 bkw: no fractions of a sec for the *nix date command.
+
+mads time.asm -pl -d:year=%YYYY% -d:month=%MM% -d:day=%DD% -d:hour=%HH24% -d:minute=%MI% -d:second=%SS%

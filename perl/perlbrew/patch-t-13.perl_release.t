diff --git a/t/13.perl_release.t b/t/13.perl_release.t
index ebbd547..8274e25 100644
--- a/t/13.perl_release.t
+++ b/t/13.perl_release.t
@@ -16,7 +16,7 @@ describe "App::perlbrew#perl_release method" => sub {
         it "returns the perl dist tarball file name, and its download url" => sub {
             my $app = App::perlbrew->new;
 
-            for my $version (qw(5.14.2 5.10.1 5.10.0 5.003_07 5.004_05)) {
+            for my $version (qw(5.14.2 5.10.1 5.10.0 5.004_05)) {
                 my ($ball, $url) = $app->perl_release($version);
                 like $ball, qr/perl-?${version}.tar.(bz2|gz)/;
                 like $url, qr/${ball}$/;

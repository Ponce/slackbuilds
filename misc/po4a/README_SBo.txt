Dependency tree is as follows (all dependencies listed are available
at http://slackbuilds.org).

po4a
|
|-- perl-Module-Build
|-- perl-YAML-Tiny. mandatory for the YAML module.
|-- perl-text-WrapI18N to format po4a's warnings and error messages.
|   |                  Optional.
|   |-- Text::CharWidth. Mandatory
|-- perl-Unicode-LineBreak, includes module Unicode::GCString to compute
    text width, neeeded by AsciiDoc to determine two line titles in
    encodings different from ASCII. Mandatory for TEXT module.
    |-- perl-MIME-Charset. Mandatory
        |-- perl-Encode-EUCJPASCII. Optional
        |-- perl-Encode-HanExtra. Optional.
        |-- perl-Encode-JISX0213. Optional
            |-- perl-Encode-ISO2022. Mandatory

In addition, perl-Test-Pod allows running the test for the POFD format.

Note: by default the SlackBuild does not run "./Build test". If
you want to run the tests, export TESTS=yes in the SlackBuild's
environment. This will make the package take a few extra minutes to
build.

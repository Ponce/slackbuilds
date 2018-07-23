This build was listed as "orphaned - no maintainer" for a while.

I thought it would be nice to update it for the latest version of
TeighaViewer, which supports x86_64. Unfortunately, the latest version
segfaults with an unhelpful error message, and all attempts to find a
solution have been fruitless. Google searches show Ubuntu users having
the same problem, meaning TeighaViewer 19.5.0.0 doesn't even work on the
platform it's intended for (Ubuntu). So I'm sticking with 4.00.0 for now,
meaning this is still a 32-bit-only build.

The download site only has the latest version, but I was able to find
several older versions (newer than 4.00.0) on web.archive.org and test
them. These didn't crash, but they also didn't *work*: none of them
would actually render anything. These versions all use qt5, and were
built against older qt5 releases (5.3.x), so the problem might be qt5
incompatibility... only the qt4 32-bit-only version works :(

I'm listing myself as maintainer, but unless there's a new version of
TeighaViewer that actually works, I won't be upgrading this build.

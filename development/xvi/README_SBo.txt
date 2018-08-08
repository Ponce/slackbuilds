The xvi binary is 2/3 the size of Slackware's nano binary, or 1/4 the
size of elvis, or 1/20 the size of vim. It's also approximately 1/2 the
size of ex-vi. This isn't quite a fair comparison as xvi is built with
-Os (optimize for size) by default. If you want to use -O2 like other
SlackBuilds do, set OPT=-O2 in the environment. xvi will be 25% larger,
but it'll still be 15% smaller than nano.

Since xvi is a standalone binary (doesn't rely on support files, like
vim's /usr/share/vim/*), it makes a good 'system rescue' editor. If
built statically, it makes an even better rescue editor. To do this,
set STATIC=yes in the environment. In this case, xvi will be installed
to /bin, since it might be needed to recover from a "can't mount /usr"
situation. Note that xvi's internal help will not be available, if /usr
isn't mounted.

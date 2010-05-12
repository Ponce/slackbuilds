Metapixel 1.0.2
===============

Metapixel is a program for generating photomosaics.  It can generate
classical photomosaics, in which the source image is viewed as a
matrix of equally sized rectangles for each of which a matching image
is substitued, as well as collage-style photomosaics, in which
rectangular parts of the source image at arbitrary positions (i.e. not
aligned to a matrix) are substituted by matching images.


Installation
------------

To compile Metapixel, you need, in addition to a C compiler, libpng,
libjpeg, and giflib.  To run the script for preparing constituent
images, you will additionally need Perl.  Most Linux distributions
contain these software packages.  On MacOS X, you can get them with
Fink (http://fink.sourceforge.net/).

Edit the first line of Makefile if you want to install Metapixel
somewhere else than /usr/local.  Then, type

  make

If everything compiled fine, become root and type

  make install


Configuring Metapixel
---------------------

You can optionally create a file ".metapixelrc" in your home directory
to store some settings which makes it easier to use Metapixel, since
you won't have to use that many switches on the command line.

A sample configuration file is included in the Metapixel distribution
under the name "metapixelrc".  See the section "The Configuration
File" below for details.  It is advisable to at least set the options
"prepare-directory" and "library-directory".


Preparing images
----------------

Before (non-anti-mosaic) mosaics can be created, the constituent
images need to be preprocessed.  Preparing an image does two things.
Firstly, it computes various coefficients by which the image can be
matched against a part of a source image.  Secondly, the image is
scaled to a smaller size.  Usually this will be the size you intend to
use for it in the target image, but it can be any arbitrary size.  It
makes sense to scale your images to the maximum size that you will use
for constituent images.  That way, no information gets lost.  The
default size is 128x128 pixels.  The matching data and the scaled
images are stored in a directory which is then called a "library".
You can use more than one library in the creation of a mosaic.

To simplify the task of creating a library, the Perl script
'metapixel-prepare' is included in the distribution.  It must be
called with the name of the directory where your original images are
stored in.  As a second argument you must give the directory of the
library to which the images are to be added.  If you have set a
default directory for preparing images in your configuration file,
the second argument is optional.

If the script is called with the option "--recurse", it searches the
directory with the original images recursively, i.e., it searches all
its direct and indirect subdirectories as well.  It also accepts
parameters specifying the size of the scaled down images.  Just call
it - it prints out usage information.

If the script constantly complains that an error occurred when running
'metapixel', that probably means that metapixel is not in your path.
The other possibility is that all your images are in a format that
Metapixel doesn't like (it only supports JPEG, PNG, and GIF).


Creating photomosaics
---------------------

Input images for mosaics can have arbitrary sizes.  Should you want
the created mosaic to be of a different size than the input image, use
the --scale option.  It scales the input image uniformly in both
directions (i.e. obeying the aspect ratio).  If the width or height of
the input image after scaling are not multiples of the width and
height of the constituent images, the input image is further scaled up
to the smallest size (larger than the input image) that obeys this
constraint, possibly changing the aspect ratio a bit.  This does not
apply to collages, however.  The sizes of their source images after
scaling are always left untouched.

Metapixel produces output images in the PNG or JPEG formats, depending
on the extension of the output file name.  In order to create a
classic photomosaic for the image input.jpg and write the output to
output.png with constituent images stored in the directory "images",
use the following command line:

  metapixel --library images --metapixel input.jpg output.png

To create a collage use

  metapixel --library images --collage --metapixel input.jpg output.png

Using the -y, -i and -q options you can change the weights for each of
the color channels.  For example, to match only luminance, completely
disregarding chrominance, use

  metapixel --library images -i0 -q0 --metapixel input.jpg output.png

The default weight for each of the channels is 1.

Using the --cheat option you can specify the percentage by which the
resulting photomosaic should be overlayed by the original image.  The
default is 0, i.e., the photomosaic is not overlayed at all.  A
percentage of 100 yields, not surprisingly, the original image.  A
percentage of 30 makes the photomosaic appear noticably better but is
yet small enough to go unnoticed without close inspection in most
circumstances.

As of version 0.6, Metapixel implements two different matching
algorithms.  The new metric, which is a trivial distance function,
seems to give better results while not being slower than the old
wavelet metric.  The metric can be chosen using the --metric option.
The default is the new subpixel metric.

You can use the --library option more than once to let Metapixel use
more than one library for a mosaic.


Classic Mosaics
---------------

Metapixel allows you to choose between two algorithms for finding
matching images, via the --search option.  The old algorithm called
"local" simply selects the best matching image for each location,
possibly disregarding images selected in locations nearby (see below).

The new algorithm called "global" repeats the following step until all
locations have been assigned to: Find the best match for any location
among all small images that have not already been used.  This
guarantees that no small image is used twice.  Obviously, it also
means that you must have at least as many small images as there are
locations in the image.

Note that "global" is much slower and uses more memory than "local".

The "--distance" option lets you specify the minimal distance between
two occurences of the same constituent image in the target image for
the "local" algorithm.  Distance 0 means that it is allowed for the
same image to occur in adjacent positions in the matrix.  The default
distance is 5, which means that there must be at least 5 images
"between" two occurences of the same image in the matrix.  Note that
Metapixel is forced to select non-optimal matches for distances
greater 0.


Antimosaics
-----------

Antimosaics are classic mosaics for which the small images are the
parts of a single image, possibly the input image itself, and can be
created using the --antimosaic option.  Metapixel subdivides the
antimosaic file as if it were doing a mosaic of that file, but then
uses the resulting subimages as the small images for a classic mosaic.

In case the antimosaic image and the input image are the same,
Metapixel will simply reconstruct the input image from the subimages,
because they will always match best in their original locations.  To
tell Metapixel to do otherwise, you can use the
--forbid-reconstruction option, which allows you to specify a minimum
distance between the original location of a subimage and the location
it has in the resulting mosaic.

Here's how you create an antimosaic with a minimum reconstruction
distance of 2:

  metapixel --library images -x input.jpg -f 2 --metapixel input.jpg output.png


The Configuration File
----------------------

The first thing Metapixel does is try to read the file ".metapixelrc"
in your home directory.  From this file, it reads default values for
its settings, so that you don't have to give them on the command line
each time you use Metapixel.

In this configuration file, you can use the following directives:

  (prepare-directory <directory>)

    The library directory which metapixel-prepare should use by
    default.  metapixel-prepare does not automatically create the
    directory if it doesn't exist, so make sure it does.

  (prepare-dimensions <width> <height>)

    The size metapixel-prepare should use for the small images.

  (library-directory <directory>)

    A library directory which Metapixel should use when creating
    mosaics.  You can use this directive more than once.

  (small-image-dimensions <width> <height>)

    The dimensions of the small images Metapixel should use in
    mosaics.

  (yiq-weights <y> <i> <q>)

    The weights for the channels to be used in matching images.

  (metric <metric>)

    The metric Metapixel should use for matching images.  This can
    either be "subpixel" or "wavelet".

  (search-method <method>)

    The search method for creating classic mosaics.  This can either
    be "local" or "global".

  (minimum-classic-distance <dist>)

    The minimum distance between two occurences of the same image in
    classic mosaics with the local search method.

  (minimum-collage-distance <dist>)

    The minimum distance (in pixels) between two occurences of the
    same image in collage mosaics.

  (cheat-amount <perc>)

    The cheat amount in percent.

  (forbid-reconstruction-distance <dist>)

    The minimum distance between the position of subimage in the
    original image and its position in the output image in an
    antimosaic.

Take a look at the file "metapixelrc" in the distribution.  It gives
examples for each of the directives discussed here.


Collages
--------

To create a collage, you have to use the "--collage" option in
addition to "--metapixel".

You can also specify a minimum distance between two occurences of the
same image, which is measured in pixels.  The default value is 256.
Use the "--distance" option to change it.  Note that the distance is
measured between the centers of the images, not their edges, i.e., a
minimum distance of 10 means that the centers of two occurences of the
same image must be at least 10 pixels apart.  This will usually mean
that they are allowed to overlap, unless you use very tiny small
images.

Note that Metapixel uses ridiculous amounts of memory for collage
mosaics.  To create a collage photomosaics of size 2048x2048 your
machine should at least have 64MBytes RAM.


Protocols
---------

Metapixel can, in addition to producing a classical mosaic, write a
file specifying which small images it put in each of the locations.
This protocol file can then be used to reproduce the mosaic without
doing the matching again, for example to experiment with different
cheat amounts.  The protocol also contains information on how good
each small image matches the original location, so you can find out
where the matches are good and where they aren't.  You can also modify
the protocol and let metapixel generate a mosaic which it wouldn't
have matched itself, for whatever reason you might want to do this.

Use the --out option to create a protocol and the --in option to
reproduce a mosaic from a protocol.  The protocol file is a LISP list
with the following syntax:

  (mosaic (size <WIDTH> <HEIGHT>) (metapixels . <PIXELS>))

<WIDTH> and <HEIGHT> are the number of small images in the mosaic
across the width and height of the mosaic, respectively.  <PIXELS> is
a list containing lists with the following syntax:

  (<X> <Y> <W> <H> <FILENAME>)

<X> and <Y> are the position of the small image.  The upper left small
image has coordinates (0,0), the lower right (<WIDTH>-1,<HEIGHT>-1).
<W> and <H> must both be 1 in this version of Metapixel.  <FILENAME> is
the name of the small image file.

A typical line in the protocol file looks like this:

  (30 23 1 1 "semiharmless.new/wallpaper07.jpg.png") ; 4792.000000

The number at the end of the line is the matching score.  The lower
the score, the better the match.  Note that the semicolon ';'
introduces a comment which lasts ends with the end of the line, so the
matching score is not part of the protocol syntax.


The matching algorithms
-----------------------

The algorithm that does the image matching via wavelets is described
in the paper 'Fast Multiresolution Image Querying' by Charles
E. Jacobs, Adam Finkelstein and David H. Salesin.

The new subpixel metric is very trivial.  I suggest you consult the
source if you are interested in it.  The matching function is
subpixel_compare().


Sorting Images by Size or Aspect Ratio
--------------------------------------

Metapixel comes with a tool called `metapixel-sizesort' which sorts
images by size or aspect ratio by moving them to directories
containing only files with similar size or aspect ratio.

An example: Let's say you have thousands of images in /my/images, and
you want them sorted by aspect ratio and placed in /my/sorted/images.
You can do this with this command:

  metapixel-sizesort --ratio=2 /my/images /my/sorted/images

The option `2' to ratio tells metapixel-sizesort to put all those
images together whose aspect ratios are the same with an accuracy of
two places behind the comma.  You might now have (among others) a
directory called /my/sorted/images/ratio_0.79 which contains all
images whose ratio between width and height is about 0.79.


Upgrading from versions 0.8/0.9/0.10
------------------------------------

Starting from release 0.11, Metapixel requires that the tables file is
in the same directory as the small images described in that file.  If
your configuration is different, all you need to do is to make sure
that all these files are in the same directory.  You don't need to
remove the paths in the tables file, as Metapixel does that
automatically.


Upgrading from versions 0.6/0.7
-------------------------------

The tables file format has changed in Metapixel 0.8, but you don't
need to run 'metapixel-prepare' again.  There's a program called
'convert' included in the distribution that does the job.  Just tell
it which size your small images are, give it the old tables file on
stdin and it writes the new one on stdout.

For example, if your small images are 128 pixels wide and 96 pixels
high, go to the directory with the tables file (usually the directory
where the small images are) and do

  convert --width=128 --height=96 <tables >tables.mxt


Licence and Availability
------------------------

Metapixel is free software distributed under the terms of the GPL.
The file `COPYING' contains the text of the license.

The source of Metapixel is available at the Metapixel homepage at

  http://www.complang.tuwien.ac.at/schani/metapixel/

---
Mark Probst
schani@complang.tuwien.ac.at

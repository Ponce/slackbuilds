try extra; catch extra=0; end
try language; catch language=0; end
try main; catch main=0; end
try nonfree; catch nonfree=0; end
integration=0;
msh=0;
triangular=0;
nan=0;
mapping=0;
windows=0;
secs1d=0;
symband=0;
java=0;
ad=0;
engine=0;
pdb=0;
tsa=0;
graceplot=0;
jhandles=0;
multicore=0;
fpl=0;
ocs=0;
bim=0;
tcl=0;
civil=0;
secs2d=0;
xraylib=0;
data=0;
informationtheory=0;
miscellaneous=0;
special=0;
odepkg=0;
econometrics=0;
financial=0;
strings=0;
irsa=0;
vrml=0;
odebvp=0;
gsl=0;
audio=0;
time=0;
octcdf=0;
outliers=0;
ann=0;
parallel=0;
missing=0;
specfun=0;
physicalconstants=0;
ftp=0;
nnet=0;
statistics=0;
combinatorics=0;
optiminterp=0;
ga=0;
fixed=0;
zenity=0;
control=0;
splines=0;
optim=0;
bioinfo=0;
io=0;
plot=0;
database=0;
general=0;
image=0;
ident=0;
communications=0;
symbolic=0;
video=0;
sockets=0;
signal=0;
struct=0;
linear=0;
octgpr=0;
arpack=0;
spline=0;
pt_br=0;
installed=fopen('installed.tmp','w');
skipped=fopen('skipped.tmp','w');
broken=fopen('broken.tmp','w');
oldcwd=pwd;
cd(pkg_prefix);
pkg prefix ./usr/share/octave/packages ./usr/libexec/octave/packages ;
pkg local_list ./ll
pkg global_list ./gl
cd(oldcwd);
if  extra==1
  fprintf('%s','Building integration (extra) [1/73]... ')
  try
    pkg install ./extra/integration-1.0.5.tar.gz
    integration=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of integration aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping integration (extra) [1/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','integration');
if  extra==1
  fprintf('%s','Building triangular (extra) [2/73]... ')
  try
    pkg install ./extra/triangular-1.0.4.tar.gz
    triangular=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of triangular aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping triangular (extra) [2/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','triangular');
if  extra==1
  fprintf('%s','Building nan (extra) [3/73]... ')
  try
    pkg install ./extra/nan-1.0.6.tar.gz
    nan=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nan aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nan (extra) [3/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','nan');
if  extra==1
  fprintf('%s','Building mapping (extra) [4/73]... ')
  try
    pkg install ./extra/mapping-1.0.5.tar.gz
    mapping=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of mapping aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping mapping (extra) [4/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','mapping');
if  extra==1
  fprintf('%s','Building windows (extra) [5/73]... ')
  try
    pkg install ./extra/windows-1.0.5.tar.gz
    windows=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of windows aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping windows (extra) [5/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','windows');
if  extra==1
  fprintf('%s','Building secs1d (extra) [6/73]... ')
  try
    pkg install ./extra/secs1d-0.0.6.tar.gz
    secs1d=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of secs1d aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping secs1d (extra) [6/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','secs1d');
if  extra==1
  fprintf('%s','Building symband (extra) [7/73]... ')
  try
    pkg install ./extra/symband-1.0.6.tar.gz
    symband=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of symband aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping symband (extra) [7/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','symband');
if  extra==1
  fprintf('%s','Building java (extra) [8/73]... ')
  try
    pkg install ./extra/java-1.2.4.tar.gz
    java=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of java aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping java (extra) [8/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','java');
if  extra==1
  fprintf('%s','Building ad (extra) [9/73]... ')
  try
    pkg install ./extra/ad-1.0.2.tar.gz
    ad=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ad aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ad (extra) [9/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ad');
if  extra==1
  fprintf('%s','Building engine (extra) [10/73]... ')
  try
    pkg install ./extra/engine-1.0.6.tar.gz
    engine=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of engine aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping engine (extra) [10/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','engine');
if  extra==1
  fprintf('%s','Building pdb (extra) [11/73]... ')
  try
    pkg install ./extra/pdb-1.0.5.tar.gz
    pdb=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of pdb aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping pdb (extra) [11/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','pdb');
if  extra==1
  fprintf('%s','Building tsa (extra) [12/73]... ')
  try
    pkg install ./extra/tsa-3.10.6.tar.gz
    tsa=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of tsa aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping tsa (extra) [12/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','tsa');
if java==1 &&  extra==1
  fprintf('%s','Building jhandles (extra) [13/73]... ')
  try
    pkg install ./extra/jhandles-0.3.3.tar.gz
    jhandles=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of jhandles aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping jhandles (extra) [13/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','jhandles');
if  extra==1
  fprintf('%s','Building multicore (extra) [14/73]... ')
  try
    pkg install ./extra/multicore-0.2.12.tar.gz
    multicore=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of multicore aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping multicore (extra) [14/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','multicore');
if  extra==1
  fprintf('%s','Building fpl (extra) [15/73]... ')
  try
    pkg install ./extra/fpl-0.1.2.tar.gz
    fpl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of fpl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping fpl (extra) [15/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','fpl');
if  extra==1
  fprintf('%s','Building ocs (extra) [16/73]... ')
  try
    pkg install ./extra/ocs-0.0.1.tar.gz
    ocs=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ocs aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ocs (extra) [16/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ocs');
if  extra==1
  fprintf('%s','Building tcl (extra) [17/73]... ')
  try
    pkg install ./extra/tcl-octave-0.1.6.tar.gz
    tcl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of tcl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping tcl (extra) [17/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','tcl');
if  extra==1
  fprintf('%s','Building civil (extra) [18/73]... ')
  try
    pkg install ./extra/civil-engineering-1.0.5.tar.gz
    civil=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of civil aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping civil (extra) [18/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','civil');
if  extra==1
  fprintf('%s','Building secs2d (extra) [19/73]... ')
  try
    pkg install ./extra/secs2d-0.0.6.tar.gz
    secs2d=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of secs2d aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping secs2d (extra) [19/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','secs2d');
if  extra==1
  fprintf('%s','Building xraylib (extra) [20/73]... ')
  try
    pkg install ./extra/xraylib-1.0.6.tar.gz
    xraylib=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of xraylib aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping xraylib (extra) [20/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','xraylib');
if  main==1
  fprintf('%s','Building data (main) [21/73]... ')
  try
    pkg install ./main/data-smoothing-1.0.0.tar.gz
    data=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of data aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping data (main) [21/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','data');
if  main==1
  fprintf('%s','Building informationtheory (main) [22/73]... ')
  try
    pkg install ./main/informationtheory-0.1.5.tar.gz
    informationtheory=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of informationtheory aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping informationtheory (main) [22/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','informationtheory');
if  main==1
  fprintf('%s','Building miscellaneous (main) [23/73]... ')
  try
    pkg install ./main/miscellaneous-1.0.6.tar.gz
    miscellaneous=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of miscellaneous aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping miscellaneous (main) [23/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','miscellaneous');
if  main==1
  fprintf('%s','Building special (main) [24/73]... ')
  try
    pkg install ./main/special-matrix-1.0.5.tar.gz
    special=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of special aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping special (main) [24/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','special');
if  main==1
  fprintf('%s','Building odepkg (main) [25/73]... ')
  try
    pkg install ./main/odepkg-0.6.0.tar.gz
    odepkg=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of odepkg aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping odepkg (main) [25/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','odepkg');
if  main==1
  fprintf('%s','Building econometrics (main) [26/73]... ')
  try
    pkg install ./main/econometrics-1.0.6.tar.gz
    econometrics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of econometrics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping econometrics (main) [26/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','econometrics');
if  main==1
  fprintf('%s','Building strings (main) [27/73]... ')
  try
    pkg install ./main/strings-1.0.5.tar.gz
    strings=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of strings aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping strings (main) [27/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','strings');
if  main==1
  fprintf('%s','Building irsa (main) [28/73]... ')
  try
    pkg install ./main/irsa-1.0.5.tar.gz
    irsa=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of irsa aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping irsa (main) [28/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','irsa');
if  main==1
  fprintf('%s','Building vrml (main) [29/73]... ')
  try
    pkg install ./main/vrml-1.0.6.tar.gz
    vrml=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of vrml aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping vrml (main) [29/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','vrml');
if  main==1
  fprintf('%s','Building odebvp (main) [30/73]... ')
  try
    pkg install ./main/odebvp-1.0.4.tar.gz
    odebvp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of odebvp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping odebvp (main) [30/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','odebvp');
if  main==1
  fprintf('%s','Building gsl (main) [31/73]... ')
  try
    pkg install ./main/gsl-1.0.6.tar.gz
    gsl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of gsl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping gsl (main) [31/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','gsl');
if  main==1
  fprintf('%s','Building audio (main) [32/73]... ')
  try
    pkg install ./main/audio-1.1.1.tar.gz
    audio=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of audio aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping audio (main) [32/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','audio');
if  main==1
  fprintf('%s','Building time (main) [33/73]... ')
  try
    pkg install ./main/time-1.0.7.tar.gz
    time=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of time aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping time (main) [33/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','time');
if  main==1
  fprintf('%s','Building octcdf (main) [34/73]... ')
  try
    pkg install ./main/octcdf-1.0.9.tar.gz
    octcdf=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of octcdf aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping octcdf (main) [34/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','octcdf');
if  main==1
  fprintf('%s','Building outliers (main) [35/73]... ')
  try
    pkg install ./main/outliers-0.13.7.tar.gz
    outliers=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of outliers aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping outliers (main) [35/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','outliers');
if  main==1
  fprintf('%s','Building ann (main) [36/73]... ')
  try
    pkg install ./main/ann-1.0.tar.gz
    ann=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ann aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ann (main) [36/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ann');
if  main==1
  fprintf('%s','Building parallel (main) [37/73]... ')
  try
    pkg install ./main/parallel-1.0.6.tar.gz
    parallel=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of parallel aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping parallel (main) [37/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','parallel');
if  main==1
  fprintf('%s','Building missing (main) [38/73]... ')
  try
    pkg install ./main/missing-functions-1.0.0.tar.gz
    missing=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of missing aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping missing (main) [38/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','missing');
if  main==1
  fprintf('%s','Building specfun (main) [39/73]... ')
  try
    pkg install ./main/specfun-1.0.6.tar.gz
    specfun=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of specfun aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping specfun (main) [39/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','specfun');
if  main==1
  fprintf('%s','Building physicalconstants (main) [40/73]... ')
  try
    pkg install ./main/physicalconstants-0.1.5.tar.gz
    physicalconstants=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of physicalconstants aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping physicalconstants (main) [40/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','physicalconstants');
if  main==1
  fprintf('%s','Building ftp (main) [41/73]... ')
  try
    pkg install ./main/ftp-1.0.tar.gz
    ftp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ftp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ftp (main) [41/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ftp');
if  main==1
  fprintf('%s','Building nnet (main) [42/73]... ')
  try
    pkg install ./main/nnet-0.1.7.tar.gz
    nnet=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nnet aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nnet (main) [42/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','nnet');
if  main==1
  fprintf('%s','Building statistics (main) [43/73]... ')
  try
    pkg install ./main/statistics-1.0.6.tar.gz
    statistics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of statistics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping statistics (main) [43/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','statistics');
if  main==1
  fprintf('%s','Building combinatorics (main) [44/73]... ')
  try
    pkg install ./main/combinatorics-1.0.6.tar.gz
    combinatorics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of combinatorics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping combinatorics (main) [44/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','combinatorics');
if  main==1
  fprintf('%s','Building optiminterp (main) [45/73]... ')
  try
    pkg install ./main/optiminterp-0.2.7.tar.gz
    optiminterp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of optiminterp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping optiminterp (main) [45/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','optiminterp');
if miscellaneous==1 &&  main==1
  fprintf('%s','Building ga (main) [46/73]... ')
  try
    pkg install ./main/ga-0.1.1.tar.gz
    ga=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ga aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ga (main) [46/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ga');
if  main==1
  fprintf('%s','Building fixed (main) [47/73]... ')
  try
    pkg install ./main/fixed-0.7.6.tar.gz
    fixed=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of fixed aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping fixed (main) [47/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','fixed');
if  main==1
  fprintf('%s','Building zenity (main) [48/73]... ')
  try
    pkg install ./main/zenity-0.5.5.tar.gz
    zenity=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of zenity aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping zenity (main) [48/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','zenity');
if  main==1
  fprintf('%s','Building control (main) [49/73]... ')
  try
    pkg install ./main/control-1.0.6.tar.gz
    control=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of control aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping control (main) [49/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','control');
if  main==1
  fprintf('%s','Building splines (main) [50/73]... ')
  try
    pkg install ./main/splines-1.0.5.tar.gz
    splines=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of splines aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping splines (main) [50/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','splines');
if miscellaneous==1 &&  main==1
  fprintf('%s','Building optim (main) [51/73]... ')
  try
    pkg install ./main/optim-1.0.3.tar.gz
    optim=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of optim aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping optim (main) [51/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','optim');
if  main==1
  fprintf('%s','Building bioinfo (main) [52/73]... ')
  try
    pkg install ./main/bioinfo-0.1.0.tar.gz
    bioinfo=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of bioinfo aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping bioinfo (main) [52/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','bioinfo');
if  main==1
  fprintf('%s','Building io (main) [53/73]... ')
  try
    pkg install ./main/io-1.0.6.tar.gz
    io=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of io aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping io (main) [53/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','io');
if  main==1
  fprintf('%s','Building plot (main) [54/73]... ')
  try
    pkg install ./main/plot-1.0.5.tar.gz
    plot=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of plot aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping plot (main) [54/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','plot');
if  main==1
  fprintf('%s','Building database (main) [55/73]... ')
  try
    pkg install ./main/database-1.0.tar.gz
    database=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of database aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping database (main) [55/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','database');
if  main==1
  fprintf('%s','Building general (main) [56/73]... ')
  try
    pkg install ./main/general-1.0.6.tar.gz
    general=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of general aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping general (main) [56/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','general');
if  main==1
  fprintf('%s','Building image (main) [57/73]... ')
  try
    pkg install ./main/image-1.0.6.tar.gz
    image=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of image aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping image (main) [57/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','image');
if  main==1
  fprintf('%s','Building ident (main) [58/73]... ')
  try
    pkg install ./main/ident-1.0.5.tar.gz
    ident=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ident aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ident (main) [58/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','ident');
if  main==1
  fprintf('%s','Building symbolic (main) [59/73]... ')
  try
    pkg install ./main/symbolic-1.0.6.tar.gz
    symbolic=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of symbolic aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping symbolic (main) [59/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','symbolic');
if  main==1
  fprintf('%s','Building video (main) [60/73]... ')
  try
    pkg install ./main/video-1.0.0.tar.gz
    video=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of video aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping video (main) [60/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','video');
if  main==1
  fprintf('%s','Building sockets (main) [61/73]... ')
  try
    pkg install ./main/sockets-1.0.4.tar.gz
    sockets=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of sockets aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping sockets (main) [61/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','sockets');
if  main==1
  fprintf('%s','Building signal (main) [62/73]... ')
  try
    pkg install ./main/signal-1.0.7.tar.gz
    signal=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of signal aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping signal (main) [62/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','signal');
if  main==1
  fprintf('%s','Building struct (main) [63/73]... ')
  try
    pkg install ./main/struct-1.0.5.tar.gz
    struct=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of struct aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping struct (main) [63/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','struct');
if  main==1
  fprintf('%s','Building linear (main) [64/73]... ')
  try
    pkg install ./main/linear-algebra-1.0.5.tar.gz
    linear=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of linear aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping linear (main) [64/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','linear');
if  main==1
  fprintf('%s','Building octgpr (main) [65/73]... ')
  try
    pkg install ./main/octgpr-1.1.3.tar.gz
    octgpr=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of octgpr aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping octgpr (main) [65/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','octgpr');
if  nonfree==1
  fprintf('%s','Building arpack (nonfree) [66/73]... ')
  try
    pkg install ./nonfree/arpack-1.0.5.tar.gz
    arpack=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of arpack aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping arpack (nonfree) [66/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','arpack');
if  nonfree==1
  fprintf('%s','Building spline (nonfree) [67/73]... ')
  try
    pkg install ./nonfree/spline-gcvspl-1.0.5.tar.gz
    spline=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of spline aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping spline (nonfree) [67/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','spline');
if  language==1
  fprintf('%s','Building pt_br (language) [68/73]... ')
  try
    pkg install ./language/pt_br-1.0.6.tar.gz
    pt_br=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of pt_br aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping pt_br (language) [68/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','pt_br');
if splines==1 &&  extra==1
  fprintf('%s','Building msh (extra) [69/73]... ')
  try
    pkg install ./extra/msh-0.0.6.tar.gz
    msh=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of msh aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping msh (extra) [69/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','msh');
if io==1 &&  extra==1
  fprintf('%s','Building graceplot (extra) [70/73]... ')
  try
    pkg install ./extra/graceplot-1.0.5.tar.gz
    graceplot=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of graceplot aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping graceplot (extra) [70/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','graceplot');
if msh==1 && fpl==1 &&  extra==1
  fprintf('%s','Building bim (extra) [71/73]... ')
  try
    pkg install ./extra/bim-0.0.6.tar.gz
    bim=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of bim aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping bim (extra) [71/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','bim');
if time==1 &&  main==1
  fprintf('%s','Building financial (main) [72/73]... ')
  try
    pkg install ./main/financial-0.2.2.tar.gz
    financial=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of financial aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping financial (main) [72/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','financial');
if signal==1 &&  main==1
  fprintf('%s','Building communications (main) [73/73]... ')
  try
    pkg install ./main/communications-1.0.6.tar.gz
    communications=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of communications aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping communications (main) [73/73].')
  fid=skipped;
end
fprintf(fid,'%s\n','communications');
fclose(installed);
fclose(skipped);
fclose(broken);

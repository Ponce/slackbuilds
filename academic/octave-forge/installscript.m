try extra; catch extra=0; end
try language; catch language=0; end
try main; catch main=0; end
try nonfree; catch nonfree=0; end
jhandles=0;
tcl=0;
nan=0;
ocs=0;
pdb=0;
engine=0;
java=0;
bugfix=0;
nurbs=0;
bim=0;
secs2d=0;
civil=0;
fpl=0;
generate_html=0;
symband=0;
graceplot=0;
tsa=0;
nlwing2=0;
mapping=0;
integration=0;
oct2mat=0;
ad=0;
windows=0;
xraylib=0;
multicore=0;
secs1d=0;
msh=0;
arpack=0;
spline=0;
spanish=0;
pt_br=0;
missing=0;
zenity=0;
strings=0;
control=0;
special=0;
benchmark=0;
parallel=0;
physicalconstants=0;
specfun=0;
optim=0;
octgpr=0;
data=0;
plot=0;
ann=0;
sockets=0;
vrml=0;
fixed=0;
image=0;
simp=0;
ga=0;
gsl=0;
outliers=0;
irsa=0;
database=0;
ftp=0;
nnet=0;
quaternion=0;
bioinfo=0;
symbolic=0;
audio=0;
miscellaneous=0;
octcdf=0;
splines=0;
io=0;
general=0;
informationtheory=0;
odepkg=0;
signal=0;
struct=0;
time=0;
odebvp=0;
combinatorics=0;
statistics=0;
linear=0;
video=0;
optiminterp=0;
ident=0;
communications=0;
econometrics=0;
financial=0;
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
  fprintf('%s','Building tcl (extra) [1/81]... ')
  try
    pkg install ./extra/tcl-octave-0.1.8.tar.gz
    tcl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of tcl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping tcl (extra) [1/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','tcl');
if  extra==1
  fprintf('%s','Building nan (extra) [2/81]... ')
  try
    pkg install ./extra/nan-1.0.9.tar.gz
    nan=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nan aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nan (extra) [2/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','nan');
if  extra==1
  fprintf('%s','Building pdb (extra) [3/81]... ')
  try
    pkg install ./extra/pdb-1.0.7.tar.gz
    pdb=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of pdb aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping pdb (extra) [3/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','pdb');
if  extra==1
  fprintf('%s','Building engine (extra) [4/81]... ')
  try
    pkg install ./extra/engine-1.0.9.tar.gz
    engine=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of engine aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping engine (extra) [4/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','engine');
if  extra==1
  fprintf('%s','Building java (extra) [5/81]... ')
  try
    pkg install ./extra/java-1.2.6.tar.gz
    java=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of java aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping java (extra) [5/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','java');
if  extra==1
  fprintf('%s','Building bugfix (extra) [6/81]... ')
  try
    pkg install ./extra/bugfix-3.0.6-1.0.tar.gz
    bugfix=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of bugfix aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping bugfix (extra) [6/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','bugfix');
if  extra==1
  fprintf('%s','Building nurbs (extra) [7/81]... ')
  try
    pkg install ./extra/nurbs-1.0.1.tar.gz
    nurbs=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nurbs aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nurbs (extra) [7/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','nurbs');
if  extra==1
  fprintf('%s','Building secs2d (extra) [8/81]... ')
  try
    pkg install ./extra/secs2d-0.0.8.tar.gz
    secs2d=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of secs2d aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping secs2d (extra) [8/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','secs2d');
if  extra==1
  fprintf('%s','Building civil (extra) [9/81]... ')
  try
    pkg install ./extra/civil-engineering-1.0.7.tar.gz
    civil=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of civil aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping civil (extra) [9/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','civil');
if  extra==1
  fprintf('%s','Building fpl (extra) [10/81]... ')
  try
    pkg install ./extra/fpl-0.1.6.tar.gz
    fpl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of fpl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping fpl (extra) [10/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','fpl');
if  extra==1
  fprintf('%s','Building generate_html (extra) [11/81]... ')
  try
    pkg install ./extra/generate_html-0.0.9.tar.gz
    generate_html=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of generate_html aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping generate_html (extra) [11/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','generate_html');
if  extra==1
  fprintf('%s','Building symband (extra) [12/81]... ')
  try
    pkg install ./extra/symband-1.0.10.tar.gz
    symband=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of symband aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping symband (extra) [12/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','symband');
if  extra==1
  fprintf('%s','Building tsa (extra) [13/81]... ')
  try
    pkg install ./extra/tsa-4.0.1.tar.gz
    tsa=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of tsa aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping tsa (extra) [13/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','tsa');
if  extra==1
  fprintf('%s','Building nlwing2 (extra) [14/81]... ')
  try
    pkg install ./extra/nlwing2-1.1.1.tar.gz
    nlwing2=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nlwing2 aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nlwing2 (extra) [14/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','nlwing2');
if  extra==1
  fprintf('%s','Building mapping (extra) [15/81]... ')
  try
    pkg install ./extra/mapping-1.0.7.tar.gz
    mapping=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of mapping aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping mapping (extra) [15/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','mapping');
if  extra==1
  fprintf('%s','Building integration (extra) [16/81]... ')
  try
    pkg install ./extra/integration-1.0.7.tar.gz
    integration=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of integration aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping integration (extra) [16/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','integration');
if  extra==1
  fprintf('%s','Building ad (extra) [17/81]... ')
  try
    pkg install ./extra/ad-1.0.6.tar.gz
    ad=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ad aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ad (extra) [17/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ad');
if  extra==1
  fprintf('%s','Building windows (extra) [18/81]... ')
  try
    pkg install ./extra/windows-1.0.8.tar.gz
    windows=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of windows aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping windows (extra) [18/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','windows');
if  extra==1
  fprintf('%s','Building xraylib (extra) [19/81]... ')
  try
    pkg install ./extra/xraylib-1.0.8.tar.gz
    xraylib=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of xraylib aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping xraylib (extra) [19/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','xraylib');
if  extra==1
  fprintf('%s','Building multicore (extra) [20/81]... ')
  try
    pkg install ./extra/multicore-0.2.15.tar.gz
    multicore=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of multicore aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping multicore (extra) [20/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','multicore');
if  extra==1
  fprintf('%s','Building secs1d (extra) [21/81]... ')
  try
    pkg install ./extra/secs1d-0.0.8.tar.gz
    secs1d=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of secs1d aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping secs1d (extra) [21/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','secs1d');
if  nonfree==1
  fprintf('%s','Building arpack (nonfree) [22/81]... ')
  try
    pkg install ./nonfree/arpack-1.0.8.tar.gz
    arpack=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of arpack aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping arpack (nonfree) [22/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','arpack');
if  nonfree==1
  fprintf('%s','Building spline (nonfree) [23/81]... ')
  try
    pkg install ./nonfree/spline-gcvspl-1.0.8.tar.gz
    spline=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of spline aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping spline (nonfree) [23/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','spline');
if  language==1
  fprintf('%s','Building spanish (language) [24/81]... ')
  try
    pkg install ./language/spanish-1.0.1.tar.gz
    spanish=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of spanish aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping spanish (language) [24/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','spanish');
if  language==1
  fprintf('%s','Building pt_br (language) [25/81]... ')
  try
    pkg install ./language/pt_br-1.0.8.tar.gz
    pt_br=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of pt_br aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping pt_br (language) [25/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','pt_br');
if  main==1
  fprintf('%s','Building missing (main) [26/81]... ')
  try
    pkg install ./main/missing-functions-1.0.2.tar.gz
    missing=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of missing aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping missing (main) [26/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','missing');
if  main==1
  fprintf('%s','Building zenity (main) [27/81]... ')
  try
    pkg install ./main/zenity-0.5.7.tar.gz
    zenity=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of zenity aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping zenity (main) [27/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','zenity');
if  main==1
  fprintf('%s','Building strings (main) [28/81]... ')
  try
    pkg install ./main/strings-1.0.7.tar.gz
    strings=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of strings aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping strings (main) [28/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','strings');
if  main==1
  fprintf('%s','Building control (main) [29/81]... ')
  try
    pkg install ./main/control-1.0.11.tar.gz
    control=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of control aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping control (main) [29/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','control');
if  main==1
  fprintf('%s','Building special (main) [30/81]... ')
  try
    pkg install ./main/special-matrix-1.0.7.tar.gz
    special=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of special aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping special (main) [30/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','special');
if  main==1
  fprintf('%s','Building benchmark (main) [31/81]... ')
  try
    pkg install ./main/benchmark-1.1.1.tar.gz
    benchmark=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of benchmark aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping benchmark (main) [31/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','benchmark');
if  main==1
  fprintf('%s','Building parallel (main) [32/81]... ')
  try
    pkg install ./main/parallel-2.0.0.tar.gz
    parallel=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of parallel aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping parallel (main) [32/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','parallel');
if  main==1
  fprintf('%s','Building physicalconstants (main) [33/81]... ')
  try
    pkg install ./main/physicalconstants-0.1.7.tar.gz
    physicalconstants=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of physicalconstants aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping physicalconstants (main) [33/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','physicalconstants');
if  main==1
  fprintf('%s','Building specfun (main) [34/81]... ')
  try
    pkg install ./main/specfun-1.0.8.tar.gz
    specfun=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of specfun aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping specfun (main) [34/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','specfun');
if  main==1
  fprintf('%s','Building octgpr (main) [35/81]... ')
  try
    pkg install ./main/octgpr-1.1.5.tar.gz
    octgpr=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of octgpr aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping octgpr (main) [35/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','octgpr');
if  main==1
  fprintf('%s','Building plot (main) [36/81]... ')
  try
    pkg install ./main/plot-1.0.7.tar.gz
    plot=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of plot aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping plot (main) [36/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','plot');
if  main==1
  fprintf('%s','Building ann (main) [37/81]... ')
  try
    pkg install ./main/ann-1.0.2.tar.gz
    ann=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ann aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ann (main) [37/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ann');
if  main==1
  fprintf('%s','Building sockets (main) [38/81]... ')
  try
    pkg install ./main/sockets-1.0.5.tar.gz
    sockets=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of sockets aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping sockets (main) [38/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','sockets');
if  main==1
  fprintf('%s','Building fixed (main) [39/81]... ')
  try
    pkg install ./main/fixed-0.7.10.tar.gz
    fixed=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of fixed aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping fixed (main) [39/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','fixed');
if  main==1
  fprintf('%s','Building image (main) [40/81]... ')
  try
    pkg install ./main/image-1.0.10.tar.gz
    image=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of image aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping image (main) [40/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','image');
if  main==1
  fprintf('%s','Building simp (main) [41/81]... ')
  try
    pkg install ./main/simp-1.1.0.tar.gz
    simp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of simp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping simp (main) [41/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','simp');
if  main==1
  fprintf('%s','Building gsl (main) [42/81]... ')
  try
    pkg install ./main/gsl-1.0.8.tar.gz
    gsl=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of gsl aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping gsl (main) [42/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','gsl');
if  main==1
  fprintf('%s','Building outliers (main) [43/81]... ')
  try
    pkg install ./main/outliers-0.13.9.tar.gz
    outliers=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of outliers aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping outliers (main) [43/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','outliers');
if  main==1
  fprintf('%s','Building irsa (main) [44/81]... ')
  try
    pkg install ./main/irsa-1.0.7.tar.gz
    irsa=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of irsa aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping irsa (main) [44/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','irsa');
if  main==1
  fprintf('%s','Building database (main) [45/81]... ')
  try
    pkg install ./main/database-1.0.4.tar.gz
    database=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of database aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping database (main) [45/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','database');
if  main==1
  fprintf('%s','Building ftp (main) [46/81]... ')
  try
    pkg install ./main/ftp-1.0.2.tar.gz
    ftp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ftp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ftp (main) [46/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ftp');
if  main==1
  fprintf('%s','Building nnet (main) [47/81]... ')
  try
    pkg install ./main/nnet-0.1.10.tar.gz
    nnet=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of nnet aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping nnet (main) [47/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','nnet');
if  main==1
  fprintf('%s','Building quaternion (main) [48/81]... ')
  try
    pkg install ./main/quaternion-1.0.0.tar.gz
    quaternion=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of quaternion aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping quaternion (main) [48/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','quaternion');
if  main==1
  fprintf('%s','Building bioinfo (main) [49/81]... ')
  try
    pkg install ./main/bioinfo-0.1.2.tar.gz
    bioinfo=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of bioinfo aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping bioinfo (main) [49/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','bioinfo');
if  main==1
  fprintf('%s','Building symbolic (main) [50/81]... ')
  try
    pkg install ./main/symbolic-1.0.9.tar.gz
    symbolic=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of symbolic aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping symbolic (main) [50/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','symbolic');
if  main==1
  fprintf('%s','Building audio (main) [51/81]... ')
  try
    pkg install ./main/audio-1.1.4.tar.gz
    audio=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of audio aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping audio (main) [51/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','audio');
if  main==1
  fprintf('%s','Building miscellaneous (main) [52/81]... ')
  try
    pkg install ./main/miscellaneous-1.0.9.tar.gz
    miscellaneous=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of miscellaneous aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping miscellaneous (main) [52/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','miscellaneous');
if  main==1
  fprintf('%s','Building octcdf (main) [53/81]... ')
  try
    pkg install ./main/octcdf-1.0.13.tar.gz
    octcdf=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of octcdf aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping octcdf (main) [53/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','octcdf');
if  main==1
  fprintf('%s','Building splines (main) [54/81]... ')
  try
    pkg install ./main/splines-1.0.7.tar.gz
    splines=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of splines aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping splines (main) [54/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','splines');
if  main==1
  fprintf('%s','Building io (main) [55/81]... ')
  try
    pkg install ./main/io-1.0.9.tar.gz
    io=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of io aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping io (main) [55/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','io');
if  main==1
  fprintf('%s','Building general (main) [56/81]... ')
  try
    pkg install ./main/general-1.1.3.tar.gz
    general=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of general aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping general (main) [56/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','general');
if  main==1
  fprintf('%s','Building informationtheory (main) [57/81]... ')
  try
    pkg install ./main/informationtheory-0.1.8.tar.gz
    informationtheory=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of informationtheory aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping informationtheory (main) [57/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','informationtheory');
if  main==1
  fprintf('%s','Building odepkg (main) [58/81]... ')
  try
    pkg install ./main/odepkg-0.6.7.tar.gz
    odepkg=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of odepkg aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping odepkg (main) [58/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','odepkg');
if  main==1
  fprintf('%s','Building struct (main) [59/81]... ')
  try
    pkg install ./main/struct-1.0.7.tar.gz
    struct=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of struct aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping struct (main) [59/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','struct');
if  main==1
  fprintf('%s','Building time (main) [60/81]... ')
  try
    pkg install ./main/time-1.0.9.tar.gz
    time=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of time aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping time (main) [60/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','time');
if  main==1
  fprintf('%s','Building odebvp (main) [61/81]... ')
  try
    pkg install ./main/odebvp-1.0.6.tar.gz
    odebvp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of odebvp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping odebvp (main) [61/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','odebvp');
if  main==1
  fprintf('%s','Building combinatorics (main) [62/81]... ')
  try
    pkg install ./main/combinatorics-1.0.9.tar.gz
    combinatorics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of combinatorics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping combinatorics (main) [62/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','combinatorics');
if miscellaneous==1 &&  main==1
  fprintf('%s','Building statistics (main) [63/81]... ')
  try
    pkg install ./main/statistics-1.0.9.tar.gz
    statistics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of statistics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping statistics (main) [63/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','statistics');
if  main==1
  fprintf('%s','Building linear (main) [64/81]... ')
  try
    pkg install ./main/linear-algebra-1.0.8.tar.gz
    linear=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of linear aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping linear (main) [64/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','linear');
if  main==1
  fprintf('%s','Building video (main) [65/81]... ')
  try
    pkg install ./main/video-1.0.2.tar.gz
    video=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of video aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping video (main) [65/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','video');
if  main==1
  fprintf('%s','Building optiminterp (main) [66/81]... ')
  try
    pkg install ./main/optiminterp-0.3.2.tar.gz
    optiminterp=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of optiminterp aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping optiminterp (main) [66/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','optiminterp');
if  main==1
  fprintf('%s','Building ident (main) [67/81]... ')
  try
    pkg install ./main/ident-1.0.7.tar.gz
    ident=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ident aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ident (main) [67/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ident');
if miscellaneous==1 && time==1 &&  main==1
  fprintf('%s','Building financial (main) [68/81]... ')
  try
    pkg install ./main/financial-0.3.2.tar.gz
    financial=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of financial aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping financial (main) [68/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','financial');
if java==1 &&  extra==1
  fprintf('%s','Building jhandles (extra) [69/81]... ')
  try
    pkg install ./extra/jhandles-0.3.5.tar.gz
    jhandles=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of jhandles aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping jhandles (extra) [69/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','jhandles');
if odepkg==1 &&  extra==1
  fprintf('%s','Building ocs (extra) [70/81]... ')
  try
    pkg install ./extra/ocs-0.0.4.tar.gz
    ocs=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ocs aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ocs (extra) [70/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ocs');
if general==1 && io==1 &&  extra==1
  fprintf('%s','Building graceplot (extra) [71/81]... ')
  try
    pkg install ./extra/graceplot-1.0.8.tar.gz
    graceplot=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of graceplot aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping graceplot (extra) [71/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','graceplot');
if io==1 &&  extra==1
  fprintf('%s','Building oct2mat (extra) [72/81]... ')
  try
    pkg install ./extra/oct2mat-1.0.7.tar.gz
    oct2mat=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of oct2mat aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping oct2mat (extra) [72/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','oct2mat');
if splines==1 &&  extra==1
  fprintf('%s','Building msh (extra) [73/81]... ')
  try
    pkg install ./extra/msh-0.1.1.tar.gz
    msh=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of msh aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping msh (extra) [73/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','msh');
if miscellaneous==1 &&  main==1
  fprintf('%s','Building optim (main) [74/81]... ')
  try
    pkg install ./main/optim-1.0.6.tar.gz
    optim=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of optim aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping optim (main) [74/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','optim');
if optim==1 &&  main==1
  fprintf('%s','Building data (main) [75/81]... ')
  try
    pkg install ./main/data-smoothing-1.2.0.tar.gz
    data=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of data aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping data (main) [75/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','data');
if statistics==1 && struct==1 && miscellaneous==1 &&  main==1
  fprintf('%s','Building vrml (main) [76/81]... ')
  try
    pkg install ./main/vrml-1.0.10.tar.gz
    vrml=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of vrml aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping vrml (main) [76/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','vrml');
if specfun==1 && optim==1 &&  main==1
  fprintf('%s','Building signal (main) [77/81]... ')
  try
    pkg install ./main/signal-1.0.10.tar.gz
    signal=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of signal aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping signal (main) [77/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','signal');
if signal==1 &&  main==1
  fprintf('%s','Building communications (main) [78/81]... ')
  try
    pkg install ./main/communications-1.0.10.tar.gz
    communications=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of communications aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping communications (main) [78/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','communications');
if optim==1 &&  main==1
  fprintf('%s','Building econometrics (main) [79/81]... ')
  try
    pkg install ./main/econometrics-1.0.8.tar.gz
    econometrics=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of econometrics aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping econometrics (main) [79/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','econometrics');
if msh==1 && fpl==1 &&  extra==1
  fprintf('%s','Building bim (extra) [80/81]... ')
  try
    pkg install ./extra/bim-0.1.1.tar.gz
    bim=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of bim aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping bim (extra) [80/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','bim');
if communications==1 &&  main==1
  fprintf('%s','Building ga (main) [81/81]... ')
  try
    pkg install ./main/ga-0.9.7.tar.gz
    ga=1;
    fid=installed;
    fprintf('done.\n')
  catch
    fprintf('\n%s\n','Build of ga aborted due to errors.')
    fid=broken;
  end
else
  disp('Skipping ga (main) [81/81].')
  fid=skipped;
end
fprintf(fid,'%s\n','ga');
fclose(installed);
fclose(skipped);
fclose(broken);

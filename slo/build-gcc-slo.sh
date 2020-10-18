# http://slo.sourceforge.net/dochtml/ch04s02.html

INSTALLDIR=$HOME/gcc-slo
INSTALLDIR_GMP=$HOME/gcc-slo-deps/gmp-5.1.3
INSTALLDIR_MPFR=$HOME/gcc-slo-deps/mpfr-3.1.2
INSTALLDIR_MPC=$HOME/gcc-slo-deps/mpc-1.0.1

mkdir gcc-slo-obj
cd gcc-slo-obj
# Test to see if $HOME contains spaces. If the current directory or the directory to be installed
# in contains spaces. If so, refuse to continue, since this will result in errors.
if [ `echo $INSTALLDIR | grep -c ' '` != '0' ]
then
  echo "Cannot build if path to install in contains spaces (INSTALLDIR=$INSTALLDIR)."
  echo "Please replace INSTALLDIR in build script with another location that does not contain spaces."
  exit
fi
PWD=`pwd`
if [ `echo $PWD | grep -c ' '` != '0' ]
then
  echo Cannot build if path the current directory contains spaces.
  echo Please replace copy this directory to a directory with spaces in the path, e.g. /tmp.
  echo Then run this script in that directory.
  exit
fi

../gcc-slo-src/configure --prefix=$INSTALLDIR --with-gmp=$INSTALLDIR_GMP --with-mpfr=$INSTALLDIR_MPFR \
  --with-mpc=$INSTALLDIR_MPC --disable-multilib --program-suffix=-slo --enable-mapped-location --enable-languages=c,c++

# look for gnu make
if [ "`make -v | grep GNU -`" != '' ]
then
echo "make is GNU Make"
GNUMAKE=make
else
echo "make is not GNU Make. I hope you installed GNU Make as gmake."
echo "Otherwise, you'll need to install GNU Make as either make or"
echo "gmake to be able to continue building gcc-slo."
GNUMAKE=gmake
fi

# look for gnu find
if [ "`find -version | grep GNU -`" != '' ]
then
echo "find is GNU find"
GNUFIND=find
else
echo "find is not GNU find. I hope you installed GNU find as /usr/bin/find."
echo "Otherwise, you'll need to install GNU find and change build-gcc-slo.sh"
GNUFIND=/usr/bin/find
fi

echo $GNUMAKE -k
$GNUMAKE -k
echo rm -r `$GNUFIND . -name librd`
echo Resultaat van "$GNUFIND . -name librd" is : `$GNUFIND . -name librd`
rm -r `$GNUFIND . -name librd`
echo $GNUMAKE -k
$GNUMAKE -k
echo $GNUMAKE install
$GNUMAKE install

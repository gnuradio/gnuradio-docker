#!/bin/sh
set -e

export SRCDIR=/home/user/gnuradio
export BUILDDIR=/home/user/build
export PREFIX=/opt/gnuradio/

. /home/user/.pathsrc

mkdir -p $BUILDDIR && mkdir -p $PREFIX && cd $BUILDDIR

if [ "x$CPPONLY" = "xYES" ] ; then
   PYTHON_SUPPORT='-DENABLE_PYTHON=OFF'
   echo Disabling python support.
else
   PYTHON_SUPPORT=
fi

cmake -Wno-dev \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      $PYTHON_SUPPORT \
      $SRCDIR 2>&1 | tee cmake.log || {
    echo CMake failed!
    exit 1
}

make -j$MAKE_JOBS 2>&1 | tee build.log || {
    echo Compilation failed!
    exit 1
}

make install 2>&1 | tee install.log || {
    echo Installation failed!
    exit 1
}

exit 0

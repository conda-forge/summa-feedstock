#!/bin/bash

if [[ $(uname) == Linux ]]; then
  ln -s "${CC}" "${BUILD_PREFIX}/bin/gcc"
  ln -s "${FC}" "${BUILD_PREFIX}/bin/gfortran"
fi

export F_MASTER=$(pwd)
# export FC=gfortran
export FC_EXE=${FC}
export FC_ENV=$(uname)
export NCDF_PATH=${PREFIX}
# export LIBLAPACK="$LDFLAGS -L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib -llapack -lblas"
export INCLUDES='-I${PREFIX}/include -I/usr/include'
export LIBRARIES='-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib -lnetcdff -llapack -lblas'

export CFLAGS="$CFLAGS -fPIC -I$PREFIX/include"
export FLAGS_NOAH="-O2 -ffree-form -fdefault-real-8 -ffree-line-length-none -fmax-errors=0 -fbacktrace -Wno-unused -Wno-unused-dummy-argument"
export FLAGS_COMM="-O2 -Wall -ffree-line-length-none -fmax-errors=0 -fbacktrace -fcheck=bounds"
export FLAGS_SUMMA=${FLAGS_COMM}

export EXE_PATH="$PREFIX/bin"
make -C ${F_MASTER}/build/ -f Makefile
mv $F_MASTER/bin/summa.exe $PREFIX/bin/summa.exe

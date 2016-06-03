#/bin/bash
set -e
set -o nounset

mkdir -p $PWD/work/build
mkdir -p $PWD/work/ccache
mkdir -p $PWD/work/gnuradio
mkdir -p $PREFIX

rm -rf $PWD/work/build/*
rm -rf $PREFIX/*

docker run -it --rm \
    -e MAKE_JOBS=48 \
    -e CPPONLY=${CPPONLY-x} \
    -v $PWD/work/ccache:/home/user/.ccache \
    -v $PWD/work/gnuradio:/home/user/gnuradio \
    -v $PWD/work/build:/home/user/build \
    -v $PREFIX:/opt/gnuradio \
    gnuradio/gnuradio-builder

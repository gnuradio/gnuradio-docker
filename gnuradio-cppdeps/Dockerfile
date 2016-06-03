FROM ubuntu:16.04
MAINTAINER jcorgan@gnuradio.org

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         libasound2 \
         libboost-date-time1.58.0 \
         libboost-filesystem1.58.0 \
         libboost-program-options1.58.0 \
         libboost-thread1.58.0 \
         libcomedi0 \
         libfftw3-bin \
         libgsl2 \
         libjack-jackd2-0 \
         liblog4cpp5v5 \
         libportaudio2 \
         libqwt6abi1 \
         libsdl-image1.2 \
         libuhd003 \
         libusb-1.0-0 \
         libzmq5 \
         pkg-config \
         --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

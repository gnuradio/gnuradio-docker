FROM ubuntu:18.04
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2021-01-13

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         libad9361-0 \
         libasound2 \
         libboost-date-time1.65.1 \
         libboost-filesystem1.65.1 \
         libboost-program-options1.65.1 \
         libboost-thread1.65.1 \
         libcomedi0 \
         libfftw3-bin \
         libgmp10 \
         libgsl23 \
         libgtk-3-0 \
         libiio0 \
         libjack-jackd2-0 \
         liblog4cpp5v5 \
         libpangocairo-1.0-0 \
         libportaudio2 \
         libqwt6abi1 \
         libsdl-image1.2 \
         libsndfile1-dev \
         libuhd003.010.003 \
         libusb-1.0-0 \
         libzmq5 \
         libpango-1.0-0 \
         gir1.2-gtk-3.0 \
         gir1.2-pango-1.0 \
         pkg-config \
         --no-install-recommends

# Py3 deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         pybind11-dev \
         python3-click \
         python3-click-plugins \
         python3-mako \
         python3-dev \
         python3-gi \
         python3-gi-cairo \
         python3-lxml \
         python3-numpy \
         python3-opengl \
         python3-pyqt5 \
         python-wxgtk3.0 \
         python3-yaml \
         python3-zmq \
         python-six \
         python3-six \
         --no-install-recommends

# Py deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         python-cheetah \
         python-click \
         python-click-plugins \
         python-dev \
         python-gi \
         python-gi-cairo \
         python-gtk2 \
         python-lxml \
         python-mako \
         python-numpy \
         python-opengl \
         python-qt4 \
         python-pyqt5 \
         python-wxgtk3.0 \
         python-yaml \
         python-zmq \
         --no-install-recommends

# Build deps
RUN mv /sbin/sysctl /sbin/sysctl.orig \
    && ln -sf /bin/true /sbin/sysctl \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       --no-install-recommends \
       build-essential \
       ccache \
       cmake \
       libad9361-dev \
       libboost-date-time-dev \
       libboost-dev \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-regex-dev \
       libboost-system-dev \
       libboost-test-dev \
       libboost-thread-dev \
       libcomedi-dev \
       libcppunit-dev \
       libfftw3-dev \
       libgmp-dev \
       libgsl0-dev \
       libiio-dev \
       liblog4cpp5-dev \
       libqt4-dev \
       libqwt-dev \
       libqwt5-qt4 \
       libqwt-qt5-dev \
       qtbase5-dev \
       libsdl1.2-dev \
       libuhd-dev \
       libusb-1.0-0-dev \
       libzmq3-dev \
       libgsm1-dev \
       libcodec2-dev \
       portaudio19-dev \
       pyqt4-dev-tools \
       pyqt5-dev-tools \
       python-cheetah \
       python-sphinx \
       doxygen \
       doxygen-latex \
       swig \
    && rm -f /sbin/sysctl \
    && ln -s /usr/bin/ccache /usr/lib/ccache/cc \
    && ln -s /usr/bin/ccache /usr/lib/ccache/c++ \
    && mv /sbin/sysctl.orig /sbin/sysctl

# Testing deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
       xvfb \
       lcov \
       python3-scipy \
       --no-install-recommends \
    && apt-get clean

# Thrift
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
       libssl1.0-dev \
       flex \
       bison \
       automake \
       autoconf \
       libtool


RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:git-core/ppa
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -qy git

RUN mkdir /src && cd /src \
    && git clone https://github.com/apache/thrift.git --branch 0.10.0 --depth 1 \
    && cd thrift \
    && ./bootstrap.sh \
    && ./configure --with-c_glib --with-cpp --with-libevent --with-python --without-csharp --without-d --without-erlang --without-go --without-haskell --without-java --without-lua --without-nodejs --without-perl --without-php --without-ruby --without-zlib --without-qt4 --without-qt5 --disable-tests --disable-tutorial --prefix=/usr \
    && make -j4 install \
    && mv /usr/lib/python2.7/site-packages/thrift /usr/lib/python2.7/dist-packages
RUN cd /src/thrift \
    && PYTHON=/usr/bin/python3 ./configure --with-c_glib --with-cpp --with-libevent --with-python --without-csharp --without-d --without-erlang --without-go --without-haskell --without-java --without-lua --without-nodejs --without-perl --without-php --without-ruby --without-zlib --without-qt4 --without-qt5 --disable-tests --disable-tutorial --prefix=/usr \
    && make -j4 install \
    && mv /usr/lib/python3.6/site-packages/thrift /usr/lib/python3/dist-packages

RUN DEBIAN_FRONTEND=noninteractive \
        apt-get -y clean \
        && apt-get -y autoclean \
        && apt-get -y autoremove \
        && rm -r /src

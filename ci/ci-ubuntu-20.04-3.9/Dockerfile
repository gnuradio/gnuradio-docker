FROM ubuntu:20.04
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2021-08-15

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         libad9361-0 \
         libasound2 \
         libboost-date-time1.71.0 \
         libboost-filesystem1.71.0 \
         libboost-program-options1.71.0 \
         libboost-thread1.71.0 \
         libfftw3-bin \
         libgmp10 \
         libgsl23 \
         libgtk-3-0 \
         libiio0 \
         libsoapysdr0.7 \
         soapysdr-tools \
         libjack-jackd2-0 \
         liblog4cpp5v5 \
         libpangocairo-1.0-0 \
         libportaudio2 \
         libqwt-qt5-6 \
         libsndfile1-dev \
         libsdl-image1.2 \
         libthrift-dev \
         libuhd3.15.0 \
         libusb-1.0-0 \
         libzmq5 \
         libpango-1.0-0 \
         gir1.2-gtk-3.0 \
         gir1.2-pango-1.0 \
         pkg-config \
         thrift-compiler \
         --no-install-recommends \
    && apt-get clean

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
         python3-yaml \
         python3-zmq \
         python3-six \
         python3-pytest \
         --no-install-recommends \
    && apt-get clean

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
       libcppunit-dev \
       libfftw3-dev \
       libgmp-dev \
       libgsl0-dev \
       libiio-dev \
       libsoapysdr-dev \
       liblog4cpp5-dev \
       libspdlog-dev \
       libfmt-dev \
       libqwt-qt5-dev \
       qtbase5-dev \
       libsdl1.2-dev \
       libuhd-dev \
       libusb-1.0-0-dev \
       libzmq3-dev \
       portaudio19-dev \
       pyqt5-dev-tools \
       doxygen \
       doxygen-latex \
       swig \
    && rm -f /sbin/sysctl \
    && ln -s /usr/bin/ccache /usr/lib/ccache/cc \
    && ln -s /usr/bin/ccache /usr/lib/ccache/c++ \
    && mv /sbin/sysctl.orig /sbin/sysctl \
    && apt-get clean

# Testing deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
       xvfb \
       lcov \
       python3-scipy \
       --no-install-recommends \
    && apt-get clean

# Install other dependencies (e.g. VOLK)
RUN apt-get -y install -q \
        git \
    ca-certificates \
    appstream-util \
    --no-install-recommends \
    && apt-get clean \
    && apt-get autoclean

# Install VOLK
RUN mkdir -p /src/build \
&& git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 \
&& cd /src/build \
&& cmake -DCMAKE_BUILD_TYPE=Release ../volk/ \
&& make -j4\
&& make install \
&& cd / \
&& rm -rf /src/

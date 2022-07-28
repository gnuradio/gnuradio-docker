FROM debian:buster
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2021-11-01

# Prepare distribution
RUN apt-get update -q \
    && apt-get -y upgrade \
    && apt-get install -qy \
    ca-certificates \
    && sh -c 'echo deb http://deb.debian.org/debian buster-backports main > /etc/apt/sources.list.d/backports.list' \
    && apt-get clean

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -qy \
    git \
    libasio-dev \
    libasound2 \
    libfftw3-bin \
    libgmp10 \
    libgsl23 \
    libgtk-3-0 \
    libjack-jackd2-0 \
    liblog4cpp5v5 \
    libpangocairo-1.0-0 \
    libportaudio2 \
    libqwt-qt5-6 \
    libsndfile1-dev \
    libsdl-image1.2 \
    libthrift-dev \
    libuhd-dev \
    libusb-1.0-0 \
    libzmq5 \
    libpango-1.0-0 \
    gir1.2-gtk-3.0 \
    gir1.2-pango-1.0 \
    pkg-config \
    thrift-compiler \
    libunwind-dev \
    build-essential \
    ccache \
    cmake \
    libcppunit-dev \
    libfftw3-dev \
    libgmp-dev \
    libgsl0-dev \
    liblog4cpp5-dev \
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
# Py3 deps
    python3-click \
    python3-click-plugins \
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
# Testing deps
    xvfb \
    lcov \
    python3-scipy \
    --no-install-recommends \
# backported Boost 1.71, spdlog, libfmt
    && apt-get install -t buster-backports -qy \
    libspdlog-dev \
    libfmt-dev \
    libboost1.71-all-dev \
    && apt-get clean

# Install Mako
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy python3-pip \
    --no-install-recommends \
    && apt-get clean \
    && pip3 install Mako

# Install VOLK
RUN mkdir -p /src/build && \
    git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 && \
    cd /src/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../volk/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/

# Install Pybind11
RUN mkdir -p /src/build && \
    git clone --recursive https://github.com/pybind/pybind11.git /src/pybind11 --branch v2.4.0 && \
    cd /src/build && \
    cmake -DPYBIND11_TEST=OFF /src/pybind11 && \
    make install && \
    rm -rf /src/

# Install SoapySDR
RUN mkdir -p /src \
    && cd /src \
    && git clone -b soapy-sdr-0.8.0 https://github.com/pothosware/SoapySDR/ \
    && cd SoapySDR \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr .. \
    && make install \
    && cd / \
    && rm -rf /src


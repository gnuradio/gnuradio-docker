FROM debian:buster
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2025-02-23
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's:deb.debian.org/debian :archive.debian.org/debian :g' /etc/apt/sources.list \
  ; apt-get update -q \
  && apt-get -y upgrade \
  && apt-get clean

# CPP deps
RUN \
  apt-get install -qy \
  --no-install-recommends \
  # I don't like this any more than you, but we'll have to downgrade libc to be able to install python3-dev
  # --allow-downgrades \
  # libc6=2.28-10+deb10u1 \
  # libbz2-1.0=1.0.6-9.2~deb1 \
  libasound2 \
  libboost-date-time1.67.0 \
  libboost-filesystem1.67.0 \
  libboost-program-options1.67.0 \
  libboost-thread1.67.0 \
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
  && apt-get clean

# Py3 deps
RUN \
  apt-get install -qy \
  --no-install-recommends \
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
  && apt-get clean

# Build deps
RUN apt-get install -y \
  --no-install-recommends \
  build-essential \
  ccache \
  cmake \
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
  liblog4cpp5-dev \
  libqwt-qt5-dev \
  libqt5opengl5-dev \
  qtbase5-dev \
  libsdl1.2-dev \
  libuhd-dev \
  libusb-1.0-0-dev \
  libzmq3-dev \
  portaudio19-dev \
  pyqt5-dev-tools \
  doxygen \
  doxygen-latex && \
  apt-get clean

# Testing deps
RUN \
  apt-get install -qy \
  --no-install-recommends \
  xvfb \
  lcov \
  python3-scipy \
  && apt-get clean \
  && apt-get autoclean

# Install other dependencies (e.g. VOLK)
RUN apt-get -y install -q \
  --no-install-recommends \
  git \
  ca-certificates \
  && apt-get clean  \
  && apt-get autoclean

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

# Get spdlog from buster-backports
RUN \
  sh -c 'echo deb http://archive.debian.org/debian buster-backports main > /etc/apt/sources.list.d/backports.list' \
  && apt-get update \
  && apt-get install -t buster-backports -qy \
  --no-install-recommends \
  libspdlog-dev libfmt-dev \
  && apt-get clean

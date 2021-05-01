FROM centos:7.6.1810
MAINTAINER Martin Braun <martin@gnuradio.org>

ENV security_updates_as_of 2021-01-06

RUN yum install epel-release -y -q
RUN yum --enablerepo=epel check-update -y; yum install -y \
# Build
        cmake3 \
        make \
        gcc \
        gcc-c++ \
        xz

# CPP deps
RUN yum install -y \
        boost-devel \
        log4cpp-devel \
        cppzmq-devel \
        libunwind-devel \
# ctrlport - thrift
        thrift \
        thrift-devel \
# Math libraries
        fftw-devel \
        gsl-devel \
        gmp-devel \
# Documentation
        doxygen \
        graphviz \
# Audio, SDL
        SDL-devel \
        alsa-lib-devel \
        portaudio-devel \
        jack-audio-connection-kit-devel \
        libsndfile-devel \
# HW drivers
        uhd-devel \
## Vocoder libraries
        codec2-devel \
        gsm-devel

# Python deps
RUN yum install -y \
        python36-devel \
        python36-pybind11 \
        python36-numpy \
        python36-scipy \
        python36-zmq \
        python36-thrift \
        python36-pytest \
        python36-PyYAML \
# GUI libraries
        xdg-utils \
        qwt-qt5-devel \
        python36-PyQt5 \
        python36-qt5-devel \
# XML Parsing / GRC
        desktop-file-utils \
        python36-mako \
        python36-click \
        python36-click-plugins \
# GRC/next
        python36-pyyaml \
        python36-lxml \
        python36-gobject \
	gtk3 \
        python36-cairo \
        pango

# For VOLK
RUN yum install -y \
        git

RUN yum clean all

# Install VOLK
RUN pip3 install mako
RUN mkdir -p /src/build
RUN git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.3.0 --depth 1
RUN cd /src/build && cmake3 -DCMAKE_BUILD_TYPE=Release ../volk/ && make && make install && cd / && rm -rf /src/

# Install Pybind11
RUN mkdir -p /src/build
RUN git clone --recursive https://github.com/pybind/pybind11.git /src/pybind11 --branch v2.4.0 --depth 1
RUN cd /src/build && cmake3 -DPYBIND11_TEST=OFF /src/pybind11 && make install && rm -rf /src/

# Install SoapySDR
RUN mkdir -p /src \
    && pushd /src \
    && git clone -b soapy-sdr-0.8.0 https://github.com/pothosware/SoapySDR/ \
    && cd SoapySDR \
    && mkdir build \
    && cd build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=/usr .. \
    && make install \
    && popd \
    && rm -rf /src

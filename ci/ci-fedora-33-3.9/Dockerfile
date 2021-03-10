FROM fedora:33
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2021-01-06

# Build
RUN dnf install -y \
        cmake \
        make \
        gcc \
        gcc-c++ \
        xz

# CPP deps
RUN dnf install -y \
        boost-devel \
        log4cpp-devel \
        cppzmq-devel \
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
        gsm-devel \
# gr-iio
        libad9361-devel \
        libiio-devel \
# gr-soapy
        SoapySDR-devel

# Python deps
RUN dnf install -y \
        python3-devel \
        python3-pybind11 \
        python3-numpy \
        python3-scipy \
        python3-zmq \
        python3-thrift \
        python3-pytest \
# GUI libraries
        xdg-utils \
        qwt-qt5-devel \
        python3-PyQt5 \
        python3-qt5-devel \
# XML Parsing / GRC
        desktop-file-utils \
        python3-mako \
        python3-click \
        python3-click-plugins \
# GRC/next
        python3-pyyaml \
        python3-lxml \
        python3-gobject \
	gtk3 \
        python3-cairo \
        pango

# For VOLK
RUN dnf install -y \
        git

RUN dnf clean all

# Install VOLK
RUN mkdir -p /src/build
RUN git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 --depth 1
RUN cd /src/build && cmake -DCMAKE_BUILD_TYPE=Release ../volk/ && make && make install && cd / && rm -rf /src/

# CCache
RUN dnf install -y \
        ccache \
        && dnf clean all

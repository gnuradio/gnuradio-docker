FROM fedora:37
LABEL maintainer="martin@gnuradio.org"

ENV security_updates_as_of 2022-11-15

# Build
RUN dnf install --refresh -y \
        cmake \
        make \
        gcc \
        gcc-c++ \
        xz \
# CPP deps
        asio-devel \
        boost-devel \
        log4cpp-devel \
        cppzmq-devel \
        spdlog-devel \
        fmt-devel \
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
        libiio-devel \
# gr-soapy
        SoapySDR-devel \
# Python deps
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
        pango \
# Git For VOLK and libad9361 source building
        git \
# For ccaching
        ccache \
# For testing metainfo files
        libappstream-glib \
# Install VOLK
        volk-devel \
        && dnf clean all

# Install libad9361
RUN mkdir -p /src/build && \
    git clone https://github.com/analogdevicesinc/libad9361-iio /src/libad9361 --branch v0.2 --depth 1 && \
    cd /src/build && cmake -DCMAKE_BUILD_TYPE=Release ../libad9361/ && \
    make && \
    make install && \
    cd / && \
    rm -rf /src/

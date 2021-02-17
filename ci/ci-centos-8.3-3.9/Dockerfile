FROM centos:8.3.2011
MAINTAINER Martin Braun <martin@gnuradio.org>

ENV security_updates_as_of 2021-01-06

RUN dnf install epel-release -y -q
RUN dnf -y install dnf-plugins-core
RUN dnf --enablerepo=epel check-update -y; dnf install -y \
# Build
        cmake3 \
        make \
        gcc \
        gcc-c++ \
        xz \
        ccache \
        clang
run dnf config-manager --set-enabled powertools

# CPP deps
RUN dnf install -y \
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
RUN dnf install -y \
        python3-devel \
        python3-pybind11 \
        python3-numpy \
        python3-scipy \
        python3-zmq \
        python3-thrift \
        python3-pytest \
        python3-PyYAML \
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
RUN pip3 install --upgrade mako

FROM opensuse/tumbleweed
LABEL maintainer="jmorman@gnuradio.org"

ENV security_updates_as_of 2022-09-06

# Build
RUN zypper install -y \
        cmake \
        gcc \
        gcc-c++ \
        clang \
# CPP deps
        spdlog-devel \
        fmt-devel \
        yaml-cpp-devel \
        gtest \
        cppzmq-devel \
# Math libraries
        fftw3-devel \
        gsl-devel \
        gmp-devel \
        volk-devel \
# Documentation
        doxygen \
        graphviz \
# gr-soapy
        soapy-sdr-devel \
# Python deps
        python310-devel \
        python310-pybind11-devel \
        python310-numpy \
        python310-pip \
# GUI libraries
        xdg-utils \
        qwt-devel \
        python310-PyQt6 \
        python310-qt5-devel \
# GRC/next
        python310-PyYAML \
        python310-gobject \
	libgtk-3-0 \
        python310-cairo \
        libpango-1_0-0 \
# Audio, SDL
        SDL2-devel \
        alsa-devel \
        portaudio-devel \
        libjack-devel \
        jack \
        libsndfile-devel \
# Git For VOLK and libad9361 source building
        git \
# For ccaching
        ccache \
# For testing metainfo files
        AppStream 

RUN pip install meson ninja mako six jinja2 pyyaml zmq jsonschema jsonschema-default packaging

RUN zypper install -y \
        flatbuffers-devel 
